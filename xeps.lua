local parse_xml = require"util.xml".parse;

local xeps = io.open"xeplist.xml":read"*a"

xeps = parse_xml(xeps)

local data = {}
for xep in xeps:childtags() do
	local x = {
		number = tonumber(xep:get_child_text"number");
		name = xep:get_child_text"title";
		type = xep:get_child_text"type";
		status = xep:get_child_text"status";
		updated = xep:get_child_text"updated";
		shortname = xep:get_child_text"shortname";
		abstract = xep:get_child_text"abstract";
	}
	if xep.attr.accepted == "true" then
		data[("xep%04d"):format(x.number)] = x;
	end
end
return data;

