// player = new Player(nullptr);
// This line of code is where I believe the memory leak was introduced. 
// The new keyword dynamically allocates memory, so it needs to be released when we're done with it.
// I opted to change the implementation to use a unique_ptr, so that the memory is automatically released when we are done with it

void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId)
{
    // I changed type here to a unique_ptr
    std::unique_ptr<Player> player = g_game.getPlayerByName(recipient);
    if (!player)
    {
        // This is where the memory leak was introduced.
        // I changed the code here to convert the returned pointer into a unique_ptr
        player = std::make_unique<Player>(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient))
        {
            return;
        }
    }

    Item *item = Item::CreateItem(itemId);
    if (!item)
    {
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline())
    {
        IOLoginData::savePlayer(player);
    }
}