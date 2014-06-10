SpawnManager = SpawnManager or class()
function SpawnManager:init()
	self._spawn_requests = {}
end

function SpawnManager:spawn_enemy_group_in_vis_group(event, i_vis_group)
	local spawn_request = {}
	spawn_request.groups = {}
	do
		local (for generator), (for state), (for control) = pairs(event.groups)
		do
			do break end
			spawn_request.groups[unit_name] = {
				amount = unit_data.amount
			}
		end

	end

	spawn_request.ai = event.ai
	do
		local (for generator), (for state), (for control) = pairs(spawn_request.groups)
		do
			do break end
			local spawn_positions = {}
			local i = 1
			while i <= unit_data.amount do
				local new_pos = managers.navigation:find_random_position_in_visibility_group(i_vis_group)
				table.insert(spawn_positions, new_pos)
				i = i + 1
			end

			unit_data.positions = spawn_positions
		end

	end

	self._spawn_requests = self._spawn_requests or {}
	table.insert(self._spawn_requests, spawn_request)
	return self:_spawn_units()
end

function SpawnManager:spawn_enemy_group(event)
	local spawn_request = {}
	spawn_request.groups = {}
	do
		local (for generator), (for state), (for control) = pairs(event.groups)
		do
			do break end
			spawn_request.groups[unit_name] = {
				amount = unit_data.amount
			}
		end

	end

	spawn_request.ai = event.ai
	local criminals = World:find_units_quick("all", managers.slot:get_mask("players"))
	if #criminals > 0 then
		local hide_from_trackers = {}
		do
			local (for generator), (for state), (for control) = ipairs(criminals)
			do
				do break end
				table.insert(hide_from_trackers, criminal_unit:movement():nav_tracker())
			end

		end

		local vis_group_pos, i_vis_group = managers.navigation:find_hide_position({trackers = hide_from_trackers})
		if i_vis_group then
			local (for generator), (for state), (for control) = pairs(spawn_request.groups)
			do
				do break end
				local spawn_positions = {}
				local i = 1
				while i <= unit_data.amount do
					local new_pos = managers.navigation:find_random_position_in_visibility_group(i_vis_group)
					table.insert(spawn_positions, new_pos)
					i = i + 1
				end

				unit_data.positions = spawn_positions
			end

		else
			print("SpawnManager:spawn_enemy_group() Could not find a hidden position. Cancelling spawn")
			return
		end

	else
		local new_pos, i_vis_group = managers.navigation:find_random_position()
		local (for generator), (for state), (for control) = pairs(spawn_request.groups)
		do
			do break end
			local spawn_positions = {}
			local i = 1
			while i <= unit_data.amount do
				local new_pos = managers.navigation:find_random_position_in_visibility_group(i_vis_group)
				table.insert(spawn_positions, new_pos)
				i = i + 1
			end

			unit_data.positions = spawn_positions
		end

	end

	self._spawn_requests = self._spawn_requests or {}
	table.insert(self._spawn_requests, spawn_request)
	return self:_spawn_units()
end

function SpawnManager:update(unit, t, dt)
end

function SpawnManager:_spawn_units()
	if self._spawn_requests then
		local units_spawned = {}
		local trash_requests
		do
			local (for generator), (for state), (for control) = pairs(self._spawn_requests)
			do
				do break end
				local trash_groups
				do
					local (for generator), (for state), (for control) = pairs(spawn_request.groups)
					do
						do break end
						if unit_data.amount == 1 then
							trash_groups = trash_groups or {}
							trash_groups[unit_name] = true
						else
							unit_data.amount = unit_data.amount - 1
						end

						local new_unit = World:spawn_unit(Idstring(unit_name), unit_data.positions[#unit_data.positions], Rotation(math.UP, math.random() * 360))
						if spawn_request.ai then
							local ai_instance = {}
							do
								local (for generator), (for state), (for control) = pairs(spawn_request.ai)
								do
									do break end
									ai_instance[k] = v
								end

							end

							new_unit:brain():set_spawn_ai(ai_instance)
						end

						table.remove(unit_data.positions)
						table.insert(units_spawned, new_unit)
					end

				end

				if trash_groups then
					local (for generator), (for state), (for control) = pairs(trash_groups)
					do
						do break end
						spawn_request.groups[unit_name] = nil
					end

				end

				if not next(spawn_request.groups) then
					trash_requests = trash_requests or {}
					trash_requests[request_id] = true
				end

			end

		end

		if trash_requests then
			local (for generator), (for state), (for control) = pairs(trash_requests)
			do
				do break end
				self._spawn_requests[request_id] = nil
			end

		end

		if not next(self._spawn_requests) then
			self._spawn_requests = nil
		end

		return units_spawned
	end

end

