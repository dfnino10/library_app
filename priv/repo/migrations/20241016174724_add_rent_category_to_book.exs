defmodule LibraryApp.Repo.Migrations.AddRentCategoryToBook do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :rent_category, :string, default: "open"
    end
  end
end
