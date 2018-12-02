local function openModem()
    for n,sModem in ipairs( peripheral.getNames() ) do
        if peripheral.getType( sModem ) == "modem" then
            if not rednet.isOpen( sModem ) then
                rednet.open( sModem )
                sOpenedModem = sModem
            end
            return true
        end
    end
    print( "No modems found." )
    return false
end

local function closeModem()
    if sOpenedModem ~= nil then
        rednet.close( sOpenedModem )
        sOpenedModem = nil
    end
end