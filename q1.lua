-- I am assuming 1000 here is the index used on player objects for their log in / log out state
-- I set it to a constant so that we are always using the correct index
local LoginSaveIndex <const> = 1000

local function releaseStorage(index, player)
  player:setStorageValue(index, -1)
end

local function isLoggedIn(player)
  local loggedInVal = player:getStorageValue(LoginSaveIndex)
  if loggedInVal == 1 then
    return true
  elseif loggedInVal == -1 then
    return false
  else
    -- In this instance we are getting an unexpected result, so we raise an error
    -- This fictional function logs an error that includes the player object, an error code, and an error description
    logAndRaiseError("error_code", "error_description", player)
    return false
  end
end

-- I renamed the function to make what it does more clear
local function releaseStorageOnLogout(player)
  -- I turned this check into a function to reduce code and make it easier to read
  if isLoggedIn(player) then
    addEvent(releaseStorage, LoginSaveIndex, player)
    return true
  else
    return false
  end
end