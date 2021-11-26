alias SecretFriend.API.SFList

SFList.new(:arq)
|> SFList.add_friend("Angel")
|> SFList.add_friend("Ramon")
|> SFList.add_friend("Rita")

IO.inspect(SFList.show(:arq))
IO.puts("Loaded...")
