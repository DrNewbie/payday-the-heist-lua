core:module("CoreSessionDebug")
SessionDebug = SessionDebug or class()
function SessionDebug:init(session_state)
	self._session_state = session_state
	self:_parse_standard_arguments()
end

function SessionDebug:_parse_standard_arguments()
	local level
	local args = Application:argv()
	local (for generator), (for state), (for control) = ipairs(args)
	do
		do break end
		if arg == "-level" then
			level = true
		else
			if level then
				level_name = arg
				local session_info = self._session_state:session_info()
				session_info:set_level_name(level_name)
				self._session_state:player_slots():primary_slot():request_debug_local_user_binding()
				self._session_state:join_standard_session()
		end

	end

	else
	end

end

