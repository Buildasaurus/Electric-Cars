local electricCarEntity = table.deepcopy(data.raw["car"]["car"]) -- copy car entitiy

electricCarEntity.name = "electric-car-entity"


electricCarEntity.minable = { result = "electric-car", mining_time = 0.3 }


electricCarEntity.effectivity = 6

electricCarEntity.rotation_speed = 0.01

electricCarEntity.energy_source = {
    type = "burner",
    fuel_inventory_size = 0,
}


electricCarEntity.has_belt_immunity = true
data:extend { electricCarEntity }



-- Electrical concrete

local electricalConcreteTile = table.deepcopy(data.raw["tile"]["concrete"]) -- entity version of concrete



electricalConcreteTile.name = "electrical-concrete"
electricalConcreteTile.minable = { mining_time = 0.1, result = "electrical-concrete" }
electricalConcreteTile.tint = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 }
electricalConcreteTile.next_direction = "electrical-concrete"
electricalConcreteTile.walking_speed_modifier = 1.4


data:extend { electricalConcreteTile }
