# Roblox-Random-Picker
An easy way to pick random items.


### Basic Usage:

```lua
local RandomPicker = require(path)

local MyPicker = RandomPicker.new()

MyPicker:Add(item: any, rarity: number)
local RandomItem = MyPicker:Pick(seed: number | nil)

print(RandomItem)
```

### Chest Example:

```lua
-- Picking a random item from a chest

local RandomPicker = require(path)

local Chest = RandomPicker.new()

Chest:Add('Sword', 20)
Chest:Add('Axe', 30)
Chest:Add('Shield', 40)
Chest:Add('Potion', 10)

local ChoosenItem = Chest:Pick()
print(ChoosenItem .. ' was choosen!')
``` 

### Murder Example:
```lua
-- Picking a random player to be the murder

local Players = game:GetService('Players')

local RandomPicker = require(path)

local function ChooseMurder()
	local MurderPicker = RandomPicker.new()

	for _, player in ipairs(Players:GetPlayers()) do
		local chance = player.Stats.ChanceToBeMurder.Value -- an IntValue inside a folder
		MurderPicker:Add(player, chance)
	end

	return MurderPicker:Pick()
end

local Murder = ChooseMurder()
print(Murder.Name .. ' is the murder!')
```
