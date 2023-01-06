BathingSessions = {}

RegisterServerEvent("rdr-bathing:canEnterBath")
AddEventHandler("rdr-bathing:canEnterBath", function(town)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local currentMoney = user.getMoney()

        if not BathingSessions[town] then
            if currentMoney >= Globals.Price then
                user.removeMoney(Globals.Price)

                BathingSessions[town] = _source
                TriggerClientEvent("rdr-bathing:StartBath", _source, town)
            else
                print("NOTIFICATION HERE")
            end
        else
            print("NOTIFICATION HERE")
        end

    end)
end)


RegisterServerEvent("rdr-bathing:canEnterDeluxeBath")
AddEventHandler("rdr-bathing:canEnterDeluxeBath", function(p1 , p2 , p3)
    local _source = source
    if BathingSessions[p2] == _source then

        TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
            local currentMoney = user.getMoney()

            if currentMoney >= Globals.Deluxe then
                user.removeMoney(Globals.Deluxe)
                TriggerClientEvent("rdr-bathing:StartDeluxeBath", _source , p1 , p2 , p3)
            else
                print("NOTIFICATION HERE")
				TriggerClientEvent("rdr-bathing:HideDeluxePrompt", _source)
            end


        end)
    end

end)


RegisterServerEvent("rdr-bathing:setBathAsFree")
AddEventHandler("rdr-bathing:setBathAsFree", function(town)
    if BathingSessions[town] == source then
        BathingSessions[town] = nil
    end
end)

AddEventHandler('playerDropped', function()
    for town,player in pairs(BathingSessions) do
        if player == source then
            BathingSessions[town] = nil
        end
    end
end)


