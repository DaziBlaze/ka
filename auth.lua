local License = license or ""
local HttpService = game:GetService("HttpService")
local Analytics = game:GetService("RbxAnalyticsService")

local name = "Keter"
local ownerid = "xCcjVHkQgx"
local version = "1.0"

-- initialize KeyAuth
local initReq = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. name .. '&ownerid=' .. ownerid .. '&type=init&ver=' .. version)
if initReq == "KeyAuth_Invalid" then return end
local initData = HttpService:JSONDecode(initReq)
if not initData.success then return end
local sessionid = initData.sessionid

-- get local HWID
local HWID = Analytics:GetClientId()

-- check license
local licenseUrl = 'https://keyauth.win/api/1.1/?name=' .. name ..
                   '&ownerid=' .. ownerid ..
                   '&type=license&key=' .. HttpService:UrlEncode(License) ..
                   '&ver=' .. version ..
                   '&sessionid=' .. sessionid

local licenseReq = game:HttpGet(licenseUrl)
local data = HttpService:JSONDecode(licenseReq)
if not data.success then return end

-- if the license HWID variable is empty, set it
local hwidVar = data.info.var or "" -- var is the KeyAuth variable for custom data
if hwidVar == "" then
    local setHWIDUrl = 'https://keyauth.win/api/1.1/?name=' .. name ..
                       '&ownerid=' .. ownerid ..
                       '&type=setvar&var=hwid&varval=' .. HttpService:UrlEncode(HWID) ..
                       '&sessionid=' .. sessionid
    game:HttpGet(setHWIDUrl)
end

-- re-fetch var if needed
local licenseReq2 = game:HttpGet(licenseUrl)
local data2 = HttpService:JSONDecode(licenseReq2)
if data2.info.var ~= HWID then return end

print("🔑 Successfully whitelisted by Hardbuild")
