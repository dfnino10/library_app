defmodule LibraryApp.Repositories.BookGenreRepo do
  @moduledoc """
  This module contains functions for querying the books_genres table.
  """

  import Ecto.Query, warn: false

  alias LibraryApp.Schemas.BookGenre
  alias LibraryApp.Repo
  alias LibraryApp.Util.FlexHelper

  @doc """
  List book genres by the given parameters.

  ## Parameters

  * `params` - A map containing the parameters to filter the book genres by. It supports the following keys:
    * `:book_ids` - The list of book ids to filter by.
    * `:genre_ids` - The list of genre ids to filter by.
    * `:preload` - The keyword list of the preload keys to fetch with the book genres. Can be nested.

  ## Returns

  A list of book genres that match the given parameters.

  ## Example

      iex> list_book_genres_by(%{book_ids: [1, 2, 3], preload: [:book, :genre]})
  """
  @spec list_book_genres_by(map()) :: list(BookGenre.t())
  def list_book_genres_by(params) do
    params
    |> query_list_book_genres_by()
    |> Repo.all()
  end

  @doc """
  Fetches a single book genre based on the provided parameters.

  Raises an error if no book genre is found.
  Raises if more than one book genre is found.

  See `list_book_genres_by/1` for available parameters.
  """
  @spec get_book_genre_by!(map()) :: BookGenre.t()
  def get_book_genre_by!(params) do
    params
    |> query_list_book_genres_by()
    |> Repo.one!()
  end

  @spec query_list_book_genres_by(params :: map()) :: Ecto.Query.t()
  def query_list_book_genres_by(params) do
    BookGenre
    |> from(as: :book_genre)
    |> Composite.new(params)
    |> apply_params()
    |> apply_dependencies()
    |> Composite.apply()
  end

  defp apply_params(query) do
    query
    |> Composite.param(:book_ids, &filter_by_book_ids/2)
    |> Composite.param(:genre_ids, &filter_by_genre_ids/2)
    |> Composite.param(:preload, &preload_data/2, requires: &add_dependencies_for_preloads/1)
  end

  @available_dependencies MapSet.new([
                            :book,
                            :genre
                          ])
  defp apply_dependencies(query) do
    query
    |> Composite.dependency(:book, &join_book/1)
    |> Composite.dependency(:genre, &join_genre/1)
  end

  defp add_dependencies_for_preloads(preloads) do
    FlexHelper.get_optimal_dependencies(preloads, @available_dependencies)
  end

  defp filter_by_book_ids(query, book_ids) do
    where(query, [bg], bg.book_id in ^book_ids)
  end

  defp filter_by_genre_ids(query, genre_ids) do
    where(query, [bg], bg.genre_id in ^genre_ids)
  end

  defp join_book(query) do
    join(query, :left, [bg], b in assoc(bg, :book), as: :book)
  end

  defp join_genre(query) do
    join(query, :left, [bg], g in assoc(bg, :genre), as: :genre)
  end

  defp preload_data(query, preloads) do
    dynamic_preloads = FlexHelper.build_dynamic_preloads(preloads, @available_dependencies)
    preload(query, ^dynamic_preloads)
  end
end
