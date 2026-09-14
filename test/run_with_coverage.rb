# Runs Project_1.rb with coverage turned on.
# The menu tests use this instead of running Project_1.rb directly,
# because Ruby does not record coverage for the main script.
# Each run gets its own name so SimpleCov merges it into the main report.
require "simplecov"

SimpleCov.command_name "menu run #{Process.pid}"
SimpleCov.formatter = SimpleCov::Formatter::SimpleFormatter

program = File.expand_path("../Project_1.rb", __dir__)
$0 = program
load program
