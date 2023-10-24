local boombox_ = joaat('prop_boombox_01')

local carry_anim_dict = 'anim@heists@box_carry@'
local carry_anim_name = 'idle'
local put_anim_dict = 'random@domestic'
local put_anim_name = 'pickup_low'

local carrying_boombox = false

local current_boombox = nil

local function nearbyBoombox()
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local objects = GetGamePool('CObject')
    for _, object in ipairs(objects) do
        if GetEntityModel(object) == boombox_ and #(playerCoords - GetEntityCoords(object)) < 3.0 then
            return object
        end
    end
    return false
end

local function openUi()
    local boombox = nearbyBoombox()
    if not boombox then return end
    current_boombox = boombox
    exports['mx-audioplayer']:open({
        onPlay = function(sound)
            TriggerServerEvent('mx-boombox:attach', sound.soundId, NetworkGetNetworkIdFromEntity(current_boombox))
        end
    })
end

local function loadAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function create()
    local boombox = nearbyBoombox()
    if boombox then return end
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local heading = GetEntityHeading(player)
    RequestModel(boombox_)
    while not HasModelLoaded(boombox_) do
        RequestModel(boombox_)
        Wait(5)
    end
    local object = CreateObject(boombox_, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
    PlaceObjectOnGroundProperly(object)
    SetEntityHeading(object, heading)
    SetEntityAsMissionEntity(object, true, true)
    SetModelAsNoLongerNeeded(boombox_)
    loadAnim(put_anim_dict)
    TaskPlayAnim(player, put_anim_dict, put_anim_name, 8.0, -8.0, -1, 0, 0, false, false, false)
    Wait(200)
    PlaceObjectOnGroundProperly(object)
    StopAnimTask(player, put_anim_dict, put_anim_name, 3.0)
end

local function carryAnim()
    local ped = PlayerPedId()
    loadAnim(carry_anim_dict)
    while carrying_boombox do
        if IsEntityPlayingAnim(PlayerPedId(), carry_anim_dict, carry_anim_name, 3) then goto continue end
        TaskPlayAnim(ped, carry_anim_dict, carry_anim_name, 8.0, -8.0, -1, 51, 0, false, false, false)
        ::continue::
        Wait(500)
    end
    StopAnimTask(ped, carry_anim_dict, carry_anim_name, 3.0)
end

local function pickup()
    local player = PlayerPedId()
    local boombox = nearbyBoombox()
    if not boombox then return end
    AttachEntityToEntity(boombox, player, GetPedBoneIndex(player, 24817), 0.0, 0.40, -0.0, -180.0, 90.0, 0.0, false, false, false, false, 2, true)
    carrying_boombox = true
    CreateThread(carryAnim)
    return
end

local function drop()
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local boombox = nearbyBoombox()
    if not boombox then return end
    carrying_boombox = false
    DetachEntity(boombox, true, true)
    SetEntityCoords(boombox, playerCoords.x, playerCoords.y, playerCoords.z - 0.95, true, true, true, true)
    SetEntityAsMissionEntity(boombox, true, true)
    loadAnim(put_anim_dict)
    TaskPlayAnim(player, put_anim_dict, put_anim_name, 8.0, -8.0, -1, 0, 0, false, false, false)
    Wait(500)
    PlaceObjectOnGroundProperly(boombox)
end

local function destroy()
    local boombox = nearbyBoombox()
    if not boombox then return end
    SetEntityAsMissionEntity(boombox, true, true)
    DeleteEntity(boombox)
end

RegisterCommand(Config.AccessBoomboxCommand, openUi, false)

RegisterCommand(Config.CreateBoomboxCommand, create, false)

RegisterCommand(Config.PickupBoomboxCommand, pickup, false)

RegisterCommand(Config.DropBoomboxCommand, drop, false)

RegisterCommand(Config.DestroyBoomboxCommand, destroy, false)
