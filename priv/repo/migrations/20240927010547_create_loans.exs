defmodule LibraryApp.Repo.Migrations.CreateLoans do
  use Ecto.Migration

  def change do
    create table(:loans) do
      add :book_id, references(:books, on_delete: :delete_all), null: false
      add :member_id, references(:members, on_delete: :delete_all), null: false
      add :loan_date, :date, null: false
      add :return_date, :date

      timestamps()
    end

    create index(:loans, [:book_id])
    create index(:loans, [:member_id])
  end
end
