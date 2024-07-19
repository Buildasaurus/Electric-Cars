script.on_event(defines.events.on_built_entity, function(event)
    if event.created_entity.name == "electric-car-entity" then
        local car = event.created_entity
        car.burner.currently_burning = game.item_prototypes["coal"]  -- Assuming you want to use coal as the initial fuel
        car.burner.remaining_burning_fuel = 100 * 1000000 -- 100 MJ in joules
    end
end)
