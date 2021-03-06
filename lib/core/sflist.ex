defmodule SecretFriend.Core.SFList do

    def new, do: []

    @doc """
    sflist -> secret friend list
    new_friend -> new friend to add to sflist
    """
    def add_friend(sflist, new_friend), do:
        [new_friend | sflist]

    def create_selection(sflist) do
        sflist
        |> Enum.shuffle()
        |> gen_pairs()
    end

    defp gen_pairs(sflist), do:
        Enum.chunk_every(sflist, 2, 1, sflist)
end