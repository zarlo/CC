local response = http.get(
        "https://raw.githubusercontent.com/zarlo/CC/master/nget.lua"
)

if response then
    local sResponse = response.readAll()
    response.close()
    local file = fs.open( "nget.lua", "w" )
    file.write( sResponse )
    file.close()
else
    printError( "Failed." )
    return
end

local response = http.get(
        "https://raw.githubusercontent.com/zarlo/CC/master/etc/nget/repositories.list"
)

if response then
    local sResponse = response.readAll()
    response.close()
    local file = fs.open( "/etc/nget/repositories.list", "w" )
    file.write( sResponse )
    file.close()
else
    printError( "Failed." )
    return
end