local sounds = {}

RegisterNetEvent('mx-boombox:play', function(url, soundId, netId)
    local src = source
    if not netId then return end
    if sounds[src] then
        -- Destroy the previous sound
        exports['mx-surround']:Destroy(-1, sounds[src])
    end
    local player = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(player)
    -- Play the new sound
    exports['mx-surround']:Play(-1, soundId, url, playerCoords)
    -- Check if the sound was created
    if not soundId then return print('Failed to play sound') end
    -- Attach the sound to the player for everyone
    exports['mx-surround']:attachEntity(-1, soundId, netId)
    exports['mx-surround']:setDestroyOnFinish(-1, soundId, false)
    sounds[src] = soundId
end)

AddEventHandler('playerDropped', function()
    local src = source
    if sounds[src] then
        exports['mx-surround']:Destroy(-1, sounds[src])
    end
    sounds[src] = nil
end)

RegisterNetEvent('mx-boombox:setVolume', function(soundId, volume)
    print('volume', volume)
    exports['mx-surround']:setVolumeMax(-1, soundId, volume)
end)
