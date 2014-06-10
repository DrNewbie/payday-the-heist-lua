core:module("CoreAiDataManager")
core:import("CoreTable")
AiDataManager = AiDataManager or class()
function AiDataManager:init()
	self:_setup()
end

function AiDataManager:_setup()
	self._data = {}
	self._data.patrol_paths = {}
end

function AiDataManager:add_patrol_path(name)
	if self._data.patrol_paths[name] then
		Application:error("Patrol path with name " .. name .. " allready exists!")
		return false
	end

	self._data.patrol_paths[name] = {
		points = {}
	}
	return true
end

function AiDataManager:remove_patrol_path(name)
	if not self._data.patrol_paths[name] then
		Application:error("Patrol path with name " .. name .. " doesnt exists!")
		return false
	end

	self._data.patrol_paths[name] = nil
	return true
end

function AiDataManager:add_patrol_point(name, unit)
	if not self._data.patrol_paths[name] then
		Application:error("Patrol path with name " .. name .. " doesn't exist exists!")
		return
	end

	local t = {
		position = unit:position(),
		rotation = unit:rotation(),
		unit = unit,
		unit_id = unit:unit_data().unit_id
	}
	table.insert(self._data.patrol_paths[name].points, t)
end

function AiDataManager:delete_point_by_unit(unit)
	local (for generator), (for state), (for control) = pairs(self._data.patrol_paths)
	do
		do break end
		local (for generator), (for state), (for control) = ipairs(path.points)
		do
			do break end
			if point.unit == unit then
				table.remove(path.points, i)
				return
			end

		end

	end

end

function AiDataManager:patrol_path_by_unit(unit)
	local (for generator), (for state), (for control) = pairs(self._data.patrol_paths)
	do
		do break end
		local (for generator), (for state), (for control) = ipairs(path.points)
		do
			do break end
			if point.unit == unit then
				return name, path
			end

		end

	end

end

function AiDataManager:patrol_point_index_by_unit(unit)
	local (for generator), (for state), (for control) = pairs(self._data.patrol_paths)
	do
		do break end
		local (for generator), (for state), (for control) = ipairs(path.points)
		do
			do break end
			if point.unit == unit then
				return i, point
			end

		end

	end

end

function AiDataManager:patrol_path(name)
	return self._data.patrol_paths[name]
end

function AiDataManager:all_patrol_paths()
	return self._data.patrol_paths
end

function AiDataManager:patrol_path_names()
	local t = {}
	do
		local (for generator), (for state), (for control) = pairs(self._data.patrol_paths)
		do
			do break end
			table.insert(t, name)
		end

	end

	table.sort(t)
	return t
end

function AiDataManager:destination_path(position, rotation)
	return {
		points = {
			{position = position, rotation = rotation}
		}
	}
end

function AiDataManager:clear()
	self:_setup()
end

function AiDataManager:save_data()
	local t = CoreTable.deep_clone(self._data)
	do
		local (for generator), (for state), (for control) = pairs(t.patrol_paths)
		do
			do break end
			local (for generator), (for state), (for control) = ipairs(path.points)
			do
				do break end
				point.position = point.unit:position()
				point.rotation = point.unit:rotation()
				point.unit = nil
			end

		end

	end

	return t
end

function AiDataManager:load_data(data)
	if not data then
		return
	end

	self._data = data
end

function AiDataManager:load_units(units)
	local (for generator), (for state), (for control) = ipairs(units)
	do
		do break end
		local (for generator), (for state), (for control) = pairs(self._data.patrol_paths)
		do
			do break end
			local (for generator), (for state), (for control) = ipairs(path.points)
			do
				do break end
				if point.unit_id == unit:unit_data().unit_id then
					point.unit = unit
				end

			end

		end

	end

end

