defmodule LibraryApp.Repositories.BookRepo do
  @moduledoc """
  This module contains functions for querying the books table.
  """

  import Ecto.Query, warn: false

  alias LibraryApp.Schemas.Book
  alias LibraryApp.Repo
  alias LibraryApp.Util.FlexHelper

  def get_book_by_id(id) do
    Repo.get_by(Book, id: id)
  end

  def get_book_by_uuid(uuid) do
    Repo.get_by(Book, uuid: uuid)
  end

  def list_books_by_author_id(author_id) do
    Book
    |> where([b], b.author_id == ^author_id)
    |> Repo.one()
  end

  def list_books_by_author_ids(author_ids) do
    Book
    |> where([b], b.author_id in ^author_ids)
    |> Repo.all()
  end

  def list_books_by_author_uuid(author_uuid) do
    Book
    |> join(:inner, [b], a in assoc(b, :author), as: :author)
    |> where([author: a], a.uuid == ^author_uuid)
    |> Repo.one()
  end

  def list_books_by_author_uuids(author_uuids) do
    Book
    |> join(:inner, [b], a in assoc(b, :author), as: :author)
    |> where([author: a], a.uuid in ^author_uuids)
    |> Repo.all()
  end

  def list_books_by_author_name(author_name) do
    Book
    |> from(as: :book)
    |> join(:inner, [book: b], author in assoc(b, :author), as: :author)
    |> where([author: a], a.name == ^author_name)
    |> where([book: b], b.rent_category == :open)
    |> Repo.all()
  end

  def list_books_by_genre_name(genre_name) do
    Book
    |> from(as: :book)
    |> join(:inner, [book: b], genre in assoc(b, :genres), as: :genre)
    |> where([genre: g], g.name == ^genre_name)
    |> where([book: b], b.rent_category == :open)
    |> Repo.all()
  end

  def list_books_by_author_name_genre_and_rent_category(author_name, genre_name, rent_category) do
    Book
    |> from(as: :book)
    |> join(:inner, [book: b], author in assoc(b, :author), as: :author)
    |> join(:inner, [book: b], genre in assoc(b, :book_genres), as: :book_genre)
    |> join(:inner, [book_genre: bg], g in assoc(bg, :genre), as: :genre)
    |> where([author: a], a.name == ^author_name)
    |> where([genre: g], g.name == ^genre_name)
    |> where([book: b], b.rent_category == ^rent_category)
    |> preload([:author, :genres])
    |> Repo.all()
  end

  @doc """
  List books by the given parameters.

  ## Parameters

  * `params` - A map containing the parameters to filter the books by. It supports the following keys:
    * `:book_ids` - The list of book ids to filter by.
    * `:titles` - The list of titles to filter by.
    * `:preload` - The keyword list of the preload keys to fetch with the books. Can be nested.

  ## Returns

  A list of books that match the given parameters.

  ## Example

      iex> list_books_by(%{book_ids: [1, 2, 3], preload: [:author, :genres]})
  """
  @spec list_books_by(map()) :: list(Book.t())
  def list_books_by(params) do
    params
    |> query_list_books_by()
    |> Repo.all()
  end

  @doc """
  Fetches a single book based on the provided parameters.

  Raises an error if no book is found.
  Raises if more than one book is found.

  See `list_books_by/1` for available parameters.
  """
  @spec get_book_by!(map()) :: Book.t()
  def get_book_by!(params) do
    params
    |> query_list_books_by()
    |> Repo.one!()
  end

  @spec query_list_books_by(params :: map()) :: Ecto.Query.t()
  def query_list_books_by(params) do
    Book
    |> from(as: :book)
    |> Composite.new(params)
    |> apply_params()
    |> apply_dependencies()
    |> Composite.apply()
  end

  defp apply_params(query) do
    query
    |> Composite.param(:book_ids, &filter_by_book_ids/2)
    |> Composite.param(:author_ids, &filter_by_author_ids/2, requires: :author)
    |> Composite.param(:titles, &filter_by_titles/2)
    |> Composite.param(:genre_names, &filter_by_genre_names/2, requires: :genres)
    |> Composite.param(:author_name, &filter_by_author_name/2, requires: :author)
    |> Composite.param(:author_names, &filter_by_author_name/2, requires: :author)
    |> Composite.param(:rent_category, &filter_by_rent_category/2)
    |> Composite.param(:preload, &preload_data/2, requires: &add_dependencies_for_preloads/1)
  end

  @available_dependencies MapSet.new([
                            :author,
                            :genres
                          ])
  defp apply_dependencies(query) do
    query
    |> Composite.dependency(:author, &join_author/1)
    |> Composite.dependency(:genres, &join_genres/1)
  end

  defp add_dependencies_for_preloads(preloads) do
    FlexHelper.get_optimal_dependencies(preloads, @available_dependencies)
  end

  defp filter_by_book_ids(query, book_ids) do
    where(query, [b], b.id in ^book_ids)
  end

  defp filter_by_author_ids(query, author_ids) do
    where(query, [author: author], author.id in ^author_ids)
  end

  defp filter_by_titles(query, titles) do
    where(query, [b], b.title in ^titles)
  end

  defp filter_by_genre_names(query, genre_names) do
    where(query, [genres: g], g.name in ^genre_names)
  end

  defp filter_by_author_name(query, %{ci_contains: author_name}) do
    where(query, [author: author], ilike(author.name, ^"%#{author_name}%"))
  end

  defp filter_by_author_name(query, %{cs_contains: author_name}) do
    where(query, [author: author], like(author.name, ^"%#{author_name}%"))
  end

  defp filter_by_author_name(query, %{is: author_name}) do
    where(query, [author: author], author.name == ^author_name)
  end

  defp filter_by_author_name(query, author_names) do
    where(query, [author: author], author.name in ^author_names)
  end

  defp filter_by_rent_category(query, rent_category) do
    where(query, [b], b.rent_category in ^rent_category)
  end

  defp join_author(query) do
    join(query, :left, [b], a in assoc(b, :author), as: :author)
  end

  defp join_genres(query) do
    join(query, :left, [b], g in assoc(b, :genres), as: :genres)
  end

  defp preload_data(query, preloads) do
    dynamic_preloads = FlexHelper.build_dynamic_preloads(preloads, @available_dependencies)
    preload(query, ^dynamic_preloads)
  end
end
