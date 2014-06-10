GroupAIStateZombieApocalypse = GroupAIStateZombieApocalypse or class(GroupAIStateStreet)
function GroupAIStateZombieApocalypse:_init_misc_data()
	GroupAIStateZombieApocalypse.super._init_misc_data(self)
end

function GroupAIStateZombieApocalypse:update(t, dt)
	GroupAIStateBase.update(self, t, dt)
	self:_upd_zombie_activity(t)
end

function GroupAIStateZombieApocalypse:_upd_zombie_activity(t)
end

function GroupAIStateZombieApocalypse:spawn_one_teamAI()
end

function GroupAIStateZombieApocalypse:set_wave_mode(flag)
	if flag == "hunt" then
		local player = managers.player:player_unit()
		if not player then
			return
		end

		local (for generator), (for state), (for control) = pairs(self._police)
		do
			do break end
			local objective = {type = "hunt", tar_unit = player}
			u_data.unit:brain():set_objective(objective)
		end

	end

end

function GroupAIStateZombieApocalypse:assign_enemy_to_group_ai(unit)
end

