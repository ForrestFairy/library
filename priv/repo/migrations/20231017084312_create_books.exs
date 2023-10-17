defmodule Library.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :author, :string
      add :isbn, :string
      add :genre, {:array, :string}
      add :location, :integer
      add :state, :integer

      timestamps()
    end
  end
end
