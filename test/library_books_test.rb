require_relative "test_helper"

class LibraryBooksTest < Minitest::Test
  def setup
    @library = Library.new
    @dune = Book.new("Dune", "B1", "Frank Herbert", "Sci-Fi")
    @hobbit = Book.new("The Hobbit", "B2", "J.R.R. Tolkien", "Fantasy")
    @alice = LibraryMember.new("M1", "Alice")

    capture_io do
      @library.add_book(@dune)
      @library.add_book(@hobbit)
    end
    @library.add_member(@alice)
  end

  def test_add_book_prints_message
    book = Book.new("Emma", "B3", "Jane Austen", "Classic")
    output, _err = capture_io { @library.add_book(book) }

    assert_includes output, "Title: Emma, ID: B3, Author: Jane Austen, Genre: Classic, Status: Available added to System!"
    assert_equal book, @library.find_book("B3")
  end

  def test_remove_book
    output, _err = capture_io { @library.remove_book("B1") }

    assert_includes output, "Book Removed! Dune"
    assert_nil @library.find_book("B1")
  end

  def test_remove_book_not_found
    output, _err = capture_io { @library.remove_book("B9") }

    assert_includes output, "Book with ID B9 not found!"
    refute_nil @library.find_book("B1")
  end

  def test_display_books
    output, _err = capture_io { @library.display_books }

    assert_includes output, "Title: Dune, ID: B1, Author: Frank Herbert, Genre: Sci-Fi"
    assert_includes output, "Title: The Hobbit, ID: B2, Author: J.R.R. Tolkien, Genre: Fantasy"
  end

  def test_display_books_when_empty
    output, _err = capture_io { Library.new.display_books }

    assert_equal "", output
  end

  def test_search_book_found
    output, _err = capture_io { @library.search_book("Dune") }

    assert_includes output, "Title: Dune, Book Found!"
  end

  def test_search_book_not_found
    output, _err = capture_io { @library.search_book("Missing Book") }

    assert_includes output, "Book with title 'Missing Book' not found!"
  end

  def test_sort_books_by_title
    output, _err = capture_io { @library.sort_books_by_title }

    assert_includes output, "Books are sorted!"
    assert output.index("Dune") < output.index("The Hobbit")
  end

  def test_sort_books_by_title_changes_order
    zebra = Book.new("Aardvark Tales", "B3", "Someone", "Kids")
    capture_io { @library.add_book(zebra) }
    output, _err = capture_io { @library.sort_books_by_title }

    assert output.index("Aardvark Tales") < output.index("Dune")
  end

  def test_filter_books_by_genre
    output, _err = capture_io { @library.filter_books_by_genre("Fantasy") }

    assert_includes output, "Books in Genre: Fantasy"
    assert_includes output, "The Hobbit"
    refute_includes output, "Dune"
  end

  def test_filter_books_by_genre_none_found
    output, _err = capture_io { @library.filter_books_by_genre("Horror") }

    assert_includes output, "No books found in Horror"
  end

  def test_track_overdue_books
    capture_io { @library.borrow_book("B1", "M1", "2026-09-01") }
    output, _err = capture_io { @library.track_overdue_books("2026-10-01") }

    assert_includes output, "Overdue Books:"
    assert_includes output, "Title: Dune, Borrower: Alice, Due Date: 2026-09-01"
  end

  def test_track_overdue_books_none_overdue
    capture_io { @library.borrow_book("B1", "M1", "2026-12-01") }
    output, _err = capture_io { @library.track_overdue_books("2026-10-01") }

    assert_includes output, "No overdue books found."
  end

  def test_track_overdue_books_ignores_available_books
    output, _err = capture_io { @library.track_overdue_books("2026-10-01") }

    assert_includes output, "No overdue books found."
  end
end
