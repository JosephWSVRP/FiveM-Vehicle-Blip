local lastVehicle = nil
local blip = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Check every second
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        
        if vehicle ~= 0 then
            lastVehicle = vehicle
            if blip then
                RemoveBlip(blip)
            end
        end

        if lastVehicle and DoesEntityExist(lastVehicle) and not IsPedInAnyVehicle(playerPed, false) then
            local coords = GetEntityCoords(lastVehicle)
            if blip then
                SetBlipCoords(blip, coords.x, coords.y, coords.z)
            else
                blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                SetBlipSprite(blip, 1) -- Small white blip
                SetBlipColour(blip, 0) -- White color
                SetBlipScale(blip, 0.6)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Last Vehicle")
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end)
