defmodule Library.Books do
  @moduledoc """
  The Books context.
  """
  @base_amount 8
  import Ecto.Query, warn: false
  alias Library.Repo

  alias Library.Books.Book
  alias Library.Pagination
  def list_katalog(0), do: list_books(:paged, 1, @base_amount)
  def list_katalog(0, page), do: list_books(:paged, page, @base_amount)

  def list_katalog(a, page \\ 1, per_page \\ @base_amount)
  def list_katalog(0, page, per_page), do: list_books(:paged, page, per_page)

  def list_katalog(katalog, page, per_page) do
    Book
    |> where(location: ^katalog)
    |> order_by(asc: :title)
    |> Pagination.page(page, per_page: per_page)
  end

  def suggest(_, ""), do: []

  def suggest(katalog, prefix) do
    katalog
    |> list_katalog
    |> Map.fetch!(:list)
    |> Enum.filter(&has_prefix?(&1, prefix))
    |> Enum.slice(1..5)
  end

  def has_prefix?(book, prefix) do
    String.starts_with?(String.downcase(book.title), String.downcase(prefix))
  end

  def search_by_title("") do
    list_katalog(0)
    |> Map.fetch!(:list)
  end

  def search_by_title(title), do: search_by_title(0, title)

  def search_by_title(katalog, "") do
    katalog
    |> list_katalog
    |> Map.fetch!(:list)
  end

  def search_by_title(katalog, title) do
    list_katalog(katalog)
    |> Map.fetch!(:list)
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

  def list_books(a, page \\ 1, per_page \\ 5)
  def list_books(:paged, page, per_page) do
    Book
    |> order_by(asc: :title)
    |> Pagination.page(page, per_page: per_page)
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
