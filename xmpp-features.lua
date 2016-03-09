
local lfs = require"lfs";
local st = require"util.stanza";
-- local template = require"util.template";
local envloadfile = require"util.envload".envloadfile;

local xeps = require"xeps";

local other = {
	ipv6 = "IPv6 support";
	admin_web = "Web admin interface";
	admin_telnet = "Telnet admin interface";
	rfc3920 = "RFC3920: XMPP Core (old)";
	rfc3921 = "RFC3921: XMPP IM (old)";
	rfc6120 = "RFC6120: XMPP Core";
	rfc6121 = "RFC6121: XMPP IM";
	rfc6122 = "RFC6122: XMPP Address Format";
	-- rfc6125 = "RFC6125: Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)";
	rfc6125 = "RFC6125: Verification of Domain-Based Identity within PKIX Certificates in TLS";
	rfc6455 = "RFC6455: The WebSocket Protocol";
}

local dir = ... or "servers"

local xeptable = st.stanza"table";
xeptable:tag"thead":tag"tr"
xeptable:tag"th":text"XEP":up()

local used_keys = { name = true, type = true, website = true }; -- Keys already here are ignored
local servers = {};
for file in lfs.dir(dir)do
	if file:match"%.lua" then
		local env = setmetatable({}, {__newindex=function(t,k,v) if not used_keys[k] then used_keys[#used_keys+1]=k used_keys[k]=true end;rawset(t,k,v); end});
		pcall(envloadfile(dir.."/"..file, env));
		pcall(envloadfile("compliance.lua", env));
		setmetatable(env, nil);
		local name = file:match"(.*)%.lua$";
		xeptable:tag"th":tag("a", { href=(env.website or "#") })
			:text(env.name or name:gsub("^.", string.upper)):up():up();
		servers[name] = env;
		servers[#servers+1]=name;
	end
end
xeptable:up():up();
xeptable:tag"tbody";

table.sort(used_keys);

for i=1,#used_keys do
	local xepname = used_keys[i];
	local xep = xeps[xepname];
	if xep then
	xeptable:tag("tr", { id = xepname;
			class=table.concat({xep.type:gsub("%s",""), xep.status}, " ") })
		:tag"th":tag("a", { title = table.concat({xep.type, xep.status, xep.updated}, ", ");
				href=xep.href or ("http://xmpp.org/extensions/xep-%s.html"):format(xep.number) })
			:text("XEP-"..xep.number..": "..xep.name):up():up();
	else
		xeptable:tag("tr", { id = xepname; }):tag("th"):text(other[xepname] or xepname):up();
	end
	for i=1,#servers do
		local server = servers[servers[i]];
		local xepstatus = server[xepname]
		xeptable:tag("td", { class = xepstatus == nil and "na" or xepstatus and "yes" or "no" })
		if xepstatus == nil then
			xeptable:text("n/a");
		else
			xeptable:tag"strong":text(xepstatus and "Yes" or "No"):up();
			if type(xepstatus) == "string" then
				xeptable:text(", "..xepstatus);
			end
		end
		xeptable:up();
	end
	xeptable:up();
end

print(([[
<!DOCTYPE html>
<html lang="en">
<head>
<title>PIFT</title>
<meta charset="utf-8">
<style>
body {
  font-family: sans-serif; }
#legend {
  margin-bottom: 2em; }
  #legend span span {
    border: 1px dotted silver;
    font-size: smaller; }

.Experimental span, .Experimental th {
  background-color: #88f; }

.Proposed span, .Proposed th {
  background-color: #7af; }

.Deferred span, .Deferred th {
  background-color: #ccc; }

.Deprecated span, .Deprecated th {
  background-color: #f88; }

.Obsolete span, .Obsolete th {
  background-color: #e66; }

.Rejected span, .Rejected th {
  background-color: #faa; }

.Retracted span, .Retracted th {
  background-color: #fbb; }

.Deprecated strong, .Obsolete strong, .Rejected strong, .Retracted strong, .Humorous strong, .Historical strong {
  font-weight: normal; }

.Draft span, .Draft th {
  background-color: #ae4; }

.Final span, .Final th {
  background-color: #8f8; }

.Active span, .Active th {
  background-color: #8f8; }

.Humorous span, .Humorous th {
  font-weight: normal;
  font-family: "Comic Sans MS"; }

.Historical span, .Historical th {
  font-weight: normal; }

.yes { background-color: #cfc; }
.no { background-color: #fcc; }
.na { background-color: #ffa; color: #666; }

</style>
</head>
<body>
<h1>Probably inaccurate feature comparison table</h1>
<div id='legend'>
  <span class='Experimental'>
    <span>Experimental</span>
  </span>
  <span class='Proposed'>
    <span>Proposed</span>
  </span>
  <span class='Deferred'>
    <span>Deferred</span>
  </span>
  <span class='Deprecated'>
    <span>Deprecated</span>
  </span>
  <span class='Obsolete'>
    <span>Obsolete</span>
  </span>
  <span class='Rejected'>
    <span>Rejected</span>
  </span>
  <span class='Retracted'>
    <span>Retracted</span>
  </span>
  <span class='Draft'>
    <span>Draft</span>
  </span>
  <span class='Final'>
    <span>Final</span>
  </span>
  <span class='Active'>
    <span>Active</span>
  </span>
</div>

<p id='intro'> See something inaccurate?  <a href='https://github.com/Zash/XMPP-Features'>File an issue or send a patch</a>.  </p>

%s

</body>
</html>
]]):format(tostring(xeptable)));
