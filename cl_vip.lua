ESX = nil
VIP = false
local PlayerLoaded = false

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

CreateThread(function()
	TriggerServerEvent("ddx_vip:checkVip", source)
end)

RegisterNetEvent("ddx_vip:vipChecked")
AddEventHandler("ddx_vip:vipChecked", function()
	VIP = true
	ESX.ShowNotification('VIP ACTIF')
end)

local ShowNotification = function(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

vipShop_config = {
	position = {
		{name = 'Vip Shop', x = -1528.65,  y = -416.58,  z = 35.81} -- ADD MORE IF U WANT DON'T FORGET THE COMMA 
	},

	items = {
		{label = 'Pain', value = 'bread', price = '15'},
		{label = 'Eau', value = 'water', price = '10'}
	}
}


----------------------------------------------------------------
----						Shop							----
----------------------------------------------------------------

Numbers = {}
local mainMenu = RageUI.CreateMenu("Vip Shop", "Vip Shop")
local index = {
    list = 1,
}

CreateThread(function()
	while true do

		for i = 1, 10 do
			table.insert(Numbers, i)
		end

		for k,v in pairs(vipShop_config.position) do
			local playerPOS = GetEntityCoords(PlayerPedId())
			if GetDistanceBetweenCoords(playerPOS, v.x, v.y, v.z, true) < 10.0 and VIP == true then
				DrawMarker(29, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.9, 0.9, 0.9, 0, 128, 255, 255, true, true, 2, false, nil, nil, false)
			end
			if GetDistanceBetweenCoords(playerPOS, v.x, v.y, v.z, true) < 2 and VIP == true then
				Visual.Subtitle("Appuyez sur ~r~E~w~ pour ouvrir le shop", 100)
                Keys.Register('E', 'E', 'Open RageUI Showcase menu default.', function()
					RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
				end)
			end
		end

		RageUI.IsVisible(mainMenu, function()
			for k, v in ipairs(vipShop_config.items) do
				RageUI.List(v.label .. ' ' .. v.price .. '~g~$~w~', Numbers, index.list, nil, { }, true,
				 
				{
					onListChange = function(Index, Item)
						index.list = Index;
					end,
					onSelected = function(Index, Item)
						local count = Index;
						local item = v.value
						local price = v.price * count
						TriggerServerEvent('ddx_vip:buyItem', v, count)
					end,
				})
			end
		end)

		Wait(5)
    end
end)

CreateThread(function()
	for k,v in pairs(vipShop_config.position) do
		local vipBlip = AddBlipForCoord(v.x,v.y,v.z)
		SetBlipDisplay(vipBlip, 4)
		SetBlipSprite(vipBlip, 605)
		SetBlipColour(vipBlip, 5)
		SetBlipScale(vipBlip, 0.8)
		SetBlipAsShortRange(vipBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vip Shop")
		EndTextCommandSetBlipName(vipBlip)
	end
end)