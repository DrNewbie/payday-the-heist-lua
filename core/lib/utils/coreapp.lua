core:module("CoreApp")
function arg_supplied(key)
	do
		local (for generator), (for state), (for control) = ipairs(Application:argv())
		do
			do break end
			if arg == key then
				return true
			end

		end

	end

	return false
end

function arg_value(key)
	local found
	local (for generator), (for state), (for control) = ipairs(Application:argv())
	do
		do break end
		if found then
			return arg
		elseif arg == key then
			found = true
		end

	end

end

function min_exe_version(version, system_name)
end

