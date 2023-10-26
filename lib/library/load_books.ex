defmodule Library.LoadBooks do
  alias Library.Books

  def read_books(file, location) do
    File.cd!("priv/static/load_books")
    file
    |> File.read!()
    |> String.split("\r\n")
    |> Enum.map(&(String.split(&1, ",")))
    |> Enum.map(fn [title, author, isbn, genre] ->
                  genre =
                    genre
                    |> String.trim_leading("[")
                    |> String.trim_trailing("]")
                    |> String.split(";")

                  Books.create_book(%{title: title, author: author, isbn: isbn, genre: genre, location: location})
                end)

    File.cd!("../../..")
  end
end
