# Planning

## What we are building

A Library Management System that runs from the command line. It is written in Ruby.

A librarian uses a numbered menu to add and remove books, search for books, check books out, and return them. We are also adding library members so the system can keep track of who uses the library.

Team:
- Christopher Parker
- Can Ercan

## Essential features

These are the core features from our proposal. The app is not done without them.

- Add books
- Remove books
- Search books
- Borrow (check out) books
- Return books
- Member management (being added now)

## Optional / stretch features

These are nice to have. We will keep them if they work and do not get in the way of the essential features.

- Due dates when borrowing a book
- Overdue tracking
- Book categories (genre filter)

First versions of these already exist in the original Library class. They may still need cleanup and tests.

## How we are splitting the work

We are splitting the project between individual tasks and shared review. Each team member will work on features, tests, and documentation. We will review each other's work and help with remaining tasks before submission.

## How we work

- One small task at a time.
- Each task gets its own commit with a short message.
- New classes go in their own file. The original `Project_1.rb` stays in place.
- Program logic should return values. Printing belongs in the menu code.
- Invalid input should show a message, not crash the program.

## Definition of done for a feature or story

A feature or story is done when:
- The feature works the way the user story describes.
- Invalid input does not crash the app.
- Tests for the feature pass with `rake test`.
- The code is simple enough for the other teammate to read.
- The work is committed and pushed to GitHub.

## Definition of done for the project

The project is done when:
- All essential features work.
- All tests pass.
- The required docs exist: user stories, pairing log, design, backlog, planning, retrospective, and README.
- Both team members have commits in the repository.
- The app runs from the command line with `ruby Project_1.rb`.
- The project is ready to hand in as the team deliverable.
