-- Returns the specific webhook if set, otherwise falls back to the main webhook.
local function getWebhook(specific)
    if specific and specific ~= "" then
        return specific
    end
    return Config.Webhook
end

local function sendToDiscord(title, message, webhook)
    local embed = {
        {
            ["title"] = title,
            ["description"] = message,
            ["color"] = Config.LogColor,
            ["footer"] = {
                ["text"] = Config.ServerName .. " • ox_inventory logs"
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, "POST", json.encode({
        username = "Inventory Logs",
        embeds = embed
    }), { ["Content-Type"] = "application/json" })
end

-- ITEM ADDED
AddEventHandler('ox_inventory:itemAdded', function(source, inventory, item, count)
    if not Config.LogItemAdd then return end

    local msg = ("**Player:** %s\n**Inventory:** %s\n**Item Added:** %s x%s")
        :format(source, inventory, item, count)

    sendToDiscord("Item Added", msg, getWebhook(Config.WebhookInventoryAdd))
end)

-- ITEM REMOVED
AddEventHandler('ox_inventory:itemRemoved', function(source, inventory, item, count)
    if not Config.LogItemRemove then return end

    local msg = ("**Player:** %s\n**Inventory:** %s\n**Item Removed:** %s x%s")
        :format(source, inventory, item, count)

    sendToDiscord("Item Removed", msg, getWebhook(Config.WebhookInventoryRemove))
end)

-- ITEM TRANSFERS (player-to-player gives)
AddEventHandler('ox_inventory:giveItem', function(source, target, item, count)
    if not Config.LogItemTransfer then return end

    local msg = ("**From Player:** %s\n**To Player:** %s\n**Item:** %s x%s")
        :format(source, target, item, count)

    sendToDiscord("Item Transferred", msg, getWebhook(Config.WebhookItemTransfers))
end)

-- STASH LOGS
AddEventHandler('ox_inventory:stashOpened', function(source, stash)
    if not Config.LogStash then return end

    local msg = ("**Player:** %s\n**Opened Stash:** %s")
        :format(source, stash)

    sendToDiscord("Stash Accessed", msg, getWebhook(Config.WebhookStash))
end)

-- LOOT LOGS (drop / dead-body inventory access)
-- ox_inventory identifies these containers by a "type:id" prefix in the inventory name.
-- Known prefixes: "drop:" (items dropped on the ground), "corpse:" (dead NPC/player body),
-- "loot:" (custom loot containers).  Adjust the pattern below if your server uses different prefixes.
-- Note: ox_inventory fires dedicated stashOpened / trunkOpened / gloveboxOpened events for those
-- types, so they will NOT appear in openedInventory and there is no risk of duplicate logging.
AddEventHandler('ox_inventory:openedInventory', function(source, inventory)
    -- Detect loot-type inventories by their name prefix.
    local isLoot = type(inventory) == "string" and
        (inventory:find("^drop:") or inventory:find("^corpse:") or inventory:find("^loot:"))

    if isLoot then
        if not Config.LogLoot then return end

        local msg = ("**Player:** %s\n**Opened Loot:** %s")
            :format(source, inventory)

        sendToDiscord("Loot Accessed", msg, getWebhook(Config.WebhookLoot))
    else
        -- All remaining openedInventory fires represent the player's own inventory.
        -- Stash, trunk, and glovebox each have their own dedicated ox_inventory events
        -- and are handled by the handlers below, not by this event.
        if not Config.LogPlayerInventory then return end

        local msg = ("**Player:** %s\n**Opened Inventory:** %s")
            :format(source, inventory)

        sendToDiscord("Inventory Opened", msg, getWebhook(Config.WebhookPlayerInventory))
    end
end)

-- TRUNK LOGS
AddEventHandler('ox_inventory:trunkOpened', function(source, plate)
    if not Config.LogTrunk then return end

    local msg = ("**Player:** %s\n**Opened Trunk:** %s")
        :format(source, plate)

    sendToDiscord("Trunk Accessed", msg, getWebhook(Config.WebhookTrunk))
end)

-- GLOVEBOX LOGS
AddEventHandler('ox_inventory:gloveboxOpened', function(source, plate)
    if not Config.LogGlovebox then return end

    local msg = ("**Player:** %s\n**Opened Glovebox:** %s")
        :format(source, plate)

    sendToDiscord("Glovebox Accessed", msg, getWebhook(Config.WebhookGlovebox))
end)
