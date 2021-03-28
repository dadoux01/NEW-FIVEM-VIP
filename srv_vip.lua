ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local vipList = {
        "license:9adf9858542575c87f0a69109d9bbee13c02e187"
    }


RegisterNetEvent("ddx_vip:checkVip")
AddEventHandler("ddx_vip:checkVip", function()
	identifier = GetPlayerIdentifiers(source)
    for k,v in ipairs(identifier) do
        for _,k in pairs(vipList) do
            if v == k then
                TriggerClientEvent("ddx_vip:vipChecked", source)
		    	print(('ddx_vip: Le statut VIP a été réinitialisé pour %s !'):format(GetPlayerName(source)))
		    end
        end
	end
end)

RegisterServerEvent('ddx_vip:buyItem')
AddEventHandler('ddx_vip:buyItem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()

    if playerMoney >= item.price * count then
        xPlayer.addInventoryItem(item.value, count)
        xPlayer.removeMoney(item.price * count)

        TriggerClientEvent('esx:showNotification', source, "Merci de votre ~g~Achats !")
     else
          TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez d'argent, il vous manque: ~r~".. item.price * count - playerMoney .."$")
     end
end)

