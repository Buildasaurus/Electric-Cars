-- items.lua
--[[

local electricCarBattery = table.deepcopy(data.raw["item"]["wood"]) -- copy wood item

electricCarBattery.name = "electric-car-battery"
electricCarBattery.icons = {
    {
        icon = electricCarBattery.icon,
        icon_size = electricCarBattery.icon_size,
        tint = { r = 0.5, g = 0.5, b = 0.5, a = 0.75 }
    },
}

data:extend({ { electricCarBattery } })


local recipe = {
    type = "recipe",
    name = "electric-car-battery",
    enabled = true,
    energy_required = 0.1, -- time to craft in seconds (at crafting speed 1)
    ingredients = { { "copper-plate", 1 } },
    result = "electric-car-battery"
}

--]]
