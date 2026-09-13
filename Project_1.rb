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

    return "Title: #{@title}, ID: #{@book_id}, Author: #{@author}, Genre: #{@genre}, Status: #{status}#{borrower_info}"
  end

  def borrow_book(borrower_name, return_date)
    if !@is_borrowed
      puts "Book borrowed by #{borrower_name} and return date is: #{return_date}"

      @borrower = borrower_name
      @return_date = return_date
      @is_borrowed = true
    else
      puts "Book is already taken out!"
    end
  end

  def return_book
    if @is_borrowed
      puts "Book has been returned!"

      @is_borrowed = false
      @borrower = nil
      @return_date = nil
    else
      puts "Book is already in the system!"
    end
  end

  def update_genre(new_genre)
    old_genre = @genre
    @genre = new_genre

    puts "Genre changed! Old Genre: #{old_genre} to #{new_genre}"
  end
end


class Library
  def initialize
    @book_list = []
    @member_list = []
  end

  def add_book(book)
    @book_list << book
    puts "#{book} added to System!"
  end

  def remove_book(book_id)
    found = false

    for book in @book_list
      if book.book_id == book_id
        @book_list.delete(book)
        puts "Book Removed! #{book.title}"
        found = true
        break
      end
    end

    if !found
      puts "Book with ID #{book_id} not found!"
    end
  end

  def display_books
    for book in @book_list
      puts "Title: #{book.title}, ID: #{book.book_id}, Author: #{book.author}, Genre: #{book.genre}"
    end
  end

  def search_book(title)
    found = false

    for book in @book_list
      if book.title == title
        puts "Title: #{book.title}, Book Found!"
        found = true
        break
      end
    end

    if !found
      puts "Book with title '#{title}' not found!"
    end
  end

  def borrow_book(book_id, borrower_name, return_date)
    found = false

    for book in @book_list
      if book.book_id == book_id
        book.borrow_book(borrower_name, return_date)
        found = true
        break
      end
    end

    if !found
      puts "Book with ID #{book_id} not found! Unable to borrow."
    end
  end

  def return_book(book_id)
    found = false

    for book in @book_list
      if book.book_id == book_id
        book.return_book
        found = true
        break
      end
    end

    if !found
      puts "Book with ID #{book_id} not found! Unable to return."
    end
  end

  def sort_books_by_title
    @book_list.sort_by! do |book|
      book.title
    end

    puts "Books are sorted!"

    for book in @book_list
      puts book
    end
  end

  def filter_books_by_genre(genre)
    filtered_list = []

    for book in @book_list
      if book.genre == genre
        filtered_list << book
      end
    end

    if filtered_list.length > 0
      puts "Books in Genre: #{genre}"

      for book in filtered_list
        puts book
      end
    else
      puts "No books found in #{genre}"
    end
  end

  def track_overdue_books(current_date)
    overdue_list = []

    for book in @book_list
      if book.return_date != nil && book.return_date < current_date
        overdue_list << book
      end
    end

    if overdue_list.length > 0
      puts "Overdue Books:"

      for book in overdue_list
        puts "Title: #{book.title}, Borrower: #{book.borrower}, Due Date: #{book.return_date}"
      end
    else
      puts "No overdue books found."
    end
  end

  def add_member(member)
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


if __FILE__ == $0
  library = Library.new


  while true
    puts
    puts "Welcome To Library:"
    puts "1 - Add a book"
    puts "2 - Remove a book"
    puts "3 - View all books"
    puts "4 - Search for a book"
    puts "5 - Borrow a book"
    puts "6 - Return a book"
    puts "7 - Sort books by title"
    puts "8 - Filter books by genre"
    puts "9 - Track overdue books"
    puts "10 - Exit"

    print "Enter your choice: "
    response = gets.chomp

    if response == "1"
      print "Enter Book Title: "
      title = gets.chomp

      print "Enter Book ID: "
      book_id = gets.chomp

      print "Enter Author Name: "
      author = gets.chomp

      print "Enter Book Genre: "
      genre = gets.chomp

      book = Book.new(title, book_id, author, genre)
      library.add_book(book)

    elsif response == "2"
      print "Enter Book ID: "
      book_id = gets.chomp

      library.remove_book(book_id)

    elsif response == "3"
      library.display_books

    elsif response == "4"
      print "Enter Book Title: "
      title = gets.chomp

      library.search_book(title)

    elsif response == "5"
      print "Enter Book ID: "
      book_id = gets.chomp

      print "Please Enter Borrower Name: "
      borrower_name = gets.chomp

      print "Please Enter Return Date: "
      return_date = gets.chomp

      library.borrow_book(book_id, borrower_name, return_date)

    elsif response == "6"
      print "Enter Book ID: "
      book_id = gets.chomp

      library.return_book(book_id)

    elsif response == "7"
      library.sort_books_by_title

    elsif response == "8"
      print "Enter Book Genre for Filtering: "
      filter_genre = gets.chomp

      library.filter_books_by_genre(filter_genre)

    elsif response == "9"
      print "Please Enter Current Date to Track Overdues: "
      current_date = gets.chomp

      library.track_overdue_books(current_date)

    elsif response == "10"
      puts "Thank you for visiting the Library!"
      break

    else
      puts "Invalid choice!"
    end
  end
end
