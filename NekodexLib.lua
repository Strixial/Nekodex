local NekodexLib = {}

local RunService = game:GetService("RunService")

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

local HTTPService = game:GetService("HttpService")
function NekodexLib.TransformJSON(obj)
    if typeof(obj) == "string" then
        return HTTPService:DecodeJSON(obj)
    else
        return HTTPService:EncodeJSON(obj)
    end
end

return NekodexLib