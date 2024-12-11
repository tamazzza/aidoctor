local QBCore = exports['qb-core']:GetCoreObject()

local function IsAllowedJob(jobName)
    for _, allowedJob in ipairs(Config.Job) do
        if allowedJob == jobName then
            return true
        end
    end
    return false
end

QBCore.Functions.CreateCallback('ai:docOnline', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local xPlayers = QBCore.Functions.GetPlayers()
    local doctor = Config.Doctor
    local canpay = Config.CanPay

    if Ply.PlayerData.money["cash"] >= Config.Price then
        canpay = true
    else if Ply.PlayerData.money["bank"] >= Config.Price then
        canpay = true
    end
end

    for i = 1, #xPlayers, 1 do
        local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
        if IsAllowedJob(xPlayer.PlayerData.job.name) then
            doctor = doctor + 1
        end
    end

    cb(doctor, canpay)
end)

RegisterServerEvent('ai:charge')
AddEventHandler('ai:charge', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if xPlayer.PlayerData.money["cash"] >= Config.Price then
        xPlayer.Functions.RemoveMoney("cash", Config.Price)
    else
        xPlayer.Functions.RemoveMoney("bank", Config.Price)
    end
end)
