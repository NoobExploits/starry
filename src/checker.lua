local ids = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/ids.lua"))()

local placeid = game.PlaceId

if ((placeid) == ids.pSim99) then
    print('loaded pet sim')
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/games/pSim99.lua"))()
end