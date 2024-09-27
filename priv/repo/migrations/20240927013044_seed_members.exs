defmodule LibraryApp.Repo.Migrations.SeedMembers do
  use Ecto.Migration

  def up do
    execute("""
    INSERT INTO members (name, email, inserted_at, updated_at) VALUES
      ('Alice Smith', 'alice@example.com', NOW(), NOW()),
      ('Bob Johnson', 'bob@example.com', NOW(), NOW()),
      ('Carol Williams', 'carol@example.com', NOW(), NOW()),
      ('David Brown', 'david@example.com', NOW(), NOW()),
      ('Eve Davis', 'eve@example.com', NOW(), NOW()),
      ('Frank Miller', 'frank@example.com', NOW(), NOW()),
      ('Grace Wilson', 'grace@example.com', NOW(), NOW()),
      ('Hank Moore', 'hank@example.com', NOW(), NOW()),
      ('Ivy Taylor', 'ivy@example.com', NOW(), NOW()),
      ('Jack Anderson', 'jack@example.com', NOW(), NOW()),
      ('Karen Thomas', 'karen@example.com', NOW(), NOW()),
      ('Leo Jackson', 'leo@example.com', NOW(), NOW()),
      ('Mia White', 'mia@example.com', NOW(), NOW()),
      ('Nina Harris', 'nina@example.com', NOW(), NOW()),
      ('Oscar Martin', 'oscar@example.com', NOW(), NOW()),
      ('Paul Thompson', 'paul@example.com', NOW(), NOW()),
      ('Quinn Garcia', 'quinn@example.com', NOW(), NOW()),
      ('Rita Martinez', 'rita@example.com', NOW(), NOW());
    """)
  end

  def down do
    execute("""
    DELETE FROM members;
    """)
  end
end
