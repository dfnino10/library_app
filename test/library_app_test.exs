defmodule LibraryAppTest do
  use ExUnit.Case
  doctest LibraryApp

  test "greets the world" do
    assert LibraryApp.hello() == :world
  end
end
