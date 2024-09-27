defmodule LibraryApp.Repositories.GenreRepo do
  @moduledoc """
  This module contains functions for querying the genres table.
  """

  import Ecto.Query, warn: false

  alias LibraryApp.Schemas.Genre
  alias LibraryApp.Repo
  alias LibraryApp.Util.FlexHelper

  @doc """
  List genres by the given parameters.

  ## Parameters

  * `params` - A map containing the parameters to filter the genres by. It supports the following keys:
    * `:genre_ids` - The list of genre ids to filter by.
    * `:names` - The list of names to filter by.
    * `:preload` - The keyword list of the preload keys to fetch with the genres. Can be nested.

  ## Returns

  A list of genres that match the given parameters.

  ## Example

      iex> list_genres_by(%{genre_ids: [1, 2, 3], preload: [:books]})
  """
  @spec list_genres_by(map()) :: list(Genre.t())
  def list_genres_by(params) do
    params
    |> query_list_genres_by()
    |> Repo.all()
  end

  @doc """
  Fetches a single genre based on the provided parameters.

  Raises an error if no genre is found.
  Raises if more than one genre is found.

  See `list_genres_by/1` for available parameters.
  """
  @spec get_genre_by!(map()) :: Genre.t()
  def get_genre_by!(params) do
    params
    |> query_list_genres_by()
    |> Repo.one!()
  end

  @spec query_list_genres_by(params :: map()) :: Ecto.Query.t()
  def query_list_genres_by(params) do
    Genre
    |> from(as: :genre)
    |> Composite.new(params)
    |> apply_params()
    |> apply_dependencies()
    |> Composite.apply()
  end

  defp apply_params(query) do
    query
    |> Composite.param(:genre_ids, &filter_by_genre_ids/2)
    |> Composite.param(:names, &filter_by_names/2)
    |> Composite.param(:preload, &preload_data/2, requires: &add_dependencies_for_preloads/1)
  end

  @available_dependencies MapSet.new([
                            :books
                          ])
  defp apply_dependencies(query) do
    query
    |> Composite.dependency(:books, &join_books/1)
  end

  defp add_dependencies_for_preloads(preloads) do
    FlexHelper.get_optimal_dependencies(preloads, @available_dependencies)
  end

  defp filter_by_genre_ids(query, genre_ids) do
    where(query, [g], g.id in ^genre_ids)
  end

  defp filter_by_names(query, names) do
    where(query, [g], g.name in ^names)
  end

  defp join_books(query) do
    join(query, :left, [g], bg in assoc(g, :book_genres), as: :book_genres)
    |> join(:left, [book_genres: bg], b in assoc(bg, :book), as: :books)
  end

  defp preload_data(query, preloads) do
    dynamic_preloads = FlexHelper.build_dynamic_preloads(preloads, @available_dependencies)
    preload(query, ^dynamic_preloads)
  end
end
