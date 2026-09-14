# Library Management System

A small Ruby command-line library management app for adding, removing, searching, borrowing, and returning books. It also has basic member management.

## Team

- Christopher Parker
- Can Ercan

## Setup

You need Ruby installed. The project was built and tested with Ruby 2.6.

Check your Ruby version:

```
ruby -v
```

Minitest and Rake come with Ruby. SimpleCov and RuboCop are listed in the `Gemfile`. Install them with:

```
bundle install
```

On a Mac with the built-in Ruby, `bundle install` may ask for sudo. We installed the gems for our user instead with `gem install <gem> --user-install`.

Clone the repository and go into the folder:

```
git clone https://github.com/cjparker-1/csce606-project1-library-manager.git
cd csce606-project1-library-manager
```

## Running the app

```
ruby Project_1.rb
```

A numbered menu appears. Type the number of the option you want and press Enter. Pick `14` to exit.

## Running the tests

```
rake test
```

This runs every test file in the `test/` folder. You can also run one file on its own, for example:

```
ruby test/library_member_test.rb
```

## Coverage

Coverage uses SimpleCov and runs automatically with the tests:

```
rake test
```

The last line of the output shows the line coverage. It is currently about 93%. A full report is written to `coverage/index.html`, which you can open in a browser. The `coverage/` folder is not committed.

## Code style

We use RuboCop. Run it with:

```
bundle exec rubocop
```

The settings are in `.rubocop.yml`. RuboCop currently reports no offenses.

## Main features

- Add books
- Remove books
- View books
- Search books
- Borrow books
- Return books
- Sort by title
- Filter by genre
- Track overdue books
- Basic member management

## Known limitations

- Data is stored only in memory and is lost when the program exits.
- Input validation is still being improved.

## Project documents

- `docs/user_stories.md`
- `docs/planning.md`
- `docs/design.md`
- `docs/backlog.md`
