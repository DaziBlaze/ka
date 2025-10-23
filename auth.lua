local License = license or ""
local HttpService = game:GetService("HttpService")
local Analytics = game:GetService("RbxAnalyticsService")

local name = "Keter"
local ownerid = "xCcjVHkQgx"
local version = "1.0"

local initReq = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. name .. '&ownerid=' .. ownerid .. '&type=init&ver=' .. version)
if initReq == "KeyAuth_Invalid" then return end
local initData = HttpService:JSONDecode(initReq)
if not initData.success then return end
local sessionid = initData.sessionid

local HWID = Analytics:GetClientId()

local licenseUrl = 'https://keyauth.win/api/1.1/?name=' .. name ..
                   '&ownerid=' .. ownerid ..
                   '&type=license&key=' .. HttpService:UrlEncode(License) ..
                   '&ver=' .. version ..
                   '&sessionid=' .. sessionid

local licenseReq = game:HttpGet(licenseUrl)
local data = HttpService:JSONDecode(licenseReq)
if not data.success then return end

if data.info.username == "" or data.info.username == nil then
    local setHWIDUrl = 'https://keyauth.win/api/1.1/?name=' .. name ..
                       '&ownerid=' .. ownerid ..
                       '&type=setvar&var=username&varval=' .. HttpService:UrlEncode(HWID) ..
                       '&sessionid=' .. sessionid
    game:HttpGet(setHWIDUrl)
end

if data.info.username ~= HWID then return end

print("🔑 Successfully whitelisted by Hardbuild")
