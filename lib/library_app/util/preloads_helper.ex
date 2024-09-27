defmodule LibraryApp.Util.PreloadsHelper do
  @moduledoc false

  import Ecto.Query, warn: false

  def build_dynamic_preloads(preloads, available_dependencies) do
    preloads
    |> flatten()
    |> Map.new(&dynamic_or_key(&1, available_dependencies))
    |> build_nested_preloads(preloads, available_dependencies)
  end

  # credo:disable-for-lines:20 Credo.Check.Refactor.ABCSize
  defp build_nested_preloads(dynamics, preloads, available_dependencies) when is_list(preloads) do
    Enum.reduce(preloads, Keyword.new(), fn
      {key, nested}, acc ->
        case dynamics[key] do
          nil ->
            Keyword.put(acc, key, build_nested_preloads(dynamics, nested, available_dependencies))

          dynamic ->
            if is_function(nested) do
              Keyword.put(acc, key, nested)
            else
              Keyword.put(
                acc,
                key,
                {dynamic, build_nested_preloads(dynamics, nested, available_dependencies)}
              )
            end
        end

      key, acc ->
        case dynamics[key] do
          nil -> [key | acc]
          dynamic -> Keyword.put(acc, key, dynamic)
        end
    end)
  end

  defp build_nested_preloads(_dynamics, preloads, _available_dependencies)
       when is_function(preloads) do
    preloads
  end

  defp dynamic_or_key(preload_key, available_dependencies) do
    if MapSet.member?(available_dependencies, preload_key) do
      {preload_key, dynamic([{^preload_key, p}], p)}
    else
      {preload_key, nil}
    end
  end

  def flatten(keyword_list) when is_list(keyword_list) do
    Enum.flat_map(keyword_list, fn
      {key, value} ->
        [key | flatten(value)]

      key ->
        [key]
    end)
  end

  def flatten(value) when is_atom(value), do: [value]
  def flatten(_value), do: []

  @spec get_optimal_dependencies(list() | atom(), MapSet.t()) :: list(atom())
  def get_optimal_dependencies(preloads, available_dependencies) when is_list(preloads) do
    Enum.flat_map(preloads, fn
      {key, value} ->
        if is_function(value) do
          []
        else
          child_deps = get_optimal_dependencies(value, available_dependencies)

          case child_deps do
            [] ->
              if MapSet.member?(available_dependencies, key), do: [key], else: []

            _deps ->
              child_deps
          end
        end

      key ->
        get_optimal_dependencies(key, available_dependencies)
    end)
  end

  def get_optimal_dependencies(value, available_dependencies) when is_atom(value) do
    if MapSet.member?(available_dependencies, value) do
      [value]
    else
      []
    end
  end

  def get_optimal_dependencies(_value, _available_dependencies), do: []
end
