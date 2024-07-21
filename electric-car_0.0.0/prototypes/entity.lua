
local electricCarEntity = table.deepcopy(data.raw["car"]["car"]) -- Copy car entity
electricCarEntity.name = "electric-car-entity"
electricCarEntity.minable = { result = "electric-car", mining_time = 0.3 }
electricCarEntity.effectivity = 1
electricCarEntity.consumption = "1000KW"
electricCarEntity.rotation_speed = 0.01
electricCarEntity.braking_power = "500kW"

electricCarEntity.weight = 500
electricCarEntity.friction = 0.01

electricCarEntity.burner = {
    fuel_category = "electrical",
    effectivity = 1,
    fuel_inventory_size = 1,
}

electricCarEntity.has_belt_immunity = true

data:extend { electricCarEntity }


data.raw.car.car.consumption = "10000kW"
data.raw.car.car.friction = (2e-3)*40
data.raw.car.car.weight = 700 -- unchanged


-- Electrical concrete
local electricalConcreteTile = table.deepcopy(data.raw["tile"]["concrete"]) -- entity version of concrete

electricalConcreteTile.name = "electrical-concrete"
electricalConcreteTile.minable = { mining_time = 0.1, result = "electrical-concrete" }
electricalConcreteTile.tint = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 }
electricalConcreteTile.next_direction = "electrical-concrete"
electricalConcreteTile.walking_speed_modifier = 1.4

data:extend { electricalConcreteTile }
