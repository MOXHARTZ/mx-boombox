RegisterNetEvent('mx-boombox:attach', function(soundId, netId, volume)
    if not netId then return end
    exports['mx-surround']:attachEntity(-1, soundId, netId)
    Wait(200)
    exports['mx-surround']:setVolumeMax(-1, soundId, volume)
end)
