require "minitest/autorun"
require "open3"

# Runs the real program with typed input and checks what it prints.
class MemberMenuTest < Minitest::Test
  RUNNER = File.expand_path("run_with_coverage.rb", __dir__)

  def run_menu(*inputs)
    typed = (inputs + ["14"]).join("\n") + "\n"
    output, _status = Open3.capture2("ruby", RUNNER, stdin_data: typed)
    output
  end

  def test_add_and_list_member
    output = run_menu("10", "M1", "Alice", "12")

    assert_includes output, "Member added! Alice"
    assert_includes output, "Member ID: M1, Name: Alice"
  end

  def test_find_member
    output = run_menu("10", "M1", "Alice", "11", "M1")

    assert_includes output, "Member ID: M1, Name: Alice"
  end

  def test_find_unknown_member
    output = run_menu("11", "M9")

    assert_includes output, "Member with ID M9 not found!"
  end

  def test_list_with_no_members
    output = run_menu("12")

    assert_includes output, "No members found."
  end

  def test_remove_member
    output = run_menu("10", "M1", "Alice", "13", "M1", "12")

    assert_includes output, "Member Removed! Alice"
    assert_includes output, "No members found."
  end

  def test_remove_unknown_member
    output = run_menu("13", "M9")

    assert_includes output, "Member with ID M9 not found!"
  end

  def test_blank_member_id_shows_error_and_keeps_running
    output = run_menu("10", "", "Alice")

    assert_includes output, "Member ID cannot be blank"
    assert_includes output, "Thank you for visiting the Library!"
  end

  def test_duplicate_member_id_shows_error_and_keeps_running
    output = run_menu("10", "M1", "Alice", "10", "M1", "Bob")

    assert_includes output, "Member ID M1 already exists"
    assert_includes output, "Thank you for visiting the Library!"
  end

  def test_member_borrows_and_returns_book
    output = run_menu("1", "Dune", "B1", "Frank Herbert", "Sci-Fi",
                      "10", "M1", "Alice",
                      "5", "B1", "M1", "2026-10-01",
                      "6", "B1")

    assert_includes output, "Book borrowed by Alice and return date is: 2026-10-01"
    assert_includes output, "Book has been returned!"
  end

  def test_unknown_member_cannot_borrow
    output = run_menu("1", "Dune", "B1", "Frank Herbert", "Sci-Fi",
                      "5", "B1", "M9", "2026-10-01")

    assert_includes output, "Member with ID M9 not found! Unable to borrow."
    refute_includes output, "Book borrowed by"
  end
end
