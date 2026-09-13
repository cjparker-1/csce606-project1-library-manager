class LibraryMember
  attr_reader :member_id, :name, :borrowed_books

  def initialize(member_id, name)
    @member_id = member_id
    @name = name
    @borrowed_books = []
  end

  def add_borrowed_book(book)
    @borrowed_books << book
  end

  def remove_borrowed_book(book)
    @borrowed_books.delete(book)
  end
end
