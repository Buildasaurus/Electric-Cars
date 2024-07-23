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

        -- find a way to retrieve the energy from the global table
        local remainingEnergy = 0 -- Starts with no energy

        log("Stored energy at " .. carItem.item_number .. " was " .. remainingEnergy)

        entity.burner.currently_burning = game.item_prototypes["car-battery"]
    end
end

script.on_event(defines.events.on_built_entity, on_built_entity)

-- Charge the car when on electrical concrete
local function charge_car(car)
    if car and car.valid and car.burner.fuel_categories["electrical"] then
        local position = car.position
        local surface = car.surface
        local tile = surface.get_tile(position)
        log("Valid electrical car detected")
        if tile.name == "electrical-concrete" then
            -- Find the energy interface at the car's position
            local energy_interface = surface.find_entities_filtered { position = position, name = "electric-concrete-energy-interface" }
                [1]
            log("The car is on electrical concrete")

            if energy_interface and energy_interface.energy > 0 then
                log("The concrete has energy")

                -- Charge the car if the energy interface has power
                if car.burner then
                    local energy_to_add = 1e4 -- 10 KJ per tick
                    local new_heat = car.burner.remaining_burning_fuel + energy_to_add


                    if car.burner.remaining_burning_fuel == 0 or car.burner.currently_burning.fuel_value < new_heat and car.burner.currently_burning.name ~= "car-battery"
                    then
                        car.burner.currently_burning = game.item_prototypes["car-battery"]
                    end
                    log("The car is burning " .. car.burner.currently_burning.name .. " at heat " .. car.burner.heat)
                    log("The max heat of the car is " .. car.burner.heat_capacity)
                    log("The car is about to get" ..
                        energy_to_add .. "and should be at " .. new_heat)

                    car.burner.remaining_burning_fuel = new_heat
                    log("The car has a burner and now has fuel " .. car.burner.remaining_burning_fuel)
                end
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
    if entity and entity.name == "electric-racer-entity" then
        -- Save energy data
        local remainingEnergy = entity.burner and entity.burner.remaining_burning_fuel or 0
        local electricCarItem = event.buffer.find_item_stack("electric-racer")

        -- find a way to store the energy
        log("electric-racer-entity mined. Remaining energy: " .. remainingEnergy)
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
