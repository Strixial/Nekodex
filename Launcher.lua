--[[
    the nekodex loader 🥶
    hand coded by the one and only qman#1337
    i think my code goes so hard, ill let you copy+paste into your shitty hub ;)
    
]]

-- Prelaunch things
getgenv().LauncherVersion = "1.0"
local NekodexLib = loadstring(game:HttpGet("https://github.com/Strixial/Nekodex/raw/main/NekodexLib.lua"))()
local BaseNekodexUrl = "https://raw.githubusercontent.com/Strixial/Nekodex/main/" -- if youre a skid change this to your base url

-- Get game list and current game
local NekodexGames = game:HttpGet("https://github.com/Strixial/Nekodex/raw/main/NekodexGames.json")
NekodexGames = NekodexLib.TransformJSON(NekodexGames)

if not NekodexGames[game.PlaceId] then
    print("Nekodex - Unsupported game!")
else
    print("Loading for ", NekodexGames[game.PlaceId]["GameName"])
    -- get script url and load
    loadstring(NekodexLib.Req(BaseNekodexUrl..NekodexGames[game.PlaceId]["CodeDirectory"]))()
end