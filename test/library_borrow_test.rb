require_relative "test_helper"

class LibraryBorrowTest < Minitest::Test
  def setup
    @library = Library.new
    @book = Book.new("Dune", "B1", "Frank Herbert", "Sci-Fi")
    @alice = LibraryMember.new("M1", "Alice")
    @bob = LibraryMember.new("M2", "Bob")

    capture_io { @library.add_book(@book) }
    @library.add_member(@alice)
    @library.add_member(@bob)
  end

  def test_member_borrows_book
    capture_io { @library.borrow_book("B1", "M1", "2026-10-01") }

    assert @book.is_borrowed
    assert_equal "Alice", @book.borrower
    assert_equal "2026-10-01", @book.return_date
  end

  def test_borrowed_book_is_added_to_member_list
    capture_io { @library.borrow_book("B1", "M1", "2026-10-01") }

    assert_equal [@book], @alice.borrowed_books
  end

  def test_return_removes_book_from_member
    capture_io do
      @library.borrow_book("B1", "M1", "2026-10-01")
      @library.return_book("B1")
    end

    assert_equal [], @alice.borrowed_books
    refute @book.is_borrowed
    assert_nil @book.borrower
  end

  def test_unknown_member_cannot_borrow
    output, _err = capture_io { @library.borrow_book("B1", "M9", "2026-10-01") }

    assert_includes output, "Member with ID M9 not found! Unable to borrow."
    refute @book.is_borrowed
  end

  def test_unknown_book_cannot_be_borrowed
    output, _err = capture_io { @library.borrow_book("B9", "M1", "2026-10-01") }

    assert_includes output, "Book with ID B9 not found! Unable to borrow."
    assert_equal [], @alice.borrowed_books
  end

  def test_already_borrowed_book_cannot_be_borrowed_again
    output, _err = capture_io do
      @library.borrow_book("B1", "M1", "2026-10-01")
      @library.borrow_book("B1", "M2", "2026-11-01")
    end

    assert_includes output, "Book is already taken out!"
    assert_equal "Alice", @book.borrower
    assert_equal [@book], @alice.borrowed_books
    assert_equal [], @bob.borrowed_books
  end

  def test_return_unknown_book_does_not_crash
    output, _err = capture_io { @library.return_book("B9") }

    assert_includes output, "Book with ID B9 not found! Unable to return."
  end

  def test_return_book_that_is_not_borrowed_does_not_crash
    output, _err = capture_io { @library.return_book("B1") }

    assert_includes output, "Book is already in the system!"
    refute @book.is_borrowed
  end
end
