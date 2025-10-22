local License = license or ""

local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local LuaName = "KeyAuth Lua Example"

StarterGui:SetCore("SendNotification", {
	Title = LuaName,
	Text = "Initializing Authentication...",
	Duration = 5
})

local initialized = false
local sessionid = ""

local name = "Keter"
local ownerid = "xCcjVHkQgx"
local version = "1.0"

local req = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. name .. '&ownerid=' .. ownerid .. '&type=init&ver=' .. version)

if req == "KeyAuth_Invalid" then
	print("Error: Application not found.")
	StarterGui:SetCore("SendNotification", {
		Title = LuaName,
		Text = "Error: Application not found.",
		Duration = 3
	})
	return
end

local data = HttpService:JSONDecode(req)

if data.success then
	initialized = true
	sessionid = data.sessionid
elseif data.message == "invalidver" then
	print("Error: Wrong application version.")
	StarterGui:SetCore("SendNotification", {
		Title = LuaName,
		Text = "Error: Wrong application version.",
		Duration = 3
	})
	return
else
	print("Error: " .. data.message)
	return
end

print("\n\nLicensing...\n")
local req = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. name .. '&ownerid=' .. ownerid .. '&type=license&key=' .. License .. '&ver=' .. version .. '&sessionid=' .. sessionid)
local data = HttpService:JSONDecode(req)

if not data.success then
	StarterGui:SetCore("SendNotification", {
		Title = LuaName,
		Text = "Error: " .. data.message,
		Duration = 5
	})
	return
end

StarterGui:SetCore("SendNotification", {
	Title = LuaName,
	Text = "Successfully Authorized :)",
	Duration = 5
})
