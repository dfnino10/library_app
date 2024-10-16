defmodule LibraryApp.Schemas.BookGenre do
  alias LibraryApp.Schemas.Book
  alias LibraryApp.Schemas.Genre
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "books_genres" do
    belongs_to(:book, Book)
    belongs_to(:genre, Genre)

    timestamps()
  end

  @type t :: %__MODULE__{
          book: Book.t(),
          genre: Genre.t()
        }

  @doc false
  def changeset(book_genre, attrs) do
    book_genre
    |> cast(attrs, [:book_id, :genre_id])
    |> validate_required([:book_id, :genre_id])
  end
end
