defmodule Library.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :title, :string
    field :author, :string
    field :ISBN, :string
    field :genre, :string
    field :location, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :ISBN, :genre, :location])
    |> validate_required([:title, :author, :ISBN, :genre, :location])
  end
end
