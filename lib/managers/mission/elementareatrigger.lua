core:import("CoreElementArea")
core:import("CoreClass")
ElementAreaTrigger = ElementAreaTrigger or class(CoreElementArea.ElementAreaTrigger)
function ElementAreaTrigger:init(...)
	ElementAreaTrigger.super.init(self, ...)
end

function ElementAreaTrigger:project_instigators()
	local instigators = {}
	if Network:is_client() then
		if self._values.instigator == "player" then
			table.insert(instigators, managers.player:player_unit())
		end

		return instigators
	end

	if self._values.instigator == "player" then
		table.insert(instigators, managers.player:player_unit())
	elseif self._values.instigator == "enemies" then
		if managers.groupai:state():police_hostage_count() <= 0 then
			local (for generator), (for state), (for control) = pairs(managers.enemy:all_enemies())
			do
				do break end
				table.insert(instigators, data.unit)
			end

		else
			local (for generator), (for state), (for control) = pairs(managers.enemy:all_enemies())
			do
				do break end
				if not data.unit:anim_data().surrender then
					table.insert(instigators, data.unit)
				end

			end

		end

	elseif self._values.instigator == "civilians" then
		local (for generator), (for state), (for control) = pairs(managers.enemy:all_civilians())
		do
			do break end
			table.insert(instigators, data.unit)
		end

	elseif self._values.instigator == "escorts" then
		local (for generator), (for state), (for control) = pairs(managers.enemy:all_civilians())
		do
			do break end
			if tweak_data.character[data.unit:base()._tweak_table].is_escort then
				table.insert(instigators, data.unit)
			end

		end

	elseif self._values.instigator == "criminals" then
		local (for generator), (for state), (for control) = pairs(managers.groupai:state():all_char_criminals())
		do
			do break end
			table.insert(instigators, data.unit)
		end

	end

	return instigators
end

function ElementAreaTrigger:project_amount_all()
	if self._values.instigator == "criminals" then
		local i = 0
		do
			local (for generator), (for state), (for control) = pairs(managers.groupai:state():all_char_criminals())
			do
				do break end
				i = i + 1
			end

		end

		return i
	end

	return managers.network:game():amount_of_alive_players()
end

CoreClass.override_class(CoreElementArea.ElementAreaTrigger, ElementAreaTrigger)
