alias SecretFriend.Core.SFList

sflist =
    SFList.new()
    |> SFList.add_friend("Angel")
    |> SFList.add_friend("Ramon")
    |> SFList.add_friend("Rita")

IO.puts("Loaded sflist inspect ... #{inspect(sflist)}")
IO.puts("Loaded sflist join ... #{Enum.join(sflist, ",")}")
