require_relative "library_member"

module TerminalUI
  COLOR_ENABLED = $stdout.respond_to?(:tty?) && $stdout.tty? && ENV["NO_COLOR"].nil?
  INTERACTIVE = COLOR_ENABLED && $stdin.respond_to?(:tty?) && $stdin.tty?

  CODES = {
    reset: "\e[0m",
    bold: "\e[1m",
    dim: "\e[2m",
    red: "\e[31m",
    green: "\e[32m",
    yellow: "\e[33m",
    blue: "\e[34m",
    magenta: "\e[35m",
    cyan: "\e[36m"
  }.freeze

  module_function

  def colorize(text, *styles)
    return text unless COLOR_ENABLED

    "#{styles.map { |style| CODES.fetch(style) }.join}#{text}#{CODES[:reset]}"
  end

  def success(text)
    puts colorize(text, :green)
  end

  def warn_msg(text)
    puts colorize(text, :yellow)
  end

  def error_msg(text)
    puts colorize(text, :red)
  end

  def info(text)
    puts colorize(text, :cyan)
  end

  def heading(text)
    puts colorize(text, :bold, :blue)
  end

  def divider(char = "-", width = 60)
    puts colorize(char * width, :dim)
  end

  def banner(title)
    width = title.length + 8
    top = "+#{'-' * width}+"

    puts colorize(top, :magenta)
    puts colorize("|#{title.center(width)}|", :bold, :magenta)
    puts colorize(top, :magenta)
  end

  def menu_section(title, options)
    puts colorize(title, :bold, :blue)

    options.each do |number, text|
      puts "  #{colorize(number.to_s.rjust(2), :cyan)}  #{text}"
    end

    puts
  end

  def prompt(text)
    print "#{colorize('>', :cyan)} #{text}"
    gets.chomp
  end

  def prompt_date(label)
    loop do
      value = prompt("#{label} (YYYY-MM-DD, e.g. 2026-10-01): ")
      return value if value =~ /\A\d{4}-\d{2}-\d{2}\z/

      error_msg("That date is not in YYYY-MM-DD format. Please try again.")
    end
  end

  def clear_screen
    print "\e[H\e[2J" if INTERACTIVE
  end

  def pause(text = "Press Enter to return to the menu...")
    return unless INTERACTIVE

    print colorize("\n#{text}", :dim)
    gets
  end
end

class Book
  attr_accessor :title, :book_id, :author, :genre, :is_borrowed, :borrower, :return_date

  def initialize(title, book_id, author, genre, is_borrowed = false, borrower = nil, return_date = nil)
    @title = title
    @book_id = book_id
    @author = author
    @genre = genre
    @is_borrowed = is_borrowed
    @borrower = borrower
    @return_date = return_date
  end

  def to_s
    if @is_borrowed
      status = "Borrowed"
      borrower_info = ", Borrower: #{@borrower}, Return Date: #{@return_date}"
    else
      status = "Available"
      borrower_info = ""
    end

    "Title: #{@title}, ID: #{@book_id}, Author: #{@author}, Genre: #{@genre}, Status: #{status}#{borrower_info}"
  end

  def borrow_book(borrower_name, return_date)
    if !@is_borrowed
      TerminalUI.success("Book borrowed by #{borrower_name} and return date is: #{return_date}")

      @borrower = borrower_name
      @return_date = return_date
      @is_borrowed = true
    else
      TerminalUI.error_msg("Book is already taken out!")
    end
  end

  def return_book
    if @is_borrowed
      TerminalUI.success("Book has been returned!")

      @is_borrowed = false
      @borrower = nil
      @return_date = nil
    else
      TerminalUI.warn_msg("Book is already in the system!")
    end
  end

  def update_genre(new_genre)
    old_genre = @genre
    @genre = new_genre

    TerminalUI.info("Genre changed! Old Genre: #{old_genre} to #{new_genre}")
  end
end

class Library
  def initialize
    @book_list = []
    @member_list = []
  end

  def add_book(book)
    @book_list << book
    TerminalUI.success("#{book} added to System!")
  end

  def remove_book(book_id)
    found = false

    for book in @book_list
      if book.book_id == book_id
        @book_list.delete(book)
        TerminalUI.success("Book Removed! #{book.title}")
        found = true
        break
      end
    end

    TerminalUI.error_msg("Book with ID #{book_id} not found!") unless found
  end

  def display_books
    for book in @book_list
      status = book.is_borrowed ? TerminalUI.colorize("Borrowed", :yellow) : TerminalUI.colorize("Available", :green)
      puts "Title: #{book.title}, ID: #{book.book_id}, Author: #{book.author}, Genre: #{book.genre} [#{status}]"
    end
  end

  def books
    @book_list.dup
  end

  def search_book(title)
    found = false

    for book in @book_list
      if book.title == title
        TerminalUI.success("Title: #{book.title}, Book Found!")
        found = true
        break
      end
    end

    TerminalUI.error_msg("Book with title '#{title}' not found!") unless found
  end

  def find_book(book_id)
    @book_list.find { |book| book.book_id == book_id }
  end

  def borrow_book(book_id, member_id, return_date)
    member = find_member(member_id)
    book = find_book(book_id)

    if member.nil?
      TerminalUI.error_msg("Member with ID #{member_id} not found! Unable to borrow.")
    elsif book.nil?
      TerminalUI.error_msg("Book with ID #{book_id} not found! Unable to borrow.")
    elsif book.is_borrowed
      TerminalUI.error_msg("Book is already taken out!")
    else
      book.borrow_book(member.name, return_date)
      member.add_borrowed_book(book)
    end
  end

  def return_book(book_id)
    book = find_book(book_id)

    if book.nil?
      TerminalUI.error_msg("Book with ID #{book_id} not found! Unable to return.")
      return
    end

    member = @member_list.find { |m| m.borrowed_books.include?(book) }
    book.return_book
    member.remove_borrowed_book(book) if member
  end

  def sort_books_by_title
    @book_list.sort_by!(&:title)

    TerminalUI.success("Books are sorted!")

    for book in @book_list
      puts TerminalUI.colorize(book.to_s, :cyan)
    end
  end

  def filter_books_by_genre(genre)
    filtered_list = []

    for book in @book_list
      filtered_list << book if book.genre == genre
    end

    if filtered_list.any?
      TerminalUI.heading("Books in Genre: #{genre}")

      for book in filtered_list
        puts TerminalUI.colorize(book.to_s, :cyan)
      end
    else
      TerminalUI.warn_msg("No books found in #{genre}")
    end
  end

  def track_overdue_books(current_date)
    overdue_list = []

    for book in @book_list
      overdue_list << book if book.return_date && book.return_date < current_date
    end

    if overdue_list.any?
      TerminalUI.heading("Overdue Books:")

      for book in overdue_list
        TerminalUI.warn_msg("Title: #{book.title}, Borrower: #{book.borrower}, Due Date: #{book.return_date}")
      end
    else
      TerminalUI.success("No overdue books found.")
    end
  end

  def add_member(member)
    raise ArgumentError, "Member ID #{member.member_id} already exists" if find_member(member.member_id)

    @member_list << member
  end

  def find_member(member_id)
    @member_list.find { |member| member.member_id == member_id }
  end

  def remove_member(member_id)
    member = find_member(member_id)
    @member_list.delete(member)
  end

  def list_members
    @member_list
  end
end

BOOK_MENU = [
  [1, "Add a book"],
  [2, "Remove a book"],
  [3, "View all books"],
  [4, "Search for a book"],
  [5, "Borrow a book"],
  [6, "Return a book"],
  [7, "Sort books by title"],
  [8, "Filter books by genre"],
  [9, "Track overdue books"]
].freeze

MEMBER_MENU = [
  [10, "Add a member"],
  [11, "Find a member"],
  [12, "List all members"],
  [13, "Remove a member"]
].freeze

SYSTEM_MENU = [[14, "Exit"]].freeze

def print_menu
  TerminalUI.divider("=")
  TerminalUI.menu_section("BOOKS", BOOK_MENU)
  TerminalUI.menu_section("MEMBERS", MEMBER_MENU)
  TerminalUI.menu_section("SYSTEM", SYSTEM_MENU)
end

if __FILE__ == $PROGRAM_NAME
  library = Library.new

  while true
    TerminalUI.clear_screen
    TerminalUI.banner("LIBRARY MANAGEMENT SYSTEM")
    puts
    print_menu

    response = TerminalUI.prompt("Enter your choice: ")
    TerminalUI.divider

    if response == "1"
      title = TerminalUI.prompt("Enter Book Title: ")
      book_id = TerminalUI.prompt("Enter Book ID: ")
      author = TerminalUI.prompt("Enter Author Name: ")
      genre = TerminalUI.prompt("Enter Book Genre: ")

      book = Book.new(title, book_id, author, genre)
      library.add_book(book)

    elsif response == "2"
      book_id = TerminalUI.prompt("Enter Book ID: ")

      library.remove_book(book_id)

    elsif response == "3"
      if library.books.empty?
        TerminalUI.warn_msg("No books in the library yet.")
      else
        TerminalUI.heading("All Books")
        library.display_books
      end

    elsif response == "4"
      title = TerminalUI.prompt("Enter Book Title: ")

      library.search_book(title)

    elsif response == "5"
      book_id = TerminalUI.prompt("Enter Book ID: ")
      member_id = TerminalUI.prompt("Enter Member ID: ")
      return_date = TerminalUI.prompt_date("Please Enter Return Date")

      library.borrow_book(book_id, member_id, return_date)

    elsif response == "6"
      book_id = TerminalUI.prompt("Enter Book ID: ")

      library.return_book(book_id)

    elsif response == "7"
      library.sort_books_by_title

    elsif response == "8"
      filter_genre = TerminalUI.prompt("Enter Book Genre for Filtering: ")

      library.filter_books_by_genre(filter_genre)

    elsif response == "9"
      current_date = TerminalUI.prompt_date("Please Enter Current Date to Track Overdues")

      library.track_overdue_books(current_date)

    elsif response == "10"
      member_id = TerminalUI.prompt("Enter Member ID: ")
      name = TerminalUI.prompt("Enter Member Name: ")

      begin
        member = LibraryMember.new(member_id, name)
        library.add_member(member)
        TerminalUI.success("Member added! #{name}")
      rescue ArgumentError => e
        TerminalUI.error_msg(e.message)
      end

    elsif response == "11"
      member_id = TerminalUI.prompt("Enter Member ID: ")

      member = library.find_member(member_id)

      if member
        TerminalUI.info("Member ID: #{member.member_id}, Name: #{member.name}")
      else
        TerminalUI.error_msg("Member with ID #{member_id} not found!")
      end

    elsif response == "12"
      members = library.list_members

      if members.empty?
        TerminalUI.warn_msg("No members found.")
      else
        TerminalUI.heading("All Members")
        members.each do |library_member|
          TerminalUI.info("Member ID: #{library_member.member_id}, Name: #{library_member.name}")
        end
      end

    elsif response == "13"
      member_id = TerminalUI.prompt("Enter Member ID: ")

      member = library.remove_member(member_id)

      if member
        TerminalUI.success("Member Removed! #{member.name}")
      else
        TerminalUI.error_msg("Member with ID #{member_id} not found!")
      end

    elsif response == "14"
      TerminalUI.success("Thank you for visiting the Library!")
      break

    else
      TerminalUI.error_msg("Invalid choice!")
    end

    TerminalUI.pause
  end
end
