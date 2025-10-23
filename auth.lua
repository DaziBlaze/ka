local License = license or ""
local HttpService = game:GetService("HttpService")

local name = "Keter"
local ownerid = "xCcjVHkQgx"
local version = "1.0"

-- initialize KeyAuth
local initReq = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. name .. '&ownerid=' .. ownerid .. '&type=init&ver=' .. version)
if initReq == "KeyAuth_Invalid" then
    print("⛔ Error: Application not found")
    return
end

local initData = HttpService:JSONDecode(initReq)
if not initData.success then
    print("⛔ Error: Failed to initialize KeyAuth")
    return
end

local sessionid = initData.sessionid

-- check license
local licenseUrl = 'https://keyauth.win/api/1.1/?name=' .. name ..
                   '&ownerid=' .. ownerid ..
                   '&type=license&key=' .. HttpService:UrlEncode(License) ..
                   '&ver=' .. version ..
                   '&sessionid=' .. sessionid

local licenseReq = game:HttpGet(licenseUrl)
local data = HttpService:JSONDecode(licenseReq)

if data.success then
    print("🔑 Successfully whitelisted by Hardbuild")
else
    print("⛔ Error: " .. (data.message or "Authentication failed"))
end
