defmodule BusTest do
  use ExUnit.Case
  doctest Bus

  test "greets the world" do
    assert Bus.hello() == :world
  end
end
