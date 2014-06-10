core:module("CoreNewsReportManager")
core:import("CoreClass")
core:import("CoreString")
core:import("CoreDebug")
NewsReportManager = NewsReportManager or CoreClass.class()
NewsReportManager.NEWS_FILE = "settings/news"
NewsReportManager.OLD_NEWS_FILE = "settings/old_news"
NewsReportManager.KEYWORDS = {
	SP = " ",
	TB = "\t",
	NL = "\n",
	GRIN_URL = "http://www.grin.se",
	GANON_URL = "http://ganonbackup",
	WIKI_URL = "http://ganonbackup/wiki_artistwiki/index.php/Main_Page",
	CT_WIKI_URL = "http://ganonbackup/wiki_artistwiki/index.php/Core_Team",
	GRIN = [[

  _|_|_|  _|_|_|    _|_|_|  _|      _|
_|        _|    _|    _|    _|_|    _|
_|  _|_|  _|_|_|      _|    _|  _|  _|
_|    _|  _|    _|    _|    _|    _|_|
  _|_|_|  _|    _|  _|_|_|  _|      _|
]],
	ENV = {
		os.getenv,
		true
	}
}
function NewsReportManager:init()
	self._news_dates = {}
	local news_file = self.NEWS_FILE .. ".xml"
	local old_news_file = self.OLD_NEWS_FILE .. ".xml"
	if SystemFS:exists(news_file) then
		if not SystemFS:exists(old_news_file) then
			local old_news = assert(SystemFS:open(old_news_file, "w"))
			old_news:write("<old_news/>")
			old_news:close()
		else
			local old_news_root = assert(DB:load_node("xml", self.OLD_NEWS_FILE))
			local (for generator), (for state), (for control) = old_news_root:children()
			do
				do break end
				self._news_dates[cat:name()] = cat:parameter("date")
			end

		end

	else
		CoreDebug.cat_print("spam", "[CoreNewsReportManager] Can't find: " .. news_file)
	end

end

function NewsReportManager:replace(str)
	local replace_str = function(s)
		local value = NewsReportManager.KEYWORDS[s]
		return tostring(type(value) == "table" and value[1]() or value or s)
	end

	do
		local (for generator), (for state), (for control) = pairs(NewsReportManager.KEYWORDS)
		do
			do break end
			if type(v) == "table" and v[2] then
				str = string.gsub(str, "%$" .. k .. "%s([%w_]+)", v[1])
			end

		end

	end

	str = string.gsub(str, "%$([%w_]+)", replace_str)
	return str
end

function NewsReportManager:format_news(news, format, ...)
	if format == "TEXT" then
		local output
		do
			local (for generator), (for state), (for control) = ipairs(news)
			do
				do break end
				output = output and string.format([[
%s
Date: %s%s]], output, v.date, v.text) or string.format("Date: %s%s", v.date, v.text)
				output = self:replace(output)
			end

		end

		return output
	else
		local start = 0
		if #news > 20 then
			start = math.abs(20 - #news)
		end

		local output = {}
		do
			local (for generator), (for state), (for control) = ipairs(news)
			do
				do break end
				if i > start then
					local str = string.format("Date: %s%s", v.date, v.text)
					table.insert(output, self:replace(str))
				end

			end

		end

		return #output > 0 and output
	end

end

function NewsReportManager:write_new_date()
	local old_news = assert(SystemFS:open(self.OLD_NEWS_FILE .. ".xml", "w"))
	old_news:write("<old_news>\n")
	do
		local (for generator), (for state), (for control) = pairs(self._news_dates)
		do
			do break end
			old_news:printf("\t<%s date=\"%s\"/>\n", k, v)
		end

	end

	old_news:write("</old_news>")
	old_news:close()
end

function NewsReportManager:check_min_date(min_date, date)
	local d0 = {}
	local d1 = {}
	do
		local (for generator), (for state), (for control) = string.gmatch(min_date, "%d+")
		do
			do break end
			table.insert(d0, tonumber(n))
		end

	end

	do
		local (for generator), (for state), (for control) = string.gmatch(date, "%d+")
		do
			do break end
			table.insert(d1, tonumber(n))
		end

	end

	assert(#d0 == #d1, "Bad date format!")
	do
		local (for generator), (for state), (for control) = ipairs(d0)
		do
			do break end
			if n > d1[i] then
				break
			elseif n < d1[i] then
				return true
			end

		end

	end

	return false
end

function NewsReportManager:check_news(category, include_old_news, format, ...)
	local news = {}
	local news_updated = false
	local news_root = DB:has("xml", self.NEWS_FILE) and DB:load_node("xml", self.NEWS_FILE)
	if news_root then
		local (for generator), (for state), (for control) = news_root:children()
		do
			do break end
			local cat_name = cat:name()
			if cat_name == category then
				local i = 1
				local (for generator), (for state), (for control) = cat:children()
				do
					do break end
					local msg_date = msg:parameter("date")
					local old_date = self._news_dates[cat_name]
					if not old_date or include_old_news or self:check_min_date(old_date, msg_date) then
						self._news_dates[cat_name] = msg_date
						news[i] = {
							date = msg_date,
							text = msg:data()
						}
						date_updated = true
						i = i + 1
					end

				end

			end

		end

	end

	if date_updated then
		self:write_new_date()
	end

	return self:format_news(news, format, ...)
end

function NewsReportManager:get_news(category)
	return self:check_news(category)
end

function NewsReportManager:get_old_news(category)
	return self:check_news(category, true)
end

