defmodule Library.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Library.Books` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        isbn: "some isbn",
        author: "some author",
        genre: ["option1", "option2"],
        location: 1,
        state: 42,
        title: "some title"
      })
      |> Library.Books.create_book()

    book
  end
end
