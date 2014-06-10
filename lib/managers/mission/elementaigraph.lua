core:import("CoreMissionScriptElement")
ElementAIGraph = ElementAIGraph or class(CoreMissionScriptElement.MissionScriptElement)
function ElementAIGraph:init(...)
	ElementAIGraph.super.init(self, ...)
end

function ElementAIGraph:on_script_activated()
end

function ElementAIGraph:client_on_executed(...)
	self:on_executed(...)
end

function ElementAIGraph:on_executed(instigator)
	if not self._values.enabled then
		return
	end

	do
		local (for generator), (for state), (for control) = ipairs(self._values.graph_ids)
		do
			do break end
			managers.navigation:set_nav_segment_state(id, self._values.operation)
		end

	end

	ElementAIGraph.super.on_executed(self, instigator)
end

