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
        title: "some title",
        author: "some author",
        ISBN: "some ISBN",
        genre: "some genre",
        location: "some location"
      })
      |> Library.Books.create_book()

    book
  end
end
