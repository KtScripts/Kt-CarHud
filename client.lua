local showHud = false
local seatbeltOn = false
local flash = false

-- Key mapping
RegisterKeyMapping('togglebelt', 'Toggle Seatbelt', 'keyboard', 'B')

RegisterCommand('togglebelt', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        seatbeltOn = not seatbeltOn
        TriggerEvent('hud:seatbeltToggled', seatbeltOn)
    end
end, false)

RegisterNetEvent('hud:seatbeltToggled', function(state)
    SendNUIMessage({ seatbelt = state and "on" or "off" })
end)

CreateThread(function()
    while true do
        Wait(200)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if IsPedInAnyVehicle(ped, false) then
            if not showHud then
                showHud = true
                SendNUIMessage({ show = true })
            end

            local speed = GetEntitySpeed(vehicle) * 2.23694 
            local fuel = exports['cdn-fuel']:GetFuel(vehicle) or 0

            if speed > 15 and not seatbeltOn then
                flash = not flash
                SendNUIMessage({ flashBelt = flash })
            else
                SendNUIMessage({ flashBelt = false })
            end

            SendNUIMessage({
                speed = math.floor(speed),
                fuel = math.floor(fuel),
                seatbelt = seatbeltOn and "on" or "off"
            })
        elseif showHud then
            showHud = false
            SendNUIMessage({ show = false })
        end
    end
end)
