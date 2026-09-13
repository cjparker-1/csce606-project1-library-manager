# Library Management System

A small Ruby command-line library management app for adding, removing, searching, borrowing, and returning books. Member management is also being added.

## Team

- Christopher Parker
- Can Ercan

## Setup

You need Ruby installed. The project was built and tested with Ruby 2.6.

Check your Ruby version:

```
ruby -v
```

The tests use Minitest and Rake. Both come with Ruby, so there is nothing else to install right now.

Clone the repository and go into the folder:

```
git clone https://github.com/cjparker-1/csce606-project1-library-manager.git
cd csce606-project1-library-manager
```

## Running the app

```
ruby Project_1.rb
```

A numbered menu appears. Type the number of the option you want and press Enter. Pick `10` to exit.

## Running the tests

```
rake test
```

This runs every test file in the `test/` folder. You can also run one file on its own, for example:

```
ruby test/library_member_test.rb
```

## Coverage

Coverage setup is planned but not added yet. We plan to use SimpleCov. This section will be updated with the command and instructions after SimpleCov is added.

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
- Member management is not connected to the menu yet.
- Borrowing still uses a borrower name instead of a `LibraryMember`.
- Input validation is still being improved.
- Coverage and RuboCop setup are not finished yet.

## Project documents

- `docs/user_stories.md`
- `docs/planning.md`
- `docs/design.md`
- `docs/backlog.md`
