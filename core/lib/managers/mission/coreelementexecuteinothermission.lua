core:module("CoreElementExecuteInOtherMission")
core:import("CoreMissionScriptElement")
ElementExecuteInOtherMission = ElementExecuteInOtherMission or class(CoreMissionScriptElement.MissionScriptElement)
function ElementExecuteInOtherMission:init(...)
	ElementExecuteInOtherMission.super.init(self, ...)
end

function ElementExecuteInOtherMission:client_on_executed(...)
	self:on_executed(...)
end

function ElementExecuteInOtherMission:get_mission_element(id)
	local (for generator), (for state), (for control) = pairs(managers.mission:scripts())
	do
		do break end
		if script:element(id) then
			print("found in", name, id)
			return script:element(id)
		end

	end

end

