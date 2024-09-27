defmodule LibraryApp.Repo.Migrations.SeedAuthors do
  use Ecto.Migration

  def up do
    authors = [
      %{
        name: "J.K. Rowling",
        bio: "British author, best known for the Harry Potter series.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "George R.R. Martin",
        bio: "American novelist and short story writer, known for A Song of Ice and Fire.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "J.R.R. Tolkien",
        bio: "English writer, poet, and academic, known for The Lord of the Rings.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "Agatha Christie",
        bio: "English writer known for her 66 detective novels and 14 short story collections.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "Stephen King",
        bio: "American author of horror, supernatural fiction, suspense, and fantasy novels.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "Isaac Asimov",
        bio: "American writer and professor of biochemistry, known for his works of science fiction.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "Ernest Hemingway",
        bio: "American novelist, short-story writer, and journalist.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "Mark Twain",
        bio: "American writer, humorist, entrepreneur, publisher, and lecturer.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "Jane Austen",
        bio: "English novelist known primarily for her six major novels.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "Charles Dickens",
        bio: "English writer and social critic, created some of the world's best-known fictional characters.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "F. Scott Fitzgerald",
        bio: "American novelist, essayist, screenwriter, and short-story writer.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "Harper Lee",
        bio: "American novelist best known for her 1960 novel To Kill a Mockingbird.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "Leo Tolstoy",
        bio: "Russian writer who is regarded as one of the greatest authors of all time.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "J.D. Salinger",
        bio: "American novelist and short-story writer, known for The Catcher in the Rye.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      },
      %{
        name: "George Orwell",
        bio: "English writer, novelist, and journalist, known for 1984 and Animal Farm.",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      }
    ]

    LibraryApp.Repo.insert_all("authors", authors)
  end

  def down do
    execute("DELETE FROM authors;")
  end
end
