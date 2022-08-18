local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local HighlightColor3 = getgenv().NekodexUIColor or Color3.fromRGB(249, 150, 255)

local Window = Material.Load({
	Title = "Astolfoware - Murder Mystery 2",
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

local Tab = Window.New({
    Title = "Main"
})

local KillSheriffAsMurd = Tab.Button({
    Text = "Kill Sheriff",
    Callback = function()
        local Player

        for i, v in pairs(game.Players:GetPlayers()) do
            if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
                Player = v
            end
        end
        
        Player.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 2)
        
        game:GetService("Players").LocalPlayer.Character.Knife.Stab:FireServer("Slash")
    end
})

local KillAllAsSheriff = Tab.Button({
    Text = "Win Game as Murderer",
    Callback = function()
        for i, Player in pairs(game.Players:GetPlayers) do
            Player.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 2)
        
            game:GetService("Players").LocalPlayer.Character.Knife.Stab:FireServer("Slash")
            task.wait(0.1)
        end
    end
})

local KillAsSher = Tab.Button({
    Text = "Win Game as Sheriff",
    Callback = function()
        local Player

        for i, v in pairs(game.Players:GetPlayers()) do
            if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                Player = v
            end
        end
        
        local oldCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame + (Player.Character.HumanoidRootPart.CFrame.LookVector * -5)
        
        task.wait(0.1)
        
        local args = {
            [1] = 1,
            [2] = Player.Character.Head.Position,
            [3] = "AH"
        }
        
        game:GetService("Players").LocalPlayer.Character.Gun.KnifeServer.ShootGun:InvokeServer(unpack(args))
    
        task.wait(0.1)
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
    end
})