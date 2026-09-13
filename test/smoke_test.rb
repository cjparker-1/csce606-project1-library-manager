require_relative "test_helper"

class SmokeTest < Minitest::Test
  def test_project_file_loads_without_starting_menu
    assert defined?(Book)
    assert defined?(Library)
  end
end
