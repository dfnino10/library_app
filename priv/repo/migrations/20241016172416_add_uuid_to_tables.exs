defmodule LibraryApp.Repo.Migrations.AddUuidToTables do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";")

    alter table(:authors) do
      add :uuid, :uuid, null: false, default: fragment("uuid_generate_v4()")
    end

    alter table(:books) do
      add :uuid, :uuid, null: false, default: fragment("uuid_generate_v4()")
    end

    alter table(:genres) do
      add :uuid, :uuid, null: false, default: fragment("uuid_generate_v4()")
    end

    alter table(:loans) do
      add :uuid, :uuid, null: false, default: fragment("uuid_generate_v4()")
    end

    alter table(:members) do
      add :uuid, :uuid, null: false, default: fragment("uuid_generate_v4()")
    end
  end
end
