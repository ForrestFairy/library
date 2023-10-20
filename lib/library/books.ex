defmodule Library.Books do
  @moduledoc """
  The Books context.
  """

  import Ecto.Query, warn: false
  alias Library.Repo

  alias Library.Books.Book

  def list_katalog("0"), do: list_books()

  def list_katalog(katalog) do
    Repo.all(from book in Book,
              where: book.location == ^katalog,
              select: book)
  end

  def suggest(_, ""), do: []

  def suggest(katalog, prefix) do
    Enum.filter(list_katalog(katalog), &has_prefix?(&1, prefix))
  end

  def has_prefix?(book, prefix) do
    String.starts_with?(String.downcase(book.title), String.downcase(prefix))
  end

  def search_by_title(title), do: search_by_title("0", title)

  def search_by_title(katalog, title) do
    list_katalog(katalog)
    |> Enum.filter(&(&1.title == title))
  end

  def reserve_book(id) do
    id
    |> get_book!
    |> reserve
  end

  defp reserve(%Book{} = book) do
    case book.state do
      1 ->
        update_book(book, %{state: 2})
      _ ->
        {:error, :not_available}
    end
  end

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}

  """
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end
end
