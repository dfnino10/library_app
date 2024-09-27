defmodule LibraryApp.Repositories.MemberRepo do
  @moduledoc """
  This module contains functions for querying the members table.
  """

  import Ecto.Query, warn: false

  alias LibraryApp.Schemas.Member
  alias LibraryApp.Repo
  alias LibraryApp.Util.FlexHelper

  @doc """
  List members by the given parameters.

  ## Parameters

  * `params` - A map containing the parameters to filter the members by. It supports the following keys:
    * `:member_ids` - The list of member ids to filter by.
    * `:names` - The list of names to filter by.
    * `:emails` - The list of emails to filter by.
    * `:preload` - The keyword list of the preload keys to fetch with the members. Can be nested.

  ## Returns

  A list of members that match the given parameters.

  ## Example

      iex> list_members_by(%{member_ids: [1, 2, 3], preload: [:loans, :books]})
  """
  @spec list_members_by(map()) :: list(Member.t())
  def list_members_by(params) do
    params
    |> query_list_members_by()
    |> Repo.all()
  end

  @doc """
  Fetches a single member based on the provided parameters.

  Raises an error if no member is found.
  Raises if more than one member is found.

  See `list_members_by/1` for available parameters.
  """
  @spec get_member_by!(map()) :: Member.t()
  def get_member_by!(params) do
    params
    |> query_list_members_by()
    |> Repo.one!()
  end

  @spec query_list_members_by(params :: map()) :: Ecto.Query.t()
  def query_list_members_by(params) do
    Member
    |> from(as: :member)
    |> Composite.new(params)
    |> apply_params()
    |> apply_dependencies()
    |> Composite.apply()
  end

  defp apply_params(query) do
    query
    |> Composite.param(:member_ids, &filter_by_member_ids/2)
    |> Composite.param(:names, &filter_by_names/2)
    |> Composite.param(:emails, &filter_by_emails/2)
    |> Composite.param(:preload, &preload_data/2, requires: &add_dependencies_for_preloads/1)
  end

  @available_dependencies MapSet.new([
                            :loans,
                            :books
                          ])
  defp apply_dependencies(query) do
    query
    |> Composite.dependency(:loans, &join_loans/1)
    |> Composite.dependency(:books, &join_books/1)
  end

  defp add_dependencies_for_preloads(preloads) do
    FlexHelper.get_optimal_dependencies(preloads, @available_dependencies)
  end

  defp filter_by_member_ids(query, member_ids) do
    where(query, [m], m.id in ^member_ids)
  end

  defp filter_by_names(query, names) do
    where(query, [m], m.name in ^names)
  end

  defp filter_by_emails(query, emails) do
    where(query, [m], m.email in ^emails)
  end

  defp join_loans(query) do
    join(query, :left, [m], l in assoc(m, :loans), as: :loans)
  end

  defp join_books(query) do
    join(query, :left, [m], b in assoc(m, :books), as: :books)
  end

  defp preload_data(query, preloads) do
    dynamic_preloads = FlexHelper.build_dynamic_preloads(preloads, @available_dependencies)
    preload(query, ^dynamic_preloads)
  end
end
