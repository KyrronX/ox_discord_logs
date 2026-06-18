# 📦 ox-discord-logs  
A lightweight, open‑source Discord logging module for **ox_inventory** in FiveM.  
Designed for **any server**, any framework, and any developer who wants clean, reliable inventory logs sent directly to Discord.

This resource is **framework‑agnostic**, easy to configure, and production‑ready.

---

## 🚀 What This Resource Does

`ox-discord-logs` listens to key **ox_inventory** events and sends them to a Discord webhook using rich embeds.

It logs:

- Item added  
- Item removed  
- Item transfers (player-to-player gives)  
- Stash opened  
- Loot accessed (drops / dead-body containers)  
- Trunk opened  
- Glovebox opened  
- Player inventory opened  

This makes it ideal for:

- Staff moderation  
- Anti‑cheat auditing  
- Player activity tracking  
- Server transparency  
- Inventory debugging  

---

## 📁 Repository Structure

```
/
├── ox-discord-logs/        # The FiveM resource
│   ├── fxmanifest.lua
│   ├── config.lua
│   └── server.lua
│
└── README.md               # Main project documentation (this file)
```

---

## 🔧 Installation

1. Download or clone the repository:

```
git clone https://github.com/YOURNAME/ox-discord-logs
```

2. Drag the `ox-discord-logs` folder into your FiveM `resources/` directory.

3. Open `config.lua` and set your Discord webhook:

```lua
Config.Webhook = "https://discord.com/api/webhooks/XXXXXXXXX/XXXXXXXXX"
```

4. Add this to your `server.cfg`:

```
ensure ox-discord-logs
```

---

## ⚙️ Configuration

Inside `config.lua`:

```lua
-- Main/Fallback webhook — used when a category webhook is not set
Config.Webhook = "YOUR_WEBHOOK_HERE"

-- Per-category webhooks (leave as "" to fall back to the main webhook)
Config.WebhookInventoryAdd    = ""   -- inventory-add logs
Config.WebhookInventoryRemove = ""   -- inventory-remove logs
Config.WebhookItemTransfers   = ""   -- item-transfer logs
Config.WebhookStash           = ""   -- stash-logs
Config.WebhookLoot            = ""   -- loot-logs
Config.WebhookTrunk           = ""   -- trunk-logs
Config.WebhookGlovebox        = ""   -- glovebox-logs
Config.WebhookPlayerInventory = ""   -- player inventory-open logs

-- Toggle individual log types on/off
Config.LogItemAdd         = true
Config.LogItemRemove      = true
Config.LogItemTransfer    = true
Config.LogStash           = true
Config.LogLoot            = true
Config.LogTrunk           = true
Config.LogGlovebox        = true
Config.LogPlayerInventory = true

Config.ServerName = "Your Server Name"
Config.LogColor   = 3447003
```

Each log category can be sent to its **own Discord channel** by setting the matching `WebhookXxx` value.  
Any category left as `""` automatically falls back to the main `Config.Webhook`.

You can also toggle any log type on/off independently.

---

## 📡 Logged Events

| Event | Log Toggle | Webhook Config | Description |
|-------|-----------|----------------|-------------|
| `ox_inventory:itemAdded` | `LogItemAdd` | `WebhookInventoryAdd` | Player receives an item |
| `ox_inventory:itemRemoved` | `LogItemRemove` | `WebhookInventoryRemove` | Player loses an item |
| `ox_inventory:giveItem` | `LogItemTransfer` | `WebhookItemTransfers` | Player gives an item to another player |
| `ox_inventory:stashOpened` | `LogStash` | `WebhookStash` | Stash access |
| `ox_inventory:openedInventory` *(loot)* | `LogLoot` | `WebhookLoot` | Drop / dead-body inventory access |
| `ox_inventory:trunkOpened` | `LogTrunk` | `WebhookTrunk` | Trunk access |
| `ox_inventory:gloveboxOpened` | `LogGlovebox` | `WebhookGlovebox` | Glovebox access |
| `ox_inventory:openedInventory` | `LogPlayerInventory` | `WebhookPlayerInventory` | Player inventory opening |

---

## 🖼️ Example Discord Embed

```

Title: Item Removed
Player: 12
Inventory: player
Item Removed: bread x1
Timestamp: 2026-06-05T00:00:00Z

```

## 🤝 Contributing

Pull requests are welcome.  
If you want to add new log types or improve formatting, feel free to contribute.

---

## ⭐ Support the Project

If this resource helps your server, consider starring the repo on GitHub — it helps others find it.

Created by GSRStudio
