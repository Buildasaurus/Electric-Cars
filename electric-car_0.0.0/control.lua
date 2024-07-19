-- Function to initialize car energy when it is created
local function initializeCarEnergy(event)
    if event.created_entity and event.created_entity.name == "electric-car-entity" then
        local car = event.created_entity
        car.burner.currently_burning = game.item_prototypes["coal"]
        car.burner.remaining_burning_fuel = 100 * 1e6 -- 100 MJ in joules
    end
end

-- Function to charge the car when on electrical concrete
local function chargeCar(car)
    if car and car.valid and car.name == "electric-car-entity" then
        local position = car.position
        local surface = car.surface
        local tile = surface.get_tile(position)

        if tile.name == "electrical-concrete" then
            -- Charge the car if it is on electrical concrete
            if car.burner then
                local energyToAdd = 1e4 -- 100 KJ per tick
                car.burner.remaining_burning_fuel = car.burner.remaining_burning_fuel + energyToAdd
                -- Ensure the remaining_burning_fuel does not exceed maximum capacity
                local max_energy = 1e8 -- 100 MJ
                car.burner.remaining_burning_fuel = math.min(car.burner.remaining_burning_fuel, max_energy)
            end
        end
    end
end

-- Register the function to initialize car energy when built
script.on_event(defines.events.on_built_entity, initializeCarEnergy)

-- Register the function to charge the car on every tick
script.on_event(defines.events.on_tick, function(event)
    for _, car in pairs(game.surfaces[1].find_entities_filtered{type = "car"}) do
        chargeCar(car)
    end
end)
