
local electricCarEntity = table.deepcopy(data.raw["car"]["car"]) -- Copy car entity
electricCarEntity.name = "electric-car-entity"
electricCarEntity.minable = { result = "electric-car", mining_time = 0.3 }
electricCarEntity.consumption = "400kW"
electricCarEntity.braking_power = "500kW"
electricCarEntity.weight = 700 * 0.8
electricCarEntity.friction = (2e-3)*3
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
