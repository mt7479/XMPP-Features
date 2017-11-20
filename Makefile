LUA ?= lua

all: xmpp-features.html xmpp-clients.html

xmpp-features.html: xmpp-features.lua xeplist.xml util servers/*.lua
	$(LUA) xmpp-features.lua > $@

xmpp-clients.html: xmpp-features.lua xeplist.xml util clients/*.lua
	$(LUA) xmpp-features.lua clients > $@

util: util/stanza.lua util/xml.lua util/envload.lua

util/%:
	@mkdir -p util
	curl -s -o $@ https://hg.prosody.im/0.9/raw-file/b1c84d220c40/$@

xeplist.xml:
	curl -s -L -o $@ https://xmpp.org/extensions/xeplist.xml
