require_relative "test_helper"
require_relative "../library_member"

class LibraryMemberTest < Minitest::Test
  def setup
    @member = LibraryMember.new("M1", "Alice")
    @book = Book.new("Dune", "B1", "Frank Herbert", "Sci-Fi")
  end

  def test_new_member_has_no_books
    assert_equal "M1", @member.member_id
    assert_equal "Alice", @member.name
    assert_equal [], @member.borrowed_books
  end

  def test_add_borrowed_book
    @member.add_borrowed_book(@book)

    assert_equal [@book], @member.borrowed_books
  end

  def test_remove_borrowed_book
    @member.add_borrowed_book(@book)
    @member.remove_borrowed_book(@book)

    assert_equal [], @member.borrowed_books
  end

  def test_remove_book_not_borrowed_does_nothing
    result = @member.remove_borrowed_book(@book)

    assert_nil result
    assert_equal [], @member.borrowed_books
  end

  def test_blank_member_id_is_rejected
    error = assert_raises(ArgumentError) { LibraryMember.new("", "Alice") }

    assert_equal "Member ID cannot be blank", error.message
  end

  def test_whitespace_member_id_is_rejected
    assert_raises(ArgumentError) { LibraryMember.new("   ", "Alice") }
  end

  def test_nil_member_id_is_rejected
    assert_raises(ArgumentError) { LibraryMember.new(nil, "Alice") }
  end

  def test_blank_name_is_rejected
    error = assert_raises(ArgumentError) { LibraryMember.new("M1", "") }

    assert_equal "Member name cannot be blank", error.message
  end

  def test_whitespace_name_is_rejected
    assert_raises(ArgumentError) { LibraryMember.new("M1", "   ") }
  end
end
