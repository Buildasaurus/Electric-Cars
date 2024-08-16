data:extend { {
    type = "fuel-category",
    name = "electrical"
} }

-- Electric Racing Car
local electricCarItem = table.deepcopy(data.raw["item-with-entity-data"]["car"]) -- copy car item

electricCarItem.name = "electric-racer"
electricCarItem.icons = {
    {
        icon = electricCarItem.icon,
        icon_size = electricCarItem.icon_size,
        tint = { r = 0.5, g = 0.5, b = 1, a = 0.75 }
    },
}
electricCarItem.place_result = "electric-racer-entity"
data:extend { electricCarItem }

-- Electric Rover
local electricCarItem = table.deepcopy(data.raw["item-with-entity-data"]["car"]) -- copy car item

electricCarItem.name = "electric-rover"
electricCarItem.icons = {
    {
        icon = electricCarItem.icon,
        icon_size = electricCarItem.icon_size,
        tint = { r = 0.5, g = 0.5, b = 1, a = 0.75 }
    },
}
electricCarItem.place_result = "electric-rover-entity"
data:extend { electricCarItem }


-- Internal car battery
local carBattery = table.deepcopy(data.raw["item"]["rocket-fuel"])
carBattery.name = "car-battery"
carBattery.fuel_value = "50MJ"
carBattery.fuel_category = "electrical"
data:extend { carBattery }


-- C- battery
local CBattery = table.deepcopy(data.raw["item"]["rocket-fuel"])
CBattery.name = "c-battery"
CBattery.stack_size = 100
CBattery.fuel_value = "50KJ" -- Yes - c-batteries are quite small compared to a car battery
CBattery.fuel_category = "electrical"
CBattery.icon = "__electric-cars__/graphics/c-battery.png"
CBattery.icon_size = 384
data:extend { CBattery }


-- D- battery
local DBattery = table.deepcopy(data.raw["item"]["rocket-fuel"])
DBattery.name = "d-battery"
DBattery.stack_size = 100
DBattery.fuel_value = "140KJ" -- Yes - d-batteries are also quite small compared to a car battery
DBattery.fuel_category = "electrical"
DBattery.icon = "__electric-cars__/graphics/d-battery.png"
DBattery.icon_size = 384
data:extend { DBattery }


-- Electrical concrete
local electricalConcreteItem = table.deepcopy(data.raw["item"]["concrete"])

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
data:extend { electricalConcreteItem }




-- Electrical charging station
local chargingStation = table.deepcopy(data.raw["item"]["accumulator"])

chargingStation.name = "charging-station"
chargingStation.icons = {
    {
        icon = chargingStation.icon,
        icon_size = chargingStation.icon_size,
        tint = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 }
    },
}
chargingStation.place_result = "charging-station-entity"


data:extend { chargingStation }
