local function printSmallGuildNames(memberCount)
  local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
  -- I will assume that storeQuery returns a table where key = index and value = guild name
  local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
  
  -- First we check to make sure the query returned something
  if resultId then
    -- The query probably returns a table, and not one giant string. This loop lets us
    -- iterate through the result.
      for _, guild in ipairs(resultId) do
          local guildName = getString(guild, "name")
          print(guildName)
      end
  else
      print("No guilds found.")
  end
end