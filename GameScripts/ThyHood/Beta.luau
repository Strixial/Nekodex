local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local NekodexLib = loadstring(game:HttpGet("https://github.com/Strixial/Nekodex/raw/main/NekodexLib.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local HighlightColor3 = getgenv().NekodexUIColor or Color3.fromRGB(249, 150, 255)

local Window = Material.Load({
	Title = "Nekodex - Thy hood",
	Style = 3,
	SizeX = 200,
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
local Character = LocalPlayer.Character

local Tab = Window.New({
    Title = "Main"
})

