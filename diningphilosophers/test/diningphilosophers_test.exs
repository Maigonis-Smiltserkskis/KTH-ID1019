defmodule DiningphilosophersTest do
  use ExUnit.Case
  doctest Diningphilosophers

  test "greets the world" do
    assert Diningphilosophers.hello() == :world
  end
end
