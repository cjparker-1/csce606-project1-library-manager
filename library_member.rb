class LibraryMember
  attr_reader :member_id, :name, :borrowed_books

  def initialize(member_id, name)
    raise ArgumentError, "Member ID cannot be blank" if blank?(member_id)
    raise ArgumentError, "Member name cannot be blank" if blank?(name)

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

  private

  def blank?(value)
    value.to_s.strip.empty?
  end
end
