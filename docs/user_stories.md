# User Stories

Roles used below:
- **Librarian**: the person running the program at the command line.

Stories marked **Essential** are the core features from our proposal.

---

## 1. Add a book (Essential)

As a librarian, I want to add a book to the library so that it can be borrowed later.

Acceptance criteria:
- The menu has an "Add a book" option.
- The program asks for title, book ID, author, and genre.
- After adding, the book shows up in "View all books".
- A new book starts as Available.

## 2. Remove a book (Essential)

As a librarian, I want to remove a book by its ID so that books we no longer have are not listed.

Acceptance criteria:
- The menu has a "Remove a book" option.
- The program asks for a book ID.
- If the ID matches a book, the book is removed and a message names the removed title.
- If the ID does not match, the program says the book was not found and keeps running.

## 3. Search for a book (Essential)

As a librarian, I want to search for a book by title so that I can quickly tell if we have it.

Acceptance criteria:
- The menu has a "Search for a book" option.
- The program asks for a title.
- If a book with that title exists, the program says it was found.
- If no book matches, the program says it was not found.

## 4. Borrow a book (Essential)

As a librarian, I want to check out a book to a borrower so that we know who has it and when it is due.

Acceptance criteria:
- The menu has a "Borrow a book" option.
- The program asks for a book ID, borrower name, and return date.
- If the book is available, it becomes Borrowed and stores the borrower and return date.
- The borrowed book shows the borrower and return date when listed.

## 5. Return a book (Essential)

As a librarian, I want to return a borrowed book so that it becomes available again.

Acceptance criteria:
- The menu has a "Return a book" option.
- The program asks for a book ID.
- If the book is borrowed, it becomes Available and the borrower and return date are cleared.
- If the book is not borrowed, the program says it is already in the system.

## 6. Manage library members

As a librarian, I want to add, look up, and remove library members so that I can keep track of who uses the library.

Acceptance criteria:
- A member has a member ID and a name.
- A member can be added to the library.
- A member can be found by member ID.
- A member can be removed by member ID.
- The library can list all current members.
- Looking up or removing an unknown member ID does not crash the program.

## 7. Borrow a book that is not available (Sad path)

As a librarian, I want a clear message when a book cannot be borrowed so that I do not think the checkout worked.

Acceptance criteria:
- If the book ID does not exist, the program says the book was not found and it cannot be borrowed.
- If the book is already borrowed, the program says it is already taken out.
- In both cases the book's borrower and return date do not change.
- The program returns to the menu instead of crashing.
