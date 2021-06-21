local RandomPicker = {}
RandomPicker.__index = RandomPicker

local random = Random.new()

function RandomPicker.new(items: Array | nil)
	return setmetatable({
		Items = items or {},
		_total_sum = 0,
	}, RandomPicker)
end

function RandomPicker:Add(item, rarity: number)
	assert(not self.Destroyed, 'Picker is destroyed')

	table.insert(self.Items, {
		Item = item,
		Rarity = rarity,
	})

	self._total_sum += rarity
	self:_SortByRarity()

	return self
end

function RandomPicker:Remove(item)
	assert(not self.Destroyed, 'Picker is destroyed')

	for index, item_data in ipairs(self.Items) do
		if (item_data.Item == item) then
			table.remove(self.Items, index)
			self._total_sum -= item_data.Rarity
		end
	end

	self:_SortByRarity()
	return self
end

function RandomPicker:_GetTotalSum()
	local total = 0

	for _, item in ipairs(self.Items) do
		total += item.Rarity
	end

	return total
end

function RandomPicker:_SortByRarity()
	table.sort(self.Items, function(x, y)
		return x.Rarity > y.Rarity
	end)
end

function RandomPicker:Pick(seed: number | nil)
	assert(#self.Items > 0, 'No items to choose from.')
	assert(not self.Destroyed, 'Picker is destroyed')

	local rnd = ( seed and Random.new(seed) ) or random
	local chance = rnd:NextInteger(1, self._total_sum)

	for _, item_data in ipairs(self.Items) do
		if item_data.Rarity >= chance then
			return item_data.Item
		else
			chance -= item_data.Rarity
		end
	end

	return self:Pick()
end

function RandomPicker:SinglePick(seed: number | nil)
	local item = self:Pick(seed)
	self:Destroy()

	return item
end

function RandomPicker:Destroy()
	self.Items = nil
	self.Destroyed = true
end

return RandomPicker
