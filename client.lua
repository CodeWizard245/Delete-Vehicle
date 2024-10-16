RegisterCommand('dv', function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        local playerCoords = GetEntityCoords(playerPed)
        local radius = 10.0

        vehicle = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, radius, 0, 70)
    end

    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0 },
            multiline = true,
            args = { "System", "The vehicle has been removed." }
        })
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0 },
            multiline = true,
            args = { "System", "There are no vehicles nearby." }
        })
    end
end, false)
