Config = {}

-- Main/Fallback Discord Webhook
-- Used for any log category that does not have its own webhook set below.
Config.Webhook = "https://discord.com/api/webhooks/XXXXXXXXX/XXXXXXXXX"

-- Per-Category Webhooks
-- Leave as "" to fall back to the main webhook above.
Config.WebhookInventoryAdd    = ""   -- inventory-add logs
Config.WebhookInventoryRemove = ""   -- inventory-remove logs
Config.WebhookItemTransfers   = ""   -- item-transfer logs (player-to-player gives)
Config.WebhookStash           = ""   -- stash-logs
Config.WebhookLoot            = ""   -- loot-logs (drop / dead-body inventory access)
Config.WebhookTrunk           = ""   -- trunk-logs
Config.WebhookGlovebox        = ""   -- glovebox-logs
Config.WebhookPlayerInventory = ""   -- player inventory-open logs

-- Toggle logs
Config.LogItemAdd         = true
Config.LogItemRemove      = true
Config.LogItemTransfer    = true
Config.LogStash           = true
Config.LogLoot            = true
Config.LogTrunk           = true
Config.LogGlovebox        = true
Config.LogPlayerInventory = true

-- Embed Settings
Config.ServerName = "Kodiak City RP"
Config.LogColor = 3447003 -- Blue
