local QBCore = exports['qb-core']:GetCoreObject()
local isBookOpen = false
local tabletProp = nil

local function playAnimation()
    local animDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
    local animName = "base"
    local propName = `prop_cs_tablet`

    RequestAnimDict(animDict)
    RequestModel(propName)
    while not HasAnimDictLoaded(animDict) or not HasModelLoaded(propName) do
        Wait(100)
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    ClearPedTasksImmediately(ped)

    tabletProp = CreateObject(propName, coords.x, coords.y, coords.z, true, true, true)
    AttachEntityToEntity(tabletProp, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    TaskPlayAnim(ped, animDict, animName, 3.0, -8.0, -1, 49, 0, false, false, false)
    RemoveAnimDict(animDict)
end

local function stopAnimation()
    local ped = PlayerPedId()
    StopAnimTask(ped, "amb@code_human_in_bus_passenger_idles@female@tablet@base", "base", 1.0)
    ClearPedTasks(ped)
    if tabletProp and DoesEntityExist(tabletProp) then
        DeleteEntity(tabletProp)
        tabletProp = nil
    end
end

RegisterNetEvent('ap_guidebook:client:openBook', function(data)
    if isBookOpen then return end
    isBookOpen = true
    
    playAnimation()
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openBook',
        pages = data.pages,
        canEdit = data.canEdit,
        bookTitle = data.bookTitle,
        bookType = data.bookType,
        startCategory = data.startCategory
    })
end)

RegisterNUICallback('closeBook', function(data, cb)
    if not isBookOpen then return end
    isBookOpen = false
    SetNuiFocus(false, false)
    stopAnimation()
    cb('ok')
end)

CreateThread(function()
    while true do
        Wait(1)
        if isBookOpen and (IsControlJustPressed(0, 322) or IsControlJustPressed(0, 177)) then
            isBookOpen = false
            SetNuiFocus(false, false)
            SendNUIMessage({ action = 'forceClose' })
            stopAnimation()
        end
    end
end)

RegisterNUICallback('savePage', function(data, cb)
    QBCore.Functions.TriggerCallback('ap_guidebook:server:savePage', function(response) cb(response) end, data)
end)
RegisterNUICallback('addCategory', function(data, cb)
    QBCore.Functions.TriggerCallback('ap_guidebook:server:addCategory', function(response) cb(response) end, data)
end)
RegisterNUICallback('removeCategory', function(data, cb)
    QBCore.Functions.TriggerCallback('ap_guidebook:server:removeCategory', function(response) cb(response) end, data)
end)