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
- Stash opened  
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
Config.Webhook = "YOUR_WEBHOOK_HERE"

Config.LogItemAdd = true
Config.LogItemRemove = true
Config.LogStash = true
Config.LogTrunk = true
Config.LogGlovebox = true
Config.LogPlayerInventory = true

Config.ServerName = "Your Server Name"
Config.LogColor = 3447003
```

You can toggle any log type on/off.

---

## 📡 Logged Events

| Event | Description |
|-------|-------------|
| `ox_inventory:itemAdded` | Logs when a player receives an item |
| `ox_inventory:itemRemoved` | Logs when a player loses an item |
| `ox_inventory:stashOpened` | Logs stash access |
| `ox_inventory:trunkOpened` | Logs trunk access |
| `ox_inventory:gloveboxOpened` | Logs glovebox access |
| `ox_inventory:openedInventory` | Logs player inventory opening |

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
