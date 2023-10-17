defmodule Library.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :state, :integer, default: 1
    field :title, :string
    field :location, :integer
    field :author, :string
    field :isbn, :string
    field :genre, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :isbn, :genre, :location, :state])
    |> validate_required([:title, :author, :isbn, :genre, :location])
  end
end
