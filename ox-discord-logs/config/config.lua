Config = {}

-- ══════════════════════════════════════════════════════════════════
--  DISCORD WEBHOOK SETTINGS
-- ══════════════════════════════════════════════════════════════════

-- Main webhook used for all log categories unless overridden below.
Config.Webhook = "https://discord.com/api/webhooks/XXXXXXXXX/XXXXXXXXX"

-- Optional per-category webhook overrides.
-- Set a URL string to override, or leave as nil to fall back to Config.Webhook.
Config.Webhooks = {
    itemAdded   = nil,
    itemRemoved = nil,
    stash       = nil,
    trunk       = nil,
    glovebox    = nil,
    inventory   = nil,
}

-- ══════════════════════════════════════════════════════════════════
--  LOG TOGGLES
-- ══════════════════════════════════════════════════════════════════

Config.LogItemAdd         = true
Config.LogItemRemove      = true
Config.LogStash           = true
Config.LogTrunk           = true
Config.LogGlovebox        = true
Config.LogPlayerInventory = true

-- ══════════════════════════════════════════════════════════════════
--  EMBED APPEARANCE
-- ══════════════════════════════════════════════════════════════════

Config.ServerName   = "Your Server Name"
Config.BotUsername  = "Inventory Logs"
Config.BotAvatarUrl = "" -- Optional: URL to a bot avatar image

-- Decimal embed colour per log category.
-- Colour picker: https://www.bgreco.net/hexcolor/
Config.Colors = {
    itemAdded   = 3066993,  -- Green
    itemRemoved = 15158332, -- Red
    stash       = 3447003,  -- Blue
    trunk       = 10181046, -- Purple
    glovebox    = 15105570, -- Orange
    inventory   = 3447003,  -- Blue
}

-- ══════════════════════════════════════════════════════════════════
--  RATE LIMITING
-- ══════════════════════════════════════════════════════════════════

-- Maximum log events per player within the rolling time window.
-- Logs beyond the limit are silently suppressed to protect the webhook.
Config.RateLimitMax    = 15 -- max events
Config.RateLimitWindow = 10 -- seconds
