defmodule LibraryApp.Schemas.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field(:name, :string)
    field(:bio, :string)

    has_many(:books, LibraryApp.Schemas.Book, foreign_key: :author_id)

    timestamps()
  end

  @type t :: %__MODULE__{
          name: String.t(),
          bio: String.t()
        }

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :bio])
    |> validate_required([:name])
  end
end
