defmodule SFListTest do
    use ExUnit.Case
    alias SecretFriend.Core.SFList

    test "SFList creation" do
        assert SFList.new() == []
    end

    test "Add friend" do
        sflist =
            SFList.new()
            |> SFList.add_friend("Angel")
            |> SFList.add_friend("Ramon")
            |> SFList.add_friend("Rita")

        assert sflist == ["Rita", "Ramon", "Angel"]
    end

    test "Create selection" do
        selection =
            SFList.new()
            |> SFList.add_friend("Angel")
            |> SFList.add_friend("Ramon")
            |> SFList.add_friend("Rita")
            |> SFList.create_selection()

        assert length(selection) == 3
        assert Enum.all?(selection, fn e -> Enum.at(e, 0) != Enum.at(e, 1) end)
        assert length(Enum.uniq_by(selection, fn e -> Enum.at(e, 0) end)) == 3
        assert length(Enum.uniq_by(selection, fn e -> Enum.at(e, 1) end)) == 3
    end
end
