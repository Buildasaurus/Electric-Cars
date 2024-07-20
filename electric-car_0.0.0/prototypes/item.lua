-- Electric car
local electricCarItem = table.deepcopy(data.raw["item-with-entity-data"]["car"]) -- copy car item

electricCarItem.name = "electric-car"
electricCarItem.icons = {
    {
        icon = electricCarItem.icon,
        icon_size = electricCarItem.icon_size,
        tint = { r = 0.5, g = 0.5, b = 0.5, a = 0.75 }
    },
}

electricCarItem.place_result = "electric-car-entity"
data:extend { electricCarItem }



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
