-- ═════════════════════════════════════════════════════════════════════════════
--  Services & Core Variables
-- ═════════════════════════════════════════════════════════════════════════════
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")
local UIS               = game:GetService("UserInputService")
local LocalPlayer       = Players.LocalPlayer
local TOUCH_INPUT_TYPES = {
    [Enum.UserInputType.Touch] = true,
    [Enum.UserInputType.Accelerometer] = true,
    [Enum.UserInputType.Gyro] = true,
}

-- ═════════════════════════════════════════════════════════════════════════════
--  Utility Functions
-- ═════════════════════════════════════════════════════════════════════════════
local function IsTouchPrimaryInput()
    return UIS.TouchEnabled
end

local function GetAimScreenPoint()
    local cam = workspace.CurrentCamera
    if (IsTouchPrimaryInput() or not UIS.MouseEnabled) and cam then
        local v = cam.ViewportSize
        return Vector2.new(v.X * 0.5, v.Y * 0.5)
    end
    local ok, pos = pcall(function()
        return UIS:GetMouseLocation()
    end)
    if ok and pos then
        return pos
    end
    if cam then
        local v = cam.ViewportSize
        return Vector2.new(v.X * 0.5, v.Y * 0.5)
    end
    return Vector2.new(0, 0)
end

local function UDim2NearlyEqual(a, b, eps)
    eps = eps or 0.001
    return math.abs(a.X.Scale - b.X.Scale) <= eps
        and math.abs(a.Y.Scale - b.Y.Scale) <= eps
        and math.abs(a.X.Offset - b.X.Offset) <= 1
        and math.abs(a.Y.Offset - b.Y.Offset) <= 1
end

local function Vector2NearlyEqual(a, b, eps)
    eps = eps or 0.001
    return math.abs(a.X - b.X) <= eps and math.abs(a.Y - b.Y) <= eps
end

local function GetGuiParent()
    local guiParent = game:GetService("CoreGui")
    if gethui then pcall(function() guiParent = gethui() end) end
    return guiParent
end

local function IsPointInGui(guiObj, point)
    if not guiObj or not point then return false end
    local pos = guiObj.AbsolutePosition
    local size = guiObj.AbsoluteSize
    return point.X >= pos.X and point.X <= (pos.X + size.X) and point.Y >= pos.Y and point.Y <= (pos.Y + size.Y)
end

local function IsPointerDownOn(guiObj)
    if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local okMouse, mousePos = pcall(function()
            return UIS:GetMouseLocation()
        end)
        if not okMouse or not mousePos then
            return guiObj == nil
        end
        return guiObj and IsPointInGui(guiObj, mousePos) or true
    end
    local ok, touches = pcall(function()
        return UIS:GetTouches()
    end)
    if not ok or not touches then return false end
    if not guiObj then return #touches > 0 end
    for _, touch in ipairs(touches) do
        if IsPointInGui(guiObj, touch.Position) then
            return true
        end
    end
    return false
end

-- ═════════════════════════════════════════════════════════════════════════════
--  Executor Compatibility Check
-- ═════════════════════════════════════════════════════════════════════════════
local REQUIRED_FUNCTIONS = {
    "hookmetamethod",
    "newcclosure",
    "getnamecallmethod",
    "setnamecallmethod",
    "hookfunction",
}

for _, fn in ipairs(REQUIRED_FUNCTIONS) do
    if not getgenv()[fn] then
        LocalPlayer:Kick("Unsupported executor: missing '" .. fn .. "'. Use an executor that supports this function.")
        return
    end
end

-- ═════════════════════════════════════════════════════════════════════════════
--  Configuration
-- ═════════════════════════════════════════════════════════════════════════════
getgenv().Config = {
    Aim_Enabled          = false,
    Aim_TeamCheck        = false,
    Aim_WallCheck        = false,
    Aim_FFCheck          = false,
    Aim_MissEnabled      = false,
    Aim_MissChance       = 10,
    Aim_MaxDistance      = 120,
    Alt_Aim_Enabled      = false,
    Alt_Aim_Prediction   = false,
    Alt_Aim_PredValue    = 0.10,
    GunMod_NoRecoil      = false,
    GunMod_NoSpread      = false,
    TargetType           = "Head",
    Weight_Head          = 20,
    Weight_Torso         = 60,
    Weight_Limbs         = 20,
    FOVRadius            = 150,
    ShowFOV              = false,
    FOVColor             = Color3.fromRGB(240, 248, 255),
    Aim_HoldMode         = false,
    Aim_ActivationMode   = "Toggle via Keybind",
    ESP_Enabled          = false,
    ESP_MedicMode        = false,
    ESP_Boxes            = false,
    ESP_Names            = false,
    ESP_Tools            = false,
    ESP_Classes          = false,
    ESP_ClassFilter      = {
        Rifleman = true, Assault = true, Support = true, Medic = true,
        Skirmisher = true, Recon = true, Engineer = true, Flamer = true, Officer = true
    },
    ESP_Health           = false,
    ESP_TeamCheck        = false,
    ESP_WallCheck        = false,
    ESP_FFCheck          = false,
    ESP_TeamColor        = false,
    ESP_TextSize         = 16,
    ESP_Color            = Color3.fromRGB(240, 248, 255),
    ESP_ToolColor        = Color3.fromRGB(255, 165, 0),
    ESP_ClassColor       = Color3.fromRGB(147, 112, 219),
    Misc_AutoReload      = false,
    Misc_LShiftToggle    = false,
    Misc_Spinbot         = false,
    Misc_SpinSpeed       = 2000,
    Misc_Bhop            = false,
    Misc_BhopPower       = 50,
    Misc_CFSpeedEnabled  = false,
    Misc_CFSpeed         = 0.5,
    Misc_CFFlyEnabled    = false,
    Misc_CFFlySpeed      = 0.5,
    Bind_Aim             = "",
    Bind_Spin            = "",
    Bind_Bhop            = "",
    Bind_CFS             = "",
    Bind_CFF             = "",
}
-- ═════════════════════════════════════════════════════════════════════════════
--  FOV Circle Setup
-- ═════════════════════════════════════════════════════════════════════════════
local ESP_DRAW_TEXT_BIAS = 1
local function NormalizeESPTextSize(v)
    local n = tonumber(v) or 16
    n = math.clamp(math.floor(n + 0.5), 8, 36)
    return n
end
local function GetRenderESPTextSize()
    return NormalizeESPTextSize(Config.ESP_TextSize) + ESP_DRAW_TEXT_BIAS
end
Config.ESP_TextSize = NormalizeESPTextSize(Config.ESP_TextSize)
local function SupportsDrawing()
    local ok, drawNew = pcall(function()
        return Drawing and Drawing.new
    end)
    return ok and type(drawNew) == "function"
end

local UseGuiFOV = IsTouchPrimaryInput() or not UIS.MouseEnabled or not SupportsDrawing()
local FOVCircle = nil
local FOVGuiCircle, FOVGuiStroke = nil, nil

local function EnsureFOVGui()
    local guiParent = GetGuiParent()
    local root = guiParent:FindFirstChild("ZenithFOVGui")
    if not root then
        root = Instance.new("ScreenGui")
        root.Name = "ZenithFOVGui"
        root.ResetOnSpawn = false
        root.IgnoreGuiInset = true
        root.DisplayOrder = 100
        root.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        root.Parent = guiParent
    end
    return root
end

local function MakeGuiCircle(name, color)
    local root = EnsureFOVGui()
    local frame = root:FindFirstChild(name)
    if not frame then
        frame = Instance.new("Frame")
        frame.Name = name
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        frame.ZIndex = 10
        frame.Parent = root

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = frame

        local stroke = Instance.new("UIStroke")
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Thickness = 1
        stroke.Transparency = 0.2
        stroke.Color = color
        stroke.Parent = frame
        return frame, stroke
    end

    local stroke = frame:FindFirstChildOfClass("UIStroke")
    if not stroke then
        stroke = Instance.new("UIStroke")
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Thickness = 1
        stroke.Transparency = 0.2
        stroke.Parent = frame
    end
    stroke.Color = color
    return frame, stroke
end

if UseGuiFOV then
    FOVGuiCircle, FOVGuiStroke = MakeGuiCircle("AimFOV", Config.FOVColor)
else
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible      = Config.ShowFOV
    FOVCircle.Radius       = Config.FOVRadius
    FOVCircle.Color        = Config.FOVColor
    FOVCircle.Thickness    = 1
    FOVCircle.Filled       = false
    FOVCircle.Transparency = 0.8
    FOVCircle.NumSides     = 64
end

RunService.RenderStepped:Connect(function()
    local aimPoint = GetAimScreenPoint()
    if UseGuiFOV then
        local fovDiameter = math.max(0, Config.FOVRadius * 2)

        if FOVGuiCircle then
            FOVGuiCircle.Visible = Config.ShowFOV and fovDiameter > 0
            FOVGuiCircle.Size = UDim2.fromOffset(fovDiameter, fovDiameter)
            FOVGuiCircle.Position = UDim2.fromOffset(aimPoint.X, aimPoint.Y)
        end
        if FOVGuiStroke then
            FOVGuiStroke.Color = Config.FOVColor
        end
    else
        FOVCircle.Position = aimPoint
        FOVCircle.Visible  = Config.ShowFOV
        FOVCircle.Radius   = Config.FOVRadius
        FOVCircle.Color    = Config.FOVColor
    end
end)
-- ═════════════════════════════════════════════════════════════════════════════
--  ESP System
-- ═════════════════════════════════════════════════════════════════════════════
local ESP_Objects = {}
local function createESP(plr)
    local esp = {
        Box = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        Tool = Drawing.new("Text"),
        Class = Drawing.new("Text"),
        Revive = Drawing.new("Text"),
        HealthBar = Drawing.new("Line"),
        HealthOutline = Drawing.new("Line")
    }
    esp.Box.Thickness = 1
    esp.Box.Color = Color3.fromRGB(255, 255, 255)
    esp.Box.Filled = false
    esp.Box.ZIndex = 2
    esp.Name.Size = 16
    esp.Name.Center = true
    esp.Name.Outline = true
    esp.Name.Color = Color3.fromRGB(255, 255, 255)
    esp.Name.ZIndex = 3
    esp.Tool.Size = 16
    esp.Tool.Center = true
    esp.Tool.Outline = true
    esp.Tool.Color = Color3.fromRGB(255, 165, 0)
    esp.Tool.ZIndex = 3
    esp.Class.Size = 16
    esp.Class.Center = true
    esp.Class.Outline = true
    esp.Class.Color = Color3.fromRGB(147, 112, 219)
    esp.Class.ZIndex = 3
    esp.Revive.Size = 16
    esp.Revive.Center = true
    esp.Revive.Outline = true
    esp.Revive.Color = Color3.fromRGB(50, 255, 50)
    esp.Revive.ZIndex = 4
    esp.HealthOutline.Thickness = 3
    esp.HealthOutline.Color = Color3.fromRGB(0, 0, 0)
    esp.HealthOutline.ZIndex = 1
    esp.HealthBar.Thickness = 1
    esp.HealthBar.Color = Color3.fromRGB(0, 255, 0)
    esp.HealthBar.ZIndex = 2
    ESP_Objects[plr] = esp
end
-- ESP Loop Optimization: Single connection, focused on Drawing updates.
-- Heavy visibility logic will happen inside the loop to avoid double-iterating.
RunService.RenderStepped:Connect(function()
    if not Config.ESP_Enabled then
        for _, esp in pairs(ESP_Objects) do
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Tool.Visible = false
            esp.Class.Visible = false
            esp.Revive.Visible = false
            esp.HealthBar.Visible = false
            esp.HealthOutline.Visible = false
        end
        return
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        local char = plr.Character
        local esp = ESP_Objects[plr]
        if not esp then
            createESP(plr)
            esp = ESP_Objects[plr]
        end

        local function hideESP()
            if esp.Box.Visible then esp.Box.Visible = false end
            if esp.Name.Visible then esp.Name.Visible = false end
            if esp.Tool.Visible then esp.Tool.Visible = false end
            if esp.Class.Visible then esp.Class.Visible = false end
            if esp.Revive.Visible then esp.Revive.Visible = false end
            if esp.HealthBar.Visible then esp.HealthBar.Visible = false end
            if esp.HealthOutline.Visible then esp.HealthOutline.Visible = false end
        end

        if not char then
            hideESP()
            continue
        end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then
            hideESP()
            continue
        end
        local isAlive = (hum and hum.Health > 0)
        local isFriendly = (plr.Team and LocalPlayer.Team and plr.Team == LocalPlayer.Team)
        local reviveVal = char:FindFirstChild("ReviveTime")
        local isReviveable = (Config.ESP_MedicMode and isFriendly and reviveVal ~= nil)
        if not isAlive and not isReviveable then
            hideESP()
            continue
        end
        if Config.ESP_TeamCheck and isFriendly and not isReviveable then
            hideESP()
            continue
        end
        if Config.ESP_FFCheck and char:FindFirstChildOfClass("ForceField") then
            hideESP()
            continue
        end
        local head = char:FindFirstChild("Head") or hrp
        local cam = workspace.CurrentCamera
        if Config.ESP_WallCheck then
            local origin = cam.CFrame.Position
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                origin = LocalPlayer.Character.Head.Position
            end
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = {LocalPlayer.Character, char}
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.IgnoreWater = true
            if workspace:Raycast(origin, head.Position - origin, params) then
                hideESP()
                continue
            end
        end
        local rootPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
        local headPos = cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
        local legPos = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
        if onScreen then
            local height = math.abs(headPos.Y - legPos.Y)
            local width = height * 0.6
            local currentESPColor = Config.ESP_Color
            if Config.ESP_TeamColor and plr.TeamColor then
                currentESPColor = plr.TeamColor.Color
            end
            if Config.ESP_Boxes then
                esp.Box.Size = Vector2.new(width, height)
                esp.Box.Position = Vector2.new(rootPos.X - width/2, headPos.Y)
                esp.Box.Color = currentESPColor
                esp.Box.Visible = true
            else
                esp.Box.Visible = false
            end
            local espTextSize = GetRenderESPTextSize()
            local currentOffset = headPos.Y - (espTextSize + 4)
            if Config.ESP_Names then
                esp.Name.Text = plr.Name
                esp.Name.Size = espTextSize
                esp.Name.Position = Vector2.new(rootPos.X, currentOffset)
                esp.Name.Color = currentESPColor
                esp.Name.Visible = true
                currentOffset = currentOffset - (espTextSize + 4)
            else
                esp.Name.Size = espTextSize
                esp.Name.Visible = false
            end
            if Config.ESP_Tools then
                local equippedTool = char:FindFirstChildOfClass("Tool")
                if equippedTool then
                    esp.Tool.Text = equippedTool.Name
                    esp.Tool.Size = espTextSize
                    esp.Tool.Position = Vector2.new(rootPos.X, currentOffset)
                    esp.Tool.Color = Config.ESP_ToolColor
                    esp.Tool.Visible = true
                    currentOffset = currentOffset - (espTextSize + 4)
                else
                    esp.Tool.Size = espTextSize
                    esp.Tool.Visible = false
                end
            else
                esp.Tool.Size = espTextSize
                esp.Tool.Visible = false
            end
            local pClassObj = plr:GetAttribute("Class")
            if Config.ESP_Classes and pClassObj and tostring(pClassObj) ~= "" then
                local pClassStr = tostring(pClassObj)
                local cleanClassLower = string.lower(string.match(pClassStr, "^%s*(.-)%s*$"))
                local shouldDraw = false
                for cName, isEnabled in pairs(Config.ESP_ClassFilter) do
                    if isEnabled and string.lower(cName) == cleanClassLower then
                        shouldDraw = true
                        break
                    end
                end
                if shouldDraw then
                    esp.Class.Text = "[" .. string.upper(pClassStr) .. "]"
                    esp.Class.Size = espTextSize
                    esp.Class.Position = Vector2.new(rootPos.X, currentOffset)
                    esp.Class.Color = Config.ESP_ClassColor
                    esp.Class.Visible = true
                    currentOffset = currentOffset - (espTextSize + 4)
                else
                    esp.Class.Size = espTextSize
                    esp.Class.Visible = false
                end
            else
                esp.Class.Size = espTextSize
                esp.Class.Visible = false
            end
            if isReviveable then
                esp.Revive.Text = "[REVIVEABLE]"
                esp.Revive.Size = espTextSize
                esp.Revive.Position = Vector2.new(rootPos.X, currentOffset)
                esp.Revive.Color = Color3.fromRGB(50, 255, 50)
                esp.Revive.Visible = true
            else
                esp.Revive.Size = espTextSize
                esp.Revive.Visible = false
            end
            if Config.ESP_Health and isAlive then
                local healthPct = hum.Health / hum.MaxHealth
                local healthHeight = height * healthPct
                esp.HealthOutline.From = Vector2.new(rootPos.X - width/2 - 5, headPos.Y + height + 1)
                esp.HealthOutline.To = Vector2.new(rootPos.X - width/2 - 5, headPos.Y - 1)
                esp.HealthOutline.Visible = true
                esp.HealthBar.From = Vector2.new(rootPos.X - width/2 - 5, headPos.Y + height)
                esp.HealthBar.To = Vector2.new(rootPos.X - width/2 - 5, headPos.Y + height - healthHeight)
                esp.HealthBar.Color = Color3.fromRGB(255 - (healthPct * 255), healthPct * 255, 0)
                esp.HealthBar.Visible = true
            else
                esp.HealthBar.Visible = false
                esp.HealthOutline.Visible = false
            end
        else
            hideESP()
        end
    end
end)
Players.PlayerRemoving:Connect(function(plr)
    local esp = ESP_Objects[plr]
    if esp then
        esp.Box:Remove()
        esp.Name:Remove()
        esp.Tool:Remove()
        esp.Class:Remove()
        esp.Revive:Remove()
        esp.HealthBar:Remove()
        esp.HealthOutline:Remove()
        ESP_Objects[plr] = nil
    end
end)
-- ═════════════════════════════════════════════════════════════════════════════
--  Targeting System
-- ═════════════════════════════════════════════════════════════════════════════
local function getBestPart(char)
    local tType = Config.TargetType
    if tType == "Closest" then
        local parts = {"Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm", "LeftUpperLeg", "RightUpperLeg"}
        local cam = workspace.CurrentCamera
        local mouse = GetAimScreenPoint()
        local bestPart = nil
        local shortest = math.huge
        for _, name in ipairs(parts) do
            local p = char:FindFirstChild(name)
            if p then
                local sPos, onScreen = cam:WorldToViewportPoint(p.Position)
                if onScreen then
                    local dist = (Vector2.new(sPos.X, sPos.Y) - mouse).Magnitude
                    if dist < shortest then
                        shortest = dist
                        bestPart = p
                    end
                end
            end
        end
        return bestPart
    elseif tType == "Randomized" then
        local total = Config.Weight_Head + Config.Weight_Torso + Config.Weight_Limbs
        if total <= 0 then return char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart") end
        local roll = math.random(1, total)
        if roll <= Config.Weight_Head then
            return char:FindFirstChild("Head")
        elseif roll <= Config.Weight_Head + Config.Weight_Torso then
            local torsos = {}
            if char:FindFirstChild("UpperTorso") then table.insert(torsos, char.UpperTorso) end
            if char:FindFirstChild("LowerTorso") then table.insert(torsos, char.LowerTorso) end
            if #torsos == 0 then return char:FindFirstChild("HumanoidRootPart") end
            return torsos[math.random(1, #torsos)]
        else
            local limbs = {"LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm", "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg"}
            local valid = {}
            for _, n in ipairs(limbs) do
                if char:FindFirstChild(n) then table.insert(valid, char[n]) end
            end
            if #valid == 0 then return char:FindFirstChild("HumanoidRootPart") end
            return valid[math.random(1, #valid)]
        end
    else
        return char:FindFirstChild(tType)
    end
end
local function getClosestEnemyTarget()
    local bestPlayer, bestPart = nil, nil
    local maxFOV = math.max(0, tonumber(Config.FOVRadius) or 0)
    local bestDist = maxFOV
    local mouse = GetAimScreenPoint()
    local cam   = workspace.CurrentCamera
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        local char = plr.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        if Config.Aim_TeamCheck and plr.Team and LocalPlayer.Team and plr.Team == LocalPlayer.Team then
            continue
        end
        if Config.Aim_FFCheck and char:FindFirstChildOfClass("ForceField") then
            continue
        end
        local part = getBestPart(char)
        if not part then continue end
        local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        if Config.Aim_WallCheck then
            local origin = cam.CFrame.Position
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                origin = LocalPlayer.Character.Head.Position
            end
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = { LocalPlayer.Character, char }
            params.FilterType     = Enum.RaycastFilterType.Exclude
            params.IgnoreWater    = true
            if workspace:Raycast(origin, part.Position - origin, params) then
                continue
            end
        end
        local lpHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local targetHrp = char:FindFirstChild("HumanoidRootPart")
        if lpHrp and targetHrp and (targetHrp.Position - lpHrp.Position).Magnitude > Config.Aim_MaxDistance then
            continue
        end
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mouse).Magnitude
        if dist <= maxFOV and dist < bestDist then
            bestDist = dist
            bestPlayer = plr
            bestPart = part
        end
    end
    return bestPlayer, bestPart
end
-- ═════════════════════════════════════════════════════════════════════════════
--  Silent Aim — Namecall Hook
-- ═════════════════════════════════════════════════════════════════════════════
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer"
        and typeof(self) == "Instance"
        and self.Parent and self.Parent.Name == "ServerEvents"
        and self.Parent.Parent == ReplicatedStorage
        and Config.Aim_Enabled
    then
        if self.Name == "Shoot" then
            if Config.Aim_MissEnabled and math.random(1, 100) <= Config.Aim_MissChance then
                setnamecallmethod(method)
                return oldNamecall(self, ...)
            end
            local args  = { ... }
            local nArgs = select("#", ...)
            local targetPlr, targetPart = getClosestEnemyTarget()
            if targetPlr and targetPart then
                local headPos = targetPart.Position
                args[2] = headPos
                args[4] = 0
                args[5] = {
                    { ["Instance"] = targetPart, ["Material"] = Enum.Material.Plastic, ["Normal"] = Vector3.new(0, 1, 0), ["Position"] = headPos }
                }
                local prevChar = nil
                if type(args[1]) == "table" and args[1].Character then
                    prevChar = args[1].Character
                    args[1].Character = targetPlr.Character
                end
                setnamecallmethod(method)
                local result = oldNamecall(self, unpack(args, 1, nArgs))
                if prevChar then args[1].Character = prevChar end
                return result
            end
        elseif self.Name == "LookAngle" then
            local args  = { ... }
            local nArgs = select("#", ...)
            local targetPlr, targetPart = getClosestEnemyTarget()
            if targetPlr and targetPart then
                local cam = workspace.CurrentCamera
                args[2] = targetPart.Position - cam.CFrame.Position
                local prevChar = nil
                if type(args[1]) == "table" and args[1].Character then
                    prevChar = args[1].Character
                    args[1].Character = targetPlr.Character
                end
                setnamecallmethod(method)
                local result = oldNamecall(self, unpack(args, 1, nArgs))
                if prevChar then args[1].Character = prevChar end
                return result
            end
        end
    end
    setnamecallmethod(method)
    return oldNamecall(self, ...)
end))
-- ═════════════════════════════════════════════════════════════════════════════
--  Silent Aim — WeaponModule Hook
-- ═════════════════════════════════════════════════════════════════════════════
local clonefunction = clonefunction or function(f) return f end

local function getAltTarget()
    if not Config.Alt_Aim_Enabled then return nil end
    local bestPart, bestDist = nil, math.max(0, tonumber(Config.FOVRadius) or 0)
    local mouse = GetAimScreenPoint()
    local cam = workspace.CurrentCamera
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        local char = plr.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        if Config.Aim_TeamCheck and plr.Team and LocalPlayer.Team and plr.Team == LocalPlayer.Team then continue end
        if Config.Aim_FFCheck and char:FindFirstChildOfClass("ForceField") then continue end
        local tPart = getBestPart(char)
        if not tPart then continue end
        if Config.Aim_WallCheck then
            local origin = cam.CFrame.Position
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                origin = LocalPlayer.Character.Head.Position
            end
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = { LocalPlayer.Character, char }
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.IgnoreWater = true
            if workspace:Raycast(origin, tPart.Position - origin, params) then continue end
        end
        local screenPos, onScreen = cam:WorldToViewportPoint(tPart.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mouse).Magnitude
        if dist < bestDist then
            bestPart = tPart
            bestDist = dist
        end
    end
    return bestPart
end

local altAimVel = nil
local altAimTool = nil
local noRecoilThread = nil

task.spawn(function()
pcall(function()
    local wm = require(ReplicatedStorage.WeaponModule)
    local anon = debug.getupvalue(rawget(wm, "Shoot"), 3)
    if not anon or typeof(anon) ~= "function" then
        for _, v in next, debug.getupvalues(rawget(wm, "Shoot")) do
            if type(v) == "function" then
                anon = v
                break
            end
        end
    end
    if not anon then return end
    for k, v in next, getfenv(anon) do
        if type(v) == "function" then
            local n = debug.info(v, "n")
            if n == "Crosshair" or n == "bulletMagnetism" then
                local old; old = clonefunction(hookfunction(rawget(getfenv(anon), k), newcclosure(function(...)
                    local c = getAltTarget()
                    if c and altAimVel and altAimTool and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                        local pos = c.Position
                        local tVel = c.AssemblyLinearVelocity
                        local r = pos - LocalPlayer.Character.Head.Position
                        local vel2 = tVel - LocalPlayer.Character.Head.AssemblyLinearVelocity
                        local a = vel2:Dot(vel2) - altAimVel * altAimVel
                        local b = 2 * r:Dot(vel2)
                        local c0 = r:Dot(r)
                        local disc = b * b - 4 * a * c0
                        if disc < 0 then return pos end
                        local sqrtDisc = math.sqrt(disc)
                        local t1 = (-b - sqrtDisc) / (2 * a)
                        local t2 = (-b + sqrtDisc) / (2 * a)
                        local t
                        if t1 > 0 and t2 > 0 then t = math.min(t1, t2)
                        elseif t1 > 0 then t = t1
                        elseif t2 > 0 then t = t2
                        else return pos end
                        local prediction = pos + tVel * t
                        if Config.Alt_Aim_Prediction then
                            prediction = prediction + tVel * Config.Alt_Aim_PredValue
                        end
                        return prediction + (prediction - LocalPlayer.Character.Head.Position).Unit * (altAimTool:GetAttribute("SpreadDefault") or 0) * 0.1
                    end
                    return old(...)
                end)))
            end
        end
    end
    local oldEquip; oldEquip = clonefunction(hookfunction(rawget(wm, "Equip"), newcclosure(function(data, mode)
        if noRecoilThread then
            coroutine.close(noRecoilThread)
            noRecoilThread = nil
        end
        altAimVel = data.Tool:GetAttribute("Velocity")
        altAimTool = data.Tool
        if mode == "Equip" and Config.GunMod_NoRecoil then
            data.Tool:SetAttribute("Recoil", 0)
            noRecoilThread = task.spawn(function()
                while task.wait() do
                    if data.RecoilPattern then
                        table.clear(data.RecoilPattern)
                    end
                end
            end)
        end
        if mode == "Equip" and Config.GunMod_NoSpread then
            data.Tool:SetAttribute("SpreadDefault", 0)
        end
        return oldEquip(data, mode)
    end)))
    LocalPlayer.CharacterAdded:Connect(function()
        altAimVel = nil
        altAimTool = nil
        if noRecoilThread then
            coroutine.close(noRecoilThread)
            noRecoilThread = nil
        end
    end)
end)
end) -- task.spawn

-- ═════════════════════════════════════════════════════════════════════════════
--  Misc Systems (Spinbot, Bhop, Fly, Speed, AutoReload)
-- ═════════════════════════════════════════════════════════════════════════════
local spinAngle = 0
RunService.RenderStepped:Connect(function(dt)
    if Config.Misc_Spinbot then
        spinAngle = spinAngle + (Config.Misc_SpinSpeed * dt)
        if spinAngle >= 360 then spinAngle = spinAngle - 360 end
    end
end)
-- Consolidated Spinbot Connection
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if Config.Misc_Spinbot and hrp and hum and hum.Health > 0 then
        hum.AutoRotate = false
        local rx, ry, rz = hrp.CFrame:ToOrientation()
        hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(rx, math.rad(spinAngle), rz)
    elseif hum and hum.AutoRotate == false then
        hum.AutoRotate = true
    end
end)
RunService.RenderStepped:Connect(function()
    if Config.Misc_Bhop then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local st = hum:GetState()
                if st == Enum.HumanoidStateType.Running or st == Enum.HumanoidStateType.RunningNoPhysics or st == Enum.HumanoidStateType.Landed then
                    hum.UseJumpPower = true
                    hum.JumpPower = Config.Misc_BhopPower
                    hum.Jump = true
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end
    end
end)
local FlyHoverCFrame = nil
local FlyJumpBoostUntil = 0
UIS.JumpRequest:Connect(function()
    FlyJumpBoostUntil = os.clock() + 0.22
end)

local function CameraRelativeFromHumanoidMove(worldMove, cam)
    if not cam or worldMove.Magnitude <= 0 then
        return Vector3.new(0, 0, 0)
    end
    local flatLook = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
    local flatRight = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
    if flatLook.Magnitude < 0.001 or flatRight.Magnitude < 0.001 then
        return worldMove
    end
    flatLook = flatLook.Unit
    flatRight = flatRight.Unit
    local forward = worldMove:Dot(flatLook)
    local side = worldMove:Dot(flatRight)
    return (cam.CFrame.LookVector * forward) + (cam.CFrame.RightVector * side)
end

local function GetGamepadFlyInput(cam)
    if not UIS.GamepadEnabled or not cam then
        return Vector3.new(0, 0, 0), false, false, false
    end
    local ok, states = pcall(function()
        return UIS:GetGamepadState(Enum.UserInputType.Gamepad1)
    end)
    if not ok or not states then
        return Vector3.new(0, 0, 0), false, false, false
    end

    local stick = Vector2.new(0, 0)
    local upHeld, downHeld = false, false
    for _, input in ipairs(states) do
        if input.KeyCode == Enum.KeyCode.Thumbstick1 then
            stick = input.Position
        elseif input.KeyCode == Enum.KeyCode.ButtonA or input.KeyCode == Enum.KeyCode.ButtonL2 then
            upHeld = input.UserInputState ~= Enum.UserInputState.End
        elseif input.KeyCode == Enum.KeyCode.ButtonB or input.KeyCode == Enum.KeyCode.ButtonR2 then
            downHeld = input.UserInputState ~= Enum.UserInputState.End
        end
    end

    local move = Vector3.new(0, 0, 0)
    local deadzone = 0.08
    local hasStick = stick.Magnitude > deadzone
    if hasStick then
        move = move + (cam.CFrame.RightVector * stick.X)
        move = move + (cam.CFrame.LookVector * stick.Y)
    end
    local active = hasStick or upHeld or downHeld
    return move, upHeld, downHeld, active
end

RunService.Heartbeat:Connect(function(dt)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return end
    if Config.Misc_CFFlyEnabled then
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new(0,0,0)
        local vertical = 0

        local gpMove, gpUp, gpDown, gpActive = GetGamepadFlyInput(cam)

        if UIS.KeyboardEnabled and cam then
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + (cam.CFrame.LookVector) end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - (cam.CFrame.LookVector) end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - (cam.CFrame.RightVector) end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + (cam.CFrame.RightVector) end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then vertical = vertical + 1 end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then vertical = vertical - 1 end
        end

        if gpActive then
            moveDir = moveDir + gpMove
            if gpUp then vertical = vertical + 1 end
            if gpDown then vertical = vertical - 1 end
        elseif not UIS.KeyboardEnabled then
            if UIS.TouchEnabled and cam then
                moveDir = moveDir + CameraRelativeFromHumanoidMove(hum.MoveDirection, cam)
            elseif hum.MoveDirection.Magnitude > 0 then
                moveDir = moveDir + hum.MoveDirection
            end
        end

        if hum.Jump or (UIS.TouchEnabled and os.clock() < FlyJumpBoostUntil) then
            vertical = vertical + 1
        end
        if vertical ~= 0 then
            moveDir = moveDir + Vector3.new(0, vertical, 0)
        end

        hrp.Velocity = Vector3.new(0, 0, 0)
        if moveDir.Magnitude > 0 then
            moveDir = moveDir.Unit
            local newCF = hrp.CFrame + (moveDir * Config.Misc_CFFlySpeed * dt * 60)
            hrp.CFrame = newCF
            FlyHoverCFrame = newCF
        else
            if not FlyHoverCFrame then FlyHoverCFrame = hrp.CFrame end
            hrp.CFrame = FlyHoverCFrame
        end
    elseif Config.Misc_CFSpeedEnabled then
        FlyHoverCFrame = nil
        if hum.MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (hum.MoveDirection * Config.Misc_CFSpeed * dt * 60)
        end
    else
        FlyHoverCFrame = nil
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if not Config.Misc_AutoReload then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then continue end
        
        local ammoVal = tool:FindFirstChild("AmmoLoaded")
        if ammoVal and (ammoVal:IsA("NumberValue") or ammoVal:IsA("IntValue")) and ammoVal.Value <= 0 then
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                vim:SendKeyEvent(true, Enum.KeyCode.R, false, game)
                task.wait(0.05)
                vim:SendKeyEvent(false, Enum.KeyCode.R, false, game)
                task.wait(1)
            end)
        end
    end
end)

-- ═════════════════════════════════════════════════════════════════════════════
--  UI — Rayfield Load & Window
-- ═════════════════════════════════════════════════════════════════════════════
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Zenith Hub | Entrenched",
   LoadingTitle = "Loading Zenith Hub...",
   LoadingSubtitle = "by marcus",
   ConfigurationSaving = { Enabled = false, FolderName = "ZenithHub", FileName = "Entrenched" },
   KeySystem = false,
   Keybind = Enum.KeyCode.K,
   DisableRayfieldPrompts = true,
   Discord = { Enabled = true, Invite = "AUxjT7CURQ", RememberJoins = false },
})

local UI_DRAG_BLOCK_ACTION = "ZenithUIDragBlock"
local function LockRayfieldPosition()
    task.spawn(function()
        local guiParent = GetGuiParent()
        local CASService = game:GetService("ContextActionService")

        local rf
        local started = os.clock()
        while os.clock() - started < 8 do
            rf = guiParent:FindFirstChild("Rayfield")
            if rf then break end
            task.wait(0.2)
        end
        if not rf then return end

        local function findMainWindow()
            local direct = rf:FindFirstChild("Main", true)
            if direct and direct:IsA("GuiObject") then
                return direct
            end

            local best, bestArea = nil, -1
            for _, desc in ipairs(rf:GetDescendants()) do
                if desc:IsA("GuiObject") and desc.Visible then
                    local n = string.lower(desc.Name)
                    if n:find("main") or n:find("window") or n:find("container") or n:find("holder") then
                        local area = desc.AbsoluteSize.X * desc.AbsoluteSize.Y
                        if area > bestArea then
                            best = desc
                            bestArea = area
                        end
                    end
                end
            end
            if best then return best end
            for _, desc in ipairs(rf:GetDescendants()) do
                if desc:IsA("GuiObject") and desc.Visible then
                    local area = desc.AbsoluteSize.X * desc.AbsoluteSize.Y
                    if area > bestArea then
                        best = desc
                        bestArea = area
                    end
                end
            end
            return best
        end

        local function getRootGuiObject(obj)
            local top = obj
            local parent = obj and obj.Parent
            while parent and parent ~= rf do
                if parent:IsA("GuiObject") then
                    top = parent
                end
                parent = parent.Parent
            end
            return top
        end

        local function findTopBar(root)
            if not root then return nil end
            local direct = root:FindFirstChild("Topbar", true)
            if direct and direct:IsA("GuiObject") then
                return direct
            end
            local best, bestScore = nil, -math.huge
            for _, desc in ipairs(root:GetDescendants()) do
                if desc:IsA("GuiObject") and desc.Visible then
                    local n = string.lower(desc.Name)
                    local w, h = desc.AbsoluteSize.X, desc.AbsoluteSize.Y
                    if (n:find("top") or n:find("title") or n:find("header") or n:find("bar")) and h > 0 then
                        local score = w - (h * 2)
                        if score > bestScore then
                            best = desc
                            bestScore = score
                        end
                    end
                end
            end
            return best
        end

        local function findDragInteract()
            local dragRoot = rf:FindFirstChild("Drag", true)
            if not dragRoot then return nil end
            local interact = dragRoot:FindFirstChild("Interact")
            if interact and interact:IsA("GuiObject") then
                return interact
            end
            if dragRoot:IsA("GuiObject") then
                return dragRoot
            end
            return nil
        end

        local main = getRootGuiObject(findMainWindow())
        if not main then return end
        local topBar = findTopBar(main)
        local dragInteract = findDragInteract()

        local cameraWasLocked = false
        local savedCameraType = nil
        local savedCameraCFrame = nil
        local savedCameraFocus = nil
        local savedModalEnabled = nil
        local dragInputBlocked = false
        local lockedMainPos = main.Position
        local lockedMainTopLeft = main.AbsolutePosition
        local lockedMainSize = main.AbsoluteSize
        local lockedMainAnchor = main.AnchorPoint
        local lastMainPos = main.Position
        local lastMainAbsPos = main.AbsolutePosition
        local activeDragInput = nil
        local activeDragIsTouch = false
        local dragStartPoint = nil
        local dragMoved = false
        local dragHadUiMotion = false
        local DRAG_CAPTURE_THRESHOLD = 4
        local desktopMouseDragArmed = false
        local SIZE_TRANSITION_LOCK_TIME = 0.75
        local sizeTransitionUntil = 0
        local sizeTransitionBasePos = nil
        local sizeTransitionBaseSize = nil
        local sizeTransitionBaseAnchor = nil
        local dragSourceConnections = {}
        local watchedTopBar = nil
        local watchedDragInteract = nil
        local changeSizeButton = nil
        local hideButton = nil
        local searchButton = nil
        local settingsButton = nil
        local sizeTransitionConnections = {}

        local function getCurrentCamera()
            local cam = workspace.CurrentCamera
            if cam then return cam end
            local ok, result = pcall(function()
                return workspace:FindFirstChildOfClass("Camera")
            end)
            if ok then return result end
            return nil
        end

        local function setCameraDragLock(enabled)
            if not UIS.TouchEnabled then return end
            local cam = getCurrentCamera()
            if enabled then
                if not cameraWasLocked then
                    cameraWasLocked = true
                    savedModalEnabled = UIS.ModalEnabled
                    if cam then
                        savedCameraType = cam.CameraType
                        savedCameraCFrame = cam.CFrame
                        savedCameraFocus = cam.Focus
                    end
                end
                if not dragInputBlocked then
                    pcall(function()
                        CASService:BindActionAtPriority(
                            UI_DRAG_BLOCK_ACTION,
                            function()
                                return Enum.ContextActionResult.Sink
                            end,
                            false,
                            Enum.ContextActionPriority.High.Value,
                            Enum.UserInputType.Touch
                        )
                    end)
                    dragInputBlocked = true
                end
                pcall(function() UIS.ModalEnabled = true end)
                if cam then
                    if cam.CameraType ~= Enum.CameraType.Scriptable then
                        cam.CameraType = Enum.CameraType.Scriptable
                    end
                    if not savedCameraCFrame or not savedCameraFocus then
                        savedCameraCFrame = cam.CFrame
                        savedCameraFocus = cam.Focus
                    end
                    cam.CFrame = savedCameraCFrame
                    cam.Focus = savedCameraFocus
                end
            elseif cameraWasLocked then
                cameraWasLocked = false
                pcall(function()
                    if savedModalEnabled ~= nil then
                        UIS.ModalEnabled = savedModalEnabled
                    else
                        UIS.ModalEnabled = false
                    end
                end)
                if dragInputBlocked then
                    pcall(function()
                        CASService:UnbindAction(UI_DRAG_BLOCK_ACTION)
                    end)
                    dragInputBlocked = false
                end
                local cam = getCurrentCamera()
                if cam then
                    if savedCameraType then
                        cam.CameraType = savedCameraType
                    else
                        cam.CameraType = Enum.CameraType.Custom
                    end
                end
                savedCameraType = nil
                savedCameraCFrame = nil
                savedCameraFocus = nil
                savedModalEnabled = nil
            end
        end

        local function getMousePoint()
            local ok, pos = pcall(function()
                return UIS:GetMouseLocation()
            end)
            if ok and pos then return pos end
            return nil
        end

        local function toVector2Point(point)
            if not point then return nil end
            if typeof(point) == "Vector2" then
                return point
            end
            if typeof(point) == "Vector3" then
                return Vector2.new(point.X, point.Y)
            end
            return nil
        end

        local function pointerInDragSources(point)
            if not point then return false end
            if watchedDragInteract and watchedDragInteract.Parent and IsPointInGui(watchedDragInteract, point) then
                return true
            end
            if watchedTopBar and watchedTopBar.Parent and IsPointInGui(watchedTopBar, point) then
                return true
            end
            return false
        end

        local function pointInTopbarButton(point)
            if not point then return false end
            local buttons = {changeSizeButton, hideButton, searchButton, settingsButton}
            for _, button in ipairs(buttons) do
                if button and button.Parent and IsPointInGui(button, point) then
                    return true
                end
            end
            return false
        end

        local function clearDragSourceConnections()
            for _, conn in ipairs(dragSourceConnections) do
                pcall(function()
                    conn:Disconnect()
                end)
            end
            dragSourceConnections = {}
        end

        local function clearSizeTransitionConnections()
            for _, conn in ipairs(sizeTransitionConnections) do
                pcall(function()
                    conn:Disconnect()
                end)
            end
            sizeTransitionConnections = {}
        end

        local function UDim2StrictlyEqual(a, b, scaleEps, offsetEps)
            scaleEps = scaleEps or 0.00001
            offsetEps = offsetEps or 0.01
            return math.abs(a.X.Scale - b.X.Scale) <= scaleEps
                and math.abs(a.Y.Scale - b.Y.Scale) <= scaleEps
                and math.abs(a.X.Offset - b.X.Offset) <= offsetEps
                and math.abs(a.Y.Offset - b.Y.Offset) <= offsetEps
        end

        local function captureLockedStateFromMain()
            lockedMainPos = main.Position
            lockedMainTopLeft = main.AbsolutePosition
            lockedMainSize = main.AbsoluteSize
            lockedMainAnchor = main.AnchorPoint
        end

        local function startSizeTransitionLock()
            sizeTransitionUntil = os.clock() + SIZE_TRANSITION_LOCK_TIME
            sizeTransitionBasePos = main.Position
            sizeTransitionBaseSize = main.AbsoluteSize
            sizeTransitionBaseAnchor = main.AnchorPoint
        end

        local function getSizeTransitionTarget()
            if not sizeTransitionBasePos or not sizeTransitionBaseSize or not sizeTransitionBaseAnchor then
                return nil
            end
            local size = main.AbsoluteSize
            return UDim2.new(
                sizeTransitionBasePos.X.Scale,
                sizeTransitionBasePos.X.Offset + ((size.X - sizeTransitionBaseSize.X) * sizeTransitionBaseAnchor.X),
                sizeTransitionBasePos.Y.Scale,
                sizeTransitionBasePos.Y.Offset + ((size.Y - sizeTransitionBaseSize.Y) * sizeTransitionBaseAnchor.Y)
            )
        end

        local function getLockedPositionForCurrentSize()
            local size = main.AbsoluteSize
            local sizeChanged = math.abs(size.X - lockedMainSize.X) > 0.5 or math.abs(size.Y - lockedMainSize.Y) > 0.5
            if not sizeChanged then
                return lockedMainPos, false
            end
            local parentAbs = Vector2.new(0, 0)
            local parent = main.Parent
            if parent and parent:IsA("GuiObject") then
                parentAbs = parent.AbsolutePosition
            end
            local centerX = (lockedMainTopLeft.X - parentAbs.X) + (size.X * lockedMainAnchor.X)
            local centerY = (lockedMainTopLeft.Y - parentAbs.Y) + (size.Y * lockedMainAnchor.Y)
            return UDim2.fromOffset(centerX, centerY), true
        end

        local function isTouchInputStillActive(input)
            if not input then return false end
            local state = input.UserInputState
            if state == Enum.UserInputState.End or state == Enum.UserInputState.Cancel then
                return false
            end
            local ok, touches = pcall(function()
                return UIS:GetTouches()
            end)
            if not ok or not touches then
                return true
            end
            for _, touch in ipairs(touches) do
                if touch == input then
                    return true
                end
            end
            return false
        end

        local function isActiveDragInputAlive()
            if not activeDragInput then
                return false
            end
            if activeDragIsTouch then
                return isTouchInputStillActive(activeDragInput)
            end
            return UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        end

        local function getActiveDragPoint()
            if not activeDragInput then return nil end
            if activeDragIsTouch then
                return toVector2Point(activeDragInput.Position)
            end
            return toVector2Point(getMousePoint()) or toVector2Point(activeDragInput.Position)
        end

        local function endDragGesture(startReleaseCapture)
            if startReleaseCapture and (dragMoved or dragHadUiMotion) then
                captureLockedStateFromMain()
            end
            activeDragInput = nil
            activeDragIsTouch = false
            dragStartPoint = nil
            dragMoved = false
            dragHadUiMotion = false
            setCameraDragLock(false)
        end

        local function beginDragGesture(input)
            if not input then return end
            local inputType = input.UserInputType
            if inputType ~= Enum.UserInputType.Touch and inputType ~= Enum.UserInputType.MouseButton1 then
                return
            end
            if activeDragInput and activeDragInput ~= input then
                return
            end
            local startPoint = toVector2Point(input.Position)
            if pointInTopbarButton(startPoint) then
                return
            end
            activeDragInput = input
            activeDragIsTouch = (inputType == Enum.UserInputType.Touch)
            dragStartPoint = startPoint
            dragMoved = false
            dragHadUiMotion = false
            if inputType == Enum.UserInputType.MouseButton1 then
                desktopMouseDragArmed = true
            end
            if activeDragIsTouch then
                setCameraDragLock(true)
            end
        end

        local function bindDragSource(source)
            if not source then return end
            table.insert(dragSourceConnections, source.InputBegan:Connect(function(input, processed)
                if processed then return end
                beginDragGesture(input)
            end))
        end

        local function refreshDragSourceBindings()
            if watchedTopBar == topBar and watchedDragInteract == dragInteract then
                return
            end
            clearDragSourceConnections()
            watchedTopBar = topBar
            watchedDragInteract = dragInteract
            bindDragSource(watchedTopBar)
            if watchedDragInteract and watchedDragInteract ~= watchedTopBar then
                bindDragSource(watchedDragInteract)
            end
        end

        local function refreshTopbarButtons()
            changeSizeButton = topBar and topBar:FindFirstChild("ChangeSize")
            hideButton = topBar and topBar:FindFirstChild("Hide")
            searchButton = topBar and topBar:FindFirstChild("Search")
            settingsButton = topBar and topBar:FindFirstChild("Settings")
        end

        local function refreshSizeTransitionHooks()
            clearSizeTransitionConnections()
            if changeSizeButton and changeSizeButton:IsA("GuiButton") then
                table.insert(sizeTransitionConnections, changeSizeButton.MouseButton1Down:Connect(function()
                    if activeDragInput then
                        endDragGesture(false)
                    end
                    startSizeTransitionLock()
                end))
                if changeSizeButton.Activated then
                    table.insert(sizeTransitionConnections, changeSizeButton.Activated:Connect(function()
                        startSizeTransitionLock()
                    end))
                end
            end
        end

        local function refreshRefs()
            if not main or not main.Parent then
                main = getRootGuiObject(findMainWindow())
                if not main then return false end
                lockedMainPos = main.Position
                lockedMainTopLeft = main.AbsolutePosition
                lockedMainSize = main.AbsoluteSize
                lockedMainAnchor = main.AnchorPoint
                lastMainPos = main.Position
                lastMainAbsPos = main.AbsolutePosition
            end
            if not topBar or not topBar.Parent or not topBar:IsDescendantOf(main) then
                topBar = findTopBar(main)
                refreshTopbarButtons()
                refreshSizeTransitionHooks()
            end
            if not dragInteract or not dragInteract.Parent then
                dragInteract = findDragInteract()
            end
            if topBar then
                if not changeSizeButton or changeSizeButton.Parent ~= topBar then
                    refreshTopbarButtons()
                    refreshSizeTransitionHooks()
                end
            end
            return true
        end

        local inputBeganConnection = UIS.InputBegan:Connect(function(input, processed)
            if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
            if not UIS.MouseEnabled then return end
            if processed and activeDragInput then return end
            local mp = getMousePoint() or toVector2Point(input.Position)
            if pointInTopbarButton(mp) then return end
            if mp and pointerInDragSources(mp) then
                desktopMouseDragArmed = true
                if not activeDragInput then
                    activeDragInput = input
                    activeDragIsTouch = false
                    dragStartPoint = mp
                    dragMoved = false
                    dragHadUiMotion = false
                end
            end
        end)

        local inputEndedConnection = UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                desktopMouseDragArmed = false
            end
            if activeDragInput then
                local sameInput = (input == activeDragInput)
                local matchingMouseEnd = (not activeDragIsTouch and input.UserInputType == Enum.UserInputType.MouseButton1)
                if sameInput or matchingMouseEnd then
                    endDragGesture(true)
                end
            end
        end)

        RunService.RenderStepped:Connect(function()
            if not refreshRefs() then
                clearDragSourceConnections()
                watchedTopBar = nil
                watchedDragInteract = nil
                endDragGesture(false)
                return
            end
            refreshDragSourceBindings()

            if activeDragInput and not isActiveDragInputAlive() then
                endDragGesture(true)
            end
            if desktopMouseDragArmed and not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                desktopMouseDragArmed = false
            end

            local pointerPoint = getActiveDragPoint()
            if activeDragInput and dragStartPoint and pointerPoint then
                if (pointerPoint - dragStartPoint).Magnitude >= DRAG_CAPTURE_THRESHOLD then
                    dragMoved = true
                end
            end
            if activeDragInput then
                local uiDelta = (main.AbsolutePosition - lastMainAbsPos).Magnitude
                if uiDelta > 0.01 or not UDim2NearlyEqual(main.Position, lastMainPos, 0.00001) then
                    dragHadUiMotion = true
                end
            end

            if activeDragInput and activeDragIsTouch then
                setCameraDragLock(true)
            end

            local draggingUi = activeDragInput ~= nil and (dragMoved or dragHadUiMotion)
            if draggingUi then
                sizeTransitionUntil = 0
                captureLockedStateFromMain()
            else
                if not Vector2NearlyEqual(main.AnchorPoint, lockedMainAnchor) then
                    main.AnchorPoint = lockedMainAnchor
                end
                local targetPos = nil
                local sizeAdjusted = false
                if sizeTransitionUntil > os.clock() then
                    targetPos = getSizeTransitionTarget()
                    if targetPos then
                        lockedMainPos = targetPos
                        lockedMainSize = main.AbsoluteSize
                    end
                else
                    targetPos, sizeAdjusted = getLockedPositionForCurrentSize()
                end
                if sizeAdjusted then
                    lockedMainPos = targetPos
                    lockedMainSize = main.AbsoluteSize
                end
                if targetPos and not UDim2StrictlyEqual(main.Position, targetPos, 0.00001, 0.01) then
                    main.Position = targetPos
                end
            end

            lastMainPos = main.Position
            lastMainAbsPos = main.AbsolutePosition
        end)

        rf.Destroying:Connect(function()
            clearDragSourceConnections()
            clearSizeTransitionConnections()
            if inputBeganConnection then
                pcall(function()
                    inputBeganConnection:Disconnect()
                end)
            end
            if inputEndedConnection then
                pcall(function()
                    inputEndedConnection:Disconnect()
                end)
            end
            endDragGesture(false)
        end)
    end)
end
LockRayfieldPosition()

local CAS = game:GetService("ContextActionService")
local keybindElements = {}

local function CASBind(Tab, Name, ActionID, ConfigKey, Callback)
    local keybindObj = Tab:CreateKeybind({
        Name = Name,
        CurrentKeybind = Config[ConfigKey] or "",
        HoldToInteract = false,
        Callback = function() end,
    })
    keybindElements[ConfigKey] = keybindObj
    
    task.spawn(function()
        task.wait(1.5)
        pcall(function()
            local guiParent = game:GetService("CoreGui")
            if gethui then pcall(function() guiParent = gethui() end) end
            
            for _, desc in ipairs(guiParent:GetDescendants()) do
                if desc:IsA("TextLabel") and desc.Text == Name and desc.Parent and desc.Parent:IsA("Frame") then
                    local container = desc.Parent
                    
                    if container:FindFirstChild("ClearBtn") then continue end
                    
                    local clearBtn = Instance.new("TextButton")
                    clearBtn.Name = "ClearBtn"
                    clearBtn.Size = UDim2.new(0, 24, 0, 24)
                    clearBtn.Position = UDim2.new(1, -145, 0.5, 0)
                    clearBtn.AnchorPoint = Vector2.new(1, 0.5)
                    clearBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    clearBtn.TextColor3 = Color3.fromRGB(220, 60, 60)
                    clearBtn.TextSize = 14
                    clearBtn.Font = Enum.Font.GothamBold
                    clearBtn.Text = "X"
                    clearBtn.BorderSizePixel = 0
                    clearBtn.ZIndex = 50
                    
                    local corner = Instance.new("UICorner", clearBtn)
                    corner.CornerRadius = UDim.new(0, 4)
                    
                    clearBtn.Parent = container
                    
                    clearBtn.MouseEnter:Connect(function()
                        clearBtn.BackgroundColor3 = Color3.fromRGB(70, 40, 40)
                    end)
                    clearBtn.MouseLeave:Connect(function()
                        clearBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    end)
                    
                    clearBtn.MouseButton1Click:Connect(function()
                        pcall(function() keybindObj:Set("None") end)
                    end)
                end
            end
        end)
    end)

    task.spawn(function()
        local lastKey = Config[ConfigKey] or ""

        local function getEnum(keyStr)
            if typeof(keyStr) == "EnumItem" then return keyStr end
            local ks = tostring(keyStr)
            if ks == "" or ks == "None" then return nil end
            local s, k = pcall(function() return Enum.KeyCode[ks] end)
            if s and k then return k end
            s, k = pcall(function() return Enum.UserInputType[ks] end)
            if s and k then return k end
            return nil
        end

        local function updateBind(kc)
            CAS:UnbindAction(ActionID)
            if not kc then return end
            
            CAS:BindActionAtPriority(ActionID, function(actionName, inputState, inputObject)
                if UIS:GetFocusedTextBox() then 
                    return Enum.ContextActionResult.Pass 
                end

                if inputState == Enum.UserInputState.Begin then
                    Callback(true)
                elseif inputState == Enum.UserInputState.End then
                    Callback(false)
                end
                
                if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
                    return Enum.ContextActionResult.Pass
                end
                
                return Enum.ContextActionResult.Sink
            end, false, 100000, kc)
        end

        if lastKey ~= "" and lastKey ~= nil then
            updateBind(getEnum(lastKey))
        end

        while task.wait(0.3) do
            pcall(function()
                local curKey = keybindObj.CurrentKeybind or ""
                if curKey ~= lastKey then
                    lastKey = curKey
                    Config[ConfigKey] = curKey
                    updateBind(getEnum(curKey))
                end
            end)
        end
    end)
end



-- ═════════════════════════════════════════════════════════════════════════════
--  UI — Tabs & Elements
-- ═════════════════════════════════════════════════════════════════════════════
local UI = {}
local ForceUpdates = {}
local AimFFToggle, ESPFFToggle
local AimbotTab = Window:CreateTab("Silent Aim", 4483362458)
local GunModsTab = Window:CreateTab("Gun Mods", 4483362458)
local ESPTab    = Window:CreateTab("Visuals", 4483362458)
local MiscTab   = Window:CreateTab("Misc", 4483362458)
local ConfigTab = Window:CreateTab("Config", 4483362458)

local function UpdateDistVisibility()
    local isOn = Config.Aim_Enabled
    task.spawn(function()
        task.wait(0.05)
        pcall(function()
            local guiParent = game:GetService("CoreGui")
            if gethui then pcall(function() guiParent = gethui() end) end
            local rf = guiParent:FindFirstChild("Rayfield")
            if not rf then return end
            for _, desc in ipairs(rf:GetDescendants()) do
                if desc:IsA("TextLabel") and (
                    string.find(desc.Text, "Aim Max Distance", 1, true) or
                    string.find(desc.Text, "Aim Distance Input", 1, true) or
                    string.find(desc.Text, "Hardcoded to 120 Because Of Game Patches", 1, true)
                ) and desc.Parent then
                    desc.Parent.Visible = isOn
                end
            end
        end)
    end)
end

local AimToggle = AimbotTab:CreateToggle({
   Name = "Enable Silent Aim",
   CurrentValue = Config.Aim_Enabled,
   Flag = "Aim_Enabled",
   Callback = function(Value)
       Config.Aim_Enabled = Value
       UpdateDistVisibility()
   end,
})
AimbotTab:CreateParagraph({Title = "Note", Content = "Hardcoded to 120 Because Of Game Patches"})
local AimDistSl
AimDistSl = AimbotTab:CreateSlider({
    Name = "Aim Max Distance",
    Range = {0, 120},
    Increment = 10,
    Suffix = " studs",
    CurrentValue = Config.Aim_MaxDistance,
    Flag = "Aim_MaxDistance",
    Callback = function(Value) Config.Aim_MaxDistance = Value end,
})
AimbotTab:CreateInput({
    Name = "Aim Distance Input",
    PlaceholderText = "Enter exact studs...",
    RemoveTextAfterFocusLost = true,
    Callback = function(Text)
        local v = tonumber(Text)
        if v then
            local clamped = math.clamp(v, 0, 120)
            Config.Aim_MaxDistance = clamped
            pcall(function() AimDistSl:Set(clamped) end)
        end
    end,
})
local function UpdateAltPredVisibility()
    local isOn = Config.Alt_Aim_Enabled
    task.spawn(function()
        task.wait(0.05)
        pcall(function()
            local guiParent = game:GetService("CoreGui")
            if gethui then pcall(function() guiParent = gethui() end) end
            local rf = guiParent:FindFirstChild("Rayfield")
            if not rf then return end
            for _, desc in ipairs(rf:GetDescendants()) do
                if desc:IsA("TextLabel") and (
                    string.find(desc.Text, "Enable Prediction", 1, true) or
                    string.find(desc.Text, "Prediction Value", 1, true) or
                    string.find(desc.Text, "Prediction Input", 1, true)
                ) and desc.Parent then
                    desc.Parent.Visible = isOn
                end
            end
        end)
    end)
end

ForceUpdates.Alt_Aim_Enabled = AimbotTab:CreateToggle({
    Name = "Silent Aim (WeaponModule)",
    CurrentValue = Config.Alt_Aim_Enabled,
    Flag = "Alt_Aim_Enabled",
    Callback = function(Value)
        Config.Alt_Aim_Enabled = Value
        UpdateAltPredVisibility()
    end,
})
ForceUpdates.Alt_Aim_Prediction = AimbotTab:CreateToggle({
    Name = "Enable Prediction",
    CurrentValue = Config.Alt_Aim_Prediction,
    Flag = "Alt_Aim_Prediction",
    Callback = function(Value) Config.Alt_Aim_Prediction = Value end,
})
local AltPredSl
AltPredSl = AimbotTab:CreateSlider({
    Name = "Prediction Value",
    Range = {0, 1},
    Increment = 0.05,
    Suffix = "s",
    CurrentValue = Config.Alt_Aim_PredValue,
    Flag = "Alt_Aim_PredValue",
    Callback = function(Value) Config.Alt_Aim_PredValue = Value end,
})
AimbotTab:CreateInput({
    Name = "Prediction Input",
    PlaceholderText = "Enter exact value...",
    RemoveTextAfterFocusLost = true,
    Callback = function(Text)
        local v = tonumber(Text)
        if v then
            local clamped = math.clamp(v, 0, 1)
            Config.Alt_Aim_PredValue = clamped
            pcall(function() AltPredSl:Set(clamped) end)
        end
    end,
})
ForceUpdates.Aim_ActivationMode = AimbotTab:CreateDropdown({
    Name = "Activation Mode",
    Options = {"Always On", "Toggle via Keybind", "While Key Held", "While Left Click Held", "While Right Click Held"},
    CurrentOption = Config.Aim_ActivationMode or "Toggle via Keybind",
    Flag = "Aim_ActivationMode",
    Callback = function(Options)
        local opt = Options[1]
        Config.Aim_ActivationMode = opt
        if opt == "Always On" then
            Config.Aim_Enabled = true
            AimToggle:Set(true)
        elseif opt:find("Held") or opt == "Toggle via Keybind" then
            Config.Aim_Enabled = false
            AimToggle:Set(false)
        end
    end,
})
CASBind(AimbotTab, "Silent Aim Keybind", "CAS_Aim", "Bind_Aim", function(isBegin)
    if Config.Aim_ActivationMode == "While Key Held" then
        Config.Aim_Enabled = isBegin
        AimToggle:Set(Config.Aim_Enabled)
    elseif Config.Aim_ActivationMode == "Toggle via Keybind" then
        if isBegin then AimToggle:Set(not Config.Aim_Enabled) end
    end
end)
ForceUpdates.Aim_TeamCheck = AimbotTab:CreateToggle({
   Name = "Team Check",
   CurrentValue = Config.Aim_TeamCheck,
   Flag = "Aim_TeamCheck",
   Callback = function(Value) Config.Aim_TeamCheck = Value end,
})
ForceUpdates.Aim_WallCheck = AimbotTab:CreateToggle({
   Name = "Wall Check",
   CurrentValue = Config.Aim_WallCheck,
   Flag = "Aim_WallCheck",
   Callback = function(Value) Config.Aim_WallCheck = Value end,
})
AimFFToggle = AimbotTab:CreateToggle({
   Name = "ForceField Check",
   CurrentValue = Config.Aim_FFCheck,
   Flag = "Aim_FFCheck",
   Callback = function(Value) Config.Aim_FFCheck = Value end,
})
local function UpdateMissVisibility()
    local isMiss = Config.Aim_MissEnabled
    task.spawn(function()
        task.wait(0.05)
        pcall(function()
            local guiParent = game:GetService("CoreGui")
            if gethui then pcall(function() guiParent = gethui() end) end
            local rf = guiParent:FindFirstChild("Rayfield")
            if not rf then return end
            for _, desc in ipairs(rf:GetDescendants()) do
                if desc:IsA("TextLabel") and (string.find(desc.Text, "Miss Chance %%") or string.find(desc.Text, "Miss Chance Input")) and desc.Parent then
                    desc.Parent.Visible = isMiss
                end
            end
        end)
    end)
end
ForceUpdates.Aim_MissEnabled = AimbotTab:CreateToggle({
   Name = "Enable Miss Chance",
   CurrentValue = Config.Aim_MissEnabled,
   Flag = "Aim_MissEnabled",
   Callback = function(Value)
      Config.Aim_MissEnabled = Value
      UpdateMissVisibility()
   end,
})
local MissSl
MissSl = AimbotTab:CreateSlider({ Name = "Miss Chance %", Range = {0, 100}, Increment = 1, Suffix = "%", CurrentValue = Config.Aim_MissChance, Flag = "Aim_MissChance", Callback = function(Value) Config.Aim_MissChance = Value end })
AimbotTab:CreateInput({
   Name = "Miss Chance Input",
   PlaceholderText = "Enter exact %...",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local v = tonumber(Text)
       if v then
           local clamped = math.clamp(v, 0, 100)
           Config.Aim_MissChance = clamped
           pcall(function() MissSl:Set(clamped) end)
       end
   end,
})
UpdateMissVisibility()
UpdateDistVisibility()
UpdateAltPredVisibility()
AimbotTab:CreateSection("Targeting Settings")
local function UpdateWeightVisibility()
    local isRand = (Config.TargetType == "Randomized")
    local targetNames = {
        "Randomization Weights",
        "Head Weight Chance",
        "Head Weight Input",
        "Torso Weight Chance",
        "Torso Weight Input",
        "Limbs Weight Chance",
        "Limbs Weight Input"
    }
    task.spawn(function()
        task.wait(0.05)
        pcall(function()
            local guiParent = game:GetService("CoreGui")
            if gethui then pcall(function() guiParent = gethui() end) end
            local rf = guiParent:FindFirstChild("Rayfield")
            if not rf then return end
            for _, desc in ipairs(rf:GetDescendants()) do
                if desc:IsA("TextLabel") then
                    for _, tName in ipairs(targetNames) do
                        if string.find(desc.Text, tName) and desc.Parent then
                            desc.Parent.Visible = isRand
                        end
                    end
                end
            end
        end)
    end)
end
ForceUpdates.TargetType = AimbotTab:CreateDropdown({
   Name = "Target Method",
   Options = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart", "Closest", "Randomized"},
   CurrentOption = {Config.TargetType},
   MultipleOptions = false,
   Flag = "TargetType",
   Callback = function(Options)
      Config.TargetType = Options[1]
      UpdateWeightVisibility()
   end,
})
local RandSec = AimbotTab:CreateSection("Randomization Weights")
local HeadSl, TorsoSl, LimbsSl
HeadSl  = AimbotTab:CreateSlider({ Name = "Head Weight Chance", Range = {0, 100}, Increment = 1, Suffix = "%", CurrentValue = Config.Weight_Head, Flag = "Weight_Head", Callback = function(Value) Config.Weight_Head = Value end })
AimbotTab:CreateInput({
   Name = "Head Weight Input",
   PlaceholderText = "Enter exact %...",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local v = tonumber(Text)
       if v then
           local clamped = math.clamp(v, 0, 100)
           Config.Weight_Head = clamped
           pcall(function() HeadSl:Set(clamped) end)
       end
   end,
})
TorsoSl = AimbotTab:CreateSlider({ Name = "Torso Weight Chance", Range = {0, 100}, Increment = 1, Suffix = "%", CurrentValue = Config.Weight_Torso, Flag = "Weight_Torso", Callback = function(Value) Config.Weight_Torso = Value end })
AimbotTab:CreateInput({
   Name = "Torso Weight Input",
   PlaceholderText = "Enter exact %...",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local v = tonumber(Text)
       if v then
           local clamped = math.clamp(v, 0, 100)
           Config.Weight_Torso = clamped
           pcall(function() TorsoSl:Set(clamped) end)
       end
   end,
})
LimbsSl = AimbotTab:CreateSlider({ Name = "Limbs Weight Chance", Range = {0, 100}, Increment = 1, Suffix = "%", CurrentValue = Config.Weight_Limbs, Flag = "Weight_Limbs", Callback = function(Value) Config.Weight_Limbs = Value end })
AimbotTab:CreateInput({
   Name = "Limbs Weight Input",
   PlaceholderText = "Enter exact %...",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local v = tonumber(Text)
       if v then
           local clamped = math.clamp(v, 0, 100)
           Config.Weight_Limbs = clamped
           pcall(function() LimbsSl:Set(clamped) end)
       end
   end,
})
UpdateWeightVisibility()
AimbotTab:CreateSection("Field of View")
ForceUpdates.ShowFOV = AimbotTab:CreateToggle({ Name = "Show FOV Circle", CurrentValue = Config.ShowFOV, Flag = "ShowFOV", Callback = function(Value) Config.ShowFOV = Value end })
local FOVSl
FOVSl = AimbotTab:CreateSlider({ Name = "FOV Radius", Range = {0, 2000}, Increment = 10, Suffix = "px", CurrentValue = Config.FOVRadius, Flag = "FOVRadius", Callback = function(Value) Config.FOVRadius = Value end })
AimbotTab:CreateInput({
   Name = "FOV Radius Input",
   PlaceholderText = "Enter exact radius...",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local v = tonumber(Text)
       if v then
           local clamped = math.clamp(v, 0, 2000)
           Config.FOVRadius = clamped
           pcall(function() FOVSl:Set(clamped) end)
       end
   end,
})
local FOVColorPicker = AimbotTab:CreateColorPicker({ Name = "FOV Color", Color = Config.FOVColor, Flag = "FOVColor", Callback = function(Value) Config.FOVColor = Value end })
GunModsTab:CreateSection("Recoil")
ForceUpdates.GunMod_NoRecoil = GunModsTab:CreateToggle({
    Name = "No Recoil",
    CurrentValue = Config.GunMod_NoRecoil,
    Flag = "GunMod_NoRecoil",
    Callback = function(Value) Config.GunMod_NoRecoil = Value end,
})
GunModsTab:CreateSection("Spread")
ForceUpdates.GunMod_NoSpread = GunModsTab:CreateToggle({
    Name = "No Gun Spread",
    CurrentValue = Config.GunMod_NoSpread,
    Flag = "GunMod_NoSpread",
    Callback = function(Value) Config.GunMod_NoSpread = Value end,
})
ESPTab:CreateSection("Visual Enhancements")
local ESP_Toggles = {}

local ClassNamesList = {"Rifleman", "Assault", "Support", "Medic", "Skirmisher", "Recon", "Engineer", "Flamer", "Officer"}
local function UpdateClassFilterVisibility()
    local isVis = Config.ESP_Classes
    local targetStrings = {"Class Tracking Filter", "Disable All Classes", "Enable All Classes"}
    for _, nm in ipairs(ClassNamesList) do
        table.insert(targetStrings, "Track: " .. nm)
    end
    task.spawn(function()
        task.wait(0.05)
        pcall(function()
            local guiParent = game:GetService("CoreGui")
            if gethui then pcall(function() guiParent = gethui() end) end
            local rf = guiParent:FindFirstChild("Rayfield")
            if not rf then return end
            for _, desc in ipairs(rf:GetDescendants()) do
                if desc:IsA("TextLabel") then
                    for _, targetStr in ipairs(targetStrings) do
                        if string.find(desc.Text, targetStr, 1, true) and desc.Parent then
                            desc.Parent.Visible = isVis
                        end
                    end
                end
            end
        end)
    end)
end

ESP_Toggles.ESP_Enabled = ESPTab:CreateToggle({ Name = "Enable ESP", CurrentValue = Config.ESP_Enabled, Flag = "ESP_Enabled", Callback = function(Value) Config.ESP_Enabled = Value end })
ESP_Toggles.ESP_TeamCheck = ESPTab:CreateToggle({ Name = "Team Check", CurrentValue = Config.ESP_TeamCheck, Flag = "ESP_TeamCheck", Callback = function(Value) Config.ESP_TeamCheck = Value end })
ESP_Toggles.ESP_WallCheck = ESPTab:CreateToggle({ Name = "Wall Check", CurrentValue = Config.ESP_WallCheck, Flag = "ESP_WallCheck", Callback = function(Value) Config.ESP_WallCheck = Value end })
ESP_Toggles.ESP_FFCheck = ESPTab:CreateToggle({ Name = "ForceField Check", CurrentValue = Config.ESP_FFCheck, Flag = "ESP_FFCheck", Callback = function(Value) Config.ESP_FFCheck = Value end })
ESP_Toggles.ESP_TeamColor = ESPTab:CreateToggle({ Name = "Use Team Colors", CurrentValue = Config.ESP_TeamColor, Flag = "ESP_TeamColor", Callback = function(Value) Config.ESP_TeamColor = Value end })

ESP_Toggles.ESP_Boxes = ESPTab:CreateToggle({ Name = "Show Boxes", CurrentValue = Config.ESP_Boxes, Flag = "ESP_Boxes", Callback = function(Value) Config.ESP_Boxes = Value end })
ESP_Toggles.ESP_Names = ESPTab:CreateToggle({ Name = "Show Names", CurrentValue = Config.ESP_Names, Flag = "ESP_Names", Callback = function(Value) Config.ESP_Names = Value end })
ESP_Toggles.ESP_Tools = ESPTab:CreateToggle({ Name = "Show Tools", CurrentValue = Config.ESP_Tools, Flag = "ESP_Tools", Callback = function(Value) Config.ESP_Tools = Value end })
ESP_Toggles.ESP_Classes = ESPTab:CreateToggle({ Name = "Show Classes", CurrentValue = Config.ESP_Classes, Flag = "ESP_Classes", Callback = function(Value) 
    Config.ESP_Classes = Value 
    UpdateClassFilterVisibility()
end })
ESP_Toggles.ESP_MedicMode = ESPTab:CreateToggle({ Name = "Medic Mode (Revivables)", CurrentValue = Config.ESP_MedicMode, Flag = "ESP_MedicMode", Callback = function(Value) Config.ESP_MedicMode = Value end })
ESP_Toggles.ESP_Health = ESPTab:CreateToggle({ Name = "Show Health", CurrentValue = Config.ESP_Health, Flag = "ESP_Health", Callback = function(Value) Config.ESP_Health = Value end })
ESPTab:CreateSection("Class Tracking Filter")
local ClassToggles = {}
local MasterClassBtn
local function countEnabledClasses()
    local cnt = 0
    for _, v in pairs(Config.ESP_ClassFilter) do
        if v then cnt = cnt + 1 end
    end
    return cnt
end
local function updateMasterButtonText()
    if not MasterClassBtn then return end
    if countEnabledClasses() > 0 then
        MasterClassBtn:Set("Disable All Classes")
    else
        MasterClassBtn:Set("Enable All Classes")
    end
end
MasterClassBtn = ESPTab:CreateButton({
    Name = "Disable All Classes",
    Callback = function()
        local isDisabling = (countEnabledClasses() > 0)
        for _, toggle in pairs(ClassToggles) do
            toggle:Set(not isDisabling)
        end
    end
})
for _, cName in ipairs(ClassNamesList) do
    ClassToggles[cName] = ESPTab:CreateToggle({
        Name = "Track: " .. cName,
        CurrentValue = Config.ESP_ClassFilter[cName],
        Callback = function(Value)
            Config.ESP_ClassFilter[cName] = Value
            updateMasterButtonText()
        end
    })
end
updateMasterButtonText()
UpdateClassFilterVisibility()
ESPTab:CreateSection("Typography & Health")
ForceUpdates.ESP_TextSize = ESPTab:CreateSlider({
   Name = "Text Size",
   Range = {8, 36},
   Increment = 1,
   Suffix = "px",
   CurrentValue = NormalizeESPTextSize(Config.ESP_TextSize),
   Flag = "ESP_TextSize",
   Callback = function(Value)
       Config.ESP_TextSize = NormalizeESPTextSize(Value)
   end
})
ESPTab:CreateSection("Miscellaneous Colors")
local ESPColorPicker = ESPTab:CreateColorPicker({ Name = "ESP Primary Color", Color = Config.ESP_Color, Flag = "ESP_Color", Callback = function(Value) Config.ESP_Color = Value end })
local ToolColorPicker = ESPTab:CreateColorPicker({ Name = "Tool Text Color", Color = Config.ESP_ToolColor, Flag = "ESP_ToolColor", Callback = function(Value) Config.ESP_ToolColor = Value end })
local ClassColorPicker = ESPTab:CreateColorPicker({ Name = "Class Text Color", Color = Config.ESP_ClassColor, Flag = "ESP_ClassColor", Callback = function(Value) Config.ESP_ClassColor = Value end })

MiscTab:CreateSection("Keybind Utilities")
ForceUpdates.Misc_LShiftToggle = MiscTab:CreateToggle({
   Name = "LShift Sprint Toggle",
   CurrentValue = Config.Misc_LShiftToggle,
   Flag = "Misc_LShiftToggle",
   Callback = function(Value) Config.Misc_LShiftToggle = Value end
})

MiscTab:CreateSection("Weapon Automation")
local AutoReloadTog = MiscTab:CreateToggle({ Name = "Auto Reload", CurrentValue = Config.Misc_AutoReload, Flag = "Misc_AutoReload", Callback = function(Value) Config.Misc_AutoReload = Value end })

MiscTab:CreateSection("Movement Anti-Aim")
local SpinToggle = MiscTab:CreateToggle({ Name = "Enable Spinbot", CurrentValue = Config.Misc_Spinbot, Flag = "Misc_Spinbot", Callback = function(Value) Config.Misc_Spinbot = Value end })
CASBind(MiscTab, "Spinbot Toggle", "CAS_Spin", "Bind_Spin", function(isBegin) if isBegin then SpinToggle:Set(not Config.Misc_Spinbot) end end)
local SpinSl
SpinSl = MiscTab:CreateSlider({ Name = "Spin Speed", Range = {0, 5000}, Increment = 10, Suffix = "", CurrentValue = Config.Misc_SpinSpeed, Flag = "Misc_SpinSpeed", Callback = function(Value) Config.Misc_SpinSpeed = Value end })
MiscTab:CreateInput({
   Name = "Spinbot Speed Input",
   PlaceholderText = "Enter exact speed...",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local val = tonumber(Text)
       if val then
           Config.Misc_SpinSpeed = val
           pcall(function() SpinSl:Set(val) end)
       end
   end,
})
local BhopToggle = MiscTab:CreateToggle({ Name = "Enable Bunny Hop", CurrentValue = Config.Misc_Bhop, Flag = "Misc_Bhop", Callback = function(Value) Config.Misc_Bhop = Value end })
CASBind(MiscTab, "Bunny Hop Toggle", "CAS_Bhop", "Bind_Bhop", function(isBegin) if isBegin then BhopToggle:Set(not Config.Misc_Bhop) end end)

local BhopSl
BhopSl = MiscTab:CreateSlider({ Name = "Bunny Hop Power", Range = {0, 500}, Increment = 1, Suffix = "", CurrentValue = Config.Misc_BhopPower, Flag = "Misc_BhopPower", Callback = function(Value) Config.Misc_BhopPower = Value end })
MiscTab:CreateInput({
   Name = "Bunny Hop Power Input",
   PlaceholderText = "Enter exact power...",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local val = tonumber(Text)
       if val then
           local clamped = math.clamp(val, 0, 500)
           Config.Misc_BhopPower = clamped
           pcall(function() BhopSl:Set(clamped) end)
       end
   end,
})
MiscTab:CreateSection("CFrame Speed")
local CFSToggle = MiscTab:CreateToggle({
   Name = "Enable CFrame Speed",
   CurrentValue = Config.Misc_CFSpeedEnabled,
   Flag = "Misc_CFSpeedEnabled",
   Callback = function(Value) Config.Misc_CFSpeedEnabled = Value end,
})
CASBind(MiscTab, "CFrame Speed Toggle", "CAS_CFS", "Bind_CFS", function(isBegin) if isBegin then CFSToggle:Set(not Config.Misc_CFSpeedEnabled) end end)
local CFSSlider
CFSSlider = MiscTab:CreateSlider({ Name = "CFrame Speed Amount", Range = {0, 1.5}, Increment = 0.001, Suffix = "", CurrentValue = Config.Misc_CFSpeed, Flag = "Misc_CFSpeed", Callback = function(Value) Config.Misc_CFSpeed = Value end })
MiscTab:CreateInput({
   Name = "Manual Input",
   PlaceholderText = "Enter value...",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local val = tonumber(Text)
       if val then
           local clamped = math.clamp(val, 0, 1.5)
           Config.Misc_CFSpeed = clamped
           pcall(function() CFSSlider:Set(clamped) end)
       end
   end,
})
MiscTab:CreateSection("CFrame Fly")
local CFFToggle = MiscTab:CreateToggle({
   Name = "Enable CFrame Fly",
   CurrentValue = Config.Misc_CFFlyEnabled,
   Flag = "Misc_CFFlyEnabled",
   Callback = function(Value) Config.Misc_CFFlyEnabled = Value end,
})
CASBind(MiscTab, "CFrame Fly Toggle", "CAS_CFF", "Bind_CFF", function(isBegin) if isBegin then CFFToggle:Set(not Config.Misc_CFFlyEnabled) end end)
local CFFSlider
CFFSlider = MiscTab:CreateSlider({ Name = "CFrame Fly Speed", Range = {0, 1.5}, Increment = 0.001, Suffix = "", CurrentValue = Config.Misc_CFFlySpeed, Flag = "Misc_CFFlySpeed", Callback = function(Value) Config.Misc_CFFlySpeed = Value end })
MiscTab:CreateInput({
   Name = "Manual Input",
   PlaceholderText = "Enter value...",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local val = tonumber(Text)
       if val then
           local clamped = math.clamp(val, 0, 1.5)
           Config.Misc_CFFlySpeed = clamped
           pcall(function() CFFSlider:Set(clamped) end)
       end
   end,
})

-- register all remaining element references so refreshUI never falls back to Rayfield.Flags
ForceUpdates.Aim_Enabled         = AimToggle
ForceUpdates.Aim_FFCheck         = AimFFToggle
ForceUpdates.Alt_Aim_PredValue   = AltPredSl
ForceUpdates.Aim_MissChance      = MissSl
ForceUpdates.Aim_MaxDistance     = AimDistSl
ForceUpdates.Weight_Head         = HeadSl
ForceUpdates.Weight_Torso        = TorsoSl
ForceUpdates.Weight_Limbs        = LimbsSl
ForceUpdates.FOVRadius           = FOVSl
ForceUpdates.FOVColor            = FOVColorPicker
ForceUpdates.ESP_Color           = ESPColorPicker
ForceUpdates.ESP_ToolColor       = ToolColorPicker
ForceUpdates.ESP_ClassColor      = ClassColorPicker
ForceUpdates.Misc_AutoReload     = AutoReloadTog
ForceUpdates.Misc_Spinbot        = SpinToggle
ForceUpdates.Misc_SpinSpeed      = SpinSl
ForceUpdates.Misc_Bhop           = BhopToggle
ForceUpdates.Misc_BhopPower      = BhopSl
ForceUpdates.Misc_CFSpeedEnabled = CFSToggle
ForceUpdates.Misc_CFSpeed        = CFSSlider
ForceUpdates.Misc_CFFlyEnabled   = CFFToggle
ForceUpdates.Misc_CFFlySpeed     = CFFSlider

UIS.InputBegan:Connect(function(input, gpe)
    if UIS:GetFocusedTextBox() then return end
    if input.KeyCode and input.KeyCode ~= Enum.KeyCode.Unknown and gpe then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if Config.Aim_ActivationMode == "While Left Click Held" then
            Config.Aim_Enabled = true
            if AimToggle then task.defer(function() pcall(function() AimToggle:Set(true) end) end) end
        end
    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
        if Config.Aim_ActivationMode == "While Right Click Held" then
            Config.Aim_Enabled = true
            if AimToggle then task.defer(function() pcall(function() AimToggle:Set(true) end) end) end
        end
    end
end)

UIS.InputEnded:Connect(function(input, gpe)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if Config.Aim_ActivationMode == "While Left Click Held" then
            Config.Aim_Enabled = false
            if AimToggle then task.defer(function() pcall(function() AimToggle:Set(false) end) end) end
        end
    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
        if Config.Aim_ActivationMode == "While Right Click Held" then
            Config.Aim_Enabled = false
            if AimToggle then task.defer(function() pcall(function() AimToggle:Set(false) end) end) end
        end
    end
end)

-- ═══════════ CONFIG SYSTEM ═══════════
local HttpService = game:GetService("HttpService")
local CONFIG_FOLDER = "ZenithHub/Entrenched"
if not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end

local DROPDOWN_KEYS = { TargetType = true, Aim_ActivationMode = true }

local function serializeConfig()
    local data = {}
    for key, val in pairs(Config) do
        if typeof(val) == "Color3" then
            data[key] = { _t = "c3", R = val.R, G = val.G, B = val.B }
        elseif type(val) == "table" then
            data[key] = val
        else
            data[key] = val
        end
    end
    return HttpService:JSONEncode(data)
end

local function deserializeIntoConfig(json)
    local data = HttpService:JSONDecode(json)
    
    if data.Aim_ActivationMode == nil then Config.Aim_ActivationMode = "Toggle via Keybind" end
    if data.Aim_HoldMode == nil then Config.Aim_HoldMode = false end
    if data.Misc_LShiftToggle == nil then Config.Misc_LShiftToggle = false end

    for key, val in pairs(data) do
        if Config[key] == nil then continue end
        if type(val) == "table" and val._t == "c3" then
            Config[key] = Color3.new(val.R, val.G, val.B)
        elseif key == "ESP_ClassFilter" and type(val) == "table" then
            for cName, cVal in pairs(val) do
                Config.ESP_ClassFilter[cName] = cVal
            end
        elseif type(val) == "table" and Config[key] and type(Config[key]) == "table" then
            -- Deep merge for other tables if any
            for k, v in pairs(val) do
                Config[key][k] = v
            end
        else
            Config[key] = val
        end
    end
    Config.ESP_TextSize = NormalizeESPTextSize(Config.ESP_TextSize)
end

local function getConfigList()
    local ok, files = pcall(listfiles, CONFIG_FOLDER)
    if not ok then return {} end
    local names = {}
    for _, path in ipairs(files) do
        local name = string.match(path, "([^/\\]+)%.json$")
        if name then table.insert(names, name) end
    end
    table.sort(names)
    return names
end

local function refreshUI()
    if not Rayfield or not Rayfield.Flags then return end
    Config.ESP_TextSize = NormalizeESPTextSize(Config.ESP_TextSize)
    
    -- Sync standard flags
    for key, val in pairs(Config) do
        if key == "ESP_ClassFilter" then continue end
        if string.sub(key, 1, 5) == "Bind_" then continue end
        
        -- Use specific toggle references for ESP components to force visual sync
        if ESP_Toggles[key] then
            pcall(function() ESP_Toggles[key]:Set(val) end)
        elseif ForceUpdates[key] then
            pcall(function()
                if DROPDOWN_KEYS[key] then
                    ForceUpdates[key]:Set({val})
                else
                    ForceUpdates[key]:Set(val)
                end
            end)
        else
            local flag = Rayfield.Flags[key]
            if flag then
                pcall(function()
                    if DROPDOWN_KEYS[key] then
                        flag:Set({val})
                    else
                        flag:Set(val)
                    end
                end)
            end
        end
    end
    
    -- Sync keybinds
    for key, element in pairs(keybindElements) do
        local val = Config[key] or ""
        pcall(function() element:Set(val) end)
    end
    
    -- Sync color pickers directly to Rayfield's color system
    pcall(function()
        if ForceUpdates["FOVColor"] then ForceUpdates["FOVColor"]:Set(Config.FOVColor) end
        if ForceUpdates["ESP_Color"] then ForceUpdates["ESP_Color"]:Set(Config.ESP_Color) end
        if ForceUpdates["ESP_ToolColor"] then ForceUpdates["ESP_ToolColor"]:Set(Config.ESP_ToolColor) end
        if ForceUpdates["ESP_ClassColor"] then ForceUpdates["ESP_ClassColor"]:Set(Config.ESP_ClassColor) end
    end)
    
    -- Sync Class Toggles
    if ClassToggles then
        for cName, toggle in pairs(ClassToggles) do
            pcall(function() toggle:Set(Config.ESP_ClassFilter[cName] or false) end)
        end
    end

    -- Refresh visibility of grouped elements
    pcall(UpdateWeightVisibility)
    pcall(UpdateMissVisibility)
    pcall(UpdateDistVisibility)
    pcall(UpdateAltPredVisibility)
    pcall(UpdateClassFilterVisibility)
    pcall(updateMasterButtonText)
end

local function saveConfig(name)
    pcall(function()
        writefile(CONFIG_FOLDER .. "/" .. name .. ".json", serializeConfig())
    end)
end

local function loadConfig(name)
    local path = CONFIG_FOLDER .. "/" .. name .. ".json"
    if not isfile(path) then return false end
    local ok = pcall(function()
        deserializeIntoConfig(readfile(path))
        refreshUI()
    end)
    return ok
end

local function deleteConfig(name)
    pcall(function()
        local path = CONFIG_FOLDER .. "/" .. name .. ".json"
        if isfile(path) then delfile(path) end
    end)
end

-- ═══════════ CONFIG TAB UI ═══════════
local configNameInput = ""
local selectedConfig = ""
local AUTO_LOAD_FILE = CONFIG_FOLDER .. "/_autoload.txt"

local autoLoadName = ""
pcall(function()
    if isfile(AUTO_LOAD_FILE) then
        autoLoadName = readfile(AUTO_LOAD_FILE)
    end
end)

local function formatConfigList()
    local list = getConfigList()
    if #list == 0 then return "No saved profiles" end
    return table.concat(list, ", ")
end

ConfigTab:CreateSection("Save Profile")
ConfigTab:CreateInput({
    Name = "Profile Name",
    PlaceholderText = "Enter profile name...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text) configNameInput = Text end,
})
ConfigTab:CreateButton({
    Name = "Save Current Settings",
    Callback = function()
        if configNameInput ~= "" then
            saveConfig(configNameInput)
            Rayfield:Notify({ Title = "Config Saved", Content = "Profile '" .. configNameInput .. "' saved successfully.", Duration = 3 })
            pcall(refreshConfigSlots)
        end
    end,
})

ConfigTab:CreateSection("Manage Profiles")
local SelectedLabel = ConfigTab:CreateLabel("Selected: (none)")
local AutoLoadLabel = ConfigTab:CreateLabel(autoLoadName ~= "" and ("Auto-load: " .. autoLoadName) or "No auto-load profile set")

local refreshConfigSlots -- Forward declare for button callbacks

ConfigTab:CreateInput({
    Name = "Or type profile name",
    PlaceholderText = "Type profile name...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        selectedConfig = Text
        pcall(function() SelectedLabel:Set("Selected: " .. Text) end)
    end,
})

ConfigTab:CreateButton({
    Name = "Load Profile",
    Callback = function()
        if selectedConfig ~= "" then
            if loadConfig(selectedConfig) then
                Rayfield:Notify({ Title = "Config Loaded", Content = "Profile '" .. selectedConfig .. "' applied.", Duration = 3 })
            else
                Rayfield:Notify({ Title = "Load Error", Content = "Profile '" .. selectedConfig .. "' not found.", Duration = 3 })
            end
        end
    end,
})

ConfigTab:CreateButton({
    Name = "Delete Profile",
    Callback = function()
        if selectedConfig ~= "" then
            local path = CONFIG_FOLDER .. "/" .. selectedConfig .. ".json"
            if isfile(path) then
                -- If we're deleting the auto-load config, clear the auto-load file too
                if selectedConfig == autoLoadName then
                    pcall(function() if isfile(AUTO_LOAD_FILE) then delfile(AUTO_LOAD_FILE) end end)
                    autoLoadName = ""
                    pcall(function() AutoLoadLabel:Set("No auto-load profile set") end)
                end

                deleteConfig(selectedConfig)
                Rayfield:Notify({ Title = "Config Deleted", Content = "Profile '" .. selectedConfig .. "' removed.", Duration = 3 })
                selectedConfig = ""
                pcall(function() SelectedLabel:Set("Selected: (none)") end)
                refreshConfigSlots()
            else
                Rayfield:Notify({ Title = "Not Found", Content = "No profile named '" .. selectedConfig .. "'.", Duration = 3 })
            end
        end
    end,
})

ConfigTab:CreateButton({
    Name = "Set as Auto-Load",
    Callback = function()
        if selectedConfig ~= "" then
            pcall(function() writefile(AUTO_LOAD_FILE, selectedConfig) end)
            autoLoadName = selectedConfig
            pcall(function() AutoLoadLabel:Set("Auto-load: " .. selectedConfig) end)
            Rayfield:Notify({ Title = "Auto-Load Set", Content = "'" .. selectedConfig .. "' will load on next execution.", Duration = 3 })
        end
    end,
})

ConfigTab:CreateButton({
    Name = "Clear Auto-Load",
    Callback = function()
        pcall(function() if isfile(AUTO_LOAD_FILE) then delfile(AUTO_LOAD_FILE) end end)
        autoLoadName = ""
        pcall(function() AutoLoadLabel:Set("No auto-load profile set") end)
        Rayfield:Notify({ Title = "Auto-Load Cleared", Content = "No profile will auto-load.", Duration = 3 })
    end,
})

-- Config picker: clickable buttons that fill the selection
ConfigTab:CreateSection("Saved Profiles — click to select")
local configSlotData = {}
local configSlotBtns = {}

refreshConfigSlots = function()
    local configs = getConfigList()
    configSlotData = configs
    -- Update existing button texts
    for i, btn in ipairs(configSlotBtns) do
        if i <= #configs then
            pcall(function() btn:Set(configs[i]) end)
        else
            pcall(function() btn:Set("") end)
        end
    end
    -- Create new buttons if we have more configs than slots
    for i = #configSlotBtns + 1, #configs do
        local idx = i
        configSlotBtns[idx] = ConfigTab:CreateButton({
            Name = configs[idx],
            Callback = function()
                local n = configSlotData[idx]
                if n and n ~= "" then
                    selectedConfig = n
                    pcall(function() SelectedLabel:Set("Selected: " .. n) end)
                end
            end,
        })
    end
end

-- Create initial buttons for existing configs
local initConfigs = getConfigList()
configSlotData = initConfigs
for i, name in ipairs(initConfigs) do
    local idx = i
    configSlotBtns[idx] = ConfigTab:CreateButton({
        Name = name,
        Callback = function()
            local n = configSlotData[idx]
            if n and n ~= "" then
                selectedConfig = n
                pcall(function() SelectedLabel:Set("Selected: " .. n) end)
            end
        end,
    })
end

-- Background: refresh slots if list changes
task.spawn(function()
    local lastCount = #getConfigList()
    while task.wait(2) do
        pcall(function()
            local count = #getConfigList()
            if count ~= lastCount then
                lastCount = count
                refreshConfigSlots()
            end
        end)
    end
end)

-- Auto-load config on start
if autoLoadName ~= "" then
    task.defer(function()
        task.wait(1)
        if loadConfig(autoLoadName) then
            Rayfield:Notify({ Title = "Auto-Loaded", Content = "Profile '" .. autoLoadName .. "' applied.", Duration = 3 })
        end
    end)
end


MiscTab:CreateSection("Script Options")
MiscTab:CreateButton({
   Name = "Unload Script",
   Callback = function()
      pcall(function()
          game:GetService("ContextActionService"):UnbindAction(UI_DRAG_BLOCK_ACTION)
      end)
      pcall(function()
          local cam = workspace.CurrentCamera
          if cam and cam.CameraType == Enum.CameraType.Scriptable then
              cam.CameraType = Enum.CameraType.Custom
          end
      end)
      pcall(function()
          UIS.ModalEnabled = false
      end)
      Rayfield:Destroy()
      pcall(function()
          local fovGui = GetGuiParent():FindFirstChild("ZenithFOVGui")
          if fovGui then fovGui:Destroy() end
      end)
      Config.ShowFOV = false
      Config.ESP_Enabled = false
   end,
})
-- Rayfield:LoadConfiguration() -- Disabled to prevent overwriting custom JSON config system

local isMacroHolding = false
local SprintToggleState_Macro = false

UIS.InputEnded:Connect(function(input, gameProcessed)
    if isMacroHolding then return end

    if input.KeyCode == Enum.KeyCode.LeftShift then
        if Config.Misc_LShiftToggle then
            SprintToggleState_Macro = not SprintToggleState_Macro
            
            if SprintToggleState_Macro then
                isMacroHolding = true
                task.spawn(function()
                    local VIM = game:GetService("VirtualInputManager")
                    VIM:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                end)
            else
                task.spawn(function()
                    local VIM = game:GetService("VirtualInputManager")
                    VIM:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
                end)
            end
        end
    end
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        isMacroHolding = false
    end
end)