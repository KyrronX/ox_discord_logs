# 📦 ox-discord-logs

A professional, open‑source Discord logging resource for **ox_inventory** in FiveM.  
Designed for **any server**, any framework, and any developer who wants clean, reliable inventory logs sent directly to Discord.

This resource is **framework‑agnostic**, easy to configure, and production‑ready.

---

## 🚀 What This Resource Does

`ox-discord-logs` listens to key **ox_inventory** events and sends rich Discord embeds to your webhook(s).

It logs:

- ✅ Item added
- ❌ Item removed
- 🗄️ Stash opened
- 🚗 Trunk opened
- 🧤 Glovebox opened
- 🎒 Player inventory opened

Each embed includes the **player name**, **server ID**, **Rockstar license**, and a precise timestamp — ideal for:

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
│   └── config/
│       ├── config.lua      # All user-facing settings
│       └── server.lua      # Event listeners & webhook logic
│
└── README.md
```

---

## 🔧 Installation

1. Download or clone the repository:

```bash
git clone https://github.com/KyrronX/ox_discord_logs
```

2. Drag the `ox-discord-logs` folder into your FiveM `resources/` directory.

3. Open `config/config.lua` and set your Discord webhook:

```lua
Config.Webhook = "https://discord.com/api/webhooks/XXXXXXXXX/XXXXXXXXX"
```

4. Add this to your `server.cfg`:

```
ensure ox-discord-logs
```

---

## ⚙️ Configuration (`config/config.lua`)

### Webhooks

```lua
-- Single webhook for all log types:
Config.Webhook = "https://discord.com/api/webhooks/XXXXXXXXX/XXXXXXXXX"

-- Optional per-category overrides (leave nil to use Config.Webhook):
Config.Webhooks = {
    itemAdded   = nil,
    itemRemoved = nil,
    stash       = nil,
    trunk       = nil,
    glovebox    = nil,
    inventory   = nil,
}
```

### Log Toggles

```lua
Config.LogItemAdd         = true
Config.LogItemRemove      = true
Config.LogStash           = true
Config.LogTrunk           = true
Config.LogGlovebox        = true
Config.LogPlayerInventory = true
```

### Appearance

```lua
Config.ServerName   = "Your Server Name"
Config.BotUsername  = "Inventory Logs"
Config.BotAvatarUrl = "" -- Optional bot avatar image URL

-- Per-category embed colours (decimal):
Config.Colors = {
    itemAdded   = 3066993,  -- Green
    itemRemoved = 15158332, -- Red
    stash       = 3447003,  -- Blue
    trunk       = 10181046, -- Purple
    glovebox    = 15105570, -- Orange
    inventory   = 3447003,  -- Blue
}
```

### Rate Limiting

```lua
Config.RateLimitMax    = 15  -- max events per player
Config.RateLimitWindow = 10  -- within this many seconds
```

---

## 📡 Logged Events

| Event | Description |
|-------|-------------|
| `ox_inventory:itemAdded` | Fired when a player receives an item |
| `ox_inventory:itemRemoved` | Fired when a player loses an item |
| `ox_inventory:stashOpened` | Fired when a stash is accessed |
| `ox_inventory:trunkOpened` | Fired when a vehicle trunk is accessed |
| `ox_inventory:gloveboxOpened` | Fired when a vehicle glovebox is accessed |
| `ox_inventory:openedInventory` | Fired when a player opens their inventory |

---

## 🖼️ Example Discord Embed

```
✅ Item Added
────────────────────────────────
Player     │ PlayerName (ID: 3)  │ License   │ license:abc123...
────────────────────────────────
Item       │ bread x2
Inventory  │ player
────────────────────────────────
Footer: Your Server Name • ox_inventory logs   |   2026-06-18T00:00:00Z
```

---

## 🤝 Contributing

Pull requests are welcome.  
If you want to add new log types or improve formatting, feel free to contribute.

---

## ⭐ Support the Project

If this resource helps your server, consider starring the repo on GitHub — it helps others find it.

Created by **GSRStudio**

