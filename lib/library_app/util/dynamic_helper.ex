defmodule LibraryApp.Util.DynamicHelper do
  @moduledoc """
  Helper functions for building dynamic clauses.
  """

  import Ecto.Query, warn: false

  @doc """
  Builds a dynamic clause from a keyword list. Also works with a list of tuples.
  """
  @spec build_dynamic_clause(Keyword.t() | list(tuple())) :: list()
  def build_dynamic_clause(list) do
    list
    |> Enum.map(fn {binding, fields} ->
      Enum.map(List.wrap(fields), fn field ->
        dynamic([{^binding, b}], field(b, ^field))
      end)
    end)
    |> List.flatten()
  end
end
