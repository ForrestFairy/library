defmodule Library.BooksTest do
  use Library.DataCase

  alias Library.Books

  describe "books" do
    alias Library.Books.Book

    import Library.BooksFixtures

    @invalid_attrs %{title: nil, author: nil, ISBN: nil, genre: nil, location: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Books.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Books.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{title: "some title", author: "some author", ISBN: "some ISBN", genre: "some genre", location: "some location"}

      assert {:ok, %Book{} = book} = Books.create_book(valid_attrs)
      assert book.title == "some title"
      assert book.author == "some author"
      assert book.ISBN == "some ISBN"
      assert book.genre == "some genre"
      assert book.location == "some location"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Books.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{title: "some updated title", author: "some updated author", ISBN: "some updated ISBN", genre: "some updated genre", location: "some updated location"}

      assert {:ok, %Book{} = book} = Books.update_book(book, update_attrs)
      assert book.title == "some updated title"
      assert book.author == "some updated author"
      assert book.ISBN == "some updated ISBN"
      assert book.genre == "some updated genre"
      assert book.location == "some updated location"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Books.update_book(book, @invalid_attrs)
      assert book == Books.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Books.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Books.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Books.change_book(book)
    end
  end
end
