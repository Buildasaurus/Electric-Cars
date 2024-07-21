local recipe = {
    type = "recipe",
    name = "electric-car",
    enabled = true,
    energy_required = 0.1, -- time to craft in seconds (at crafting speed 1)
    ingredients = { { "copper-plate", 200 }, { "steel-plate", 50 } },
    result = "electric-car"
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
