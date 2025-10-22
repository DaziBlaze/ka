local License = license or ""

local HttpService = game:GetService("HttpService")

local name = "Keter"
local ownerid = "xCcjVHkQgx"
local version = "1.0"

-- initialize application
local initReq = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. name .. '&ownerid=' .. ownerid .. '&type=init&ver=' .. version)
if initReq == "KeyAuth_Invalid" then return end

local initData = HttpService:JSONDecode(initReq)
if not initData.success then return end

local sessionid = initData.sessionid
local userId = game.Players.LocalPlayer.UserId

-- license check (you could add your own IP/HWID logic server-side here)
local licenseReq = game:HttpGet(
    'https://keyauth.win/api/1.1/?name=' .. name ..
    '&ownerid=' .. ownerid ..
    '&type=license&key=' .. License ..
    '&ver=' .. version ..
    '&sessionid=' .. sessionid ..
    '&userdata=' .. tostring(userId)
)
local licenseData = HttpService:JSONDecode(licenseReq)

if not licenseData.success then return end

print("🔑 Successfully whitelisted by Hardbuild")
