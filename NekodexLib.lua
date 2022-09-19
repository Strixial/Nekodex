local NekodexLib = {}

local RunService = game:GetService("RunService")
local HTTPService = game:GetService("HttpService")
local Players = game:GetService("Players")

NekodexLib.RunLoops = {RenderStepped = {}, Stepped = {}, Heartbeat = {}}
local RunLoops = NekodexLib.RunLoops

do
	function RunLoops:BindToRenderStep(Name, Func)
		if RunLoops.RenderStepped[Name] == nil then
			RunLoops.RenderStepped[Name] = RunService.RenderStepped:Connect(Func);
		end
	end

	function RunLoops:UnbindFromRenderStep(Name)
		if RunLoops.RenderStepped[Name] ~= nil then
			RunLoops.RenderStepped[Name]:Disconnect(); 
			RunLoops.RenderStepped[Name] = nil 
		end
	end

	function RunLoops:BindToStepped(Name, Func)
		if RunLoops.Stepped[Name] == nil then
			RunLoops.Stepped[Name] = RunService.Stepped:Connect(Func);
		end
	end

	function RunLoops:UnbindFromStepped(Name)
		if RunLoops.Stepped[Name] ~= nil then
			RunLoops.Stepped[Name]:Disconnect(); 
			RunLoops.Stepped[Name] = nil 
		end
	end

	function RunLoops:BindToHeartbeat(Name, Func)
		if RunLoops.Heartbeat[Name] == nil then
			RunLoops.Heartbeat[Name] = RunService.Heartbeat:Connect(Func);
		end
	end

	function RunLoops:UnbindFromHeartbeat(Name)
		if RunLoops.Heartbeat[Name] ~= nil then
			RunLoops.Heartbeat[Name]:Disconnect(); 
			RunLoops.Heartbeat[Name] = nil 
		end
	end
end

function NekodexLib.TransformJSON(obj)
    if typeof(obj) == "string" then
        return HTTPService:JSONDecode(obj)
    else
        return HTTPService:JSONEncode(obj)
    end
end

function NekodexLib.HttpGet(url)
	local request = syn.request or request

	return request({Url = url})
end

function NekodexLib.GetNearestPlayer(Position)
	local NearestPlayer, NearestDistance = nil, math.huge

	for i, v in pairs(Players:GetPlayers()) do
		if math.abs((Position - v.Character.HumanoidRootPart.Position).Magnitude) < NearestDistance then
			NearestPlayer = v
			NearestDistance = math.abs((Position - v.Character.HumanoidRootPart.Position).Magnitude)
		end
	end

	return NearestPlayer, NearestDistance
end

return NekodexLib