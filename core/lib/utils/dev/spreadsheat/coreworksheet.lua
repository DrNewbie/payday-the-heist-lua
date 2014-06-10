core:module("CoreWorksheet")
core:import("CoreClass")
local EMPTY_WORKSHEET_XML1 = [[
 <Worksheet ss:Name="%s">
  <Table> ]]
local EMPTY_WORKSHEET_XML2 = [[

  </Table>
 </Worksheet> ]]
Worksheet = Worksheet or CoreClass.class()
function Worksheet:init(name)
	self._name = name
	self._rows = {}
end

function Worksheet:add_row(row)
	table.insert(self._rows, row)
end

function Worksheet:to_xml(f)
	f:write(string.format(EMPTY_WORKSHEET_XML1, self._name))
	do
		local (for generator), (for state), (for control) = ipairs(self._rows)
		do
			do break end
			f:write("\n")
			r:to_xml(f)
		end

	end

	f:write(EMPTY_WORKSHEET_XML2)
end

