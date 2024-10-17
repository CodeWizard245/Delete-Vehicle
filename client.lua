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

TriggerEvent('chat:addSuggestion', '/dv', 'Remove the nearest vehicle.')

RegisterCommand('cv', function(source, args, rawCommand)
    local vehicleName = args[1]
    if vehicleName == nil then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0 },
            multiline = true,
            args = { "Error", "You did not specify the name of the vehicle." }
        })
        return
    end

    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed)

    RequestModel(vehicleName)
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    local vehicle = CreateVehicle(vehicleName, playerCoords.x + 5, playerCoords.y + 5, playerCoords.z, GetEntityHeading(playerPed), true, false)
    SetPedIntoVehicle(playerPed, vehicle, -1)

    TriggerEvent('chat:addMessage', {
        color = { 0, 255, 0 },
        multiline = true,
        args = { "System", "The vehicle has been created: " .. vehicleName }
    })

    SetModelAsNoLongerNeeded(vehicleName)
end, false)

TriggerEvent('chat:addSuggestion', '/cv', 'Create a vehicle. Use: /cv [the name of the transport vehicle]')
