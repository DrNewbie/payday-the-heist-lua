core:module("CoreCode")
core:import("CoreTable")
core:import("CoreDebug")
core:import("CoreClass")
core:import("CoreApp")
local open_lua_source_file = function(source)
	if DB:is_bundled() then
		return "[N/A in bundle]"
	end

	local entry_type = Idstring("lua_source")
	local entry_name = source:match("([^.]*)"):lower()
	return DB:has(entry_type, entry_name:id()) and DB:open(entry_type, entry_name:id()) or nil
end

function get_prototype(info)
	if info.source == "=[C]" then
		return "(C++ method)"
	end

	local prototype = info.source
	local source_file = open_lua_source_file(info.source)
	if source_file then
		for i = 1, info.linedefined do
			prototype = source_file:gets()
		end

		source_file:close()
	end

	return prototype
end

function get_source(info)
	if info.source == "=[C]" then
		return "(C++ method)"
	end

	local source_file = open_lua_source_file(info.source)
	local lines = {}
	for i = 1, info.linedefined - 1 do
		local line = source_file:gets()
		if line:match("^%s*%-%-") then
			table.insert(lines, line)
		else
			lines = {}
		end

	end

	for i = info.linedefined, info.lastlinedefined do
		table.insert(lines, source_file:gets())
	end

	source_file:close()
	return table.concat(lines, "\n")
end

function traceback(max_level)
	max_level = max_level or 2
	local level = 2
	while true do
		local info = debug.getinfo(level, "Sl")
		if not info or level >= max_level + 2 then
			break
		end

		if info.what == "C" then
			CoreDebug.cat_print("debug", level, "C function")
		else
			CoreDebug.cat_print("debug", string.format("[%s]:%d", info.source, info.currentline))
		end

		level = level + 1
	end

end

function alive(obj)
	if obj and obj:alive() then
		return true
	end

	return false
end

function deprecation_warning(method_name, breaking_release_name)
	CoreDebug.cat_print("debug", string.format("DEPRECATION WARNING: %s will be removed in %s", method_name, breaking_release_name or "a future release"))
end

local sort_iterator = function(t, raw)
	local sorted = {}
	do
		local (for generator), (for state), (for control) = pairs(t)
		do
			do break end
			sorted[#sorted + 1] = k
		end

	end

	table.sort(sorted, function(a, b)
		if type(a) == "number" then
			if type(b) == "number" then
				return a < b
			else
				return true
			end

		elseif type(b) == "number" then
			return false
		end

		return tostring(a) < tostring(b)
	end
)
	local index = 0
	return function()
		index = index + 1
		local k = sorted[index]
		if raw then
			return k, rawget(t, k)
		else
			return k, t[k]
		end

	end

end

function line_representation(x, seen, raw)
	if DB:is_bundled() then
		return "[N/A in bundle]"
	end

	local w = 60
	if type(x) == "userdata" then
		return tostring(x)
	elseif type(x) == "table" then
		seen = seen or {}
		if seen[x] then
			return "..."
		end

		seen[x] = true
		local r = "{"
		do
			local (for generator), (for state), (for control) = sort_iterator(x, raw)
			do
				do break end
				r = r .. line_representation(k, seen, raw) .. "=" .. line_representation(v, seen, raw) .. ", "
				if w < r:len() then
					r = r:sub(1, w)
					r = r .. "..."
			end

			else
			end

		end

		r = r .. "}"
		return r
	elseif type(x) == "string" then
		x = string.gsub(x, "\n", "\\n")
		x = string.gsub(x, "\r", "\\r")
		x = string.gsub(x, "\t", "\\t")
		if w < x:len() then
			x = x:sub(1, w) .. "..."
		end

		return x
	elseif type(x) == "function" then
		local info = debug.getinfo(x)
		if info.source == "=[C]" then
			return "(C++ method)"
		else
			return line_representation(get_prototype(info), nil, raw)
		end

	else
		return tostring(x)
	end

end

function full_representation(x, seen)
	if DB:is_bundled() then
		return "[N/A in bundle]"
	end

	if type(x) == "function" then
		local info = debug.getinfo(x)
		return get_source(info)
	elseif type(x) == "table" then
		return ascii_table(x, true)
	else
		return tostring(x)
	end

end

inspect = full_representation
function properties(x)
	local t = {}
	do
		local (for generator), (for state), (for control) = ipairs(x.__properties)
		do
			do break end
			t[p] = x[p](x)
		end

	end

	CoreDebug.cat_print("debug", ascii_table(t))
end

function help(o)
	local methods = {}
	local function add_methods(t)
		if type(t) == "table" then
			local (for generator), (for state), (for control) = pairs(t)
			do
				do break end
				if type(v) == "function" then
					local info = debug.getinfo(v, "S")
					if info.source ~= "=[C]" then
						local h = get_prototype(info)
						local name = k
						k = nil
						if h:match("= function") then
							k = name
						end

						k = k or h:match(":(.*)")
						k = k or h:match("%.(.*)")
						k = k or h
					end

					k = k .. string.rep(" ", 40 - #k)
					if info.what == "Lua" then
						k = k .. "(" .. info.source .. ":" .. info.linedefined .. ")"
					else
						k = k .. "(C++ function)"
					end

					methods[k] = true
				end

			end

		end

		if getmetatable(t) then
			add_methods(getmetatable(t))
		end

	end

	add_methods(o)
	local sorted_methods = {}
	do
		local (for generator), (for state), (for control) = pairs(methods)
		do
			do break end
			table.insert(sorted_methods, k)
		end

	end

	table.sort(sorted_methods)
	local (for generator), (for state), (for control) = ipairs(sorted_methods)
	do
		do break end
		CoreDebug.cat_print("debug", name)
	end

end

function ascii_table(t, raw)
	local out = ""
	local klen = 20
	local vlen = 20
	do
		local (for generator), (for state), (for control) = pairs(t)
		do
			do break end
			local kl = line_representation(k, nil, raw):len() + 2
			local vl = line_representation(v, nil, raw):len() + 2
			if klen < kl then
				klen = kl
			end

			if vlen < vl then
				vlen = vl
			end

		end

	end

	out = out .. ("-"):rep(klen + vlen + 5) .. "\n"
	do
		local (for generator), (for state), (for control) = sort_iterator(t, raw)
		do
			do break end
			out = out .. "| " .. line_representation(k, nil, raw):left(klen) .. "| " .. line_representation(v, nil, raw):left(vlen) .. "|\n"
		end

	end

	out = out .. ("-"):rep(klen + vlen + 5) .. "\n"
	return out
end

function memory_report(limit)
	local seen = {}
	local count = {}
	local name = {_G = _G}
	do
		local (for generator), (for state), (for control) = pairs(_G)
		do
			do break end
			if type(v) == "userdata" and v.key or type(v) ~= "userdata" then
				name[type(v) == "userdata" and v:key() or v] = k
			end

		end

	end

	local simple = function(item)
		local t = type(item)
		if t == "table" then
			return false
		end

		if t == "userdata" then
			return getmetatable(t)
		end

		return true
	end

	local function recurse(item, parent, key)
		local index = type(item) == "userdata" and item:key() or item
		if seen[index] then
			return
		end

		seen[index] = true
		local t = name[index] or name[getmetatable(item)] or parent .. "/" .. key
		count[t] = (count[t] or 0) + 1
		if type(item) == "table" then
			local (for generator), (for state), (for control) = pairs(item)
			do
				do break end
				count[t .. "/*"] = (count[t .. "/*"] or 0) + 1
				if not simple(v) and not seen[v] then
					recurse(v, t, tostring(k))
				end

			end

		end

		if CoreClass.type_name(item) == "Unit" then
			local (for generator), (for state), (for control) = ipairs(item:extensions())
			do
				do break end
				recurse(item[e](item), t, e)
			end

		end

		if getmetatable(item) and not seen[getmetatable(item)] then
			recurse(getmetatable(item), t, "metatable")
		end

	end

	recurse(_G, nil, nil)
	local units = World:unit_manager():get_units()
	do
		local (for generator), (for state), (for control) = ipairs(units)
		do
			do break end
			recurse(u, "Units", u:name():s(), u)
		end

	end

	local total = 0
	local res = {}
	do
		local (for generator), (for state), (for control) = pairs(count)
		do
			do break end
			total = total + v
			if v > (limit or 100) then
				res[#res + 1] = string.format("%6i  %s", v, k)
			end

		end

	end

	table.sort(res)
	do
		local (for generator), (for state), (for control) = ipairs(res)
		do
			do break end
			CoreDebug.cat_print("debug", l)
		end

	end

	CoreDebug.cat_print("debug", string.format([[

%6i  TOTAL]], total))
end

__old_profiled = __old_profiled or {}
if __profiled then
	__old_profiled = __profiled
	local (for generator), (for state), (for control) = pairs(__profiled)
	do
		do break end
		Application:console_command("profiler remove " .. k)
	end

end

__profiled = {}
function profile(s)
	if __profiled[s] then
		return
	end

	local t = {}
	t.s = s
	local start, stop = s:find(":")
	if start then
		t.class = s:sub(0, start - 1)
		t.name = s:sub(stop + 1)
		if not rawget(_G, t.class) then
			CoreDebug.cat_print("debug", "Could not find class " .. t.class)
			return
		end

		t.f = rawget(_G, t.class)[t.name]
		function t.patch(f)
			_G[t.class][t.name] = f
		end

	else
		t.name = s
		t.f = rawget(_G, t.name)
		function t.patch(f)
			_G[t.name] = f
		end

	end

	if not t.f or type(t.f) ~= "function" then
		CoreDebug.cat_print("debug", "Could not find function " .. s)
		return
	end

	function t.instrumented(...)
		local id = Profiler:start(t.s)
		res = t.f(...)
		Profiler:stop(id)
		return res
	end

	t.patch(t.instrumented)
	__profiled[s] = t
	Application:console_command("profiler add " .. s)
end

function unprofile(s)
	local t = __profiled[s]
	if t then
		t.patch(t.f)
	end

	Application:console_command("profiler remove " .. s)
	__profiled[s] = nil
end

function reprofile()
	do
		local (for generator), (for state), (for control) = pairs(__old_profiled)
		do
			do break end
			profile(k)
		end

	end

	__old_profiled = {}
end

