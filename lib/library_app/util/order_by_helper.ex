defmodule LibraryApp.Util.OrderByHelper do
  @moduledoc """
  Helper functions for building order by clauses for flex repositories.
  """

  alias Ecto.Query.Builder.OrderBy
  alias LibraryApp.Util.DynamicHelper

  def return_order_clauses(available_bindings, order_by) do
    order_by
    |> List.wrap()
    |> Enum.map(fn element -> return_dynamic_order(element, available_bindings) end)
    |> List.flatten()
  end

  defp return_dynamic_order({key, value}, available_bindings) do
    return_order_binding(
      {key, value},
      key in available_bindings,
      OrderBy.valid_direction?(key)
    )
  end

  defp return_dynamic_order(key, _available_bindings) when is_atom(key) do
    key
  end

  defp return_order_binding({key, value}, true = _is_binding, _valid_direction) do
    [{key, value}]
    |> DynamicHelper.build_dynamic_clause()
    |> Enum.map(fn dynamic_clause ->
      {:asc, dynamic_clause}
    end)
  end

  defp return_order_binding({direction, value}, false = _is_binding, true = _valid_direction) do
    maybe_dynamic(Keyword.keyword?(value), {direction, value})
  end

  defp return_order_binding({key, value}, false = _is_binding, false = _valid_direction) do
    {key, value}
  end

  defp maybe_dynamic(true = _is_keyword, {direction, value}) do
    value
    |> DynamicHelper.build_dynamic_clause()
    |> Enum.map(fn dynamic_clause ->
      {direction, dynamic_clause}
    end)
  end

  defp maybe_dynamic(false = _is_keyword, {direction, value}) do
    {direction, value}
  end
end
