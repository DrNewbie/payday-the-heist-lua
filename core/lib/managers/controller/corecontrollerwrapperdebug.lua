core:module("CoreControllerWrapperDebug")
core:import("CoreControllerWrapper")
ControllerWrapperDebug = ControllerWrapperDebug or class(CoreControllerWrapper.ControllerWrapper)
ControllerWrapperDebug.TYPE = "debug"
function ControllerWrapperDebug:init(controller_wrapper_list, manager, id, name, default_controller_wrapper, setup)
	self._controller_wrapper_list = controller_wrapper_list
	self._default_controller_wrapper = default_controller_wrapper
	ControllerWrapperDebug.super.init(self, manager, id, name, {}, default_controller_wrapper and default_controller_wrapper:get_default_controller_id(), setup, true, true)
	local (for generator), (for state), (for control) = ipairs(controller_wrapper_list)
	do
		do break end
		local (for generator), (for state), (for control) = pairs(controller_wrapper:get_controller_map())
		do
			do break end
			self._controller_map[controller_id] = controller
		end

	end

end

function ControllerWrapperDebug:destroy()
	ControllerWrapperDebug.super.destroy(self)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		controller_wrapper:destroy()
	end

end

function ControllerWrapperDebug:update(t, dt)
	ControllerWrapperDebug.super.update(self, t, dt)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		controller_wrapper:update(t, dt)
	end

end

function ControllerWrapperDebug:paused_update(t, dt)
	ControllerWrapperDebug.super.paused_update(self, t, dt)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		controller_wrapper:paused_update(t, dt)
	end

end

function ControllerWrapperDebug:connected(...)
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			if controller_wrapper:connected(...) then
				return true
			end

		end

	end

	return false
end

function ControllerWrapperDebug:rebind_connections(setup, setup_map)
	ControllerWrapperDebug.super.rebind_connections(self)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		controller_wrapper:rebind_connections(setup_map[controller_wrapper:get_type()], setup_map)
	end

end

function ControllerWrapperDebug:setup(...)
end

function ControllerWrapperDebug:get_any_input(...)
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			if controller_wrapper:get_any_input(...) then
				return true
			end

		end

	end

	return false
end

function ControllerWrapperDebug:get_any_input_pressed(...)
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			if controller_wrapper:get_any_input_pressed(...) then
				return true
			end

		end

	end

	return false
end

function ControllerWrapperDebug:get_input_pressed(...)
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			if controller_wrapper:connection_exist(...) and controller_wrapper:get_input_pressed(...) then
				return true
			end

		end

	end

	return false
end

function ControllerWrapperDebug:get_input_bool(...)
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			if controller_wrapper:connection_exist(...) and controller_wrapper:get_input_bool(...) then
				return true
			end

		end

	end

	return false
end

function ControllerWrapperDebug:get_input_float(...)
	local input_float = 0
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			if controller_wrapper:connection_exist(...) then
				input_float = math.max(input_float, controller_wrapper:get_input_float(...))
			end

		end

	end

	return input_float
end

function ControllerWrapperDebug:get_input_axis(...)
	local input_axis = Vector3(0, 0, 0)
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			if controller_wrapper:connection_exist(...) then
				local next_input_axis = controller_wrapper:get_input_axis(...)
				if next_input_axis:length() > input_axis:length() then
					input_axis = next_input_axis
				end

			end

		end

	end

	return input_axis
end

function ControllerWrapperDebug:get_connection_map(...)
	local map = {}
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			local sub_map = controller_wrapper:get_connection_map(...)
			local (for generator), (for state), (for control) = pairs(sub_map)
			do
				do break end
				map[k] = v
			end

		end

	end

	return map
end

function ControllerWrapperDebug:connection_exist(...)
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			if controller_wrapper:connection_exist(...) then
				return true
			end

		end

	end

	return false
end

function ControllerWrapperDebug:set_enabled(...)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		controller_wrapper:set_enabled(...)
	end

end

function ControllerWrapperDebug:enable(...)
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			controller_wrapper:enable(...)
		end

	end

	self._enabled = true
end

function ControllerWrapperDebug:disable(...)
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			controller_wrapper:disable(...)
		end

	end

	self._enabled = false
end

function ControllerWrapperDebug:add_trigger(...)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		if controller_wrapper:connection_exist(...) then
			controller_wrapper:add_trigger(...)
		end

	end

end

function ControllerWrapperDebug:add_release_trigger(...)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		if controller_wrapper:connection_exist(...) then
			controller_wrapper:add_release_trigger(...)
		end

	end

end

function ControllerWrapperDebug:remove_trigger(...)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		if controller_wrapper:connection_exist(...) then
			controller_wrapper:remove_trigger(...)
		end

	end

end

function ControllerWrapperDebug:clear_triggers(...)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		controller_wrapper:clear_triggers(...)
	end

end

function ControllerWrapperDebug:reset_cache(...)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		controller_wrapper:reset_cache(...)
	end

end

function ControllerWrapperDebug:restore_triggers(...)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		controller_wrapper:restore_triggers(...)
	end

end

function ControllerWrapperDebug:clear_connections(...)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		controller_wrapper:clear_connections(...)
	end

end

function ControllerWrapperDebug:get_setup(...)
	return self._default_controller_wrapper and self._default_controller_wrapper:get_setup(...)
end

function ControllerWrapperDebug:get_connection_settings(...)
	return self._default_controller_wrapper and self._default_controller_wrapper:get_connection_settings(...)
end

function ControllerWrapperDebug:get_connection_enabled(...)
	do
		local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
		do
			do break end
			if controller_wrapper:get_connection_enabled(...) then
				return true
			end

		end

	end

	return false
end

function ControllerWrapperDebug:set_connection_enabled(...)
	local (for generator), (for state), (for control) = ipairs(self._controller_wrapper_list)
	do
		do break end
		controller_wrapper:set_connection_enabled(...)
	end

end

