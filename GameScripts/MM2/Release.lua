local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

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

local KillAllButton = MurdTab.Button({
	Text = "Kill All",
	Callback = function()
		print("kill all real")
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

