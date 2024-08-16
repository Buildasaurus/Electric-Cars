data:extend({
    -- Technology for Electric Racing Car
    {
        type = "technology",
        name = "electric-racing-car-tech",
        icon = "__electric-cars__/graphics/electric-racer.png",
        icon_size = 170,
        prerequisites = {"electric-engine"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "electric-racer"
            },
        },
        unit = {
            count = 200,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1}
            },
            time = 30
        },
        order = "c-k-d"
    },

    -- Technology for Electric Rover
    {
        type = "technology",
        name = "electric-rover-tech",
        icon = "__electric-cars__/graphics/electric-racer.png",
        icon_size = 170,
        prerequisites = {"electric-racing-car-tech"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "electric-rover"
            },
        },
        unit = {
            count = 250,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1}
            },
            time = 30
        },
        order = "c-k-e"
    },

    -- Technology for C-Battery
    {
        type = "technology",
        name = "c-battery-tech",
        icon = "__electric-cars__/graphics/c-battery.png",
        icon_size = 384,
        prerequisites = {"battery"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "c-battery"
            },
        },
        unit = {
            count = 100,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1}
            },
            time = 15
        },
        order = "c-k-f"
    },

    -- Technology for D-Battery
    {
        type = "technology",
        name = "d-battery-tech",
        icon = "__electric-cars__/graphics/d-battery.png",
        icon_size = 384,
        prerequisites = {"c-battery-tech"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "d-battery"
            },
        },
        unit = {
            count = 150,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1}
            },
            time = 15
        },
        order = "c-k-g"
    },

    -- Technology for Electrical Concrete
    {
        type = "technology",
        name = "electrical-concrete-tech",
        icon = "__base__/graphics/technology/concrete.png",
        icon_size = 256,
        prerequisites = {"concrete"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "electrical-concrete"
            },
        },
        unit = {
            count = 200,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1}
            },
            time = 30
        },
        order = "c-k-h"
    },

    -- Technology for Charging Station
    {
        type = "technology",
        name = "charging-station-tech",
        icon = "__base__/graphics/technology/electric-energy-acumulators.png",
        icon_size = 256,
        prerequisites = {"electric-energy-distribution-1"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "charging-station"
            },
        },
        unit = {
            count = 200,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1}
            },
            time = 30
        },
        order = "c-k-i"
    }
})
