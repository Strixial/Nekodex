--[[
    the ripoff mmx game on roblox
    this one: https://www.roblox.com/games/6735275521/BACK-Murder-Mystery-X-FREE-RADIO-HUNTER

    wait wtf why are you skidding!!!!!!!!!!
]]

-- initialise libraries
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Moon'))() 
local Window = Library:CreateWindow("Nekodex", "#ea98ff", 0)

Window:CreateTab("Combat")

Window:CreateLabel("Murderer", "Combat")
Window:CreateToggle("Knife Silent Aim", "Combat", function(enabled)
    if enabled then
        print("Enabled Knife Silent Aim")
    else
        print("Disabled Knife Silent Aim")
    end
end)

Window:CreateToggle("Knife Wallbang", "Combat", function(enabled)
    if enabled then
        print("Enabled Knife Wallbang")
    else
        print("Disabled Knife Wallbang")
    end
end)

Window:CreateTab("Render")
Window:CreateLabel("ESP", "Render")

local ESPMode = "Shader"

Window:CreateToggle("ESP", "Render", function(enabled)
    if ESPMode == "Shader" then
        print("shader esp ", enabled)
    end
end)

Window:CreateDropdown("ESP Mode", "Render", {
    "Shader",
    "Skeleton",
    "2D Box"
})

