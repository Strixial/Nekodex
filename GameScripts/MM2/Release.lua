local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local HighlightColor3 = Color3.fromRGB(249, 150, 255)

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

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

LocalPlayer.CharacterAdded:Connect(function(char)
	Character = char
end)

local function GetMurderer()
	for i, v in pairs(Players:GetPlayers()) do
		if v.Backpack.Knife or v.Character.Knife then
			return v
		end
	end
end

local function GetSheriff()
	for i, v in pairs(Players:GetPlayers()) do
		if v.Backpack.Gun or v.Character.Gun then
			return v
		end
	end
end

local function KillPlayerAsMurd(Player)
	if not Character.Knife then
		if not Player.Backpack.Knife then
			return nil
		else
			Player.Backpack.Knife.Parent = Character
		end
	end

	Player.Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame + (Character.HumanoidRootPart.CFrame.LookVector * 2)
	Character.Knife.Stab:FireServer("Slash")
end

local KillAllButton = MurdTab.Button({
	Text = "Kill All",
	Callback = function()
		if not Character.Knife or not Player.Backpack.Knife then print("Not murderer!") return end
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
		for i, v in pairs(Chipset) do
			print("Option: ", i, ", Value: ", v)
		end
	end,
	Options = {
		["Kill Aura"] = false,
		["Silent Aim"] = false,
		["Silent Stab"] = false,
		["Anti Touch"] = false,
		["Auto Stab"] = false,
		["Knife Reach"] = false
	}
})

local SheriffChipset = SheriffTab.ChipSet({
	Text = "Sheriff Options",
	Callback = function(Chipset)
		for i, v in pairs(Chipset) do
			print("Option: ", i, ", Value: ", v)
		end
	end,
	Options = {
		["Aimbot"] = false,
		["Anti Team Kill"] = false,
		["Racist Cop"] = false,
		["Sexist Cop"] = false,
		["Silent Aim"] = false,
		["Wallbang"] = false
	}
})

