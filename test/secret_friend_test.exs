defmodule SecretFriendTest do
  use ExUnit.Case
  doctest SecretFriend

  test "greets the world" do
    assert SecretFriend.hello() == :world
  end
end
