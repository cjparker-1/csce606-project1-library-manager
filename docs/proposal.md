# Project Proposal: Library Management System

## Team Members

- Can Ercan
- Christopher Parker

## Application Name

Library Management System

## Application Description

The Library Management System is a simple application designed to help a school library keep track of books and library members. The application will allow users to add, remove, and search for books, as well as check books out to members and process book returns.

## Intended Users

The intended users are school library staff, custodians, or students who need an easy way to manage and access information about books in the school library.

## Core Features

### Add Books
Add a new book to the library system with information such as title, author, and book ID.

### Remove Books
Remove a book from the library system when it is no longer available.

### Search Books
Search for a book by title, author, or book ID.

### Check Out Books
Allow a library member to check out an available book. The system will update the book's availability and associate the book with the member.

### Return Books
Allow a member to return a checked-out book. The book will become available again and will be removed from the member's checked-out books.

## Stretch Features

### Due Dates
Keep track of when checked-out books are due.

### Late Book Tracking
Identify and display books that are overdue.

### Book Categories
Organize books into categories such as fiction, nonfiction, science, and history.

## Main Classes / Modules

### LibraryManager
Controls the main functionality of the application and manages the collection of books and library members.

### Book
Stores information about each book, including:

- Title
- Author
- Book ID
- Availability

### LibraryMember
Stores information about each library member and keeps track of the books currently checked out by that member.

### UserInterface
Provides a menu-based interface that allows the user to select different actions. A while loop will keep the program running until the user chooses to exit.

## Testing Plan

### Add Books
- Start with an empty library.
- Add a new book.
- Search for the book.
- Verify that the book exists in the library.

### Remove Books
- Start with a library containing a book.
- Remove the book.
- Search for the removed book.
- Verify that the book is no longer found.

### Search Books
- Add a book titled Harry Potter.
- Search for Harry Potter.
- Verify that the correct book information is returned.

### Check Out Books
- Start with an available book and an existing library member.
- Check out the book to the member.
- Verify that the book is marked as unavailable.
- Verify that the book is associated with the correct member.

### Return Books
- Start with a book that is already checked out.
- Return the book.
- Verify that the book is marked as available.
- Verify that the book is removed from the member's checked-out books.

## Manual Testing

The application will also use a while-loop menu interface so that each feature can be manually tested. Users will be able to repeatedly select actions such as adding, removing, searching, checking out, and returning books until they choose to exit the program.
