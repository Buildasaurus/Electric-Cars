

-- Electric racing car
local recipe = {
    type = "recipe",
    name = "electric-racer",
    enabled = false,
    energy_required = 10,
    ingredients = { { "battery", 120 }, { "steel-plate", 60 }, { "electronic-circuit", 10 }, { "electric-engine-unit", 15 } },
    result = "electric-racer"
}

data:extend { recipe }


--Electric rover
local recipe = {
    type = "recipe",
    name = "electric-rover",
    enabled = false,
    energy_required = 10,
    ingredients = { { "battery", 120 }, { "steel-plate", 60 }, { "electronic-circuit", 10 }, { "electric-engine-unit", 15 } },
    result = "electric-rover"
}

data:extend { recipe }


--C-battery
local recipe = {
    type = "recipe",
    name = "c-battery",
    enabled = false,
    energy_required = 0.5, -- time to craft in seconds (at crafting speed 1)
    ingredients = { { "battery", 5 }, { "copper-cable", 5 } },
    result = "c-battery"
}

data:extend { recipe }

--D-battery
local recipe = {
    type = "recipe",
    name = "d-battery",
    enabled = false,
    energy_required = 0.5, -- time to craft in seconds (at crafting speed 1)
    ingredients = { { "battery", 15 }, { "copper-cable", 15 } },
    result = "d-battery"
}

data:extend { recipe }

-- Electrical concrete

local electricalConcreteRecipe = {
    type = "recipe",
    name = "electrical-concrete",
    enabled = false,
    energy_required = 2, -- time to craft in seconds (at crafting speed 1)
    ingredients = {
        { "concrete",     10 },
        { "copper-cable", 5 }
    },
    result = "electrical-concrete",
    result_count = 10
}

data:extend { electricalConcreteRecipe }


-- Charging station
local chargingStationRecipe = {
    type = "recipe",
    name = "charging-station",
    enabled = false,
    energy_required = 5, -- time to craft in seconds (at crafting speed 1)
    ingredients = { { "steel-plate", 1 }, { "battery", 1 }, { "electronic-circuit", 1 } },
    result = "charging-station"
}


data:extend { chargingStationRecipe }
