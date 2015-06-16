-- compliance suites
if type == "server" then
xep0073 = rfc3920 and rfc3921 and xep0030 and xep0115 and "required level" or false
xep0073 = xep0073 and xep0077 and xep0078 and xep0086 and "recommended level" or xep0073 or false
xep0212 = rfc6120 and rfc6121 and xep0030 and "required level" or false
xep0212 = xep0212 and xep0078 and xep0086 and xep0138 and "recommended level" or xep0212 or false
xep0216 = xep0212 and xep0016 and xep0045 and xep0054 and "required level" or false
xep0216 = xep0216 and xep0163 and "recommended level" or xep0216 or false
xep0243 = rfc3920 and rfc3921 and xep0030 and "Core Server" or false
xep0243 = xep0243 and xep0016 and xep0045 and xep0054 and xep0124 and xep0206 and xep0163 and "Advanced Server" or xep0243 or false
xep0270 = rfc3920 and rfc3921 and xep0030 and xep0114 and "Core Server" or false
xep0270 = xep0270 and xep0016 and xep0191 and xep0124 and xep0206 and xep0054 and xep0163 and xep0045 and "Advanced Server" or xep0270 or false
xep0302 = rfc6120 and rfc6121 and rfc6122 and xep0030 and xep0114 and "Core Server" or false
xep0302 = xep0302 and xep0045 and xep0054 and xep0115 and xep0124 and xep0163 and xep0191 and xep0198 and xep0206 and "Advanced Server" or xep0302 or false
elseif type == "client" then
xep0073 = rfc3920 and rfc3921 and xep0030 and xep0115 and "required level" or false
xep0073 = xep0073 and xep0077 and xep0086 and "recommended level" or xep0073 or false
xep0117 = xep0073 and xep0045 and xep0071 and xep0096 and xep0115 and "required level" or false
xep0211 = rfc6120 and rfc6121 and xep0030 and "required level" or false
xep0211 = xep0211 and xep0106 and xep0115 and xep0138 and "recommended level" or xep0211 or false
xep0213 = xep0211 and xep0045 and xep0085 and "required level" or false
xep0213 = xep0213 and xep0016 and xep0054 and xep0155 and "recommended level" or xep0213 or false
xep0270 = rfc3920 and rfc3921 and xep0030 and xep0115 and "Core Client" or false
xep0270 = xep0270 and xep0054 and xep0163 and xep0045 and xep0085 and "Advanced Client" or xep0270 or false
xep0302 = rfc6120 and rfc6121 and rfc6122 and xep0030 and xep0115 and "Core Client" or false
xep0302 = xep0302 and xep0045 and xep0054 and xep0085 and xep0184 and xep0163 and xep0198 and "Advanced Client" or xep0302 or false
end
