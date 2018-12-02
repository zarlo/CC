if not http then

    printError( "nget requires http API" )
    printError( "Set http_enable to true in ComputerCraft.cfg" )
	  printError( "And how the hell did you get nget")

    return
end

local function printUsage()
    print( "Usages:" )
    print( "nget get <code> <filename>" )
    print( "nget run <code> <arguments>" )
	print( "nget install <code> " )
	print( "nget repos add <URL>")
end

local tArgs = { ... }

if #tArgs < 2 then
    printUsage()
    return
end

local temp = io.open("repositories.list", "r")
print(temp)
local repositories = split(temp,"|")


local function get(paste)

    write( "Connecting to server... " )
    local t = 0;
    while(t < #repositories)
    do

	local response = http.get(repositories[t]..textutils.urlEncode( paste ))


    	if response then
          print( "Success." )

          local sResponse = response.readAll()
          response.close()
          return sResponse
        end
    end
    printError( "Failed." )
end

local sCommand = tArgs[1]

if sCommand == "get" then

    if #tArgs < 3 then
        printUsage()
        return
    end

    -- Determine file to download
    local sCode = tArgs[2]
    local sFile = tArgs[3]
    local sPath = shell.resolve( sFile )
    if fs.exists( sPath ) then
        print( "File already exists" )
        return
    end

    local res = get(sCode)
    if res then
        local file = fs.open( sPath, "w" )
        file.write( res )
        file.close()

        print( "Downloaded as "..sFile )
    end

elseif sCommand == "repos" then

    local sCommand1 = tArgs[2]

    if sCommand1 == "add" then

	    local file = fs.open( "/etc/nget/repositories.list", "w" )
        file.write( temp .. "|" .. tArgs[3] )
        file.close()

	end

else

    printUsage()
    return

end