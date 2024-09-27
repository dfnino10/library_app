defmodule LibraryApp.Repositories.AuthorRepo do
  @moduledoc """
  This module contains functions for querying the authors table.
  """

  import Ecto.Query, warn: false

  alias LibraryApp.Schemas.Author
  alias LibraryApp.Repo
  alias LibraryApp.Util.FlexHelper

  @doc """
  List authors by the given parameters.

  ## Parameters

  * `params` - A map containing the parameters to filter the authors by. It supports the following keys:
    * `:author_ids` - The list of author ids to filter by.
    * `:names` - The list of names to filter by.
    * `:preload` - The keyword list of the preload keys to fetch with the authors. Can be nested.

  ## Returns

  A list of authors that match the given parameters.

  ## Example

      iex> list_authors_by(%{author_ids: [1, 2, 3], preload: [:books]})
  """
  @spec list_authors_by(map()) :: list(Author.t())
  def list_authors_by(params) do
    params
    |> query_list_authors_by()
    |> Repo.all()
  end

  @doc """
  Fetches a single author based on the provided parameters.

  Raises an error if no author is found.
  Raises if more than one author is found.

  See `list_authors_by/1` for available parameters.
  """
  @spec get_author_by!(map()) :: Author.t()
  def get_author_by!(params) do
    params
    |> query_list_authors_by()
    |> Repo.one!()
  end

  @spec query_list_authors_by(params :: map()) :: Ecto.Query.t()
  def query_list_authors_by(params) do
    Author
    |> from(as: :author)
    |> Composite.new(params)
    |> apply_params()
    |> apply_dependencies()
    |> Composite.apply()
  end

  defp apply_params(query) do
    query
    |> Composite.param(:author_ids, &filter_by_author_ids/2)
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

  defp filter_by_author_ids(query, author_ids) do
    where(query, [a], a.id in ^author_ids)
  end

  defp filter_by_names(query, names) do
    where(query, [a], a.name in ^names)
  end

  defp join_books(query) do
    join(query, :left, [a], b in assoc(a, :books), as: :books)
  end

  defp preload_data(query, preloads) do
    dynamic_preloads = FlexHelper.build_dynamic_preloads(preloads, @available_dependencies)
    preload(query, ^dynamic_preloads)
  end
end
