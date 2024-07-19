--data.lua

local electricCarItem = table.deepcopy(data.raw["item-with-entity-data"]["car"]) -- copy car item
local electricCarEntity = table.deepcopy(data.raw["car"]["car"])                 -- copy car entitiy

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
electricCarEntity.minable = { result = "electric-car", mining_time = 0.3 }


electricCarEntity.effectivity = 6

electricCarEntity.rotation_speed = 0.01

electricCarEntity.energy_source = {
    type = "burner",
    fuel_inventory_size = 0,
}


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

data:extend { electricCarItem, recipe, electricCarEntity }





-- Electrical concrete

local electricalConcreteItem = table.deepcopy(data.raw["item"]["concrete"])
local electricalConcreteTile = table.deepcopy(data.raw["tile"]["concrete"]) -- entity version of concrete

electricalConcreteItem.name = "electrical-concrete"
electricalConcreteItem.icons = {
    {
        icon = electricalConcreteItem.icon,
        icon_size = electricalConcreteItem.icon_size,
        tint = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 }
    },
}
electricalConcreteItem.place_as_tile = {
    result = "electrical-concrete",
    condition_size = 1,
    condition = { "water-tile" }
}

electricalConcreteTile.name = "electrical-concrete"
electricalConcreteTile.minable = { mining_time = 0.1, result = "electrical-concrete" }
electricalConcreteTile.tint = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 }
electricalConcreteTile.next_direction = "electrical-concrete"
electricalConcreteTile.walking_speed_modifier = 1.4

local electricalConcreteRecipe = {
    type = "recipe",
    name = "electrical-concrete",
    enabled = true,
    ingredients = {
        { "concrete", 10 },
        { "copper-cable", 5 }
    },
    result = "electrical-concrete",
    result_count = 10
}

data:extend { electricalConcreteItem, electricalConcreteTile, electricalConcreteRecipe }
