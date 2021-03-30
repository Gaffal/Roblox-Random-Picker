local RandomPicker = {}
RandomPicker.__index = RandomPicker

function RandomPicker.new(items: Array | nil)
	return setmetatable({
		Items = items or {}
	}, RandomPicker)
end

function RandomPicker:Add(item, rarity: number)
	table.insert(self.Items, {
		Item = item,
		Rarity = rarity,
	})
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
	assert(#self.Items > 0, 'Add an item bofore choosing one.')
	self:_SortByRarity()

	local totalSum = self:_GetTotalSum()
	local random = ( seed and Random.new(seed) ) or Random.new()
	local chance = random:NextInteger(1, totalSum)

	for _, item in ipairs(self.Items) do
		if item.Rarity >= chance then
			return item.Item
		else
			chance -= item.Rarity
		end
	end

	return self:Pick(seed)
end

return RandomPicker
