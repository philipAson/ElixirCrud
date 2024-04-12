defmodule UserHandlerAppTest do
  use ExUnit.Case
  doctest UserHandlerApp

  test "greets the world" do
    assert UserHandlerApp.hello() == :world
  end
end
