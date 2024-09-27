defmodule LibraryApp.Util.FlexHelper do
  @moduledoc """
  Helper functions for the Flex Repos.
  """

  alias LibraryApp.Util.DynamicHelper
  alias LibraryApp.Util.OrderByHelper
  alias LibraryApp.Util.PreloadsHelper

  defdelegate build_dynamic_clause(list), to: DynamicHelper
  defdelegate return_order_clauses(available_bindings, order_by), to: OrderByHelper
  defdelegate build_dynamic_preloads(preloads, available_dependencies), to: PreloadsHelper
  defdelegate get_optimal_dependencies(preloads, available_dependencies), to: PreloadsHelper
end
