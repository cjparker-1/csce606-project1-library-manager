require "rake/testtask"
require "fileutils"

# Remove old coverage data so each test run starts fresh.
task :clear_coverage do
  FileUtils.rm_rf("coverage")
end

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList["test/*_test.rb"]
end

task test: :clear_coverage
task default: :test
