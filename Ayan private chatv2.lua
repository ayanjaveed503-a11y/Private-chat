-- -- zayn leak by psycho v14.5 | LocalScript -> StarterPlayerScripts -- Optimized Mobile Layout Pipeline - Hard Multi-Tier Execution Block Gate -- [MULTIPLAYER DATABASE SYNC ACTIVE] 
local Players = game:GetService("Players") 
local TweenSvc = game:GetService("TweenService") 
local UIS = game:GetService("UserInputService") 
local ContentProvider = game:GetService("ContentProvider") 
local HttpSvc = game:GetService("HttpService") 
local TeleportService = game:GetService("TeleportService") 
local RunService = game:GetService("RunService") 
local Player = Players.LocalPlayer 

-- ============================================================ 
-- DATABASE CONFIGURATION 
-- ============================================================ 
local FIREBASE_URL = "https://psychoontop-chat-mkx-default-rtdb.firebaseio.com/
" 
local GLOBAL_API_URL = "https://6aef2e43b9925b27ce16b743.mockapi.io/v1/Message" 
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
    Bio = "AYAN PAPA ON TOP",
    Theme = "Glass",
    Darkness = 30,
    UIWidth = 520,
    UIHeight = 420,
    Font = Enum.Font.Gotham,
    MsgColor = Color3.fromRGB(42, 42, 54)
} 

local CREATORS = { ["AYAN"] = true, ["AYANUU"] = true, [Player.Name] = true } 
local OWNER = { ["AYAN"] = true, ["AYANUU"] = true, [Player.Name] = true } 
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

local pGui = Player:FindFirstChildOfClass("PlayerGui") or Player:WaitForChild("PlayerGui")
local Gui = make("ScreenGui",{Name="zaynleakgui",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true}) 
Gui.Parent = pGui 

local function getImageAsset(url) 
    if not url or url == "" then return "" end 
    return url 
end 

local chatOpen = false
local currentTab = "SERVER"
local MsgScroll
local switchTab
local addDMContact
local addMsg

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
    pcall(function()
        local tweener = TweenSvc:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), pr)
        tweener:Play()
    end)
end

-- ============================================================ 
-- INTERACTIVE MESSAGE OPTIONS MODAL (WITH CUSTOM EMOJI TYPING)
-- ============================================================ 
local OptionsModal = make("Frame",{
    Size=UDim2.new(0,290,0,420),
    Position=UDim2.new(0.5,-145,0.5,-210),
    BackgroundColor3=Color3.fromRGB(20,20,26),
    Visible=false,
    ZIndex=990,
    Parent=Gui
})
corner(OptionsModal,14)
stroke(OptionsModal,Color3.fromRGB(80,80,105),1.5)

local optHeader = make("Frame",{Size=UDim2.new(1,0,0,36),BackgroundTransparency=1,ZIndex=991,Parent=OptionsModal})
local optTitle = make("TextLabel",{Size=UDim2.new(1,-40,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text="Options (AYANUU)",TextColor3=C.WHITE,TextSize=13,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=991,Parent=optHeader})
local optClose = make("TextButton",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(1,-28,0.5,-11),BackgroundTransparency=1,Text="✖",TextColor3=C.RED,TextSize=14,Font=Enum.Font.GothamBold,ZIndex=991,Parent=optHeader})
optClose.MouseButton1Click:Connect(function() OptionsModal.Visible = false end)

local reactBar = make("Frame",{
    Size=UDim2.new(1,-20,0,42),
    Position=UDim2.new(0,10,0,40),
    BackgroundColor3=Color3.fromRGB(30,30,38),
    ZIndex=991,
    Parent=OptionsModal
})
corner(reactBar,21)
stroke(reactBar,Color3.fromRGB(60,60,80),1)

local defaultEmojis = {"❤️","😂","💀","💔","🥀","🥺"}
for i, emo in ipairs(defaultEmojis) do
    local eBtn = make("TextButton",{
        Size=UDim2.new(0,33,1,0),
        Position=UDim2.new(0,(i-1)*38 + 8,0,0),
        BackgroundTransparency=1,
        Text=emo,
        TextSize=16,
        ZIndex=992,
        Parent=reactBar
    })
    eBtn.MouseButton1Click:Connect(function()
        OptionsModal.Visible = false
    end)
end

-- Custom Emoji Typing Input Box inside Options Modal
local customEmojiBox = make("TextBox",{
    Size=UDim2.new(1,-20,0,32),
    Position=UDim2.new(0,10,0,88),
    BackgroundColor3=Color3.fromRGB(35,35,45),
    PlaceholderText="Type custom emoji here...",
Use code with caution.
PlaceholderColor3=C.GRAY,
Text="",
TextColor3=C.WHITE,
TextSize=12,
Font=Enum.Font.Gotham,
ZIndex=991,
Parent=OptionsModal
})
corner(customEmojiBox,6)
local activeTargetMsgSender = ""
local activeTargetMsgText = ""
local activeTargetMsgFrame = nil
local msgPreviewLbl = make("TextLabel",{
Size=UDim2.new(1,-24,0,24),
Position=UDim2.new(0,12,0,124),
BackgroundTransparency=1,
Text=""message text..."",
TextColor3=C.GRAY,
TextSize=11,
Font=Enum.Font.GothamItalic,
TextTruncate=Enum.TextTruncate.AtEnd,
ZIndex=991,
Parent=OptionsModal
})
local function makeOptBtn(text, bgCol, yPos)
local btn = make("TextButton",{
Size=UDim2.new(1,-24,0,34),
Position=UDim2.new(0,12,0,yPos),
BackgroundColor3=bgCol,
Text=text,
TextColor3=C.WHITE,
TextSize=12,
Font=Enum.Font.GothamBold,
ZIndex=991,
Parent=OptionsModal
})
corner(btn,8)
return btn
end
local copyBtn = makeOptBtn("📋 Copy Text", Color3.fromRGB(30, 100, 210), 154)
local editBtn = makeOptBtn("✏️ Edit Message", Color3.fromRGB(190, 120, 20), 194)
local replyBtn = makeOptBtn("↩️ Reply", Color3.fromRGB(220, 220, 220), 234)
replyBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
local unsendBtn = makeOptBtn("🗑️ Unsend", Color3.fromRGB(190, 40, 40), 274)
local dmOptBtn = makeOptBtn("💬 Start DM", Color3.fromRGB(40, 140, 60), 314)
local inviteOptBtn = makeOptBtn("📩 Invite in Group", Color3.fromRGB(110, 50, 180), 354)
local function openMessageOptions(sender, text, msgFrame)
activeTargetMsgSender = sender
activeTargetMsgText = text
activeTargetMsgFrame = msgFrame
optTitle.Text = "Options ("..sender..")"
msgPreviewLbl.Text = """ .. text .. """
local isMe = (sender == Player.Name or sender == "AYAN" or sender == "AYANUU")
unsendBtn.Visible = isMe
editBtn.Visible = isMe
OptionsModal.Visible = true
end
copyBtn.MouseButton1Click:Connect(function()
pcall(function()
if setclipboard then setclipboard(activeTargetMsgText) end
end)
OptionsModal.Visible = false
end)
unsendBtn.MouseButton1Click:Connect(function()
if activeTargetMsgFrame and activeTargetMsgFrame.Parent then
activeTargetMsgFrame:Destroy()
end
OptionsModal.Visible = false
end)
dmOptBtn.MouseButton1Click:Connect(function()
OptionsModal.Visible = false
if addDMContact then addDMContact(activeTargetMsgSender) end
if switchTab then switchTab("DMs") end
end)
-- ============================================================
-- BUBBLE TRIGGER BUTTON
-- ============================================================
local BubFrame=make("Frame",{Size=UDim2.new(0,54,0,54),Position=UDim2.new(1,-68,1,-92),BackgroundColor3=Color3.fromRGB(45,45,55),BackgroundTransparency=0.08,ZIndex=800,Parent=Gui})
corner(BubFrame,27)
stroke(BubFrame,Color3.fromRGB(80,100,200),1.5)
local BubBtn=make("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="💬",TextSize=26,Font=Enum.Font.GothamBold,TextColor3=C.WHITE,ZIndex=801,Parent=BubFrame})
local dragging, dragStart, startPos
BubFrame.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPos = BubFrame.Position
end
end)
UIS.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - dragStart
BubFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end)
UIS.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = false
end
end)
-- ============================================================
-- MAIN WINDOW
-- ============================================================
local Win=make("Frame",{Name="ZaynLeakWin",Size=UDim2.new(0,ClientProfileData.UIWidth,0,ClientProfileData.UIHeight),Position=UDim2.new(0.5,-ClientProfileData.UIWidth/2,0.5,-ClientProfileData.UIHeight/2),BackgroundColor3=C.WIN,BackgroundTransparency=ClientProfileData.Darkness/100,Visible=false,ZIndex=500,Parent=Gui})
corner(Win,16)
stroke(Win,C.WINOUT,1.5)
local DragHandle=make("Frame",{Size=UDim2.new(1,-36,0,44),BackgroundTransparency=1,ZIndex=501,Parent=Win})
local XBtn=make("TextButton",{Size=UDim2.new(0,24,0,24),Position=UDim2.new(1,-30,0,10),BackgroundColor3=C.RED,Text="✖",TextColor3=C.WHITE,TextSize=13,Font=Enum.Font.GothamBold,ZIndex=502,Parent=Win})
corner(XBtn,7)
local TabBar=make("Frame",{Size=UDim2.new(1,0,0,44),BackgroundColor3=C.TABBAR,BackgroundTransparency=0.15,ZIndex=501,Parent=Win})
corner(TabBar,16)
local TabScroll=make("ScrollingFrame",{Size=UDim2.new(1,-34,1,0),BackgroundTransparency=1,ScrollBarThickness=0,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.X,ZIndex=502,Parent=TabBar})
ll(TabScroll,Enum.FillDirection.Horizontal,0)
local TABS={{name="SERVER",icon="🌐"},{name="GLOBAL CHAT",icon="🚀"},{name="PROFILE",icon="⚙️"},{name="DMs",icon="💬"}}
local tabBtns={}
for i,t in ipairs(TABS) do
local btn=make("TextButton",{Size=UDim2.new(0,118,1,0),BackgroundTransparency=1,Text=t.icon.." "..t.name,TextSize=10,Font=Enum.Font.GothamBold,TextColor3=C.GRAY,ZIndex=503,LayoutOrder=i,Parent=TabScroll})
local ul=make("Frame",{Size=UDim2.new(0,50,0,2),Position=UDim2.new(0.5,-25,1,-2),BackgroundColor3=C.BLUE,BackgroundTransparency=1,ZIndex=503,Parent=btn})
tabBtns[t.name]={b=btn,ul=ul}
end
local Content=make("Frame",{Size=UDim2.new(1,0,1,-44),Position=UDim2.new(0,0,0,44),BackgroundTransparency=1,ClipsDescendants=true,ZIndex=501,Parent=Win})
local SrvPage=make("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ZIndex=501,Parent=Content})
MsgScroll=make("ScrollingFrame",{Size=UDim2.new(1,-6,1,-56),Position=UDim2.new(0,3,0,3),BackgroundTransparency=1,ScrollBarThickness=2,ScrollBarImageColor3=C.BLUE,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ZIndex=502,Parent=SrvPage})
ll(MsgScroll,Enum.FillDirection.Vertical,5)
make("UIPadding",{PaddingLeft=UDim.new(0,6),PaddingRight=UDim.new(0,6),PaddingTop=UDim.new(0,4),Parent=MsgScroll})
local IBar=make("Frame",{Size=UDim2.new(1,-10,0,48),Position=UDim2.new(0,5,1,-52),BackgroundColor3=C.INPUT,BackgroundTransparency=0.1,ZIndex=503,Parent=SrvPage})
corner(IBar,24)
stroke(IBar,Color3.fromRGB(58,58,76),1)
local CInput=make("TextBox",{Size=UDim2.new(1,-120,1,-8),Position=UDim2.new(0,14,0,4),BackgroundTransparency=1,PlaceholderText="Type message...",PlaceholderColor3=C.GRAY,Text="",TextColor3=C.WHITE,TextSize=13,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,ZIndex=504,Parent=IBar})
local MBtn=make("TextButton",{Size=UDim2.new(0,32,0,32),Position=UDim2.new(1,-74,0.5,-16),BackgroundTransparency=1,Text="🌸",TextSize=22,ZIndex=504,Parent=IBar})
local SBtn=make("TextButton",{Size=UDim2.new(0,40,0,40),Position=UDim2.new(1,-46,0.5,-20),BackgroundColor3=C.BLUE,Text="↑",TextColor3=C.WHITE,TextSize=24,Font=Enum.Font.GothamBold,ZIndex=504,Parent=IBar})
corner(SBtn,20)
local function addSys(text)
if not MsgScroll then return end
local f=make("Frame",{Size=UDim2.new(1,-4,0,42),BackgroundColor3=C.SYSBG,BackgroundTransparency=0.1,ZIndex=503,Parent=MsgScroll})
corner(f,8)
make("TextLabel",{Size=UDim2.new(1,-14,1,0),Position=UDim2.new(0,7,0,0),BackgroundTransparency=1,Text="⚠ [SYSTEM] : "..text,TextColor3=C.SYSTXT,TextSize=12,Font=Enum.Font.GothamBold,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=504,Parent=f})
end
addMsg = function(sender,text,isImg,imgUrl)
local wrap=make("Frame",{Size=UDim2.new(1,-4,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,ZIndex=503,Parent=MsgScroll})
ll(wrap,Enum.FillDirection.Horizontal,10)
local bub=make("Frame",{Size=isImg and UDim2.new(0,140,0,140) or UDim2.new(0.82,-46,0,0),AutomaticSize=isImg and Enum.AutomaticSize.None or Enum.AutomaticSize.Y,BackgroundColor3=C.THEM,BackgroundTransparency=0.08,LayoutOrder=2,ZIndex=504,Parent=wrap})
corner(bub,12)
local lbl=make("TextLabel",{Size=UDim2.new(1,-16,0,0),AutomaticSize=Enum.AutomaticSize.Y,Position=UDim2.new(0,8,0,6),BackgroundTransparency=1,Text=sender..": "..text,TextColor3=C.WHITE,TextSize=13,Font=Enum.Font.Gotham,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=505,Parent=bub})
make("Frame",{Size=UDim2.new(1,0,0,12),BackgroundTransparency=1,ZIndex=504,Parent=bub})
bub.InputBegan:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
openMessageOptions(sender, text, wrap)
end
end)
end
-- ============================================================
-- STICKERS MODAL / PANEL VIEWER (OPENED VIA 🌸 BUTTON)
-- ============================================================
local StickerModal = make("Frame",{
Size=UDim2.new(0,340,0,320),
Position=UDim2.new(0.5,-170,0.5,-160),
BackgroundColor3=Color3.fromRGB(25,25,32),
Visible=false,
ZIndex=950,
Parent=Gui
})
corner(StickerModal,14)
stroke(StickerModal,C.WINOUT,1.5)
local stHeader = make("Frame",{Size=UDim2.new(1,0,0,36),BackgroundTransparency=1,ZIndex=951,Parent=StickerModal})
make("TextLabel",{Size=UDim2.new(1,-40,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text="🌸 Select Sticker / Meme",TextColor3=C.WHITE,TextSize=13,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=951,Parent=stHeader})
local stClose = make("TextButton",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(1,-28,0.5,-11),BackgroundTransparency=1,Text="✖",TextColor3=C.RED,TextSize=14,Font=Enum.Font.GothamBold,ZIndex=951,Parent=stHeader})
stClose.MouseButton1Click:Connect(function() StickerModal.Visible = false end)
local StScroll = make("ScrollingFrame",{Size=UDim2.new(1,-12,1,-48),Position=UDim2.new(0,6,0,42),BackgroundTransparency=1,ScrollBarThickness=3,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ZIndex=951,Parent=StickerModal})
make("UIGridLayout",{CellSize=UDim2.new(0,96,0,96),CellPadding=UDim2.new(0,10,0,10),Parent=StScroll})
for i,meme in ipairs(MEMES) do
local cell=make("TextButton",{Size=UDim2.new(0,96,0,96),BackgroundColor3=C.BG3,Text=meme.label,TextColor3=C.WHITE,TextSize=11,Font=Enum.Font.GothamBold,ZIndex=952,Parent=StScroll})
corner(cell,10)
stroke(cell,Color3.fromRGB(60,60,80))
cell.MouseButton1Click:Connect(function()
addMsg(Player.Name, "[Sticker: " .. meme.label .. "]", false, nil)
StickerModal.Visible = false
end)
end
MBtn.MouseButton1Click:Connect(function()
StickerModal.Visible = not StickerModal.Visible
end)
-- ============================================================
-- PROFILE & SETTINGS PAGE
-- ============================================================
local ProfPage=make("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=false,ZIndex=501,Parent=Content})
local ProfScroll=make("ScrollingFrame",{Size=UDim2.new(1,-6,1,-10),Position=UDim2.new(0,3,0,5),BackgroundTransparency=1,ScrollBarThickness=3,CanvasSize=UDim2.new(0,0,0,500),ZIndex=502,Parent=ProfPage})
make("TextLabel",{Size=UDim2.new(1,0,0,24),Position=UDim2.new(0,0,0,0),BackgroundTransparency=1,Text="⚙️ PROFILE & SETTINGS",TextColor3=C.WHITE,TextSize=13,Font=Enum.Font.GothamBold,ZIndex=502,Parent=ProfScroll})
local function addSettingLabel(text,y)
return make("TextLabel",{Size=UDim2.new(1,-14,0,20),Position=UDim2.new(0,7,0,y),BackgroundTransparency=1,Text=text,TextColor3=C.SYSTXT,TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=502,Parent=ProfScroll})
end

addSettingLabel("Change Display Name:", 30)
local NameBox = make("TextBox",{Size=UDim2.new(1,-14,0,32),Position=UDim2.new(0,7,0,54),BackgroundColor3=C.BG3,Text=ClientProfileData.DisplayName,TextColor3=C.WHITE,TextSize=12,Font=Enum.Font.Gotham,ZIndex=502,Parent=ProfScroll})
corner(NameBox,6)
addSettingLabel("Bio Description:", 94)
local BioBox = make("TextBox",{Size=UDim2.new(1,-14,0,48),Position=UDim2.new(0,7,0,118),BackgroundColor3=C.BG3,Text=ClientProfileData.Bio,TextColor3=C.WHITE,TextSize=12,Font=Enum.Font.Gotham,MultiLine=true,ZIndex=502,Parent=ProfScroll})
corner(BioBox,6)
addSettingLabel("Darkness Level (0 - 100):", 176)
local DarkBox = make("TextBox",{Size=UDim2.new(1,-14,0,32),Position=UDim2.new(0,7,0,200),BackgroundColor3=C.BG3,Text="30",TextColor3=C.WHITE,TextSize=12,Font=Enum.Font.Gotham,ZIndex=502,Parent=ProfScroll})
corner(DarkBox,6)
local ApplyProfBtn = make("TextButton",{Size=UDim2.new(1,-14,0,38),Position=UDim2.new(0,7,0,244),BackgroundColor3=C.BLUE,Text="APPLY PROFILE & SETTINGS",TextColor3=C.WHITE,TextSize=12,Font=Enum.Font.GothamBold,ZIndex=502,Parent=ProfScroll})
corner(ApplyProfBtn,8)
ApplyProfBtn.MouseButton1Click:Connect(function()
ClientProfileData.DisplayName = NameBox.Text
ClientProfileData.Bio = BioBox.Text
ClientProfileData.Darkness = tonumber(DarkBox.Text) or 30
Win.BackgroundTransparency = ClientProfileData.Darkness / 100
addSys("Profile updated successfully!")
end)
-- ============================================================
-- DMs PAGE
-- ============================================================
local DMPage=make("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=false,ZIndex=501,Parent=Content})
local pages={["SERVER"]=SrvPage,["GLOBAL CHAT"]=SrvPage,PROFILE=ProfPage,DMs=DMPage}
switchTab = function(name)
currentTab=name
for n,pg in pairs(pages) do pg.Visible=(n==name) end
for n,t in pairs(tabBtns) do
if n==name then tw(t.b,0.1,{TextColor3=C.WHITE}) tw(t.ul,0.1,{BackgroundTransparency=0})
else tw(t.b,0.1,{TextColor3=C.GRAY}) tw(t.ul,0.1,{BackgroundTransparency=1}) end
end
end
for name,t in pairs(tabBtns) do
t.b.MouseButton1Click:Connect(function() switchTab(name) end)
end
switchTab("SERVER")
XBtn.MouseButton1Click:Connect(function() Win.Visible = false end)
BubBtn.MouseButton1Click:Connect(function() Win.Visible = not Win.Visible end)
SBtn.MouseButton1Click:Connect(function()
if CInput.Text ~= "" then
addMsg(Player.Name, CInput.Text, false, nil)
CInput.Text = ""
end
end)
addSys("👋 " .. Player.Name .. " WELCOME, DEAR✨ (AYAN)")
