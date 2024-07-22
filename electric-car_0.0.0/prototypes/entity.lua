local electricCarEntity = table.deepcopy(data.raw["car"]["car"]) -- Copy car entity
electricCarEntity.name = "electric-car-entity"
electricCarEntity.minable = { result = "electric-car", mining_time = 0.3 }
electricCarEntity.consumption = "400kW"
electricCarEntity.braking_power = "500kW"
electricCarEntity.weight = 700 * 0.8
electricCarEntity.friction = (2e-3) * 3
electricCarEntity.burner = {
    fuel_category = "electrical",
    effectivity = 1,
    fuel_inventory_size = 0,
}
data:extend { electricCarEntity }

-- Electrical concrete
local electricalConcreteTile = table.deepcopy(data.raw["tile"]["concrete"]) -- entity version of concrete

electricalConcreteTile.name = "electrical-concrete"
electricalConcreteTile.minable = { mining_time = 0.1, result = "electrical-concrete" }
electricalConcreteTile.tint = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 }
electricalConcreteTile.next_direction = "electrical-concrete"
electricalConcreteTile.walking_speed_modifier = 1.4

data:extend { electricalConcreteTile }




local energyInterface = {
    type = "electric-energy-interface",
    name = "electric-concrete-energy-interface",
    flags = { "not-blueprintable", "not-deconstructable", "not-on-map" },
    selectable_in_game = false,
    icon_size = 64,
    icon = "__base__/graphics/icons/concrete.png",
    collision_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    collision_mask = { "colliding-with-tiles-only" },
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        buffer_capacity = "20KJ",
        input_flow_limit = "20KW",
        output_flow_limit = "0W",
    },
    energy_usage = "20KW",
    picture = {
        filename = "__base__/graphics/icons/concrete.png",
        priority = "high",
        width = 1,
        height = 1,
    },
}

data:extend { energyInterface }
