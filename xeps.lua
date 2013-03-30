local parse_xml = require"util.xml".parse;

local xeps = io.open"xeps.xml":read"*a"

xeps = parse_xml(xeps)

local data = {}
for xep in xeps:childtags() do
	local x = {
		number = xep:get_child_text"number";
		name = xep:get_child_text"name";
		type = xep:get_child_text"type";
		status = xep:get_child_text"status";
		updated = xep:get_child_text"updated";
		shortname = xep:get_child_text"shortname";
		abstract = xep:get_child_text"abstract";
	}
	data["xep"..x.number] = x;
end
return data;

