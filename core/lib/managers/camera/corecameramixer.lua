core:module("CoreCameraMixer")
core:import("CoreClass")
local mvector3_add = mvector3.add
local mvector3_sub = mvector3.subtract
local mvector3_mul = mvector3.multiply
local mvector3_set = mvector3.set
local mvector3_copy = mvector3.copy
local mrotation_mul = mrotation.multiply
local mrotation_slerp = mrotation.slerp
local mrotation_set_zero = mrotation.set_zero
local safe_divide = function(a, b)
	if b == 0 then
		return 1
	end

	return a / b
end

CameraMixer = CameraMixer or CoreClass.class()
function CameraMixer:init(name)
	self._name = name
	self._cameras = {}
end

function CameraMixer:destroy()
	do
		local (for generator), (for state), (for control) = ipairs(self._cameras)
		do
			do break end
			camera.camera:destroy()
		end

	end

	self._cameras = {}
end

function CameraMixer:add_camera(camera, blend_time)
	table.insert(self._cameras, {
		camera = camera,
		blend_time = blend_time,
		time = 0,
		cam_data = nil
	})
end

function CameraMixer:stop()
	do
		local (for generator), (for state), (for control) = ipairs(self._cameras)
		do
			do break end
			camera.camera:destroy()
		end

	end

	self._cameras = {}
end

function CameraMixer:update(cud, cud_class, time, dt)
	do
		local (for generator), (for state), (for control) = ipairs(self._cameras)
		do
			do break end
			local _camera = camera.camera
			local cam_data = cud_class:new(cud)
			do
				local (for generator), (for state), (for control) = ipairs(_camera._nodes)
				do
					do break end
					local local_cam_data = cud_class:new()
					cam:update(time, dt, cam_data, local_cam_data)
					cam_data:transform_with(local_cam_data)
					mvector3_set(cam._position, cam_data._position)
					mrotation_set_zero(cam._rotation)
					mrotation_mul(cam._rotation, cam_data._rotation)
				end

			end

			camera.cam_data = cam_data
		end

	end

	local full_blend_index = 1
	do
		local (for generator), (for state), (for control) = ipairs(self._cameras)
		do
			do break end
			_camera.time = _camera.time + dt
			local factor
			if index > 1 then
				factor = math.sin(math.clamp(safe_divide(_camera.time, _camera.blend_time), 0, 1) * 90)
			else
				factor = 1
			end

			cud:interpolate_to_target(_camera.cam_data, factor)
			if factor >= 1 then
				full_blend_index = index
			end

		end

	end

	for i = 1, full_blend_index - 1 do
		self._cameras[1].camera:destroy()
		table.remove(self._cameras, 1)
	end

	local (for generator), (for state), (for control) = ipairs(self._cameras)
	do
		do break end
		assert(not camera.camera._destroyed)
	end

end

function CameraMixer:debug_render(t, dt)
	local pen = Draw:pen(Color(0.05, 0, 0, 1))
	local (for generator), (for state), (for control) = ipairs(self._cameras)
	do
		do break end
		local cam = camera.camera
		local parent_node
		local (for generator), (for state), (for control) = ipairs(cam._nodes)
		do
			do break end
			node:debug_render(t, dt)
			if parent_node then
				pen:line(parent_node._position, node._position)
			end

			parent_node = node
		end

	end

end

function CameraMixer:active_camera()
	local camera_count = #self._cameras
	if camera_count == 0 then
		return nil
	end

	return self._cameras[camera_count].camera
end

function CameraMixer:cameras()
	local cameras = {}
	do
		local (for generator), (for state), (for control) = ipairs(self._cameras)
		do
			do break end
			table.insert(cameras, camera.camera)
		end

	end

	return cameras
end

