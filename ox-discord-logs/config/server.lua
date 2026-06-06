local function sendToDiscord(title, message)
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

    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, "POST", json.encode({
        username = "Inventory Logs",
        embeds = embed
    }), { ["Content-Type"] = "application/json" })
end

-- ITEM ADDED
AddEventHandler('ox_inventory:itemAdded', function(source, inventory, item, count)
    if not Config.LogItemAdd then return end

    local msg = ("**Player:** %s\n**Inventory:** %s\n**Item Added:** %s x%s")
        :format(source, inventory, item, count)

    sendToDiscord("Item Added", msg)
end)

-- ITEM REMOVED
AddEventHandler('ox_inventory:itemRemoved', function(source, inventory, item, count)
    if not Config.LogItemRemove then return end

    local msg = ("**Player:** %s\n**Inventory:** %s\n**Item Removed:** %s x%s")
        :format(source, inventory, item, count)

    sendToDiscord("Item Removed", msg)
end)

-- STASH LOGS
AddEventHandler('ox_inventory:stashOpened', function(source, stash)
    if not Config.LogStash then return end

    local msg = ("**Player:** %s\n**Opened Stash:** %s")
        :format(source, stash)

    sendToDiscord("Stash Accessed", msg)
end)

-- TRUNK LOGS
AddEventHandler('ox_inventory:trunkOpened', function(source, plate)
    if not Config.LogTrunk then return end

    local msg = ("**Player:** %s\n**Opened Trunk:** %s")
        :format(source, plate)

    sendToDiscord("Trunk Accessed", msg)
end)

-- GLOVEBOX LOGS
AddEventHandler('ox_inventory:gloveboxOpened', function(source, plate)
    if not Config.LogGlovebox then return end

    local msg = ("**Player:** %s\n**Opened Glovebox:** %s")
        :format(source, plate)

    sendToDiscord("Glovebox Accessed", msg)
end)

-- PLAYER INVENTORY OPENED
AddEventHandler('ox_inventory:openedInventory', function(source, inventory)
    if not Config.LogPlayerInventory then return end

    local msg = ("**Player:** %s\n**Opened Inventory:** %s")
        :format(source, inventory)

    sendToDiscord("Inventory Opened", msg)
end)
