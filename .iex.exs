alias SecretFriend.API.SFList

sflist = SFList.new()
SFList.add_friend(sflist, "Angel")
SFList.add_friend(sflist, "Ramon")
SFList.add_friend(sflist, "Rita")

IO.inspect(SFList.show(sflist))
IO.puts("Loaded...")
