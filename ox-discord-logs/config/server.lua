-- ══════════════════════════════════════════════════════════════════
--  Utility: validate a Discord webhook URL
-- ══════════════════════════════════════════════════════════════════
local function isValidWebhook(url)
    return type(url) == "string"
        and url:find("^https://discord%.com/api/webhooks/%d+/[%w_%-]+$") ~= nil
end

-- ══════════════════════════════════════════════════════════════════
--  Utility: resolve the webhook for a given log category
-- ══════════════════════════════════════════════════════════════════
local function getWebhook(category)
    local override = Config.Webhooks and Config.Webhooks[category]
    return (override and override ~= "") and override or Config.Webhook
end

-- ══════════════════════════════════════════════════════════════════
--  Utility: fetch player display name and Rockstar license
-- ══════════════════════════════════════════════════════════════════
local function getPlayerInfo(source)
    local name    = GetPlayerName(source) or ("Unknown#%s"):format(source)
    local license = "N/A"

    for _, id in ipairs(GetPlayerIdentifiers(source) or {}) do
        if id:sub(1, 8) == "license:" then
            license = id
            break
        end
    end

    return name, license
end

-- ══════════════════════════════════════════════════════════════════
--  Rate limiting: suppress per-player webhook spam
-- ══════════════════════════════════════════════════════════════════
local rateLimits = {}

local function isRateLimited(source)
    local now  = os.time()
    local data = rateLimits[source]

    if not data or now >= data.reset then
        rateLimits[source] = { count = 1, reset = now + Config.RateLimitWindow }
        return false
    end

    data.count = data.count + 1
    return data.count > Config.RateLimitMax
end

-- ══════════════════════════════════════════════════════════════════
--  Core: build and send a Discord embed
-- ══════════════════════════════════════════════════════════════════
local function sendToDiscord(category, title, fields)
    local webhook = getWebhook(category)

    if not isValidWebhook(webhook) then
        print(("[ox-discord-logs] Invalid or missing webhook for category '%s' — check Config.Webhook"):format(category))
        return
    end

    local embed = {
        {
            title     = title,
            color     = Config.Colors[category] or 3447003,
            fields    = fields,
            footer    = { text = Config.ServerName .. " • ox_inventory logs" },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        }
    }

    local avatarUrl = (Config.BotAvatarUrl and Config.BotAvatarUrl ~= "") and Config.BotAvatarUrl or nil

    PerformHttpRequest(webhook, function(statusCode, text, headers)
        if statusCode ~= 204 and statusCode ~= 200 then
            print(("[ox-discord-logs] Webhook HTTP %s for category '%s'"):format(tostring(statusCode), category))
        end
    end, "POST", json.encode({
        username   = Config.BotUsername or "Inventory Logs",
        avatar_url = avatarUrl,
        embeds     = embed,
    }), { ["Content-Type"] = "application/json" })
end

-- ══════════════════════════════════════════════════════════════════
--  Event: Item Added
-- ══════════════════════════════════════════════════════════════════
AddEventHandler("ox_inventory:itemAdded", function(source, inventory, item, count)
    if not Config.LogItemAdd then return end
    if isRateLimited(source) then return end

    local name, license = getPlayerInfo(source)

    sendToDiscord("itemAdded", "✅ Item Added", {
        { name = "Player",    value = ("%s (ID: %s)"):format(name, source), inline = true  },
        { name = "License",   value = license,                              inline = true  },
        { name = "Item",      value = ("%s x%s"):format(item, count),       inline = false },
        { name = "Inventory", value = tostring(inventory),                  inline = true  },
    })
end)

-- ══════════════════════════════════════════════════════════════════
--  Event: Item Removed
-- ══════════════════════════════════════════════════════════════════
AddEventHandler("ox_inventory:itemRemoved", function(source, inventory, item, count)
    if not Config.LogItemRemove then return end
    if isRateLimited(source) then return end

    local name, license = getPlayerInfo(source)

    sendToDiscord("itemRemoved", "❌ Item Removed", {
        { name = "Player",    value = ("%s (ID: %s)"):format(name, source), inline = true  },
        { name = "License",   value = license,                              inline = true  },
        { name = "Item",      value = ("%s x%s"):format(item, count),       inline = false },
        { name = "Inventory", value = tostring(inventory),                  inline = true  },
    })
end)

-- ══════════════════════════════════════════════════════════════════
--  Event: Stash Opened
-- ══════════════════════════════════════════════════════════════════
AddEventHandler("ox_inventory:stashOpened", function(source, stash)
    if not Config.LogStash then return end
    if isRateLimited(source) then return end

    local name, license = getPlayerInfo(source)

    sendToDiscord("stash", "🗄️ Stash Accessed", {
        { name = "Player",  value = ("%s (ID: %s)"):format(name, source), inline = true  },
        { name = "License", value = license,                              inline = true  },
        { name = "Stash",   value = tostring(stash),                      inline = false },
    })
end)

-- ══════════════════════════════════════════════════════════════════
--  Event: Trunk Opened
-- ══════════════════════════════════════════════════════════════════
AddEventHandler("ox_inventory:trunkOpened", function(source, plate)
    if not Config.LogTrunk then return end
    if isRateLimited(source) then return end

    local name, license = getPlayerInfo(source)

    sendToDiscord("trunk", "🚗 Trunk Accessed", {
        { name = "Player",  value = ("%s (ID: %s)"):format(name, source), inline = true  },
        { name = "License", value = license,                              inline = true  },
        { name = "Plate",   value = tostring(plate),                      inline = false },
    })
end)

-- ══════════════════════════════════════════════════════════════════
--  Event: Glovebox Opened
-- ══════════════════════════════════════════════════════════════════
AddEventHandler("ox_inventory:gloveboxOpened", function(source, plate)
    if not Config.LogGlovebox then return end
    if isRateLimited(source) then return end

    local name, license = getPlayerInfo(source)

    sendToDiscord("glovebox", "🧤 Glovebox Accessed", {
        { name = "Player",  value = ("%s (ID: %s)"):format(name, source), inline = true  },
        { name = "License", value = license,                              inline = true  },
        { name = "Plate",   value = tostring(plate),                      inline = false },
    })
end)

-- ══════════════════════════════════════════════════════════════════
--  Event: Player Inventory Opened
-- ══════════════════════════════════════════════════════════════════
AddEventHandler("ox_inventory:openedInventory", function(source, inventory)
    if not Config.LogPlayerInventory then return end
    if isRateLimited(source) then return end

    local name, license = getPlayerInfo(source)

    sendToDiscord("inventory", "🎒 Inventory Opened", {
        { name = "Player",    value = ("%s (ID: %s)"):format(name, source), inline = true  },
        { name = "License",   value = license,                              inline = true  },
        { name = "Inventory", value = tostring(inventory),                  inline = false },
    })
end)

