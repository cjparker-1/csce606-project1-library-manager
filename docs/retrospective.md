# Retrospective

## What went well

- We had a working starting version early. The first version of the program already had books, a library, and a menu, so we had something to build on right away.
- We added member management. Members have an ID and a name, and the library can add, find, list, and remove them from the menu.
- Borrowing and returning were connected to members. A book is checked out to a member ID, and the book shows up in that member's borrowed list until it is returned.
- Testing improved a lot. We started with one smoke test and ended with 57 tests, including unit tests for every class and acceptance tests that run the real menu.
- Final line coverage is about 93%.
- RuboCop reports no offenses.
- GitHub helped keep the work organized. Each task got its own small commit, so it was easy to see what changed and when.

## What was difficult

- Much of the original project was in one Ruby file. The classes and the menu were all in `Project_1.rb`, so we had to add a run guard before tests could even load it.
- Testing the menu was harder because it runs in a separate process. The acceptance tests have to start the program, type input into it, and read what it prints.
- SimpleCov subprocess coverage took extra work. Ruby does not record coverage for the main script, so we needed a small runner file that starts SimpleCov and then loads the program, and each run has to be named so the results merge.
- Ruby 2.6 caused gem compatibility problems. The newest SimpleCov and RuboCop versions need a newer Ruby, and some of their dependencies had to be pinned to older versions before they would install.
- Adding new member features without rewriting the original code took some care. We kept most of the original structure and added the new member features with only small changes where needed.

## What we would improve next time

- Separate the menu from the application logic earlier. Having them apart from the start would have made testing simpler.
- Set up GitHub, tests, coverage, and RuboCop earlier, before most of the code was written.
- Plan pair-programming sessions earlier instead of near the end.
- Add stronger book input validation earlier. Blank titles and duplicate book IDs are still accepted.

## Did the project meet our goal?

Yes. It is a working command-line Library Management System. It can manage books and members. Users can add, remove, search, borrow, and return books, and it handles several invalid cases without crashing, such as unknown IDs, blank member input, duplicate member IDs, and borrowing a book that is already out.

Data is still only stored in memory, so everything is lost when the program exits. That leaves room to improve later.
