defmodule SecretFriend.Core.User do

  def new(name, nick) do
    %{name: name, nick: nick, sflists: []}
  end

  def sflist(%{sflists: sflists} = _user) do
    sflists
  end

  def add_sflist(%{sflists: sflists} = user, new_sflist) do
    update_sflist = [new_sflist | sflists]
    %{user | sflists: update_sflist}
  end

end
