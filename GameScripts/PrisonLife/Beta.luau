local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local NekodexLib = loadstring(game:HttpGet("https://github.com/Strixial/Nekodex/raw/main/NekodexLib.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplStorage = game:GetService("ReplicatedStorage")

local HighlightColor3 = getgenv().NekodexUIColor or Color3.fromRGB(249, 150, 255)

local Window = Material.Load({
	Title = "Nekodex - Prison Life",
	Style = 3,
	SizeX = 500,
	SizeY = 350,
	Theme = "Light",
	ColorOverrides = {
		MainFrame = Color3.fromRGB(235,235,235),
		NavBar = HighlightColor3,
		TitleBar = HighlightColor3,
		Overlay = HighlightColor3,
		BannerAccent = HighlightColor3,
		Content = HighlightColor3,
		Button = HighlightColor3,
		ChipSet = HighlightColor3,
		DataTable = HighlightColor3,
		SliderAccent = HighlightColor3,
		Toggle = HighlightColor3,
		DropdownAccent = HighlightColor3,
		ColorPickerAccent = HighlightColor3,
		TextField = HighlightColor3,
		TextFieldAccent = HighlightColor3,
	}
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character
local LocalHumanoid = LocalCharacter:WaitForChild("Humanoid")
local LocalHRP = LocalCharacter:WaitForChild("HumanoidRootPart")

local Remotes = workspace.Remote:GetChildren()
Remotes.ShootEvent = ReplStorage.ShootEvent
Remotes.ReloadEvent = ReplStorage.ReloadEvent
Remotes.MeleeEvent = ReplStorage.meleeEvent

local PrisonItems = {
    ak47 = workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP,
    rem = workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP,
    m9 = workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP,
}

LocalPlayer.CharacterAdded:Connect(function(Char)
    Character = Char
    LocalHumanoid = LocalCharacter:WaitForChild("Humanoid")
    LocalHRP = LocalCharacter:WaitForChild("HumanoidRootPart")
end)

local function PseudoFuzzySearch(String)
    for i, v in pairs(Players:GetPlayers()) do
        if string.sub(string.lower(v.Name), 1, #String) == string.lower(String) then
            return v
        end
    end
    return nil
end

local function KillPlayer(Player)
    local CurrentGun = LocalPlayer.Backpack:FindFirstChild("Remington 870") or LocalCharacter:FindFirstChild("Remington 870") or nil

    if not CurrentGun then
        print("No gun, getting rem...")
        Remotes.ItemHandler:InvokeServer(PrisonItems.rem)
        CurrentGun = LocalPlayer.Backpack:WaitForChild("Remington 870")
    end

    local TargetChar = Player.Character

    -- Perform delicate brain surgery upon our target (they fell asleep first at the sleepover 😂)
    Remotes.ShootEvent:FireServer(
        {
            {
                ["RayObject"] = Ray.new(Vector3.zero, Vector3.zero),
                ["Distance"] = 0,
                ["CFrame"] = CFrame.new(),
                ["Hit"] = TargetChar.Head
            },
            {
                ["RayObject"] = Ray.new(Vector3.zero, Vector3.zero),
                ["Distance"] = 0,
                ["CFrame"] = CFrame.new(),
                ["Hit"] = TargetChar.Head
            },
            {
                ["RayObject"] = Ray.new(Vector3.zero, Vector3.zero),
                ["Distance"] = 0,
                ["CFrame"] = CFrame.new(),
                ["Hit"] = TargetChar.Head
            },
            {
                ["RayObject"] = Ray.new(Vector3.zero, Vector3.zero),
                ["Distance"] = 0,
                ["CFrame"] = CFrame.new(),
                ["Hit"] = TargetChar.Head
            },
            {
                ["RayObject"] = Ray.new(Vector3.zero, Vector3.zero),
                ["Distance"] = 0,
                ["CFrame"] = CFrame.new(),
                ["Hit"] = TargetChar.Head
            }
        },
    CurrentGun)

    if TargetChar.Humanoid.Health > 0 then
        -- Target is still alive (unacceptable)
        -- Solution: beat them to death
        
        local PrevCFrame = LocalHRP.CFrame
        local Conn
        Conn = RunService.RenderStepped:Connect(function()
            LocalHRP.CFrame = TargetChar.HumanoidRootPart.CFrame
            Remotes.MeleeEvent:FireServer(Player)
        end)

        repeat wait() until TargetChar.Health == 0

        LocalHRP.CFrame = PrevCFrame
    end
end

-------------------- COMBAT TAB -----------------------

local CombatTab = Window.New({
    Title = "Combat"
})

CombatTab.Button({
    Text = "Kill All",
    Callback = function()
        for i, v in pairs(Players:GetPlayers()) do
            task.spawn(KillPlayer(v))
        end
    end
})

--------------------- TARGET TAB ------------------------

local TargetTab = Window.New({
    Title = "Target"
})

local TargetTabPlayer = nil

TargetTab.TextField({
    Text = "Player Name",
    Callback = function(Value)
        TargetTabPlayer = PseudoFuzzySearch(Value)
    end
})

TargetTab.Button({
    Text = "Kill Player",
    Callback = function() KillPlayer(TargetTabPlayer) end
})

TargetTab.Button({
    Text = "Go to Player",
    Callback = function()
        LocalHRP.CFrame = TargetTabPlayer.Character.HumanoidRootPart.CFrame
    end
})