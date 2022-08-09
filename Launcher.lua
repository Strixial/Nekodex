--[[
    Nekodex Loader (open-source edition)

    Use for your game hubs or something idk

    License (so you skids can know how far you can use it):
    MIT License

    Copyright (c) 2022 qman#1337 (aka Strixial, AverageNekoEnjoyer or qman_exists)

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
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
    loadstring(game:HttpGet(BaseNekodexUrl..NekodexGames[game.PlaceId]["CodeDirectory"]))()
end