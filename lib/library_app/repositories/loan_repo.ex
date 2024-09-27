defmodule LibraryApp.Repositories.LoanRepo do
  @moduledoc """
  This module contains functions for querying the loans table.
  """

  import Ecto.Query, warn: false

  alias LibraryApp.Schemas.Loan
  alias LibraryApp.Repo
  alias LibraryApp.Util.FlexHelper

  @doc """
  List loans by the given parameters.

  ## Parameters

  * `params` - A map containing the parameters to filter the loans by. It supports the following keys:
    * `:loan_ids` - The list of loan ids to filter by.
    * `:book_ids` - The list of book ids to filter by.
    * `:member_ids` - The list of member ids to filter by.
    * `:preload` - The keyword list of the preload keys to fetch with the loans. Can be nested.

  ## Returns

  A list of loans that match the given parameters.

  ## Example

      iex> list_loans_by(%{loan_ids: [1, 2, 3], preload: [:book, :member]})
  """
  @spec list_loans_by(map()) :: list(Loan.t())
  def list_loans_by(params) do
    params
    |> query_list_loans_by()
    |> Repo.all()
  end

  @doc """
  Fetches a single loan based on the provided parameters.

  Raises an error if no loan is found.
  Raises if more than one loan is found.

  See `list_loans_by/1` for available parameters.
  """
  @spec get_loan_by!(map()) :: Loan.t()
  def get_loan_by!(params) do
    params
    |> query_list_loans_by()
    |> Repo.one!()
  end

  @spec query_list_loans_by(params :: map()) :: Ecto.Query.t()
  def query_list_loans_by(params) do
    Loan
    |> from(as: :loan)
    |> Composite.new(params)
    |> apply_params()
    |> apply_dependencies()
    |> Composite.apply()
  end

  defp apply_params(query) do
    query
    |> Composite.param(:loan_ids, &filter_by_loan_ids/2)
    |> Composite.param(:book_ids, &filter_by_book_ids/2)
    |> Composite.param(:member_ids, &filter_by_member_ids/2)
    |> Composite.param(:member_names, &filter_by_member_names/2, requires: :member)
    |> Composite.param(:member_name, &filter_by_member_name/2, requires: :member)
    |> Composite.param(:return_date, &filter_by_return_date/2)
    |> Composite.param(:preload, &preload_data/2, requires: &add_dependencies_for_preloads/1)
  end

  @available_dependencies MapSet.new([
                            :book,
                            :member,
                            :author
                          ])
  defp apply_dependencies(query) do
    query
    |> Composite.dependency(:book, &join_book/1)
    |> Composite.dependency(:member, &join_member/1)
    |> Composite.dependency(:author, &join_author/1, requires: :book)
  end

  defp add_dependencies_for_preloads(preloads) do
    FlexHelper.get_optimal_dependencies(preloads, @available_dependencies)
  end

  defp filter_by_loan_ids(query, loan_ids) do
    IO.inspect("loan_ids")
    where(query, [l], l.id in ^loan_ids)
  end

  defp filter_by_book_ids(query, book_ids) do
    where(query, [l], l.book_id in ^book_ids)
  end

  defp filter_by_member_ids(query, member_ids) do
    where(query, [l], l.member_id in ^member_ids)
  end

  def filter_by_member_names(query, member_names) do
    where(query, [member: m], m.name in ^member_names)
  end

  defp filter_by_member_name(query, %{cs_contains: member_name}) do
    where(query, [member: m], like(m.name, ^"%#{member_name}%"))
  end

  defp filter_by_member_name(query, %{ci_contains: member_name}) do
    where(query, [member: m], ilike(m.name, ^"%#{member_name}%"))
  end

  defp filter_by_return_date(query, :is_nil) do
    where(query, [loan: l], is_nil(l.return_date))
  end

  defp filter_by_return_date(query, return_date) do
    where(query, [loan: l], l.return_date == ^return_date)
  end

  defp join_book(query) do
    join(query, :left, [l], b in assoc(l, :book), as: :book)
  end

  defp join_member(query) do
    join(query, :left, [l], m in assoc(l, :member), as: :member)
  end

  defp join_author(query) do
    join(query, :left, [book: b], a in assoc(b, :author), as: :author)
  end

  defp preload_data(query, preloads) do
    dynamic_preloads = FlexHelper.build_dynamic_preloads(preloads, @available_dependencies)
    preload(query, ^dynamic_preloads)
  end
end
