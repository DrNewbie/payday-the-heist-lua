_OcclusionManager = _OcclusionManager or class()
function _OcclusionManager:init()
	self._obj_id = Idstring("object3d")
	self._skip_occlusion = {}
end

function _OcclusionManager:is_occluded(unit)
	if self._skip_occlusion[unit:key()] then
		return false
	end

	return unit:occluded()
end

function _OcclusionManager:remove_occlusion(unit)
	if alive(unit) then
		local objects = unit:get_objects_by_type(self._obj_id)
		local (for generator), (for state), (for control) = pairs(objects)
		do
			do break end
			obj:set_skip_occlusion(true)
		end

	end

	self._skip_occlusion[unit:key()] = true
end

function _OcclusionManager:add_occlusion(unit)
	if alive(unit) then
		local objects = unit:get_objects_by_type(self._obj_id)
		local (for generator), (for state), (for control) = pairs(objects)
		do
			do break end
			obj:set_skip_occlusion(false)
		end

	end

	self._skip_occlusion[unit:key()] = nil
end

