# Roblox-Random-Picker
An easy way to pick random items.


### Basic Usage:

```lua
local RandomPicker = require(path)

local MyPicker = RandomPicker.new()

MyPicker:Add(item: any, rarity: number)
MyPicker:Remove(item: any)

local RandomItem = MyPicker:Pick(seed: number | nil)
MyPicker:Destroy()

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

	return MurderPicker:SinglePick()
end

local Murder = ChooseMurder()
print(Murder.Name .. ' is the murder!')
```

### Methods
```lua
local Picker = RandomPicker.new()

Picker:Add(item: any, rarity: number) -- adds an item with a rarity
Picker:Remove(item: any) -- removes a previous added item
Picker:Pick(seed: number | nil) -- picks a random item
Picker:SinglePick(seed: number | nil) -- calls 'Picker::Pick' and then, 'Picker::Destroy'
Picker:Destroy() -- destroys the picker
```
