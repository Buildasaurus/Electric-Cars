-- Electrical racer

local electricRacerEntity = table.deepcopy(data.raw["car"]["car"]) -- Copy car entity
electricRacerEntity.name = "electric-racer-entity"
electricRacerEntity.minable = { result = "electric-racer", mining_time = 0.3 }
electricRacerEntity.consumption = "400kW"
electricRacerEntity.braking_power = "500kW"
electricRacerEntity.weight = 700 * 0.8
electricRacerEntity.friction = (2e-3) * 3
electricRacerEntity.burner = {
    fuel_category = "electrical",
    effectivity = 1,
    fuel_inventory_size = 0,
}
data:extend { electricRacerEntity }


-- Electrical rover
local electricRoverEntity = table.deepcopy(data.raw["car"]["car"]) -- Copy car entity
electricRoverEntity.name = "electric-rover-entity"
electricRoverEntity.minable = { result = "electric-rover", mining_time = 0.3 }
electricRoverEntity.consumption = "200kW"
electricRoverEntity.braking_power = "100kW"
electricRoverEntity.weight = 700 * 1.8
electricRoverEntity.friction = (2e-3) * 2
electricRoverEntity.burner = {
    fuel_category = "electrical",
    effectivity = 1,
    fuel_inventory_size = 1,
}
electricRoverEntity.animation = {
    animation_speed = 8,
    direction_count = 1,
    frame_count = 1,
    height = 170,
    max_advance = 0.2,
    priority = "low",
    shift = {
        0,
        -0.1875
    },
    scale = 0.5,
    stripes = {
        {
            filename = "__electric-cars__/graphics/electric-racer.png",
            height_in_frames = 1,
            width_in_frames = 1
        }
    },
    width = 200
}
electricRoverEntity.light = {
    {
        type = "oriented",
        minimum_darkness = 0.3,
        picture = {
            filename = "__core__/graphics/light-cone.png",
            priority = "extra-high",
            flags = { "light" },
            width = 200,
            height = 200,
            scale = 2
        },
        shift = { -0.6, -14 },
        size = 1,
        intensity = 0.6,
        color = { r = 0.92, g = 0.77, b = 0.3 }
    },

}

electricRoverEntity.light_animation = {
    filename = "__base__/graphics/entity/car/car-light.png",
    blend_mode = "additive",
    draw_as_glow = true,
    width = 102,
    height = 84,
    line_length = 8,
    direction_count = 64,
    shift = { 0.0625, -0.15625 },
    priority = "low",
    repeat_count = 1,
    hr_version = {
        filename = "__base__/graphics/entity/car/hr-car-light.png",
        blend_mode = "additive",
        draw_as_glow = true,
        width = 206,
        height = 162,
        line_length = 8,
        direction_count = 64,
        shift = { 0.03125, -0.09375 },
        priority = "low",
        repeat_count = 1,
        scale = 0.5
    }
}
data:extend { electricRoverEntity }





-- Electrical concrete
local electricalConcreteTile = table.deepcopy(data.raw["tile"]["concrete"]) -- entity version of concrete

electricalConcreteTile.name = "electrical-concrete"
electricalConcreteTile.minable = { mining_time = 0.1, result = "electrical-concrete" }
electricalConcreteTile.tint = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 }
electricalConcreteTile.next_direction = "electrical-concrete"
electricalConcreteTile.walking_speed_modifier = 1.4

data:extend { electricalConcreteTile }

-- Energy interface - for making concrete require power

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
        buffer_capacity = "40KJ",
        input_flow_limit = "20KW",
        output_flow_limit = "0W",
        drain = "5KW"
    },
    picture = {
        filename = "__base__/graphics/icons/concrete.png",
        priority = "high",
        width = 1,
        height = 1,
    },
}

data:extend { energyInterface }

-- Charging station
local chargingStationEntity = table.deepcopy(data.raw["accumulator"]["accumulator"])

chargingStationEntity.name = "charging-station-entity"
chargingStationEntity.minable = { mining_time = 0.2, result = "charging-station" }
chargingStationEntity.energy_source = {
    type = "electric",
    buffer_capacity = "5MJ",
    usage_priority = "tertiary",
    input_flow_limit = "500KW",
    output_flow_limit = "0W",
    drain = "5KW"
}
chargingStationEntity.energy_usage = "10KW"
chargingStationEntity.icons = {
    {
        icon = chargingStationEntity.icon,
        icon_size = chargingStationEntity.icon_size,
        tint = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 }
    },
}
chargingStationEntity.flags = { "placeable-neutral", "placeable-player", "player-creation" }
chargingStationEntity.radius_visualisation_specification = {
    sprite = {
        filename = "__electric-cars__/graphics/shadow-circle.png",
        width = 2048,
        height = 2048,
        priority = "medium"
    },
    draw_on_selection = true,
    distance = 10
}
data:extend { chargingStationEntity }
