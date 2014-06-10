core:module("CoreMenuData")
core:import("CoreMenuNode")
core:import("CoreSerialize")
Data = Data or class()
function Data:init()
	self._nodes = {}
end

function Data:get_node(node_name, ...)
	local node
	if node_name then
		node = self._nodes[node_name]
		if not node then
			Application:error("Data:get_node(): No node named '" .. node_name .. "'")
			return nil
		end

	else
		node = self._default_node_name and self._nodes[self._default_node_name]
		if not node then
			Application:error("Data:get_node(): No default node")
			return nil
		end

	end

	if node:parameters().modifier then
		local (for generator), (for state), (for control) = ipairs(node:parameters().modifier)
		do
			do break end
			node = modify_func(node, ...)
		end

	end

	return node
end

function Data:load_data(file_path, menu_id)
	local root = PackageManager:script_data(Idstring("menu"), file_path:id())
	local menu
	do
		local (for generator), (for state), (for control) = ipairs(root)
		do
			do break end
			if c._meta == "menu" and c.id and c.id == menu_id then
				menu = c
		end

		else
		end

	end

	if not menu then
		Application:error("Data:load_data(): No menu with id '" .. menu_id .. "' in '" .. file_path .. "'")
		return
	end

	local (for generator), (for state), (for control) = ipairs(menu)
	do
		do break end
		local type = c._meta
		if type == "node" then
			local node_class = CoreMenuNode.MenuNode
			local type = c.type
			if type then
				node_class = CoreSerialize.string_to_classtable(type)
			end

			local name = c.name
			if name then
				self._nodes[name] = node_class:new(c)
			else
				Application:error("Menu node without name in '" .. menu_id .. "' in '" .. file_path .. "'")
			end

		elseif type == "default_node" then
			self._default_node_name = c.name
		end

	end

end

function Data:set_callback_handler(callback_handler)
	local (for generator), (for state), (for control) = pairs(self._nodes)
	do
		do break end
		node:set_callback_handler(callback_handler)
	end

end
