defmodule LibraryApp.Schemas.Genre do
  alias LibraryApp.Schemas.BookGenre
  alias LibraryApp.Schemas.Book
  use Ecto.Schema
  import Ecto.Changeset

  schema "genres" do
    field(:name, :string)
    has_many(:book_genres, BookGenre)
    has_many(:books, through: [:book_genres, :book])
    field(:uuid, Ecto.UUID, default: Ecto.UUID.generate())

    timestamps()
  end

  @type t :: %__MODULE__{
          name: String.t(),
          book_genres: [BookGenre.t()],
          books: [Book.t()]
        }

  @doc false
  def changeset(genre, attrs) do
    genre
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
