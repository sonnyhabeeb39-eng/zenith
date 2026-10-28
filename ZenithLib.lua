--[[
    ZenithLib v1.0
    Zenith Hub Universal UI Library
    Dark theme / Red accent / Two-column layout
    loadstring compatible
]]

local ZenithLib = {}
ZenithLib.__index = ZenithLib

-- ─── Services ───────────────────────────────────────────────────────────────
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LP               = Players.LocalPlayer

-- ─── Theme ──────────────────────────────────────────────────────────────────
local T = {
    Bg          = Color3.fromRGB(13,  13,  19),
    Card        = Color3.fromRGB(21,  21,  31),
    CardBorder  = Color3.fromRGB(36,  36,  52),
    Header      = Color3.fromRGB(9,   9,   14),
    TabBar      = Color3.fromRGB(16,  16,  24),
    Accent      = Color3.fromRGB(220, 50,  50),
    AccentHi    = Color3.fromRGB(245, 80,  80),
    Text        = Color3.fromRGB(235, 235, 248),
    Muted       = Color3.fromRGB(115, 115, 140),
    ToggleOff   = Color3.fromRGB(42,  42,  58),
    Track       = Color3.fromRGB(38,  38,  54),
    DropBg      = Color3.fromRGB(16,  16,  24),
    Separator   = Color3.fromRGB(32,  32,  46),
    Knob        = Color3.fromRGB(245, 245, 255),
}

-- ─── Utilities ───────────────────────────────────────────────────────────────
local function N(class, props)
    local i = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Parent" then i[k] = v end
    end
    if props.Parent then i.Parent = props.Parent end
    return i
end

local function Tw(obj, goal, t, style)
    TweenService:Create(
        obj,
        TweenInfo.new(t or 0.18, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        goal
    ):Play()
end

local function Draggable(win, handle)
    local down, start, origin = false, nil, nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            down   = true
            start  = i.Position
            origin = win.Position
        end
    end)
    handle.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            down = false
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if not down then return end
        if i.UserInputType ~= Enum.UserInputType.MouseMovement
        and i.UserInputType ~= Enum.UserInputType.Touch then return end
        local d = i.Position - start
        win.Position = UDim2.new(
            origin.X.Scale, origin.X.Offset + d.X,
            origin.Y.Scale, origin.Y.Offset + d.Y
        )
    end)
end

-- ─── Toggle helpers ──────────────────────────────────────────────────────────
local function MakeToggle(parent, state)
    local track = N("TextButton", {
        Size            = UDim2.new(0, 42, 0, 22),
        BackgroundColor3= state and T.Accent or T.ToggleOff,
        BorderSizePixel = 0,
        Text            = "",
        AutoButtonColor = false,
        Parent          = parent,
    })
    N("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })
    N("Frame", {
        Name            = "Thumb",
        Size            = UDim2.new(0, 16, 0, 16),
        Position        = state
            and UDim2.new(1, -19, 0.5, -8)
            or  UDim2.new(0,   3, 0.5, -8),
        BackgroundColor3= T.Knob,
        BorderSizePixel = 0,
        Parent          = track,
    })
    N("UICorner", { CornerRadius = UDim.new(1, 0),
        Parent = track:FindFirstChild("Thumb") or track })
    return track
end

local function FlipToggle(track, state)
    local thumb = track:FindFirstChild("Thumb")
    Tw(track, { BackgroundColor3 = state and T.Accent or T.ToggleOff }, 0.18)
    if thumb then
        Tw(thumb, {
            Position = state
                and UDim2.new(1, -19, 0.5, -8)
                or  UDim2.new(0,   3, 0.5, -8)
        }, 0.18)
    end
end

-- ─── Window ──────────────────────────────────────────────────────────────────
function ZenithLib.new(cfg)
    local self = setmetatable({}, ZenithLib)
    cfg = cfg or {}

    local W  = cfg.Width  or 740
    local H  = cfg.Height or 490

    -- root gui
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    local gui = N("ScreenGui", {
        Name             = "ZenithHub",
        ResetOnSpawn     = false,
        ZIndexBehavior   = Enum.ZIndexBehavior.Sibling,
        DisplayOrder     = 99,
        IgnoreGuiInset   = true,
        Parent           = ok and cg or LP.PlayerGui,
    })

    -- main window
    local main = N("Frame", {
        Name             = "Window",
        Size             = UDim2.new(0, W, 0, H),
        Position         = UDim2.new(0.5, -W/2, 0.5, -H/2),
        BackgroundColor3 = T.Bg,
        BorderSizePixel  = 0,
        ClipsDescendants = true,
        Parent           = gui,
    })
    N("UICorner",  { CornerRadius = UDim.new(0, 10), Parent = main })
    N("UIStroke",  { Color = T.CardBorder, Thickness = 1, Parent = main })

    -- drop shadow (fake via image label)
    N("ImageLabel", {
        Size             = UDim2.new(1, 40, 1, 40),
        Position         = UDim2.new(0, -20, 0, -20),
        BackgroundTransparency = 1,
        Image            = "rbxassetid://5028857084",
        ImageColor3      = Color3.new(0, 0, 0),
        ImageTransparency= 0.65,
        ScaleType        = Enum.ScaleType.Slice,
        SliceCenter      = Rect.new(24, 24, 276, 276),
        ZIndex           = 0,
        Parent           = main,
    })

    -- ── Header ──────────────────────────────────────────────────────────────
    local hdr = N("Frame", {
        Name             = "Header",
        Size             = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = T.Header,
        BorderSizePixel  = 0,
        ZIndex           = 2,
        Parent           = main,
    })
    -- bottom edge on header
    N("Frame", {
        Size             = UDim2.new(1, 0, 0, 1),
        Position         = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = T.CardBorder,
        BorderSizePixel  = 0,
        Parent           = hdr,
    })

    -- Z logo badge
    local badge = N("Frame", {
        Size             = UDim2.new(0, 30, 0, 30),
        Position         = UDim2.new(0, 14, 0.5, -15),
        BackgroundColor3 = T.Accent,
        BorderSizePixel  = 0,
        Parent           = hdr,
    })
    N("UICorner", { CornerRadius = UDim.new(0, 6), Parent = badge })
    N("TextLabel", {
        Size             = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text             = "Z",
        TextColor3       = T.Text,
        Font             = Enum.Font.GothamBold,
        TextSize         = 17,
        Parent           = badge,
    })

    -- title
    N("TextLabel", {
        Size             = UDim2.new(0, 180, 1, 0),
        Position         = UDim2.new(0, 52, 0, 0),
        BackgroundTransparency = 1,
        Text             = cfg.Title or "Zenith Hub",
        TextColor3       = T.Text,
        Font             = Enum.Font.GothamBold,
        TextSize         = 14,
        TextXAlignment   = Enum.TextXAlignment.Left,
        Parent           = hdr,
    })

    -- search bar
    local srchFrame = N("Frame", {
        Size             = UDim2.new(0, 190, 0, 28),
        Position         = UDim2.new(0.5, -95, 0.5, -14),
        BackgroundColor3 = T.Card,
        BorderSizePixel  = 0,
        Parent           = hdr,
    })
    N("UICorner", { CornerRadius = UDim.new(0, 6), Parent = srchFrame })
    N("UIStroke",  { Color = T.CardBorder, Thickness = 1, Parent = srchFrame })
    N("TextLabel", {
        Size             = UDim2.new(0, 26, 1, 0),
        BackgroundTransparency = 1,
        Text             = "🔍",
        TextSize         = 11,
        Font             = Enum.Font.Gotham,
        Parent           = srchFrame,
    })
    N("TextBox", {
        Size             = UDim2.new(1, -30, 1, 0),
        Position         = UDim2.new(0, 26, 0, 0),
        BackgroundTransparency = 1,
        PlaceholderText  = "Search...",
        PlaceholderColor3= T.Muted,
        Text             = "",
        TextColor3       = T.Text,
        Font             = Enum.Font.Gotham,
        TextSize         = 12,
        TextXAlignment   = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        Parent           = srchFrame,
    })

    -- window controls (minimize / close)
    local function WinBtn(icon, xOffset)
        local b = N("TextButton", {
            Size             = UDim2.new(0, 26, 0, 26),
            Position         = UDim2.new(1, xOffset, 0.5, -13),
            BackgroundColor3 = T.Card,
            BorderSizePixel  = 0,
            Text             = icon,
            TextColor3       = T.Muted,
            Font             = Enum.Font.GothamBold,
            TextSize         = 12,
            AutoButtonColor  = false,
            Parent           = hdr,
        })
        N("UICorner", { CornerRadius = UDim.new(0, 6), Parent = b })
        b.MouseEnter:Connect(function() Tw(b, { TextColor3 = T.Text }, 0.12) end)
        b.MouseLeave:Connect(function() Tw(b, { TextColor3 = T.Muted }, 0.12) end)
        return b
    end

    local closeBtn = WinBtn("✕", -14)
    local minBtn   = WinBtn("—", -46)

    closeBtn.MouseButton1Click:Connect(function()
        Tw(main, { Size = UDim2.new(0, W, 0, 0), Position = UDim2.new(0.5, -W/2, 0.5, 0) }, 0.22)
        task.delay(0.23, function() gui:Destroy() end)
    end)

    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        Tw(main, { Size = UDim2.new(0, W, 0, minimized and 50 or H) }, 0.22)
    end)

    Draggable(main, hdr)

    -- ── Tab bar ─────────────────────────────────────────────────────────────
    local tabBar = N("Frame", {
        Name             = "TabBar",
        Size             = UDim2.new(1, 0, 0, 36),
        Position         = UDim2.new(0, 0, 0, 50),
        BackgroundColor3 = T.TabBar,
        BorderSizePixel  = 0,
        ClipsDescendants = true,
        ZIndex           = 2,
        Parent           = main,
    })
    N("Frame", {
        Size             = UDim2.new(1, 0, 0, 1),
        Position         = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = T.CardBorder,
        BorderSizePixel  = 0,
        Parent           = tabBar,
    })
    N("UIListLayout", {
        FillDirection    = Enum.FillDirection.Horizontal,
        VerticalAlignment= Enum.VerticalAlignment.Center,
        SortOrder        = Enum.SortOrder.LayoutOrder,
        Parent           = tabBar,
    })
    N("UIPadding", { PaddingLeft = UDim.new(0, 6), Parent = tabBar })

    -- ── Content ─────────────────────────────────────────────────────────────
    local contentArea = N("Frame", {
        Name             = "Content",
        Size             = UDim2.new(1, 0, 1, -86),
        Position         = UDim2.new(0, 0, 0, 86),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent           = main,
    })

    self._gui      = gui
    self._main     = main
    self._tabBar   = tabBar
    self._content  = contentArea
    self._tabs     = {}
    self._active   = nil
    self._W        = W
    self._H        = H

    return self
end

-- ─── Tab ─────────────────────────────────────────────────────────────────────
function ZenithLib:Tab(name)
    local idx = #self._tabs + 1

    -- tab button
    local btn = N("TextButton", {
        Name             = name,
        Size             = UDim2.new(0, 0, 1, 0),
        AutomaticSize    = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel  = 0,
        Text             = "",
        AutoButtonColor  = false,
        LayoutOrder      = idx,
        ZIndex           = 3,
        Parent           = self._tabBar,
    })
    N("UIPadding", {
        PaddingLeft  = UDim.new(0, 13),
        PaddingRight = UDim.new(0, 13),
        Parent       = btn,
    })
    local lbl = N("TextLabel", {
        Size             = UDim2.new(1, 0, 1, -3),
        BackgroundTransparency = 1,
        Text             = name,
        TextColor3       = T.Muted,
        Font             = Enum.Font.Gotham,
        TextSize         = 13,
        ZIndex           = 3,
        Parent           = btn,
    })
    local underline = N("Frame", {
        Size             = UDim2.new(1, 0, 0, 2),
        Position         = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = T.Accent,
        BackgroundTransparency = 1,
        BorderSizePixel  = 0,
        ZIndex           = 3,
        Parent           = btn,
    })

    -- panel (two-column scrollable)
    local panel = N("Frame", {
        Name             = name .. "_Panel",
        Size             = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible          = false,
        ClipsDescendants = true,
        Parent           = self._content,
    })
    N("UIPadding", {
        PaddingLeft  = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        PaddingTop   = UDim.new(0, 10),
        PaddingBottom= UDim.new(0, 10),
        Parent       = panel,
    })

    -- left column
    local colL = N("ScrollingFrame", {
        Name                = "ColLeft",
        Size                = UDim2.new(0.5, -5, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel     = 0,
        ScrollBarThickness  = 2,
        ScrollBarImageColor3= T.Accent,
        CanvasSize          = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent              = panel,
    })
    N("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding   = UDim.new(0, 8),
        Parent    = colL,
    })

    -- right column
    local colR = N("ScrollingFrame", {
        Name                = "ColRight",
        Size                = UDim2.new(0.5, -5, 1, 0),
        Position            = UDim2.new(0.5, 5, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel     = 0,
        ScrollBarThickness  = 2,
        ScrollBarImageColor3= T.Accent,
        CanvasSize          = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent              = panel,
    })
    N("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding   = UDim.new(0, 8),
        Parent    = colR,
    })

    local tabData = {
        _btn       = btn,
        _lbl       = lbl,
        _underline = underline,
        _panel     = panel,
        _colL      = colL,
        _colR      = colR,
        _sCount    = 0,
    }

    btn.MouseButton1Click:Connect(function()
        self:_Activate(tabData)
    end)
    btn.MouseEnter:Connect(function()
        if self._active ~= tabData then
            Tw(lbl, { TextColor3 = T.Text }, 0.12)
        end
    end)
    btn.MouseLeave:Connect(function()
        if self._active ~= tabData then
            Tw(lbl, { TextColor3 = T.Muted }, 0.12)
        end
    end)

    table.insert(self._tabs, tabData)
    if #self._tabs == 1 then self:_Activate(tabData) end

    -- ── Section ─────────────────────────────────────────────────────────────
    function tabData:Section(title, side)
        self._sCount = self._sCount + 1
        -- auto-alternate columns if side not specified
        local col
        if side == "right" then
            col = self._colR
        elseif side == "left" then
            col = self._colL
        else
            col = (self._sCount % 2 == 1) and self._colL or self._colR
        end

        local card = N("Frame", {
            Name             = title,
            Size             = UDim2.new(1, 0, 0, 0),
            AutomaticSize    = Enum.AutomaticSize.Y,
            BackgroundColor3 = T.Card,
            BorderSizePixel  = 0,
            LayoutOrder      = self._sCount,
            ClipsDescendants = false,
            Parent           = col,
        })
        N("UICorner", { CornerRadius = UDim.new(0, 8), Parent = card })
        N("UIStroke",  { Color = T.CardBorder, Thickness = 1, Parent = card })
        N("UIPadding", {
            PaddingLeft   = UDim.new(0, 12),
            PaddingRight  = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 10),
            Parent        = card,
        })

        -- section header row
        local sHdr = N("Frame", {
            Size             = UDim2.new(1, 0, 0, 42),
            BackgroundTransparency = 1,
            Parent           = card,
        })
        N("TextLabel", {
            Size             = UDim2.new(1, -60, 1, 0),
            BackgroundTransparency = 1,
            Text             = title,
            TextColor3       = T.Text,
            Font             = Enum.Font.GothamBold,
            TextSize         = 13,
            TextXAlignment   = Enum.TextXAlignment.Left,
            Parent           = sHdr,
        })

        -- master section toggle (top-right of card header)
        local masterState = true
        local master = MakeToggle(sHdr, true)
        master.Position = UDim2.new(1, -42, 0.5, -11)

        -- separator
        N("Frame", {
            Size             = UDim2.new(1, 0, 0, 1),
            Position         = UDim2.new(0, 0, 0, 42),
            BackgroundColor3 = T.Separator,
            BorderSizePixel  = 0,
            Parent           = card,
        })

        -- item container
        local items = N("Frame", {
            Name             = "Items",
            Size             = UDim2.new(1, 0, 0, 0),
            Position         = UDim2.new(0, 0, 0, 46),
            AutomaticSize    = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Parent           = card,
        })
        N("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding   = UDim.new(0, 6),
            Parent    = items,
        })

        master.MouseButton1Click:Connect(function()
            masterState = not masterState
            FlipToggle(master, masterState)
            for _, child in ipairs(items:GetChildren()) do
                if child:IsA("Frame") or child:IsA("TextButton") then
                    Tw(child, { BackgroundTransparency = masterState and 0 or 0.4 }, 0.15)
                    -- dim text
                    for _, desc in ipairs(child:GetDescendants()) do
                        if desc:IsA("TextLabel") or desc:IsA("TextButton") then
                            Tw(desc, { TextTransparency = masterState and 0 or 0.5 }, 0.15)
                        end
                    end
                end
            end
        end)

        local sec = { _items = items, _order = 0 }

        -- helper: next layout order
        local function NextOrder()
            sec._order = sec._order + 1
            return sec._order
        end

        -- ── Toggle ──────────────────────────────────────────────────────────
        function sec:Toggle(label, default, callback)
            local state = default or false
            local row = N("Frame", {
                Size             = UDim2.new(1, 0, 0, 32),
                BackgroundTransparency = 1,
                LayoutOrder      = NextOrder(),
                Parent           = self._items,
            })
            N("TextLabel", {
                Size             = UDim2.new(1, -52, 1, 0),
                BackgroundTransparency = 1,
                Text             = label,
                TextColor3       = T.Text,
                Font             = Enum.Font.Gotham,
                TextSize         = 12,
                TextXAlignment   = Enum.TextXAlignment.Left,
                Parent           = row,
            })
            local tog = MakeToggle(row, state)
            tog.Position = UDim2.new(1, -42, 0.5, -11)

            tog.MouseButton1Click:Connect(function()
                state = not state
                FlipToggle(tog, state)
                if callback then callback(state) end
            end)
            return self
        end

        -- ── Dropdown ────────────────────────────────────────────────────────
        function sec:Dropdown(label, options, default, callback)
            local selected = default or (options and options[1]) or ""
            local open     = false

            local wrapper = N("Frame", {
                Size             = UDim2.new(1, 0, 0, 54),
                BackgroundTransparency = 1,
                ClipsDescendants = false,
                LayoutOrder      = NextOrder(),
                Parent           = self._items,
            })

            N("TextLabel", {
                Size             = UDim2.new(1, 0, 0, 18),
                BackgroundTransparency = 1,
                Text             = label,
                TextColor3       = T.Muted,
                Font             = Enum.Font.Gotham,
                TextSize         = 11,
                TextXAlignment   = Enum.TextXAlignment.Left,
                Parent           = wrapper,
            })

            local dropBtn = N("TextButton", {
                Size             = UDim2.new(1, 0, 0, 30),
                Position         = UDim2.new(0, 0, 0, 20),
                BackgroundColor3 = T.DropBg,
                BorderSizePixel  = 0,
                Text             = "",
                AutoButtonColor  = false,
                ClipsDescendants = false,
                ZIndex           = 4,
                Parent           = wrapper,
            })
            N("UICorner", { CornerRadius = UDim.new(0, 6), Parent = dropBtn })
            N("UIStroke",  { Color = T.CardBorder, Thickness = 1, Parent = dropBtn })

            local valLbl = N("TextLabel", {
                Size             = UDim2.new(1, -30, 1, 0),
                Position         = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text             = selected,
                TextColor3       = T.Text,
                Font             = Enum.Font.Gotham,
                TextSize         = 12,
                TextXAlignment   = Enum.TextXAlignment.Left,
                ZIndex           = 4,
                Parent           = dropBtn,
            })
            local arrow = N("TextLabel", {
                Size             = UDim2.new(0, 24, 1, 0),
                Position         = UDim2.new(1, -26, 0, 0),
                BackgroundTransparency = 1,
                Text             = "▾",
                TextColor3       = T.Muted,
                TextSize         = 14,
                Font             = Enum.Font.Gotham,
                ZIndex           = 4,
                Parent           = dropBtn,
            })

            -- dropdown menu frame
            local menuH     = math.min(#options, 5) * 28
            local menuFrame = N("Frame", {
                Size             = UDim2.new(1, 0, 0, 0),
                Position         = UDim2.new(0, 0, 1, 4),
                BackgroundColor3 = T.DropBg,
                BorderSizePixel  = 0,
                ClipsDescendants = true,
                ZIndex           = 10,
                Visible          = false,
                Parent           = dropBtn,
            })
            N("UICorner", { CornerRadius = UDim.new(0, 6), Parent = menuFrame })
            N("UIStroke",  { Color = T.CardBorder, Thickness = 1, Parent = menuFrame })
            N("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = menuFrame })

            for i, opt in ipairs(options) do
                local optBtn = N("TextButton", {
                    Size             = UDim2.new(1, 0, 0, 28),
                    BackgroundColor3 = T.DropBg,
                    BackgroundTransparency = 1,
                    BorderSizePixel  = 0,
                    Text             = opt,
                    TextColor3       = (opt == selected) and T.Accent or T.Text,
                    Font             = Enum.Font.Gotham,
                    TextSize         = 12,
                    TextXAlignment   = Enum.TextXAlignment.Left,
                    AutoButtonColor  = false,
                    LayoutOrder      = i,
                    ZIndex           = 10,
                    Parent           = menuFrame,
                })
                N("UIPadding", { PaddingLeft = UDim.new(0, 10), Parent = optBtn })
                optBtn.MouseEnter:Connect(function()
                    Tw(optBtn, { BackgroundTransparency = 0, BackgroundColor3 = T.Card }, 0.1)
                end)
                optBtn.MouseLeave:Connect(function()
                    Tw(optBtn, { BackgroundTransparency = 1 }, 0.1)
                end)
                optBtn.MouseButton1Click:Connect(function()
                    selected     = opt
                    valLbl.Text  = opt
                    open         = false
                    Tw(menuFrame, { Size = UDim2.new(1, 0, 0, 0) }, 0.15)
                    Tw(arrow,     { Rotation = 0 }, 0.15)
                    task.delay(0.16, function() menuFrame.Visible = false end)
                    -- recolor all option labels
                    for _, c in ipairs(menuFrame:GetChildren()) do
                        if c:IsA("TextButton") then
                            c.TextColor3 = (c.Text == opt) and T.Accent or T.Text
                        end
                    end
                    if callback then callback(opt) end
                end)
            end

            dropBtn.MouseButton1Click:Connect(function()
                open = not open
                if open then
                    menuFrame.Visible = true
                    menuFrame.Size    = UDim2.new(1, 0, 0, 0)
                    Tw(menuFrame, { Size = UDim2.new(1, 0, 0, menuH) }, 0.18)
                    Tw(arrow,     { Rotation = 180 }, 0.18)
                else
                    Tw(menuFrame, { Size = UDim2.new(1, 0, 0, 0) }, 0.15)
                    Tw(arrow,     { Rotation = 0 }, 0.15)
                    task.delay(0.16, function() menuFrame.Visible = false end)
                end
            end)

            return self
        end

        -- ── Slider ──────────────────────────────────────────────────────────
        function sec:Slider(label, min, max, default, step, callback)
            min      = min or 0
            max      = max or 100
            default  = math.clamp(default or min, min, max)
            step     = step or 1
            -- callback can be 5th arg if step omitted
            if type(step) == "function" then callback = step; step = 1 end

            local pct = (default - min) / (max - min)

            local row = N("Frame", {
                Size             = UDim2.new(1, 0, 0, 56),
                BackgroundTransparency = 1,
                LayoutOrder      = NextOrder(),
                Parent           = self._items,
            })

            -- label row
            local topRow = N("Frame", {
                Size             = UDim2.new(1, 0, 0, 18),
                BackgroundTransparency = 1,
                Parent           = row,
            })
            N("TextLabel", {
                Size             = UDim2.new(0.7, 0, 1, 0),
                BackgroundTransparency = 1,
                Text             = label,
                TextColor3       = T.Text,
                Font             = Enum.Font.Gotham,
                TextSize         = 12,
                TextXAlignment   = Enum.TextXAlignment.Left,
                Parent           = topRow,
            })
            local valLbl = N("TextLabel", {
                Size             = UDim2.new(0.3, 0, 1, 0),
                Position         = UDim2.new(0.7, 0, 0, 0),
                BackgroundTransparency = 1,
                Text             = tostring(default),
                TextColor3       = T.Accent,
                Font             = Enum.Font.GothamBold,
                TextSize         = 12,
                TextXAlignment   = Enum.TextXAlignment.Right,
                Parent           = topRow,
            })

            -- track
            local track = N("Frame", {
                Size             = UDim2.new(1, 0, 0, 5),
                Position         = UDim2.new(0, 0, 0, 30),
                BackgroundColor3 = T.Track,
                BorderSizePixel  = 0,
                Parent           = row,
            })
            N("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })

            local fill = N("Frame", {
                Size             = UDim2.new(pct, 0, 1, 0),
                BackgroundColor3 = T.Accent,
                BorderSizePixel  = 0,
                Parent           = track,
            })
            N("UICorner", { CornerRadius = UDim.new(1, 0), Parent = fill })

            local knob = N("Frame", {
                Name             = "Knob",
                Size             = UDim2.new(0, 14, 0, 14),
                Position         = UDim2.new(pct, -7, 0.5, -7),
                BackgroundColor3 = T.Knob,
                BorderSizePixel  = 0,
                Parent           = track,
            })
            N("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })
            N("UIStroke",  { Color = T.Accent, Thickness = 2, Parent = knob })

            -- drag
            local dragging = false
            local function UpdateSlider(inputX)
                local pos  = track.AbsolutePosition
                local size = track.AbsoluteSize
                local relX = math.clamp((inputX - pos.X) / size.X, 0, 1)
                local raw  = min + (max - min) * relX
                local val  = math.floor(raw / step + 0.5) * step
                val        = math.clamp(val, min, max)
                local snapX = (val - min) / (max - min)
                valLbl.Text = tostring(val)
                fill.Size   = UDim2.new(snapX, 0, 1, 0)
                knob.Position = UDim2.new(snapX, -7, 0.5, -7)
                if callback then callback(val) end
            end

            knob.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1
                or i.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    Tw(knob, { Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(knob.Position.X.Scale, -8, 0.5, -8) }, 0.1)
                end
            end)
            track.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    UpdateSlider(i.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1
                or i.UserInputType == Enum.UserInputType.Touch then
                    if dragging then
                        dragging = false
                        Tw(knob, { Size = UDim2.new(0, 14, 0, 14) }, 0.1)
                    end
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if not dragging then return end
                if i.UserInputType == Enum.UserInputType.MouseMovement
                or i.UserInputType == Enum.UserInputType.Touch then
                    UpdateSlider(i.Position.X)
                end
            end)

            return self
        end

        -- ── Button ──────────────────────────────────────────────────────────
        function sec:Button(text, callback)
            local btn = N("TextButton", {
                Size             = UDim2.new(1, 0, 0, 30),
                BackgroundColor3 = T.Accent,
                BorderSizePixel  = 0,
                Text             = text,
                TextColor3       = T.Text,
                Font             = Enum.Font.GothamBold,
                TextSize         = 12,
                AutoButtonColor  = false,
                LayoutOrder      = NextOrder(),
                Parent           = self._items,
            })
            N("UICorner", { CornerRadius = UDim.new(0, 6), Parent = btn })
            btn.MouseEnter:Connect(function() Tw(btn, { BackgroundColor3 = T.AccentHi }, 0.12) end)
            btn.MouseLeave:Connect(function() Tw(btn, { BackgroundColor3 = T.Accent }, 0.12) end)
            btn.MouseButton1Click:Connect(function()
                Tw(btn, { BackgroundColor3 = T.Card }, 0.06)
                task.delay(0.12, function() Tw(btn, { BackgroundColor3 = T.Accent }, 0.12) end)
                if callback then callback() end
            end)
            return self
        end

        -- ── Keybind ─────────────────────────────────────────────────────────
        function sec:Keybind(label, default, callback)
            local key     = default or Enum.KeyCode.Unknown
            local listening = false

            local row = N("Frame", {
                Size             = UDim2.new(1, 0, 0, 32),
                BackgroundTransparency = 1,
                LayoutOrder      = NextOrder(),
                Parent           = self._items,
            })
            N("TextLabel", {
                Size             = UDim2.new(1, -80, 1, 0),
                BackgroundTransparency = 1,
                Text             = label,
                TextColor3       = T.Text,
                Font             = Enum.Font.Gotham,
                TextSize         = 12,
                TextXAlignment   = Enum.TextXAlignment.Left,
                Parent           = row,
            })
            local keyBtn = N("TextButton", {
                Size             = UDim2.new(0, 72, 0, 22),
                Position         = UDim2.new(1, -72, 0.5, -11),
                BackgroundColor3 = T.DropBg,
                BorderSizePixel  = 0,
                Text             = key.Name,
                TextColor3       = T.Accent,
                Font             = Enum.Font.GothamBold,
                TextSize         = 11,
                AutoButtonColor  = false,
                Parent           = row,
            })
            N("UICorner", { CornerRadius = UDim.new(0, 5), Parent = keyBtn })
            N("UIStroke",  { Color = T.CardBorder, Thickness = 1, Parent = keyBtn })

            keyBtn.MouseButton1Click:Connect(function()
                if listening then return end
                listening        = true
                keyBtn.Text      = "..."
                keyBtn.TextColor3= T.Muted
            end)

            UserInputService.InputBegan:Connect(function(i, gpe)
                if not listening then return end
                if i.UserInputType == Enum.UserInputType.Keyboard then
                    listening         = false
                    key               = i.KeyCode
                    keyBtn.Text       = key.Name
                    keyBtn.TextColor3 = T.Accent
                    if callback then callback(key) end
                end
            end)

            return self
        end

        -- ── Label ───────────────────────────────────────────────────────────
        function sec:Label(text, color)
            N("TextLabel", {
                Size             = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Text             = text,
                TextColor3       = color or T.Muted,
                Font             = Enum.Font.Gotham,
                TextSize         = 11,
                TextXAlignment   = Enum.TextXAlignment.Left,
                LayoutOrder      = NextOrder(),
                Parent           = self._items,
            })
            return self
        end

        -- ── Separator ───────────────────────────────────────────────────────
        function sec:Separator()
            N("Frame", {
                Size             = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = T.Separator,
                BorderSizePixel  = 0,
                LayoutOrder      = NextOrder(),
                Parent           = self._items,
            })
            return self
        end

        return sec
    end

    return tabData
end

-- ─── Activate tab ─────────────────────────────────────────────────────────────
function ZenithLib:_Activate(tabData)
    for _, t in ipairs(self._tabs) do
        t._panel.Visible              = false
        t._underline.BackgroundTransparency = 1
        t._lbl.Font                   = Enum.Font.Gotham
        Tw(t._lbl, { TextColor3 = T.Muted }, 0.15)
    end
    tabData._panel.Visible              = true
    tabData._underline.BackgroundTransparency = 0
    tabData._lbl.Font                   = Enum.Font.GothamBold
    Tw(tabData._lbl, { TextColor3 = T.Text }, 0.15)
    self._active = tabData
end

-- ─── Notify ──────────────────────────────────────────────────────────────────
function ZenithLib:Notify(title, text, duration)
    duration = duration or 3
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    local notifGui = N("ScreenGui", {
        Name           = "ZenithNotif",
        ResetOnSpawn   = false,
        IgnoreGuiInset = true,
        DisplayOrder   = 100,
        Parent         = ok and cg or LP.PlayerGui,
    })
    local box = N("Frame", {
        Size             = UDim2.new(0, 280, 0, 0),
        Position         = UDim2.new(1, -296, 1, -16),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundColor3 = T.Card,
        BorderSizePixel  = 0,
        Parent           = notifGui,
    })
    N("UICorner", { CornerRadius = UDim.new(0, 8), Parent = box })
    N("UIStroke",  { Color = T.CardBorder, Thickness = 1, Parent = box })
    N("UIPadding", { PaddingLeft = UDim.new(0,12), PaddingRight = UDim.new(0,12),
        PaddingTop = UDim.new(0,10), PaddingBottom = UDim.new(0,10), Parent = box })
    -- accent bar
    N("Frame", {
        Size             = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = T.Accent,
        BorderSizePixel  = 0,
        Parent           = box,
    })
    N("UICorner", { CornerRadius = UDim.new(0, 3), Parent = box:FindFirstChildOfClass("Frame") })
    N("TextLabel", {
        Size             = UDim2.new(1, -14, 0, 18),
        Position         = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1,
        Text             = title,
        TextColor3       = T.Text,
        Font             = Enum.Font.GothamBold,
        TextSize         = 13,
        TextXAlignment   = Enum.TextXAlignment.Left,
        Parent           = box,
    })
    N("TextLabel", {
        Size             = UDim2.new(1, -14, 0, 0),
        Position         = UDim2.new(0, 14, 0, 22),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text             = text,
        TextColor3       = T.Muted,
        Font             = Enum.Font.Gotham,
        TextSize         = 11,
        TextXAlignment   = Enum.TextXAlignment.Left,
        TextWrapped      = true,
        Parent           = box,
    })
    -- slide in
    box.Position = UDim2.new(1, 16, 1, -16)
    Tw(box, { Position = UDim2.new(1, -296, 1, -16) }, 0.3, Enum.EasingStyle.Back)
    task.delay(duration, function()
        Tw(box, { Position = UDim2.new(1, 16, 1, -16) }, 0.22)
        task.delay(0.23, function() notifGui:Destroy() end)
    end)
end

return ZenithLib

--[[
─────────────────────────────────────────────
  USAGE EXAMPLE
─────────────────────────────────────────────

local ZenithLib = loadstring(game:HttpGet("YOUR_RAW_URL"))()

local Win = ZenithLib.new({
    Title  = "Zenith Hub",
    Width  = 740,
    Height = 490,
})

-- ── Targeting Tab ──
local Targeting = Win:Tab("Targeting")

local TargetSel = Targeting:Section("Target Selection", "left")
TargetSel
    :Dropdown("Aim Part",       {"Head","Body","Legs","Random"}, "Head",       function(v) print(v) end)
    :Dropdown("Target Priority",{"Crosshair","Distance","Health"},"Crosshair", function(v) print(v) end)
    :Toggle("Sticky Target", false, function(v) print(v) end)
    :Slider("Target Lock",  0, 100, 50, 1, function(v) print(v) end)

local TargetFilt = Targeting:Section("Target Filters", "right")
TargetFilt
    :Slider("FOV Radius", 50, 600, 300, 10, function(v) print(v) end)
    :Toggle("Show FOV",        true,  function(v) print(v) end)
    :Toggle("Visibility Check",true,  function(v) print(v) end)
    :Toggle("Target Players",  true,  function(v) print(v) end)
    :Toggle("Target Bots",     true,  function(v) print(v) end)

-- ── ESP Tab ──
local ESP = Win:Tab("ESP")
local ESPSec = ESP:Section("Players")
ESPSec
    :Toggle("Box ESP",    false, function(v) end)
    :Toggle("Name ESP",   false, function(v) end)
    :Toggle("Health Bar", false, function(v) end)
    :Keybind("Toggle ESP", Enum.KeyCode.H, function(k) print(k) end)

-- ── Notification example ──
Win:Notify("Zenith Hub", "Loaded successfully.", 4)

─────────────────────────────────────────────
]]
