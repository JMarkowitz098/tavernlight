local function removePlayerFromTheirParty(targetPlayerId) -- We should only use a playerId when interacting with a player object to avoid confusion
  -- Made local because player does not need to be accessed outside of the funtion
  -- Assuming that this constructor is pulling info from a db, which is why the player might already have a party even
  -- though it was just created here.
  local player = Player(targetPlayerId)
  -- Assuming/changing implementation so that getParty returns a table where key = playerId, and value = memberName
  local party = player:getParty()
  if party == nil then
    logWarning("Player is not in a party")
    return false
  end

  for playerId, memberName in pairs(party) do
    if playerId == targetPlayerId then
      -- I would update removeMember to use the playerId to remove a member
      -- Something like self.members[playerId] = nil
      party:removeMember(playerId)
    end
  end
  return true
  -- I add true / false returns for logging / debugging purposes after the function is called
end