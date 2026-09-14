require_relative "test_helper"

class BookTest < Minitest::Test
  def setup
    @book = Book.new("Dune", "B1", "Frank Herbert", "Sci-Fi")
  end

  def test_new_book_is_available
    refute @book.is_borrowed
    assert_nil @book.borrower
    assert_nil @book.return_date
  end

  def test_to_s_when_available
    expected = "Title: Dune, ID: B1, Author: Frank Herbert, Genre: Sci-Fi, Status: Available"

    assert_equal expected, @book.to_s
  end

  def test_to_s_when_borrowed
    capture_io { @book.borrow_book("Alice", "2026-10-01") }
    expected = "Title: Dune, ID: B1, Author: Frank Herbert, Genre: Sci-Fi, " \
               "Status: Borrowed, Borrower: Alice, Return Date: 2026-10-01"

    assert_equal expected, @book.to_s
  end

  def test_borrow_book
    output, _err = capture_io { @book.borrow_book("Alice", "2026-10-01") }

    assert_includes output, "Book borrowed by Alice and return date is: 2026-10-01"
    assert @book.is_borrowed
    assert_equal "Alice", @book.borrower
  end

  def test_borrow_book_already_borrowed
    capture_io { @book.borrow_book("Alice", "2026-10-01") }
    output, _err = capture_io { @book.borrow_book("Bob", "2026-11-01") }

    assert_includes output, "Book is already taken out!"
    assert_equal "Alice", @book.borrower
  end

  def test_return_book
    capture_io { @book.borrow_book("Alice", "2026-10-01") }
    output, _err = capture_io { @book.return_book }

    assert_includes output, "Book has been returned!"
    refute @book.is_borrowed
    assert_nil @book.borrower
    assert_nil @book.return_date
  end

  def test_return_book_not_borrowed
    output, _err = capture_io { @book.return_book }

    assert_includes output, "Book is already in the system!"
  end

  def test_update_genre
    output, _err = capture_io { @book.update_genre("Fantasy") }

    assert_includes output, "Genre changed! Old Genre: Sci-Fi to Fantasy"
    assert_equal "Fantasy", @book.genre
  end
end
