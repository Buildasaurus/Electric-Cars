-- Ensure the global table is properly initialized
local function init_global()
    if not global.car_energy then
        global.car_energy = {}
    end
end

-- Initialize global data when the mod is first loaded
local function on_init()
    init_global()
end

script.on_init(on_init)

-- Handle configuration changes
local function on_configuration_changed(data)
    if data and data.mod_changes and data.mod_changes["electric-car"] then
        init_global() -- Reinitialize the global table if the mod has changed
    end
end

script.on_configuration_changed(on_configuration_changed)



-- Initialize car energy when it is built
local function on_built_entity(event)
    local entity = event.created_entity
    if entity and entity.name == "electric-car-entity" then
        -- Ensure global is initialized
        init_global()
        local carItem = event.stack

        log("electric-car built. item_number was: " .. carItem.item_number)


        -- find a way to retrieve the energy energy from the global table
        local remainingEnergy = global.car_energy[carItem.item_number] or (50 * 1e6) -- Default 50 MJ

        log("Stored energy at " .. carItem.item_number .. " was " .. remainingEnergy)

        entity.burner.currently_burning = game.item_prototypes["car-battery"]
        entity.burner.remaining_burning_fuel = remainingEnergy
        entity.burner.currently_burning = game.item_prototypes["car-battery"]
    end
end

script.on_event(defines.events.on_built_entity, on_built_entity)




-- Charge the car when on electrical concrete
local function charge_car(car)
    if car and car.valid and car.name == "electric-car-entity" then
        local position = car.position
        local surface = car.surface
        local tile = surface.get_tile(position)

        if tile.name == "electrical-concrete" then
            -- Charge the car if it is on electrical concrete
            if car.burner then
                local energy_to_add = 1e4 -- 100 KJ per tick
                car.burner.remaining_burning_fuel = car.burner.remaining_burning_fuel + energy_to_add
                -- Ensure the remaining_burning_fuel does not exceed maximum capacity
                local max_energy = 50*1e6 -- 50 MJ
                car.burner.remaining_burning_fuel = math.min(car.burner.remaining_burning_fuel, max_energy)
            end
        end
    end
end

script.on_event(defines.events.on_tick, function(event)
    for _, car in pairs(game.surfaces[1].find_entities_filtered { type = "car" }) do
        charge_car(car)
    end
end)


-- Save car charge when it is mined
local function on_player_mined_entity(event)
    local entity = event.entity
    if entity and entity.name == "electric-car-entity" then
        -- Save energy data
        local remainingEnergy = entity.burner and entity.burner.remaining_burning_fuel or 0
        local electricCarItem = event.buffer.find_item_stack("electric-car")

        -- find a way to store the energy
        log("electric-car-entity mined. Remaining energy: " .. remainingEnergy)
        if electricCarItem then
            global.car_energy[electricCarItem.item_number] = remainingEnergy
            log("Stored energy at item_number:" .. electricCarItem.item_number)
        else
            if player then
                log("Failed to save energy stored in car. This should not happen")
            end
        end
    end
end

script.on_event(defines.events.on_player_mined_entity, on_player_mined_entity)
