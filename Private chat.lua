-- ============================================================
-- AYAN'S ULTIMATE CHAT SYSTEM (GITHUB PREMIUM, FAV/UNSTAR, THEMES & DM GROUPS)
-- ============================================================

local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("AyanChatGui") then
    CoreGui.AyanChatGui:Destroy()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- ============================================================
-- MOCKAPI CONFIGURATION (For Global Chat & Sync)
-- ============================================================
local API_URL = "https://6aef2e43b9925b27ce16b743.mockapi.io/v1/Message"
local lastMessageCount = 0

local function makeHttpRequest(options)
    local req = (syn and syn.request) or http_request or request or (http and http.request)
    if req then
        local success, response = pcall(req, options)
        if success then return response end
    end
    return nil
end

-- ============================================================
-- THEMES CONFIGURATION (Pink, Black, Glass, Bubble, Blue, Red)
-- ============================================================
local Themes = {
    Glass = {
        GlassBG = Color3.fromRGB(18, 18, 24),
        GlassTransparency = 0.25,
        AccentBlue = Color3.fromRGB(0, 122, 255),
        BubbleSelf = Color3.fromRGB(45, 45, 60),
        BubbleOther = Color3.fromRGB(30, 30, 42),
        BubbleBG = Color3.fromRGB(25, 25, 35),
        BorderColor = Color3.fromRGB(70, 70, 95)
    },
    Black = {
        GlassBG = Color3.fromRGB(10, 10, 12),
        GlassTransparency = 0.1,
        AccentBlue = Color3.fromRGB(80, 80, 100),
        BubbleSelf = Color3.fromRGB(25, 25, 30),
        BubbleOther = Color3.fromRGB(18, 18, 22),
        BubbleBG = Color3.fromRGB(15, 15, 18),
        BorderColor = Color3.fromRGB(40, 40, 50)
    },
    Pink = {
        GlassBG = Color3.fromRGB(25, 12, 20),
        GlassTransparency = 0.15,
        AccentBlue = Color3.fromRGB(255, 105, 180),
        BubbleSelf = Color3.fromRGB(50, 25, 40),
        BubbleOther = Color3.fromRGB(35, 18, 28),
        BubbleBG = Color3.fromRGB(30, 15, 25),
        BorderColor = Color3.fromRGB(70, 40, 60)
    },
    Bubble = {
        GlassBG = Color3.fromRGB(20, 30, 45),
        GlassTransparency = 0.2,
        AccentBlue = Color3.fromRGB(0, 191, 255),
        BubbleSelf = Color3.fromRGB(40, 70, 100),
        BubbleOther = Color3.fromRGB(25, 45, 65),
        BubbleBG = Color3.fromRGB(20, 35, 50),
        BorderColor = Color3.fromRGB(50, 100, 150)
    },
    Blue = {
        GlassBG = Color3.fromRGB(12, 18, 30),
        GlassTransparency = 0.15,
        AccentBlue = Color3.fromRGB(30, 144, 255),
        BubbleSelf = Color3.fromRGB(25, 45, 75),
        BubbleOther = Color3.fromRGB(16, 30, 50),
        BubbleBG = Color3.fromRGB(14, 25, 42),
        BorderColor = Color3.fromRGB(40, 75, 120)
    },
    Red = {
        GlassBG = Color3.fromRGB(25, 12, 12),
        GlassTransparency = 0.15,
        AccentBlue = Color3.fromRGB(220, 50, 50),
        BubbleSelf = Color3.fromRGB(50, 25, 25),
        BubbleOther = Color3.fromRGB(35, 18, 18),
        BubbleBG = Color3.fromRGB(30, 15, 15),
        BorderColor = Color3.fromRGB(90, 40, 40)
    }
}

local CurrentTheme = Themes.Glass
local isOnlineStatusEnabled = true

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AyanChatGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

-- ============================================================
-- HELPER FUNCTIONS
-- ============================================================
local function Create(className, properties, children)
    local instance = Instance.new(className)
    for k, v in pairs(properties) do
        instance[k] = v
    end
    if children then
        for _, child in ipairs(children) do
            child.Parent = instance
        end
    end
    return instance
end

local function AddCorner(parent, radius)
    return Create("UICorner", { CornerRadius = UDim.new(0, radius or 16), Parent = parent })
end

local function AddStroke(parent, color, thickness)
    return Create("UIStroke", { Color = color or CurrentTheme.BorderColor, Thickness = thickness or 1, Parent = parent })
end

-- ============================================================
-- DRAGGABLE FLOATING BUBBLE TOGGLE (💬)
-- ============================================================
local BubbleBtn = Create("TextButton", {
    Size = UDim2.new(0, 54, 0, 54),
    Position = UDim2.new(0, 30, 0.5, -27),
    BackgroundColor3 = CurrentTheme.BubbleBG,
    BackgroundTransparency = 0.15,
    Text = "💬",
    TextSize = 26,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    ZIndex = 999,
    Parent = ScreenGui
}, {
    AddCorner(nil, 27),
    AddStroke(nil, CurrentTheme.AccentBlue, 1.5)
})

local dragging = false
local dragStart, startPos, clicked = false, nil, true

BubbleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        clicked = true
        dragStart = input.Position
        startPos = BubbleBtn.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        if delta.Magnitude > 5 then clicked = false end
        BubbleBtn.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- ============================================================
-- MAIN CHAT WINDOW CONTAINER
-- ============================================================
local MainWindow = Create("Frame", {
    Size = UDim2.new(0, 480, 0, 360),
    Position = UDim2.new(0.5, -240, 0.5, -180),
    BackgroundColor3 = CurrentTheme.GlassBG,
    BackgroundTransparency = CurrentTheme.GlassTransparency,
    Visible = false,
    ZIndex = 500,
    Parent = ScreenGui
}, {
    AddCorner(nil, 14),
    AddStroke(nil, CurrentTheme.BorderColor, 1.5)
})

-- Top Bar Header
local TopBar = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundColor3 = CurrentTheme.GlassBG,
    BackgroundTransparency = 0.2,
    ZIndex = 501,
    Parent = MainWindow
}, {
    AddCorner(nil, 14)
})

Create("Frame", {
    Size = UDim2.new(1, 0, 0, 10),
    Position = UDim2.new(0, 0, 1, -10),
    BackgroundColor3 = CurrentTheme.GlassBG,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
    ZIndex = 501,
    Parent = TopBar
})

Create("TextLabel", {
    Size = UDim2.new(1, -140, 1, 0),
    Position = UDim2.new(0, 15, 0, 0),
    BackgroundTransparency = 1,
    Text = "Z A Y N  C H A T",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 502,
    Parent = TopBar
})

-- Close & Settings Buttons
local DestroyBtn = Create("TextButton", {
    Size = UDim2.new(0, 26, 0, 26),
    Position = UDim2.new(1, -34, 0.5, -13),
    BackgroundColor3 = Color3.fromRGB(220, 50, 50),
    BackgroundTransparency = 0.2,
    Text = "❌",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    ZIndex = 502,
    Parent = TopBar
}, {
    AddCorner(nil, 6)
})

local SettingsBtn = Create("TextButton", {
    Size = UDim2.new(0, 26, 0, 26),
    Position = UDim2.new(1, -66, 0.5, -13),
    BackgroundColor3 = CurrentTheme.BubbleBG,
    BackgroundTransparency = 0.3,
    Text = "⚙️",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    ZIndex = 502,
    Parent = TopBar
}, {
    AddCorner(nil, 6),
    AddStroke(nil, CurrentTheme.BorderColor)
})

-- ============================================================
-- SETTINGS PANEL (Themes & Online Status Toggle)
-- ============================================================
local SettingsPanel = Create("Frame", {
    Size = UDim2.new(1, -20, 1, -60),
    Position = UDim2.new(0, 10, 0, 50),
    BackgroundColor3 = CurrentTheme.GlassBG,
    BackgroundTransparency = 0.05,
    Visible = false,
    ZIndex = 750,
    Parent = MainWindow
}, {
    AddCorner(nil, 12),
    AddStroke(nil, CurrentTheme.AccentBlue, 1.5)
})

Create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 25),
    Position = UDim2.new(0, 15, 0, 10),
    BackgroundTransparency = 1,
    Text = "🎨 SELECT THEME",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 751,
    Parent = SettingsPanel
})

local ThemeGrid = Create("ScrollingFrame", {
    Size = UDim2.new(1, -30, 0, 90),
    Position = UDim2.new(0, 15, 0, 38),
    BackgroundTransparency = 1,
    ScrollBarThickness = 2,
    CanvasSize = UDim2.new(0, 0, 0, 100),
    ZIndex = 751,
    Parent = SettingsPanel
}, {
    Create("UIGridLayout", {
        CellSize = UDim2.new(0, 130, 0, 34),
        CellPadding = UDim2.new(0, 10, 0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
})

local function applyTheme(tName)
    if Themes[tName] then
        CurrentTheme = Themes[tName]
        MainWindow.BackgroundColor3 = CurrentTheme.GlassBG
        MainWindow.BackgroundTransparency = CurrentTheme.GlassTransparency
        TopBar.BackgroundColor3 = CurrentTheme.GlassBG
        BubbleBtn.BackgroundColor3 = CurrentTheme.BubbleBG
        SettingsPanel.BackgroundColor3 = CurrentTheme.GlassBG
        print("Theme applied: " .. tName)
    end
end

for tName, _ in pairs(Themes) do
    local tBtn = Create("TextButton", {
        Size = UDim2.new(0, 130, 0, 34),
        BackgroundColor3 = CurrentTheme.BubbleBG,
        BackgroundTransparency = 0.2,
        Text = tName,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        ZIndex = 752,
        Parent = ThemeGrid
    }, { AddCorner(nil, 8), AddStroke(nil, CurrentTheme.BorderColor) })

    tBtn.MouseButton1Click:Connect(function() applyTheme(tName) end)
end

-- Online Status Toggle Section
Create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 25),
    Position = UDim2.new(0, 15, 0, 140),
    BackgroundTransparency = 1,
    Text = "🟢 USER ONLINE STATUS",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 751,
    Parent = SettingsPanel
})

local StatusToggleBtn = Create("TextButton", {
    Size = UDim2.new(1, -30, 0, 34),
    Position = UDim2.new(0, 15, 0, 170),
    BackgroundColor3 = CurrentTheme.BubbleBG,
    BackgroundTransparency = 0.2,
    Text = "Status: ON (This user is online)",
    TextColor3 = Color3.fromRGB(50, 220, 50),
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    ZIndex = 752,
    Parent = SettingsPanel
}, { AddCorner(nil, 8), AddStroke(nil, CurrentTheme.BorderColor) })

StatusToggleBtn.MouseButton1Click:Connect(function()
    isOnlineStatusEnabled = not isOnlineStatusEnabled
    if isOnlineStatusEnabled then
        StatusToggleBtn.Text = "Status: ON (This user is online)"
        StatusToggleBtn.TextColor3 = Color3.fromRGB(50, 220, 50)
    else
        StatusToggleBtn.Text = "Status: OFF (Hidden)"
        StatusToggleBtn.TextColor3 = Color3.fromRGB(220, 50, 50)
    end
end)

SettingsBtn.MouseButton1Click:Connect(function()
    SettingsPanel.Visible = not SettingsPanel.Visible
end)

-- ============================================================
-- TABS BAR (3 TABS: Global, Server, DM & Groups)
-- ============================================================
local TabBar = Create("Frame", {
    Size = UDim2.new(1, -20, 0, 32),
    Position = UDim2.new(0, 10, 0, 46),
    BackgroundTransparency = 1,
    ZIndex = 501,
    Parent = MainWindow
}, {
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    })
})

local PagesContainer = Create("Frame", {
    Size = UDim2.new(1, -20, 1, -145),
    Position = UDim2.new(0, 10, 0, 84),
    BackgroundTransparency = 1,
    ZIndex = 501,
    Parent = MainWindow
})

local Pages = {}
local TabButtons = {}

local function CreateChatTab(name, order)
    local page = Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Color3.fromRGB(0, 122, 255),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
        ZIndex = 502,
        Parent = PagesContainer
    }, {
        Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10)
        })
    })
    Pages[name] = page

    local tabBtn = Create("TextButton", {
        Size = UDim2.new(0, 145, 1, 0),
        BackgroundColor3 = CurrentTheme.BubbleBG,
        BackgroundTransparency = 0.4,
        Text = name,
        TextColor3 = Color3.fromRGB(160, 160, 175),
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        LayoutOrder = order,
        ZIndex = 502,
        Parent = TabBar
    }, {
        AddCorner(nil, 6),
        AddStroke(nil, CurrentTheme.BorderColor)
    })
    TabButtons[name] = tabBtn

    tabBtn.MouseButton1Click:Connect(function()
        for tName, p in pairs(Pages) do p.Visible = (tName == name) end
        for tName, b in pairs(TabButtons) do
            TweenService:Create(b, TweenInfo.new(0.2), {
                TextColor3 = (tName == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 175),
                BackgroundColor3 = (tName == name) and Color3.fromRGB(0, 122, 255) or CurrentTheme.BubbleBG
            }):Play()
        end
    end)

    return page
end

local GlobalPage = CreateChatTab("🌐 Global Chat", 1)
local ServerPage = CreateChatTab("💬 Server Chat", 2)
local DMPage = CreateChatTab("📨 DM & Groups", 3)

Pages["🌐 Global Chat"].Visible = true
TabButtons["🌐 Global Chat"].TextColor3 = Color3.fromRGB(255, 255, 255)
TabButtons["🌐 Global Chat"].BackgroundColor3 = Color3.fromRGB(0, 122, 255)

-- ============================================================
-- DM & PRIVATE GROUP SEARCH UI SETUP
-- ============================================================
local DMHeader = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 36),
    BackgroundTransparency = 1,
    ZIndex = 503,
    Parent = DMPage
}, {
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6)
    })
})

local SearchBox = Create("TextBox", {
    Size = UDim2.new(1, -110, 1, 0),
    BackgroundColor3 = CurrentTheme.BubbleBG,
    PlaceholderText = "Search script user...",
    PlaceholderColor3 = Color3.fromRGB(160, 160, 175),
    Text = "",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 11,
    Font = Enum.Font.Gotham,
    ZIndex = 504,
    Parent = DMHeader
}, { AddCorner(nil, 6), AddStroke(nil, CurrentTheme.BorderColor) })

local CreateGroupBtn = Create("TextButton", {
    Size = UDim2.new(0, 100, 1, 0),
    BackgroundColor3 = Color3.fromRGB(0, 122, 255),
    Text = "+ Create Group",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 10,
    Font = Enum.Font.GothamBold,
    ZIndex = 504,
    Parent = DMHeader
}, { AddCorner(nil, 6) })

-- ============================================================
-- MESSAGE INPUT BAR WITH STICKER PANEL & GITHUB INTEGRATION
-- ============================================================
local InputBar = Create("Frame", {
    Size = UDim2.new(1, -20, 0, 42),
    Position = UDim2.new(0, 10, 1, -50),
    BackgroundColor3 = CurrentTheme.BubbleBG,
    BackgroundTransparency = 0.1,
    ZIndex = 503,
    Parent = MainWindow
}, {
    AddCorner(nil, 21),
    AddStroke(nil, CurrentTheme.BorderColor)
})

local ChatInput = Create("TextBox", {
    Size = UDim2.new(1, -95, 1, 0),
    Position = UDim2.new(0, 14, 0, 0),
    BackgroundTransparency = 1,
    PlaceholderText = "Type message...",
    PlaceholderColor3 = Color3.fromRGB(160, 160, 175),
    Text = "",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 12,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false,
    ZIndex = 504,
    Parent = InputBar
})

local StickerBtn = Create("TextButton", {
    Size = UDim2.new(0, 32, 0, 32),
    Position = UDim2.new(1, -74, 0.5, -16),
    BackgroundColor3 = CurrentTheme.BubbleBG,
    BackgroundTransparency = 0.3,
    Text = "🐼",
    TextSize = 16,
    ZIndex = 504,
    Parent = InputBar
}, {
    AddCorner(nil, 16)
})

local SendBtn = Create("TextButton", {
    Size = UDim2.new(0, 32, 0, 32),
    Position = UDim2.new(1, -38, 0.5, -16),
    BackgroundColor3 = Color3.fromRGB(0, 122, 255),
    Text = "↑",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    ZIndex = 504,
    Parent = InputBar
}, {
    AddCorner(nil, 16)
})

-- Sticker Popup Menu with Star (Favorite / Unstar) & GitHub Premium Link
local StickerMenu = Create("Frame", {
    Size = UDim2.new(1, -20, 0, 220),
    Position = UDim2.new(0, 10, 1, -276),
    BackgroundColor3 = CurrentTheme.GlassBG,
    BackgroundTransparency = 0.05,
    Visible = false,
    ZIndex = 800,
    Parent = MainWindow
}, {
    AddCorner(nil, 12),
    AddStroke(nil, Color3.fromRGB(0, 122, 255), 1.5)
})

local StickerTabBar = Create("Frame", {
    Size = UDim2.new(1, -16, 0, 28),
    Position = UDim2.new(0, 8, 0, 8),
    BackgroundTransparency = 1,
    ZIndex = 801,
    Parent = StickerMenu
}, {
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    })
})

local StickerPagesContainer = Create("Frame", {
    Size = UDim2.new(1, -16, 1, -44),
    Position = UDim2.new(0, 8, 0, 40),
    BackgroundTransparency = 1,
    ZIndex = 801,
    Parent = StickerMenu
})

local favoriteStickers = {}
local premiumStickersList = {"https://raw.githubusercontent.com/ayanjaveed503-a11y/EVERYONE-SCRIPT/refs/heads/main/Trio%20king.png"}

local function CreateStickerGrid()
    local grid = Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 2,
        CanvasSize = UDim2.new(0, 0, 0, 200),
        ZIndex = 802,
        Parent = StickerPagesContainer
    }, {
        Create("UIGridLayout", {
            CellSize = UDim2.new(0, 56, 0, 56),
            CellPadding = UDim2.new(0, 8, 0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    })
    return grid
end

local allStickerGrid = CreateStickerGrid()
local favStickerGrid = CreateStickerGrid()
local premStickerGrid = CreateStickerGrid()

favStickerGrid.Visible = false
premStickerGrid.Visible = false

local function CreateStickerTabBtn(name, order, targetGrid)
    local btn = Create("TextButton", {
        Size = UDim2.new(0, 130, 1, 0),
        BackgroundColor3 = CurrentTheme.BubbleBG,
        BackgroundTransparency = 0.3,
        Text = name,
        TextColor3 = Color3.fromRGB(160, 160, 175),
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        LayoutOrder = order,
        ZIndex = 802,
        Parent = StickerTabBar
    }, { AddCorner(nil, 6), AddStroke(nil, CurrentTheme.BorderColor) })

    btn.MouseButton1Click:Connect(function()
        allStickerGrid.Visible = (targetGrid == allStickerGrid)
        favStickerGrid.Visible = (targetGrid == favStickerGrid)
        premStickerGrid.Visible = (targetGrid == premStickerGrid)
    end)
    return btn
end

CreateStickerTabBtn("📁 All", 1, allStickerGrid)
CreateStickerTabBtn("⭐ Favorite", 2, favStickerGrid)
CreateStickerTabBtn("👑 Premium", 3, premStickerGrid)

local baseStickers = {
    "rbxassetid://91364271898721", "rbxassetid://6031091029", "rbxassetid://6031097225",
    "rbxassetid://6031097267", "rbxassetid://6031097317", "rbxassetid://6031097380",
    "https://raw.githubusercontent.com/ayanjaveed503-a11y/EVERYONE-SCRIPT/refs/heads/main/Trio%20king.png"
}

local postGlobalMessage, AddMessage

local function populateStickers(grid, list, isFavTab)
    for _, child in ipairs(grid:GetChildren()) do
        if child:IsA("Frame") or child:IsA("ImageButton") then child:Destroy() end
    end
    for _, imgId in ipairs(list) do
        local wrapFrame = Create("Frame", {
            Size = UDim2.new(0, 56, 0, 56),
            BackgroundTransparency = 1,
            ZIndex = 802,
            Parent = grid
        })

        local sImgBtn = Create("ImageButton", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = CurrentTheme.BubbleBG,
            Image = imgId,
            ZIndex = 803,
            Parent = wrapFrame
        }, { AddCorner(nil, 8), AddStroke(nil, CurrentTheme.BorderColor) })
        
        sImgBtn.MouseButton1Click:Connect(function()
            StickerMenu.Visible = false
            local stickerPayload = "[IMG:" .. imgId .. "]"
            if GlobalPage.Visible then
                postGlobalMessage(Player.Name, stickerPayload)
            elseif ServerPage.Visible then
                AddMessage(ServerPage, Player.Name, stickerPayload, Player.UserId)
            end
        end)

        -- Star Button: Star to Save, Unstar to Remove
        local isFav = table.find(favoriteStickers, imgId) ~= nil
        local starBtn = Create("TextButton", {
            Size = UDim2.new(0, 18, 0, 18),
            Position = UDim2.new(1, -20, 0, 2),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.4,
            Text = isFav and "⭐" or "☆",
            TextSize = 10,
            ZIndex = 804,
            Parent = wrapFrame
        }, { AddCorner(nil, 4) })

        starBtn.MouseButton1Click:Connect(function()
            local index = table.find(favoriteStickers, imgId)
            if index then
                table.remove(favoriteStickers, index)
                starBtn.Text = "☆"
                print("Unstarred sticker!")
            else
                table.insert(favoriteStickers, imgId)
                starBtn.Text = "⭐"
                print("Starred sticker!")
            end
            populateStickers(favStickerGrid, favoriteStickers, true)
        end)
    end
end

populateStickers(allStickerGrid, baseStickers, false)
populateStickers(premStickerGrid, premiumStickersList, false)

StickerBtn.MouseButton1Click:Connect(function()
    StickerMenu.Visible = not StickerMenu.Visible
end)

-- ============================================================
-- MESSAGE OPTIONS & FULL ACTIONS (Copy, Edit, Unsend, React)
-- ============================================================
local OptionsOverlay = Create("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.5,
    Visible = false,
    ZIndex = 900,
    Parent = MainWindow
})

local OptionsMenu = Create("Frame", {
    Size = UDim2.new(0, 320, 0, 280),
    Position = UDim2.new(0.5, -160, 0.5, -140),
    BackgroundColor3 = CurrentTheme.GlassBG,
    BackgroundTransparency = 0.05,
    ZIndex = 901,
    Parent = OptionsOverlay
}, {
    AddCorner(nil, 14),
    AddStroke(nil, Color3.fromRGB(0, 122, 255), 1.5)
})

Create("TextLabel", {
    Size = UDim2.new(1, -40, 0, 30),
    Position = UDim2.new(0, 20, 0, 10),
    BackgroundTransparency = 1,
    Text = "Message Options",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    ZIndex = 902,
    Parent = OptionsMenu
})

local CloseOptionsBtn = Create("TextButton", {
    Size = UDim2.new(0, 24, 0, 24),
    Position = UDim2.new(1, -32, 0, 12),
    BackgroundTransparency = 1,
    Text = "✕",
    TextColor3 = Color3.fromRGB(220, 50, 50),
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    ZIndex = 902,
    Parent = OptionsMenu
})
CloseOptionsBtn.MouseButton1Click:Connect(function() OptionsOverlay.Visible = false end)

local selectedMsgFrame = nil
local selectedMsgBubble = nil

local ReactionRow = Create("Frame", {
    Size = UDim2.new(1, -30, 0, 36),
    Position = UDim2.new(0, 15, 0, 45),
    BackgroundColor3 = CurrentTheme.BubbleBG,
    ZIndex = 902,
    Parent = OptionsMenu
}, {
    AddCorner(nil, 8),
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 12)
    })
})

local emojis = {"❤️", "😂", "💀", "💔", "🥀", "😴"}
for _, emoji in ipairs(emojis) do
    local emoBtn = Create("TextButton", {
        Size = UDim2.new(0, 32, 0, 32),
        BackgroundTransparency = 1,
        Text = emoji,
        TextSize = 16,
        ZIndex = 903,
        Parent = ReactionRow
    })
    emoBtn.MouseButton1Click:Connect(function()
        if selectedMsgFrame and selectedMsgBubble then
            local existingReact = selectedMsgBubble:FindFirstChild("ReactionBadge")
            if existingReact then existingReact:Destroy() end

            local reactBadge = Create("Frame", {
                Name = "ReactionBadge",
                Size = UDim2.new(0, 45, 0, 20),
                Position = UDim2.new(1, -45, 1, 2),
                BackgroundColor3 = CurrentTheme.BubbleBG,
                ZIndex = 605,
                Parent = selectedMsgBubble
            }, { AddCorner(nil, 10), AddStroke(nil, CurrentTheme.BorderColor) })

            Create("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = emoji .. " 1",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 10,
                Font = Enum.Font.GothamBold,
                ZIndex = 606,
                Parent = reactBadge
            })
        end
        OptionsOverlay.Visible = false
    end)
end

local ActionList = Create("Frame", {
    Size = UDim2.new(1, -30, 0, 160),
    Position = UDim2.new(0, 15, 0, 95),
    BackgroundTransparency = 1,
    ZIndex = 902,
    Parent = OptionsMenu
}, {
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8)
    })
})

local function CreateOptionButton(text, color, order)
    return Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = color or Color3.fromRGB(0, 122, 255),
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        LayoutOrder = order,
        ZIndex = 903,
        Parent = ActionList
    }, { AddCorner(nil, 8) })
end

local CopyBtn = CreateOptionButton("📋 Copy Text", Color3.fromRGB(0, 122, 255), 1)
local EditBtn = CreateOptionButton("✏️ Edit Message", Color3.fromRGB(200, 130, 20), 2)
local ReplyBtn = CreateOptionButton("💬 Reply", Color3.fromRGB(70, 70, 90), 3)
local UnsendBtn = CreateOptionButton("🗑️ Unsend (Delete)", Color3.fromRGB(220, 50, 50), 4)

CopyBtn.MouseButton1Click:Connect(function()
    if selectedMsgBubble then
        local tLabel = selectedMsgBubble:FindFirstChildOfClass("TextLabel")
        if tLabel and setclipboard then
            setclipboard(tLabel.Text)
        end
    end
    OptionsOverlay.Visible = false
end)

UnsendBtn.MouseButton1Click:Connect(function()
    if selectedMsgFrame then selectedMsgFrame:Destroy() end
    OptionsOverlay.Visible = false
end)

EditBtn.MouseButton1Click:Connect(function()
    if selectedMsgBubble then
        local tLabel = selectedMsgBubble:FindFirstChildOfClass("TextLabel")
        if tLabel then tLabel.Text = tLabel.Text .. " (edited)" end
    end
    OptionsOverlay.Visible = false
end)

-- ============================================================
-- MESSAGE BUBBLE BUILDER
-- ============================================================
function AddMessage(scrollFrame, sender, text, userId)
    local isSystem = (sender == "SYSTEM")
    local isSelf = (sender == Player.Name)
    
    local msgFrame = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ZIndex = 600,
        Parent = scrollFrame
    })

    if isSystem then
        local sysBox = Create("Frame", {
            Size = UDim2.new(1, -20, 0, 24),
            Position = UDim2.new(0, 10, 0, 2),
            BackgroundColor3 = CurrentTheme.BubbleBG,
            BackgroundTransparency = 0.4,
            ZIndex = 601,
            Parent = msgFrame
        }, { AddCorner(nil, 6), AddStroke(nil, Color3.fromRGB(255, 204, 0), 1) })

        Create("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = Color3.fromRGB(255, 204, 0),
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            ZIndex = 602,
            Parent = sysBox
        })
    else
        local thumbId = "rbxassetid://0"
        pcall(function()
            if userId then
                thumbId = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            else
                local p = Players:FindFirstChild(sender)
                if p then
                    thumbId = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                end
            end
        end)

        Create("ImageLabel", {
            Size = UDim2.new(0, 34, 0, 34),
            Position = isSelf and UDim2.new(1, -38, 0, 2) or UDim2.new(0, 4, 0, 2),
            BackgroundTransparency = 1,
            Image = thumbId,
            ZIndex = 601,
            Parent = msgFrame
        }, { AddCorner(nil, 17) })

        local bubbleBox = Create("TextButton", {
            Size = UDim2.new(0, 100, 0, 0),
            Position = isSelf and UDim2.new(1, -46, 0, 0) or UDim2.new(0, 44, 0, 0),
            AnchorPoint = isSelf and Vector2.new(1, 0) or Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = isSelf and CurrentTheme.BubbleSelf or CurrentTheme.BubbleOther,
            BackgroundTransparency = 0.15,
            Text = "",
            ZIndex = 601,
            Parent = msgFrame
        }, {
            AddCorner(nil, 18),
            AddStroke(nil, CurrentTheme.BorderColor, 1)
        })

        bubbleBox.MouseButton1Click:Connect(function()
            selectedMsgFrame = msgFrame
            selectedMsgBubble = bubbleBox
            OptionsOverlay.Visible = true
        end)

        if string.sub(text, 1, 5) == "[IMG:" then
            local imgAssetId = string.match(text, "%[(.-)%]")
            imgAssetId = string.gsub(imgAssetId, "IMG:", "")
            
            Create("ImageLabel", {
                Size = UDim2.new(0, 110, 0, 110),
                Position = UDim2.new(0, 8, 0, 8),
                BackgroundTransparency = 1,
                Image = imgAssetId,
                ZIndex = 602,
                Parent = bubbleBox
            }, { AddCorner(nil, 12) })
            
            bubbleBox.Size = UDim2.new(0, 126, 0, 126)
        else
            local msgText = Create("TextLabel", {
                Size = UDim2.new(1, -20, 0, 0),
                Position = UDim2.new(0, 10, 0, 10),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 602,
                Parent = bubbleBox
            })
            
            task.defer(function()
                if msgText.AbsoluteContentSize and msgText.AbsoluteContentSize.Y > 0 then
                    local textWidth = math.clamp(msgText.TextBounds.X + 30, 80, 340)
                    bubbleBox.Size = UDim2.new(0, textWidth, 0, msgText.AbsoluteContentSize.Y + 20)
                end
            end)
        end
    end
    
    task.defer(function()
        scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteCanvasSize.Y)
    end)
end

-- ============================================================
-- GLOBAL & SERVER CHAT SYNC
-- ============================================================
local function fetchGlobalMessages()
    local res = makeHttpRequest({ Url = API_URL, Method = "GET" })
    if res and res.StatusCode == 200 then
        local ok, msgs = pcall(function() return HttpService:JSONDecode(res.Body) end)
        if ok and type(msgs) == "table" then
            if #msgs ~= lastMessageCount then
                for _, child in ipairs(GlobalPage:GetChildren()) do
                    if child:IsA("Frame") then child:Destroy() end
                end
                for _, m in ipairs(msgs) do
                    if m.sender and m.text then
                        AddMessage(GlobalPage, m.sender, m.text, m.userId)
                    end
                end
                lastMessageCount = #msgs
            end
        end
    end
end

function postGlobalMessage(sender, text)
    task.spawn(function()
        makeHttpRequest({
            Url = API_URL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({ sender = sender, text = text, userId = Player.UserId })
        })
        task.wait(0.2)
        fetchGlobalMessages()
    end)
end

local function sendJoinAnnouncement()
    local joinText = "⭐ " .. Player.Name .. " joined the script chat!"
    if isOnlineStatusEnabled then
        joinText = joinText .. " (This user is online)"
    end
    AddMessage(ServerPage, "SYSTEM", joinText, nil)
    postGlobalMessage("SYSTEM", joinText)
end

task.spawn(sendJoinAnnouncement)

local function sendMessage()
    local text = ChatInput.Text
    if text ~= "" then
        ChatInput.Text = ""
        StickerMenu.Visible = false
        
        if GlobalPage.Visible then
            postGlobalMessage(Player.Name, text)
        elseif ServerPage.Visible then
            AddMessage(ServerPage, Player.Name, text, Player.UserId)
        end
    end
end

SendBtn.MouseButton1Click:Connect(sendMessage)
ChatInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then sendMessage() end
end)

task.spawn(function()
    while task.wait(1.5) do
        pcall(fetchGlobalMessages)
    end
end)

-- ============================================================
-- WINDOW CONTROLS
-- ============================================================
local mDragging, mDragStart, mStartPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        mDragging = true
        mDragStart = input.Position
        mStartPos = MainWindow.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                mDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if mDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - mDragStart
        MainWindow.Position = UDim2.new(mStartPos.X.Scale, mStartPos.X.Offset + delta.X, mStartPos.Y.Scale, mStartPos.Y.Offset + delta.Y)
    end
end)

local isOpen = false
BubbleBtn.MouseButton1Click:Connect(function()
    if clicked then
        isOpen = not isOpen
        MainWindow.Visible = isOpen
    end
end)

DestroyBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("Ayan Ultimate Chat with GitHub & Online Status Loaded Successfully!")
