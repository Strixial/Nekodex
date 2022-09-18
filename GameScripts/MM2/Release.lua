local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local NekodexLib = loadstring(game:HttpGet("https://github.com/Strixial/Nekodex/raw/main/NekodexLib.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local HighlightColor3 = getgenv().NekodexUIColor or Color3.fromRGB(249, 150, 255)

getgenv().RuntimeData = {}
getgenv().RuntimeData.ESPData = {
	Sheriff = false,
	Murd = false,
	Inno = false
}
getgenv().RuntimeData.SheriffHacks = {
	["Anti Team Kill"] = false, -- Prevents you from shooting innocents
	["Racist Cop"] = false, -- Only shoots black people
	["Stealth Gun"] = false, -- Attempts to hide the gun
	["Silent Aim"] = false, -- Hit every time
	["Wallbang"] = false -- Shoot through walls
}

getgenv().RuntimeData.MurdererHacks = {
	["Kill Aura"] = false, -- Kills people around you
	["Silent Aim"] = false, -- Uses silent aim for throwing the knife
	["Silent Stab"] = false, -- Attempts to hide the knife when stabbing
	["Anti Touch"] = false, -- People who touch you will be stabbed
	["Knife Reach"] = false, -- Reach hack with the knife
	["Racist Mode"] = false, -- Only kill black people
	["Sexist Mode"] = false, -- Only kill women
	["Auto Fake Gun"] = false, -- Automatically enabled the fake gun superpower
	["Hide Knife"] = false, -- Tries to hide your knife with a toy
	["Fast Throw"] = false, -- Reduces the animations before you throw your knife
}

local Window = Material.Load({
	Title = "Nekodex - Murder Mystery 2",
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

local MurdTab = Window.New({
	Title = "Murderer"
})

local SheriffTab = Window.New({
	Title = "Sheriff"
})

local InnocentTab = Window.New({
	Title = "Innocents"
})

local RenderTab = Window.New({
	Title = "Render"
})

local ServerTab = Window.New({
	Title = "Server"
})

local PlayersTab = Window.New({
	Title = "Players"
})

local MiscTab = Window.New({
	Title = "Miscellaneous"
})

local LegitTab = Window.New({
	Title = "Legit"
})

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

LocalPlayer.CharacterAdded:Connect(function(char)
	Character = char
end)

local SheriffPlayer, MurdererPlayer

local function GetMurderer()
	for i, v in pairs(Players:GetPlayers()) do
		if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
			return v
		end
	end
end

local function GetSheriff()
	for i, v in pairs(Players:GetPlayers()) do
		if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
			return v
		end
	end
end

local function RefreshPlayers()
	SheriffPlayer = GetSheriff()
	MurdererPlayer = GetMurderer()
end

local function KillPlayerAsMurd(Player, HideKnifeAfter)
	if not Character["Knife"] then
		if not Player.Backpack["Knife"] then
			return 0
		else
			Player.Backpack.Knife.Parent = Character
		end
	end

	Player.Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame + (Character.HumanoidRootPart.CFrame.LookVector * 2)
	Character.Knife.Stab:FireServer("Slash")
	if HideKnifeAfter then
		task.delay(0.2, function()
			if Character["Knife"] then
				Character.Knife.Parent = Player.Backpack
			else
				return 0
			end
		end)
	end

	return 1
end

local function ToggleShaderESP(Player, State, Color)
	if State then
		local Highlight = Instance.new("Highlight")
		Highlight.OutlineColor = Color
		Highlight.FillColor = Color
		Highlight.FillTransparency = 0.75
		Highlight.Name = "nekodex_esp"
		Highlight.Parent = Player.Character
	else
		local Highlight = Player.Character:FindFirstChild("nekodex_esp")
		if not Highlight then return end
		Highlight:Destroy()
	end
end

local KillAllButton = MurdTab.Button({
	Text = "Kill All",
	Callback = function()
		if Character["Knife"] == nil or Player.Backpack["Knife"] == nil then print("Not murderer!") return end
		for i, v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer then
				print("Killing "..v.Name.."...")
				KillPlayerAsMurd(v)
				task.wait(0.1)
			end
		end
	end,
	Menu = {
		Information = function(self)
			Window.Banner({
				Text = "Kills everyone in the server"
			})
		end
	}
})

local MurdChipset = MurdTab.ChipSet({
	Text = "Murderer Options",
	Callback = function(Chipset)
		getgenv().RuntimeData.MurdererHacks = Chipset
	end,
	Options = {
		["Kill Aura"] = false, -- Kills people around you
		["Silent Aim"] = false, -- Uses silent aim for throwing the knife
		["Silent Stab"] = false, -- Attempts to hide the knife when stabbing
		["Anti Touch"] = false, -- People who touch you will be stabbed
		["Knife Reach"] = false, -- Reach hack with the knife
		["Racist Mode"] = false, -- Only kill black people
		["Sexist Mode"] = false, -- Only kill women
		["Auto Fake Gun"] = false, -- Automatically enabled the fake gun superpower
		["Hide Knife"] = false, -- Tries to hide your knife with a toy
		["Fast Throw"] = false, -- Reduces the animations before you throw your knife
	}
})

local SheriffChipset = SheriffTab.ChipSet({
	Text = "Sheriff Options",
	Callback = function(Chipset)
		getgenv().RuntimeData.SheriffHacks = Chipset
	end,
	Options = {
		["Anti Team Kill"] = false, -- Prevents you from shooting innocents
		["Racist Cop"] = false, -- Only shoots black people
		["Stealth Gun"] = false, -- Attempts to hide the gun
		["Silent Aim"] = false, -- Hit every time
		["Wallbang"] = false -- Shoot through walls
	}
})

local InnocentsChipset = InnocentTab.ChipSet({
	Text = "Innocent Options",
	Callback = function() end,
	Options = {
		["Knife Dodge"] = false,
		["Godmode"] = false,
		["Invisible"] = false
	}
})
-- Render tab

local ESPChipset = RenderTab.ChipSet({
	Text = "ESP",
	Callback = function(Chipset)
		for i, v in pairs(Chipset) do
			if i == "Sheriff ESP" then
				getgenv().RuntimeData.ESPData.Sheriff = v
			elseif i == "Murderer ESP" then
				getgenv().RuntimeData.ESPData.Murd = v
			elseif i == "Innocents ESP" then
				getgenv().RunService.ESPData.Inno = v
			end
		end
	end,
	Options = {
		["Sheriff ESP"] = false,
		["Murderer ESP"] = false,
		["Innocents ESP (no worky)"] = false
	}
})

-- Update thread
NekodexLib.RunLoops:BindToRenderStep(function()
	RefreshPlayers()
	ToggleShaderESP(SheriffPlayer, getgenv().RuntimeData.ESPData.Sheriff)
	ToggleShaderESP(MurdererPlayer, getgenv().RuntimeData.ESPData.Murd)
	--ToggleShaderESP(SheriffPlayer, getgenv().RuntimeData.ESPData.Sheriff)

	if getgenv().RuntimeData.MurdererHacks["Kill Aura"] == true then
		local KilledPlayer, Distance = NekodexLib.GetNearestPlayer()

		if Distance < 5 then
			KillPlayerAsMurd(KilledPlayer, getgenv().RuntimeData.MurdererHacks["Silent Stab"])
			KilledPlayer.Character:Destroy() -- i reckon this would help this go smoother
		end
end)

-- Server tab

local ServerChipset = ServerTab.ChipSet({
	Text = "Server",
	Callback = function(Chipset) end,
	Options = {
		["Chat Roles"] = false
	}
})