defmodule Library.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :state, :integer
    field :title, :string
    field :location, :string
    field :author, :string
    field :ISBN, :string
    field :genre, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :ISBN, :genre, :location, :state])
    |> validate_required([:title, :author, :ISBN, :genre, :location, :state])
  end
end
