require_relative "test_helper"
require_relative "../library_member"

class LibraryMembersTest < Minitest::Test
  def setup
    @library = Library.new
    @alice = LibraryMember.new("M1", "Alice")
    @bob = LibraryMember.new("M2", "Bob")
  end

  def test_new_library_has_no_members
    assert_equal [], @library.list_members
  end

  def test_add_member
    @library.add_member(@alice)

    assert_equal [@alice], @library.list_members
  end

  def test_find_member_by_id
    @library.add_member(@alice)
    @library.add_member(@bob)

    assert_equal @bob, @library.find_member("M2")
  end

  def test_find_member_not_found_returns_nil
    @library.add_member(@alice)

    assert_nil @library.find_member("M9")
  end

  def test_remove_member
    @library.add_member(@alice)
    @library.add_member(@bob)
    @library.remove_member("M1")

    assert_equal [@bob], @library.list_members
  end

  def test_remove_member_not_found_does_nothing
    @library.add_member(@alice)
    result = @library.remove_member("M9")

    assert_nil result
    assert_equal [@alice], @library.list_members
  end

  def test_duplicate_member_id_is_rejected
    @library.add_member(@alice)
    same_id = LibraryMember.new("M1", "Someone Else")

    error = assert_raises(ArgumentError) { @library.add_member(same_id) }

    assert_equal "Member ID M1 already exists", error.message
    assert_equal [@alice], @library.list_members
  end
end
