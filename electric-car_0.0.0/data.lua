--data.lua

local electricCarItem = table.deepcopy(data.raw["item-with-entity-data"]["car"]) -- copy car item
local electricCarEntity = table.deepcopy(data.raw["car"]["car"])             -- copy car entitiy

electricCarEntity.name = "electric-car-entity"
electricCarItem.name = "electric-car"
electricCarItem.icons = {
    {
        icon = electricCarItem.icon,
        icon_size = electricCarItem.icon_size,
        tint = { r = 0.5, g = 0.5, b = 0.5, a = 0.75 }
    },
}

electricCarItem.place_result = "electric-car-entity"
electricCarEntity.minable = { result = "electric-car", mining_time = 0.3}


electricCarEntity.effectivity = 6

electricCarEntity.rotation_speed = 0.01

electricCarEntity.energy_source = { type = "void" }

electricCarEntity.has_belt_immunity = true

-- create the recipe prototype from scratch
local recipe = {
    type = "recipe",
    name = "electric-car",
    enabled = true,
    energy_required = 0.1, -- time to craft in seconds (at crafting speed 1)
    ingredients = { { "copper-plate", 200 }, { "steel-plate", 50 } },
    result = "electric-car"
}

data:extend { electricCarItem, recipe, electricCarEntity}
