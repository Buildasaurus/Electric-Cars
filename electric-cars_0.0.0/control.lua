-- Ensure the global table is properly initialized
local function init_global()
    if not global.car_energy then
        global.car_energy = {}
    end
    if not global.electric_car_entities then
        global.electric_car_entities = {}
    end
end

-- Initialize global data when the mod is first loaded
local function on_init()
    init_global()
end

script.on_init(on_init)

-- Handle configuration changes
local function on_configuration_changed(data)
    if data and data.mod_changes and data.mod_changes["electric-cars"] then
        init_global() -- Reinitialize the global table if the mod has changed
    end
end

script.on_configuration_changed(on_configuration_changed)

-- Initialize car energy when it is built
local function on_built_entity(event)
    local entity = event.created_entity
    if entity and entity.burner and entity.burner.fuel_categories["electrical"] then
        -- Ensure global is initialized
        init_global()
        local carItem = event.stack

        log("electrical car built. item_number was: " .. carItem.item_number)

        -- store the car_entity in global.electric_car_entities for later use
        global.electric_car_entities[carItem.item_number] = entity

        -- find a way to retrieve the energy from the global table
        local remainingEnergy = global.car_energy[carItem.item_number] or 0 -- Starts with no energy or saved energy

        log("Stored energy at " .. carItem.item_number .. " was " .. remainingEnergy)

        entity.burner.currently_burning = game.item_prototypes["car-battery"]
        entity.burner.remaining_burning_fuel = remainingEnergy
    end
end

local function find_near_charged_charging_station_index(nearbyChargingStations)
    for index, station in ipairs(nearbyChargingStations) do
        if station.energy > 0 then
            return index
        end
    end
    return -1 -- No charging station found with energy > 0
end

script.on_event(defines.events.on_built_entity, on_built_entity)

-- Charge the car when on electrical concrete
local function charge_car(car)
    if car and car.valid and car.burner and car.burner.fuel_categories["electrical"] then
        local position = car.position
        local surface = car.surface
        local tile = surface.get_tile(position)

        -- Check for nearby charging stations
        local nearbyChargingStations = surface.find_entities_filtered { position = position, radius = 10, name = "charging-station-entity" }
        -- store the index of the first near charging station that has more than 0 energy 0, else -1
        local near_charged_charging_station_index = find_near_charged_charging_station_index(nearbyChargingStations)


        if near_charged_charging_station_index ~= -1 then
            local energy_to_add = 600 * 1e3 / 60               -- 600 KJ per second (60 ticks pr second)
            local newHeat = 0
            local charging_station = nearbyChargingStations[near_charged_charging_station_index] -- Assume using the first found station

            if charging_station.energy >= energy_to_add then
                charging_station.energy = charging_station.energy - energy_to_add
                newHeat = car.burner.remaining_burning_fuel + energy_to_add
            elseif charging_station.energy > 0 then
                newHeat = car.burner.remaining_burning_fuel + charging_station.energy
                charging_station.energy = 0
            end
            if (car.burner.remaining_burning_fuel == 0 or car.burner.currently_burning.fuel_value < newHeat) and car.burner.currently_burning.name ~= "car-battery" then
                car.burner.currently_burning = game.item_prototypes["car-battery"]
            end
            car.burner.remaining_burning_fuel = newHeat
        elseif tile.name == "electrical-concrete" then
            -- Find the energy interface at the car's position
            local energy_interface = surface.find_entities_filtered{ position = position, name = "electric-concrete-energy-interface" }[1]

            if energy_interface and energy_interface.energy > 0 then
                if car.burner then
                    local energy_to_add = 1e4 -- 10 KJ per tick
                    local new_heat = car.burner.remaining_burning_fuel + energy_to_add

                    -- Set the car's burner to "car-battery" if not already using it
                    if car.burner.remaining_burning_fuel == 0 or car.burner.currently_burning.fuel_value < new_heat and car.burner.currently_burning.name ~= "car-battery" then
                        car.burner.currently_burning = game.item_prototypes["car-battery"]
                    end

                    car.burner.remaining_burning_fuel = new_heat
                end
            end
        end
    end
end


script.on_event(defines.events.on_tick, function(event)
    init_global()
    if global.electric_car_entities then
        for _, car in pairs(global.electric_car_entities) do
            if car ~= nil and car.valid then
                log(car["name"])
                charge_car(car)
            else
                log("WARNING - nil car saved")
            end
        end
    end
end)


-- Save car charge when it is mined
local function on_player_mined_entity(event)
    local entity = event.entity
    if entity and entity.burner and entity.burner.fuel_categories["electrical"] then
        -- Save energy data
        local remainingEnergy = entity.burner and entity.burner.remaining_burning_fuel or 0
        local electricCarItem = event.buffer[1]

        -- find a way to store the energy
        log("electric-racer-entity mined. Remaining energy: " .. remainingEnergy)
        if electricCarItem then
            global.electric_car_entities[electricCarItem.item_number] = nil

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

-- Warning, if the wrong position is given, several EEI's might be destroyed
local function destroy_EEI_at_position(position, surface_index)
    local surface = game.surfaces[surface_index]
    local entities = surface.find_entities_filtered { position = position, name = "electric-concrete-energy-interface", radius = 0.1 }
    for _, entity in pairs(entities) do
        entity.destroy()
    end
end

local function destroy_EEI_at_adjusted_position(position, surface_index)
    -- We move the position slightly right and down, so that the find_entities_filtered only finds this
    -- specific position. The tile position is propably at the corner of the tile, and this causes several to be found
    position["x"] = position["x"] + 0.5
    position["y"] = position["y"] + 0.5
    destroy_EEI_at_position(position, surface_index)
end

-- Place the energy interface when electrical concrete is placed
local function on_tile_placed(event)
    for _, tile in pairs(event.tiles) do
        if tile.old_tile.name ~= "electrical-concrete" and event.tile.name == "electrical-concrete" then
            local surface = game.surfaces[event.surface_index]
            surface.create_entity {
                name = "electric-concrete-energy-interface",
                position = tile.position,
                force = event.player_index and game.players[event.player_index].force or game.forces.player,
            }
        end
        if tile.old_tile.name == "electrical-concrete" and event.tile.name ~= "electrical-concrete" then
            destroy_EEI_at_adjusted_position(tile.position, event.surface_index)
        end
    end
end

script.on_event(defines.events.on_player_built_tile, on_tile_placed)
script.on_event(defines.events.on_robot_built_tile, on_tile_placed)

-- Remove the energy interface when electrical concrete is removed
local function on_tile_removed(event)
    for _, tile in pairs(event.tiles) do
        if tile.old_tile.name == "electrical-concrete" then
            destroy_EEI_at_adjusted_position(tile.position, event.surface_index)
        end
    end
end



script.on_event(defines.events.on_player_mined_tile, on_tile_removed)
script.on_event(defines.events.on_robot_mined_tile, on_tile_removed)
