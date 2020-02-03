ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('voidrp-base:buy', function(source, cb, price)
    local player = ESX.GetPlayerFromId(source)
    if player.getMoney() >= price then
        player.removeMoney(price)
        cb(1)
    else
        cb(0)
    end
end)

RegisterServerEvent('voidrp-base:givePlayerItem')
AddEventHandler('voidrp-base:givePlayerItem', function(item, count)
    local player = ESX.GetPlayerFromId(source)
    player.addInventoryItem(item, count)
end)

ESX.RegisterServerCallback('voidrp-base:takePlayerItem', function(source, cb, item, count)
    local player = ESX.GetPlayerFromId(source)
    local invItem = player.getInventoryItem(item)
    if invItem.count - count < 0 then
        cb(false)
    else
        player.removeInventoryItem(item, count)
        cb(true)
    end
end)

RegisterServerEvent('voidrp-base:givePlayerDirtyMoney')
AddEventHandler('voidrp-base:givePlayerDirtyMoney', function(amount)
    local player = ESX.GetPlayerFromId(source)
    player.addAccountMoney('black_money', amount)
end)

RegisterServerEvent('voidrp-base:givePlayerMoney')
AddEventHandler('voidrp-base:givePlayerMoney', function(amount)
    local player = ESX.GetPlayerFromId(source)
    player.addMoney(amount)
end)

ESX.RegisterServerCallback('voidrp-base:takePlayerMoney', function(source, cb, amount)
    local player = ESX.GetPlayerFromId(source)
    local money = player.getMoney()
    if money - amount < 0 then
        cb(false)
    else
        player.removeMoney(amount)
        cb(true)
    end
end)