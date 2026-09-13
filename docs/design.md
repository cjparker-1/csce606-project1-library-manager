# Design

## 1. System Architecture

The app is a small command-line program written in Ruby. It has three classes and one menu loop.

```
Project_1.rb
  Book            - one book and its borrow state
  Library         - holds all books and all members
  menu loop       - prints the menu, reads input, calls Library

library_member.rb
  LibraryMember   - one member and the books they have borrowed

test/
  test_helper.rb  - loads minitest and Project_1.rb
  *_test.rb       - unit tests
```

Everything lives in memory. There is no file or database. When the program exits, the books and members are gone.

## 2. Responsibilities

**Book** (`Project_1.rb`)
- Stores title, book ID, author, and genre.
- Tracks whether the book is borrowed, who borrowed it, and the return date.
- Can mark itself borrowed or returned.

**Library** (`Project_1.rb`)
- Keeps a list of `Book` objects and a list of `LibraryMember` objects.
- Book methods: add, remove, display, search by title, borrow, return, sort by title, filter by genre, track overdue.
- Member methods: add, find by ID, remove by ID, list.

**LibraryMember** (`library_member.rb`)
- Stores member ID and name.
- Keeps a list of the `Book` objects the member has borrowed.
- Can add a borrowed book and remove a returned book.

**Menu loop** (bottom of `Project_1.rb`)
- Prints the numbered menu.
- Reads what the user types.
- Asks for any extra details (title, ID, and so on).
- Calls the matching `Library` method.
- Repeats until the user picks Exit.

## 3. How the classes interact

- The menu creates one `Library` and calls its methods. The menu never touches a `Book` directly except to build a new one for "Add a book".
- `Library` owns the `Book` and `LibraryMember` objects. It looks them up by ID and calls their methods.
- `LibraryMember` holds `Book` objects in its borrowed list.

Right now the menu only uses the book methods. The member methods exist in `Library` and are tested, but they are not connected to the menu yet. Borrowing still records a borrower name as plain text instead of a `LibraryMember`. Connecting these is on the backlog.

## 4. User Interface Design

The user interface is a numbered text menu in the terminal.

Start the program:

```
ruby Project_1.rb
```

The menu looks like this:

```
Welcome To Library:
1 - Add a book
2 - Remove a book
3 - View all books
4 - Search for a book
5 - Borrow a book
6 - Return a book
7 - Sort books by title
8 - Filter books by genre
9 - Track overdue books
10 - Exit
Enter your choice:
```

Basic workflow:

1. The user runs `ruby Project_1.rb`.
2. The menu appears.
3. The user types a number and presses Enter.
4. The program asks for any information it needs, one line at a time. For example, "Borrow a book" asks for a book ID, a borrower name, and a return date.
5. The action runs and prints a short result message.
6. The menu appears again. This repeats until the user picks 10 - Exit.

If the user types a number that is not on the menu, the program prints "Invalid choice!" and shows the menu again.

## 5. Design decisions and tradeoffs

- **Command-line interface.** The project requires a terminal app, so there is no GUI or web page. This keeps the code small and easy to test.
- **Member code in its own file.** `LibraryMember` lives in `library_member.rb`. This keeps it easy to find, test, and read, and it keeps the member work separate from the original book code.
- **`Project_1.rb` stays in place.** The original `Book`, `Library`, and menu structure stays in place instead of being rewritten. New code is added next to it. The only change to the original structure was wrapping the menu in a run guard so tests can load the file without starting the menu.
- **Logic separate from printing when possible.** The original book methods print their own messages. The newer member methods return values instead and leave printing to the menu. This makes them easier to test. We did not go back and change the book methods, so the two styles both exist for now.
- **Simple arrays.** Books and members are stored in plain Ruby arrays. Lookups walk the array. This is slow for a huge library but fine for a small student project, and it keeps the code easy to follow.
- **No saving to disk.** Data lives only while the program runs. Saving to a file would be a nice feature but was not required.
