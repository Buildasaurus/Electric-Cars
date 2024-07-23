

-- Electric racing car
local recipe = {
    type = "recipe",
    name = "electric-racer",
    enabled = true,
    energy_required = 0.1, -- time to craft in seconds (at crafting speed 1)
    ingredients = { { "battery", 120 }, { "steel-plate", 60 }, { "electronic-circuit", 10 }, { "electric-engine-unit", 15 } },
    result = "electric-racer"
}

data:extend { recipe }


--Electric rover
local recipe = {
    type = "recipe",
    name = "electric-rover",
    enabled = true,
    energy_required = 0.1, -- time to craft in seconds (at crafting speed 1)
    ingredients = { { "battery", 120 }, { "steel-plate", 60 }, { "electronic-circuit", 10 }, { "electric-engine-unit", 15 } },
    result = "electric-rover"
}

data:extend { recipe }


--C-battery
local recipe = {
    type = "recipe",
    name = "c-battery",
    enabled = true,
    energy_required = 0.1, -- time to craft in seconds (at crafting speed 1)
    ingredients = { { "battery", 5 }, { "copper-cable", 5 } },
    result = "c-battery"
}

data:extend { recipe }


-- Electrical concrete

local electricalConcreteRecipe = {
    type = "recipe",
    name = "electrical-concrete",
    enabled = true,
    energy_required = 0.1, -- time to craft in seconds (at crafting speed 1)
    ingredients = {
        { "concrete",     10 },
        { "copper-cable", 5 }
    },
    result = "electrical-concrete",
    result_count = 10
}

data:extend { electricalConcreteRecipe }
