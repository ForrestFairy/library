defmodule Library.BooksTest do
  use Library.DataCase

  alias Library.Books

  describe "books" do
    alias Library.Books.Book

    import Library.BooksFixtures

    @invalid_attrs %{state: nil, title: nil, location: nil, author: nil, isbn: nil, genre: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Books.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Books.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{title: "some title", location: 12, author: "some author", isbn: "some isbn", genre: ["option1", "option2"]}

      assert {:ok, %Book{} = book} = Books.create_book(valid_attrs)
      assert book.state == 1
      assert book.title == "some title"
      assert book.location == 12
      assert book.author == "some author"
      assert book.isbn == "some isbn"
      assert book.genre == ["option1", "option2"]
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Books.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{state: 43, title: "some updated title", location: 12, author: "some updated author", isbn: "some updated isbn", genre: ["option1"]}

      assert {:ok, %Book{} = book} = Books.update_book(book, update_attrs)
      assert book.state == 43
      assert book.title == "some updated title"
      assert book.location == 12
      assert book.author == "some updated author"
      assert book.isbn == "some updated isbn"
      assert book.genre == ["option1"]
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
