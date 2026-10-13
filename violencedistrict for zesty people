local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-----------------------------------
-- CONFIGURATION & STATE LOGIC
-----------------------------------
local State = {
    MasterHighlight = false,
    
    Players = {
        Survivor = false,
        Killer = false
    },
    
    Objects = {
        Generator = false,
        Windows = false,
        Pallets = false,
        Gate = false,
        Hooks = false
    },
    
    Aimbot = {
        Enabled = false,
        Targets = {
            Killer = false,
            Survivor = false
        },
        WallCheck = false,
        AimPart = "Head",
        Smoothness = 30
    },

    Parry = {
        Enabled = false,
        Radius = 15,
        FaceAngle = 45,
        ShowRadiusVisualizer = false,
        ShowConeVisualizer = false
    },
    
    ShowNames = false,
    ShowDistance = false,
    ShowHealth = false,
    ShowTracers = false,
    
    VaultEnabled = false,
    VaultSpeed = 1.5,
    FlowstateEnabled = false,
    
    TpWalkEnabled = false,
    TpWalkSpeed = 0.1,
    WalkspeedMethod = "",
    
    DisableSkillCheck = false,
    AutoSkillCheck = false,
    SkillCheckMethod = "Normal",

    FOVEnabled = false,
    FOVValue = 70,

    FastVaultOnly = false,
    ShowGenProgress = false,
    SpikedWindows = false,
    FastPalletSlide = false
}

local KillerState = {
    AutoAttack   = false,
    AttackRange  = 12,
    MultipleLunge = false
}

local COLORS = {
    SURVIVOR = Color3.fromRGB(0, 85, 255),
    KILLER = Color3.fromRGB(255, 0, 0),
    GENERATOR = Color3.fromRGB(255, 255, 0),
    GENERATOR_DONE = Color3.fromRGB(0, 255, 0),
    WINDOWS = Color3.fromRGB(255, 255, 255),
    PALLETS = Color3.fromRGB(139, 69, 19),
    GATE = Color3.fromRGB(0, 255, 255),
    HOOK = Color3.fromRGB(132, 255, 169)
}

local ESP_Data = {}
local Object_ESP_Data = {}
local ActiveObjects = {}
local SkillCheckCache = {}

-----------------------------------
-- HELPERS & ESP DRAWING
-----------------------------------
local function GetRole()
    if not LocalPlayer.Team then return "Unknown" end
    local name = LocalPlayer.Team.Name
    if name == "Killer" then return "Killer" end
    if name == "Survivors" then return "Survivor" end
    return "Lobby"
end

local function GetCharacterRoot()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetGameValue(obj, name)
    if not obj then return nil end
    local attr = obj:GetAttribute(name)
    if attr ~= nil then return attr end
  
    local child = obj:FindFirstChild(name)
    if child then
        local success, val = pcall(function() return child.Value end)
        if success then return val end
    end
    return nil
end

local function clearESPData(data_table, key)
    if data_table[key] then
        if data_table[key].Billboard then data_table[key].Billboard:Destroy() end
        if data_table[key].Tracer then data_table[key].Tracer:Remove() end
        data_table[key] = nil
    end
end

local function drawESP(data_table, key, rootPart, color, linesArray)
    if not rootPart then
        clearESPData(data_table, key)
        return
    end

    if not data_table[key] then
        local bb = Instance.new("BillboardGui")
        bb.Name = "ESP_Text"
        bb.AlwaysOnTop = true
        bb.Size = UDim2.new(0, 200, 0, 50)
        bb.StudsOffset = Vector3.new(0, 3, 0)

        local txt = Instance.new("TextLabel", bb)
        txt.Size = UDim2.new(1, 0, 1, 0)
        txt.BackgroundTransparency = 1
        txt.Font = Enum.Font.RobotoMono
        txt.TextSize = 14
        txt.TextStrokeTransparency = 0

        local tracer = nil
        pcall(function()
            tracer = Drawing.new("Line")
            tracer.Thickness = 1.5
            tracer.Transparency = 1
        end)

        data_table[key] = { Billboard = bb, Text = txt, Tracer = tracer }
    end

    local esp = data_table[key]
    esp.Billboard.Parent = rootPart
    esp.Text.TextColor3 = color
    esp.Text.Text = table.concat(linesArray, "\n")
    esp.Billboard.Enabled = (#linesArray > 0)

    if esp.Tracer then
        if State.ShowTracers then
            local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            if onScreen then
                esp.Tracer.Visible = true
                esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                esp.Tracer.To = Vector2.new(pos.X, pos.Y)
                esp.Tracer.Color = color
            else
                esp.Tracer.Visible = false
            end
        else
            esp.Tracer.Visible = false
        end
    end
end

-----------------------------------
-- HIGHLIGHT FUNCTIONS
-----------------------------------
local function updatePlayerHighlight(player)
    local character = player.Character
    if not character then return end
    
    local existingHighlight = character:FindFirstChild("PlayerHighlight")
    if existingHighlight then existingHighlight:Destroy() end
  
    if not State.MasterHighlight then return end
    
    local team = player.Team
    if not team then return end
    
    if team.Name == "Survivors" and State.Players.Survivor then
        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerHighlight"
        highlight.FillColor = COLORS.SURVIVOR
        highlight.OutlineColor = COLORS.SURVIVOR
        highlight.FillTransparency = 0.6
        highlight.OutlineTransparency = 0.1
        highlight.Parent = character
    elseif team.Name == "Killer" and State.Players.Killer then
        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerHighlight"
        highlight.FillColor = COLORS.KILLER
        highlight.OutlineColor = COLORS.KILLER
        highlight.FillTransparency = 0.6
        highlight.OutlineTransparency = 0.1
        highlight.Parent = character
    end
end

local function updateObjectHighlight(instance)
    if not instance:IsA("Model") then return end
    
    -- Add to ActiveObjects list for ESP and real-time polling
    if string.find(instance.Name, "Generator") or instance.Name == "Window" or instance.Name == "Pallet" or instance.Name == "Palletwrong" or instance.Name == "Gate" or instance.Name == "Hook" then
        if not table.find(ActiveObjects, instance) then
            table.insert(ActiveObjects, instance)
        end
    end
    
    if string.find(instance.Name, "Generator") then
        local existingHighlight = instance:FindFirstChild("GenHighlight")
        if not State.MasterHighlight or not State.Objects.Generator then
            if existingHighlight then existingHighlight:Destroy() end
            clearESPData(Object_ESP_Data, instance)
        else
            local percent = GetGameValue(instance, "RepairProgress") or GetGameValue(instance, "Progress") or 0
            local targetColor = (percent >= 100) and COLORS.GENERATOR_DONE or COLORS.GENERATOR
             
            if not existingHighlight then
                local highlight = Instance.new("Highlight")
                highlight.Name = "GenHighlight"
                highlight.FillColor = targetColor
                highlight.OutlineColor = targetColor
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = instance
            else
                existingHighlight.FillColor = targetColor
                existingHighlight.OutlineColor = targetColor
            end
        end
    end

    if instance.Name == "Window" then
        local bottomPart = instance:FindFirstChild("Bottom")
        local highlightOnModel = instance:FindFirstChild("WindowHighlight")
        local highlightOnBottom = bottomPart and bottomPart:FindFirstChild("WindowHighlight")

        if not State.MasterHighlight or not State.Objects.Windows then
            if highlightOnModel then highlightOnModel:Destroy() end
            if highlightOnBottom then highlightOnBottom:Destroy() end
            clearESPData(Object_ESP_Data, instance)
        else
            if highlightOnModel then highlightOnModel:Destroy() end
            if bottomPart and not highlightOnBottom then
                local highlight = Instance.new("Highlight")
                highlight.Name = "WindowHighlight"
                highlight.FillColor = COLORS.WINDOWS
                highlight.OutlineColor = COLORS.WINDOWS
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Adornee = bottomPart
                highlight.Parent = bottomPart
            end
        end
    end

    if instance.Name == "Palletwrong" or instance.Name == "Pallet" then
        local existingHighlight = instance:FindFirstChild("PalletHighlight")
        if not State.MasterHighlight or not State.Objects.Pallets then
            if existingHighlight then existingHighlight:Destroy() end
            clearESPData(Object_ESP_Data, instance)
        else
            if not existingHighlight then
                local highlight = Instance.new("Highlight")
                highlight.Name = "PalletHighlight"
                highlight.FillColor = COLORS.PALLETS
                highlight.OutlineColor = COLORS.PALLETS
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = instance
            end
        end
    end

    if instance.Name == "Gate" then
        local existingHighlight = instance:FindFirstChild("GateHighlight")
        if not State.MasterHighlight or not State.Objects.Gate then
            if existingHighlight then existingHighlight:Destroy() end
            clearESPData(Object_ESP_Data, instance)
        else
            if not existingHighlight then
                local highlight = Instance.new("Highlight")
                highlight.Name = "GateHighlight"
                highlight.FillColor = COLORS.GATE
                highlight.OutlineColor = COLORS.GATE
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = instance
            end
        end
    end

    if instance.Name == "Hook" then
        local existingHighlight = instance:FindFirstChild("HookHighlight")
        if not State.MasterHighlight or not State.Objects.Hooks then
            if existingHighlight then existingHighlight:Destroy() end
            clearESPData(Object_ESP_Data, instance)
        else
            if not existingHighlight then
                local highlight = Instance.new("Highlight")
                highlight.Name = "HookHighlight"
                highlight.FillColor = COLORS.HOOK
                highlight.OutlineColor = COLORS.HOOK
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = instance
            end
        end
    end
end

-----------------------------------
-- SKILL CHECK BYPASS LOGIC
-----------------------------------
local function handleSkillCheckInstance(instance)
    if instance.Name == "Skillcheck-gen" or instance.Name == "Skillcheck-player" then
        if State.DisableSkillCheck then
            local alreadyCached = false
            for _, cached in ipairs(SkillCheckCache) do
                if cached.Instance == instance then
                    alreadyCached = true
                    break
                end
            end
            
            if not alreadyCached then
                table.insert(SkillCheckCache, {
                    Instance = instance,
                    OriginalParent = instance.Parent
                })
                instance.Parent = nil
            end
        end
    end
end

local function setSkillCheckBypass(enabled)
    State.DisableSkillCheck = enabled
    if enabled then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            handleSkillCheckInstance(obj)
        end
    else
        for _, cached in ipairs(SkillCheckCache) do
            pcall(function()
                if cached.Instance and cached.OriginalParent then
                    cached.Instance.Parent = cached.OriginalParent
                end
            end)
        end
        table.clear(SkillCheckCache)
    end
end

-----------------------------------
-- AUTO PERFECT SKILL CHECK LOGIC
-----------------------------------
local TouchID = 8822
local ActionPath = "Survivor-mob.Controls.action.check"
local SkillCheckHeartbeat = nil
local SkillCheckVisibility = nil
local GoalRotationConnection = nil
local CurrentCheckUI = nil

local function GetActionTarget()
    local current = PlayerGui
    for segment in string.gmatch(ActionPath, "[^%.]+") do 
        current = current and current:FindFirstChild(segment) 
    end
    return current
end

local function TriggerSkillCheck()
    local b = GetActionTarget()
    if b and b:IsA("GuiObject") then
        local p, s, i = b.AbsolutePosition, b.AbsoluteSize, GuiService:GetGuiInset()
        local cx, cy = p.X + (s.X/2) + i.X, p.Y + (s.Y/2) + i.Y
        pcall(function() 
            VirtualInputManager:SendTouchEvent(TouchID, 0, cx, cy) 
            task.wait(0.01) 
            VirtualInputManager:SendTouchEvent(TouchID, 2, cx, cy) 
        end)
    else
        pcall(function()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.01)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end)
    end
end

local function setupSkillCheckListeners(check)
    if CurrentCheckUI == check then return end
    CurrentCheckUI = check
    
    local line = check:WaitForChild("Line", 5)
    local goal = check:WaitForChild("Goal", 5)
    if not line or not goal then return end
    
    if SkillCheckVisibility then SkillCheckVisibility:Disconnect() end
    SkillCheckVisibility = check:GetPropertyChangedSignal("Visible"):Connect(function()
        if State.AutoSkillCheck and LocalPlayer.Team and LocalPlayer.Team.Name == "Survivors" and check.Visible then

            if SkillCheckHeartbeat then SkillCheckHeartbeat:Disconnect() SkillCheckHeartbeat = nil end
            if GoalRotationConnection then GoalRotationConnection:Disconnect() GoalRotationConnection = nil end

            local triggeredThisCheck = false

-- ═════════════════════════════════════════════════════════════════════════════
--  Instant Skill Check
-- ═════════════════════════════════════════════════════════════════════════════
            if State.SkillCheckMethod == "Instant" then
                local lastTrigger = 0
                local COOLDOWN = 0.1

                SkillCheckHeartbeat = RunService.Heartbeat:Connect(function()
                    if not State.AutoSkillCheck or not check.Visible then
                        if SkillCheckHeartbeat then SkillCheckHeartbeat:Disconnect() SkillCheckHeartbeat = nil end
                        return
                    end

                    goal.Rotation = line.Rotation - 108

                    if (os.clock() - lastTrigger) >= COOLDOWN then
                        local lr, gr = line.Rotation % 360, goal.Rotation % 360
                        local ss, se = (gr + 101) % 360, (gr + 115) % 360
                        if (ss > se and (lr >= ss or lr <= se)) or (lr >= ss and lr <= se) then
                            lastTrigger = os.clock()
                            TriggerSkillCheck()
                        end
                    end
                end)

-- ═════════════════════════════════════════════════════════════════════════════
--  Normal Skill Check
-- ═════════════════════════════════════════════════════════════════════════════
            else
                GoalRotationConnection = goal:GetPropertyChangedSignal("Rotation"):Connect(function()
                    triggeredThisCheck = false
                end)

                SkillCheckHeartbeat = RunService.Heartbeat:Connect(function()
                    if not State.AutoSkillCheck or not check.Visible then
                        if SkillCheckHeartbeat then SkillCheckHeartbeat:Disconnect() SkillCheckHeartbeat = nil end
                        if GoalRotationConnection then GoalRotationConnection:Disconnect() GoalRotationConnection = nil end
                        return
                    end

                    if not triggeredThisCheck then
                        local lr, gr = line.Rotation % 360, goal.Rotation % 360
                        local ss, se = (gr + 101) % 360, (gr + 115) % 360
                        if (ss > se and (lr >= ss or lr <= se)) or (lr >= ss and lr <= se) then
                            triggeredThisCheck = true
                            TriggerSkillCheck()
                        end
                    end
                end)
            end
        else
            -- Clean up both loops when the skill check UI disappears
            if SkillCheckHeartbeat then SkillCheckHeartbeat:Disconnect() SkillCheckHeartbeat = nil end
            if GoalRotationConnection then GoalRotationConnection:Disconnect() GoalRotationConnection = nil end
        end
    end)
end

PlayerGui.DescendantAdded:Connect(function(descendant)
    if descendant.Name == "Check" and descendant.Parent and descendant.Parent.Name == "SkillCheckPromptGui" then
        setupSkillCheckListeners(descendant)
    end
end)

local existingPrompt = PlayerGui:FindFirstChild("SkillCheckPromptGui")
if existingPrompt then
    local check = existingPrompt:FindFirstChild("Check")
    if check then setupSkillCheckListeners(check) end
end

-----------------------------------
-- AIMBOT LOGIC
-----------------------------------
local aimingDown = false
local aimConn = nil
local attributeConn = nil

local function isAlive(char)
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    return true
end

local function isValidAimTarget(plr)
    if plr == LocalPlayer or not plr.Team then return false end
    
    if State.Aimbot.Targets.Killer and plr.Team.Name == "Killer" then
        return true
    end

    if State.Aimbot.Targets.Survivor and plr.Team.Name == "Survivors" then
        local char = plr.Character
        if not char then return false end

        if char:GetAttribute("Knocked")   == true then return false end
        if char:GetAttribute("IsHooked")  == true then return false end
        if char:GetAttribute("IsCarried") == true then return false end
        
        return true
    end
    return false
end

local function getAimPart(char)
    local preferred = State.Aimbot.AimPart
    if preferred == "Head" then
        return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    elseif preferred == "HumanoidRootPart" then
        return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("Head")
    end
    return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function isVisible(aimPart)
    if not State.Aimbot.WallCheck then return true end
    local myChar = LocalPlayer.Character
    local cam = workspace.CurrentCamera
    if not myChar or not cam then return false end

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {myChar, aimPart.Parent}

    local origin = cam.CFrame.Position
    local direction = aimPart.Position - origin
    local result = workspace:Raycast(origin, direction, params)
    
    return result == nil
end

local function findAimTarget()
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end

    local bestPart = nil
    local bestDist = math.huge
    local currentPlayers = Players:GetPlayers()
    
    for i = 1, #currentPlayers do
        local plr = currentPlayers[i]
        if isValidAimTarget(plr) then
            local char = plr.Character
            if char and isAlive(char) then
                local aimPart = getAimPart(char)
                if not aimPart then continue end
                if not isVisible(aimPart) then continue end

                local dist = (aimPart.Position - myHRP.Position).Magnitude
                if dist < bestDist then
                    bestPart = aimPart
                    bestDist = dist
                end
            end
        end
    end
    return bestPart
end

local function stopAim()
    if aimConn then
        aimConn:Disconnect()
        aimConn = nil
    end
end

local function startAim()
    if aimConn then return end
    aimConn = RunService.RenderStepped:Connect(function(dt)
        if not State.Aimbot.Enabled or not aimingDown then 
            stopAim()
            return 
        end

        local myChar = LocalPlayer.Character
        if not myChar then return end
        
        local hasWeapon = myChar:FindFirstChild("Twist of Fate") or myChar:FindFirstChild("Flashlight")
        if not hasWeapon then return end

        local target = findAimTarget()
        if not target then return end

        local cam = workspace.CurrentCamera
        if not cam then return end
        
        local camPos = cam.CFrame.Position
        local myAimOrigin = myChar:FindFirstChild("Head") or myChar:FindFirstChild("HumanoidRootPart")
        
        local desiredCFrame
        if myAimOrigin then
            local fireDirection = (target.Position - myAimOrigin.Position).Unit
            desiredCFrame = CFrame.lookAt(camPos, camPos + fireDirection)
        else
            desiredCFrame = CFrame.lookAt(camPos, target.Position)
        end

        if State.Aimbot.Smoothness >= 30 then
            cam.CFrame = desiredCFrame
        else
            local alpha = 1 - math.exp(-State.Aimbot.Smoothness * dt * 3)
            cam.CFrame = cam.CFrame:Lerp(desiredCFrame, alpha)
        end
    end)
end

local function setupAimingDetection(char)
    if not char then return end
    if attributeConn then attributeConn:Disconnect() end
    
    attributeConn = char:GetAttributeChangedSignal("Aiming"):Connect(function()
        aimingDown = char:GetAttribute("Aiming") == true
        if aimingDown then startAim() else stopAim() end
    end)
    
    aimingDown = char:GetAttribute("Aiming") == true
    if aimingDown then startAim() else stopAim() end
end

-----------------------------------
-- CORE LOOP & CONNECTIONS
-----------------------------------
local function refreshAllHighlights()
    for _, obj in ipairs(Workspace:GetDescendants()) do updateObjectHighlight(obj) end
    for _, player in ipairs(Players:GetPlayers()) do updatePlayerHighlight(player) end
end

Workspace.DescendantAdded:Connect(function(obj)
    handleSkillCheckInstance(obj)
    task.wait(0.1)
    updateObjectHighlight(obj)
end)

local function setupPlayer(player)
    player.CharacterAdded:Connect(function(char)
        task.wait(0.1) 
        updatePlayerHighlight(player)
        
        if player == LocalPlayer then
            aimingDown = false
            stopAim()
            char:WaitForChild("HumanoidRootPart", 5)
            setupAimingDetection(char)
        end
    end)
    player:GetPropertyChangedSignal("Team"):Connect(function() updatePlayerHighlight(player) end)
    
    if player.Character then 
        updatePlayerHighlight(player) 
        if player == LocalPlayer then
            setupAimingDetection(player.Character)
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do setupPlayer(player) end
Players.PlayerAdded:Connect(setupPlayer)

Players.PlayerRemoving:Connect(function(player)
    clearESPData(ESP_Data, player)
end)

RunService.RenderStepped:Connect(function()
    -- 1. Player ESP Loop
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local char = player.Character
        local root = char and (char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart"))
        local hum = char and char:FindFirstChildWhichIsA("Humanoid")
        
        local teamValid = false
        local color = Color3.new(1, 1, 1)
        
        if player.Team then
            if player.Team.Name == "Survivors" and State.Players.Survivor then
                teamValid = true
                color = COLORS.SURVIVOR
            elseif player.Team.Name == "Killer" and State.Players.Killer then
                teamValid = true
                color = COLORS.KILLER
            end
        end
        
        if State.MasterHighlight and teamValid and root and hum and hum.Health > 0 then
            local lines = {}
            if State.ShowNames then table.insert(lines, player.Name) end
            if State.ShowDistance then 
                local actRoot = char:FindFirstChild("HumanoidRootPart") or root
                local dist = math.floor((Camera.CFrame.Position - actRoot.Position).Magnitude)
                table.insert(lines, "[" .. dist .. "s]")
            end
            if State.ShowHealth then
                table.insert(lines, "HP: " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth))
            end
            drawESP(ESP_Data, player, root, color, lines)
        else
            clearESPData(ESP_Data, player)
        end
    end

    -- 2. Objects ESP Loop
    for i = #ActiveObjects, 1, -1 do
        local obj = ActiveObjects[i]
        if not obj or not obj.Parent or not obj:IsDescendantOf(Workspace) then
            clearESPData(Object_ESP_Data, obj)
            table.remove(ActiveObjects, i)
            continue
        end

        local isValid = false
        local color = Color3.new(1,1,1)
        local root = nil
        local nameText = obj.Name
        local progressText = nil

        if string.find(obj.Name, "Generator") then
            isValid = State.MasterHighlight and State.Objects.Generator
            root = obj:FindFirstChild("HitBox") or obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
            local percent = GetGameValue(obj, "RepairProgress") or GetGameValue(obj, "Progress") or 0
            local isDone = percent >= 100
            color = isDone and COLORS.GENERATOR_DONE or COLORS.GENERATOR
            nameText = "Generator"
        
            if State.ShowGenProgress then
                progressText = "Progress: " .. math.floor(percent) .. "%"
            end

            -- Apply Real-Time Highlight Color Update
            local hl = obj:FindFirstChild("GenHighlight")
            if hl then
                hl.FillColor = color
                hl.OutlineColor = color
            end
        elseif obj.Name == "Window" then
            isValid = State.MasterHighlight and State.Objects.Windows
            root = obj:FindFirstChild("Bottom") or obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
            color = COLORS.WINDOWS
            nameText = "Window"
        elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then
            isValid = State.MasterHighlight and State.Objects.Pallets
            root = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
            color = COLORS.PALLETS
            nameText = "Pallet"
        elseif obj.Name == "Gate" then
            isValid = State.MasterHighlight and State.Objects.Gate
            root = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
            color = COLORS.GATE
            nameText = "Gate"
        elseif obj.Name == "Hook" then
            isValid = State.MasterHighlight and State.Objects.Hooks
            root = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
            color = COLORS.HOOK
            nameText = "Hook"
        end

        if isValid and root then
            local lines = {}
            if State.ShowNames then table.insert(lines, nameText) end
            if State.ShowDistance then
                local dist = math.floor((Camera.CFrame.Position - root.Position).Magnitude)
                table.insert(lines, "[" .. dist .. "s]")
            end
            if progressText then
                table.insert(lines, progressText)
            end
            drawESP(Object_ESP_Data, obj, root, color, lines)
        else
            clearESPData(Object_ESP_Data, obj)
        end
    end
end)

-----------------------------------
-- VAULTING FUNCTIONS
-----------------------------------
local function applyVaultSpeed()
    local char = LocalPlayer.Character
    if not char then return end
    
    if State.VaultEnabled then
        char:SetAttribute("vaultspeed", State.VaultSpeed)
    else
        char:SetAttribute("vaultspeed", 1) 
    end
    
    if State.FlowstateEnabled then
        char:SetAttribute("Flowstate", true)
    else
        char:SetAttribute("Flowstate", false)
    end
end

LocalPlayer.CharacterAdded:Connect(function() 
    task.wait(0.5) 
    applyVaultSpeed() 
end)

local timer = 0
RunService.Heartbeat:Connect(function(dt)
    timer = timer + dt
    if timer >= 2 then
        timer = 0
        applyVaultSpeed()
    end
end)

-- ═════════════════════════════════════════════════════════════════════════════
--  Fast Vault Animation Only
-- ═════════════════════════════════════════════════════════════════════════════
local _afvInstalled = false
local function installFastVaultHooks()
    if _afvInstalled then return end
    _afvInstalled = true

    local ok, SurvivorActions, AnimCtrl = pcall(function()
        local Survivors = ReplicatedStorage.Modules.Survivors
        return require(Survivors.SurvivorActions), require(Survivors.SurvivorAnimationsController)
    end)
    if not ok then return end

    local origStartVault = SurvivorActions.startVault
    SurvivorActions.startVault = function(self, vaultPoint)
        local og = self.getSprintFlag
        if State.FastVaultOnly then
            self.getSprintFlag = function() return true end
        end
        origStartVault(self, vaultPoint)
        self.getSprintFlag = og
    end

    local origVault = AnimCtrl._onVaultAnimation
    AnimCtrl._onVaultAnimation = function(self, vaultPoint, sprint)
        if not State.FastVaultOnly then
            return origVault(self, vaultPoint, sprint)
        end
        self._isFacingStraightEnough = function() return true end
        local root = self.character and self.character:FindFirstChild("HumanoidRootPart")
        if root and root.Velocity.Magnitude < 15.25 then
            root.Velocity = root.CFrame.LookVector * 20
        end
        return origVault(self, vaultPoint, true)
    end

    local origStartSlide = SurvivorActions.startPalletSlide
    SurvivorActions.startPalletSlide = function(self, slidePoint)
        local og = self.getSprintFlag
        if State.FastPalletSlide then
            self.getSprintFlag = function() return true end
        end
        origStartSlide(self, slidePoint)
        self.getSprintFlag = og
    end

    local origSlide = AnimCtrl._onPalletSlide
    AnimCtrl._onPalletSlide = function(self, slidePoint, sprint)
        if not State.FastPalletSlide then
            return origSlide(self, slidePoint, sprint)
        end
        return origSlide(self, slidePoint, true)
    end
end

-- ═════════════════════════════════════════════════════════════════════════════
--  Vault On Spiked Windows
-- ═════════════════════════════════════════════════════════════════════════════
local spikeLog = {}

local function logWindow(window)
    if spikeLog[window] then return end
    local log = { wasBlocked = CollectionService:HasTag(window, "Blocked"), parts = {} }
    for _, part in ipairs(window:GetDescendants()) do
        if part:IsA("BasePart") then
            local n = part.Name:lower()
            if n:find("spike") or n:find("barb") or n:find("wire") or n:find("thorn") then
                log.parts[part] = part.CanCollide
            end
        end
    end
    spikeLog[window] = log
end

local function stripWindow(window)
    if not window or not window.Parent then return end
    logWindow(window)
    CollectionService:RemoveTag(window, "Blocked")
    for part in pairs(spikeLog[window].parts) do
        if part and part.Parent then
            part.CanCollide = false
        end
    end
end

local function restoreWindow(window)
    local log = spikeLog[window]
    if not log then return end
    if log.wasBlocked and window.Parent then
        CollectionService:AddTag(window, "Blocked")
    end
    for part, original in pairs(log.parts) do
        if part and part.Parent then
            part.CanCollide = original
        end
    end
    spikeLog[window] = nil
end

local function restoreAllSpiked()
    for window in pairs(spikeLog) do
        pcall(restoreWindow, window)
    end
end

local function sweepSpikedWindows()
    for _, w in ipairs(CollectionService:GetTagged("Blocked")) do
        stripWindow(w)
    end
end

local _spikedInstalled = false
local function installSpikedWindowsListener()
    if _spikedInstalled then return end
    _spikedInstalled = true
    CollectionService:GetInstanceAddedSignal("Blocked"):Connect(function(instance)
        if not State.SpikedWindows then return end
        stripWindow(instance)
    end)
end

--------------------------------------------------------------
-- WALKSPEED LOGIC
--------------------------------------------------------------
local tpwalkConnection = nil
local function updateWalkspeed()
    if tpwalkConnection then
        tpwalkConnection:Disconnect()
        tpwalkConnection = nil
    end

    local character = LocalPlayer.Character
    if character then
        character:SetAttribute("speedboost", 1)
    end

    if not State.TpWalkEnabled then return end
    if State.WalkspeedMethod == "" then return end

if State.WalkspeedMethod == "Attribute" then
    local char = LocalPlayer.Character
    if char then
        char:SetAttribute("speedboost", 1 + State.TpWalkSpeed)
        tpwalkConnection = char:GetAttributeChangedSignal("speedboost"):Connect(function()
            if State.TpWalkEnabled and State.WalkspeedMethod == "Attribute" then
                char:SetAttribute("speedboost", 1 + State.TpWalkSpeed)
            end
        end)
    end
    else
        tpwalkConnection = RunService.Heartbeat:Connect(function(delta)
            local char = LocalPlayer.Character
            if not char then return end
            local humanoid = char:FindFirstChildWhichIsA("Humanoid")
            if not humanoid or not humanoid.Parent then return end
            if humanoid.MoveDirection.Magnitude > 0 then
                char:TranslateBy(humanoid.MoveDirection * State.TpWalkSpeed * delta * 10)
            end
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if State.TpWalkEnabled and State.WalkspeedMethod == "Attribute" then
        updateWalkspeed()
    end
end)

-----------------------------------
-- ANTIFLING LOGIC
-----------------------------------
local antiflingConnection = nil
local function enableAntiFling()
    if not antiflingConnection then
        antiflingConnection = RunService.Stepped:Connect(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    for _, v in ipairs(player.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)
    end
end

-----------------------------------
-- FOV LOGIC
-----------------------------------
local fovConnection = nil
local function updateFOV()
    if fovConnection then
        fovConnection:Disconnect()
        fovConnection = nil
    end
    if State.FOVEnabled then
        fovConnection = RunService.RenderStepped:Connect(function()
            local cam = Workspace.CurrentCamera
            if cam then
                cam.FieldOfView = State.FOVValue
            end
        end)
    else
        local cam = Workspace.CurrentCamera
        if cam then
            cam.FieldOfView = 70
        end
    end
end

-----------------------------------
-- KILLER LOGIC
-----------------------------------
local LastAutoAttackTime = 0
local function AutoAttack()
    if not KillerState.AutoAttack then return end
    if GetRole() ~= "Killer" then return end
    if tick() - LastAutoAttackTime < 0.3 then return end

    local root = GetCharacterRoot()
    if not root then return end

    -- find the CLOSEST valid target instead of just the first one in the list
    local closestRoot = nil
    local closestDist = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local targetRoot = char:FindFirstChild("HumanoidRootPart")
            if targetRoot
                and isAlive(char)
                and char:GetAttribute("Knocked")   ~= true
                and char:GetAttribute("IsCarried") ~= true
                and char:GetAttribute("IsHooked")  ~= true
            then
                local dist = (targetRoot.Position - root.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestRoot = targetRoot
                end
            end
        end
    end

    if closestRoot and closestDist <= KillerState.AttackRange then
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes then
                local attacks = remotes:FindFirstChild("Attacks")
                if attacks then
                    local basicAttack = attacks:FindFirstChild("BasicAttack")
                    if basicAttack then
                        basicAttack:FireServer(false)
                        LastAutoAttackTime = tick()
                    end
                end
            end
        end)
    end
end

local LastMultipleLungeTime = 0
local function MultipleLunge()
    if not KillerState.MultipleLunge then return end
    if GetRole() ~= "Killer" then return end
    if tick() - LastMultipleLungeTime < 0.5 then return end
    LastMultipleLungeTime = tick()

    -- fires TWO extra attacks rapidly after player's own input (instant kill)
    task.delay(0.05, function()
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if not remotes then return end
            local attacks = remotes:FindFirstChild("Attacks")
            if not attacks then return end
            local basicAttack = attacks:FindFirstChild("BasicAttack")
            if basicAttack then
                basicAttack:FireServer(false)
                task.wait(0.05)
                basicAttack:FireServer(false)
            end
        end)
    end)
end

-- Hook MultipleLunge to the game's actual attack button (Controls > attack inside PlayerGui)
-- This way it ONLY fires when the player presses the real attack button, nothing else
-- for mobile
local currentAttackBtn = nil
local function connectMultipleLungeToAttackBtn(btn)
    if currentAttackBtn == btn then return end
    currentAttackBtn = btn
    btn.MouseButton1Click:Connect(function()
        MultipleLunge()
    end)
end

local function findAttackBtn()
    local pg = LocalPlayer.PlayerGui
    for _, gui in ipairs(pg:GetChildren()) do
        if gui:IsA("ScreenGui") then
            local controls = gui:FindFirstChild("Controls")
            if controls then
                local attack = controls:FindFirstChild("attack")
                if attack then return attack end
            end
        end
    end
    return nil
end

-- Try right away, and keep listening so a respawned/recreated attack button gets rehooked too
local initialAttackBtn = findAttackBtn()
if initialAttackBtn then
    connectMultipleLungeToAttackBtn(initialAttackBtn)
end

LocalPlayer.PlayerGui.DescendantAdded:Connect(function(desc)
    if desc.Name == "attack" then
        task.wait()
        connectMultipleLungeToAttackBtn(desc)
    end
end)

-- for pc compatibility
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if GetRole() == "Killer" then
            MultipleLunge()
        end
    end
end)

RunService.Heartbeat:Connect(function()
    AutoAttack()
end)

-----------------------------------
-- WIND UI IMPLEMENTATION & ANTIKICK
-----------------------------------
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
shared.WindUI = WindUI

local function initAntiKick()
    if not hookmetamethod then 
        WindUI:Notify({
            Title = "Incompatible Exploit",
            Content = "Your exploit does not support Antikick",
            Duration = 3
        })
        return
    end
    local oldhmmi
    local oldhmmnc
    local oldKickFunction
    if hookfunction then
        oldKickFunction = hookfunction(LocalPlayer.Kick, function() end)
    end
    
    oldhmmi = hookmetamethod(game, "__index", function(self, method)
        if self == LocalPlayer and method:lower() == "kick" then
            return error("Expected ':' not '.' calling member function Kick", 2)
        end
        return oldhmmi(self, method)
    end)
    oldhmmnc = hookmetamethod(game, "__namecall", function(self, ...)
        if self == LocalPlayer and getnamecallmethod():lower() == "kick" then
            return
        end
        return oldhmmnc(self, ...)
    end)
    WindUI:Notify({
        Title = "Success",
        Content = "Antikick Is Running",
        Duration = 2
    })
end

initAntiKick()

-- ==========================================
-- COMBAT: AUTO PARRY LOGIC
-- ==========================================
local AttackAnimations = {
    ["122812055447896"] = "Veil lunge",
    ["133963973694098"] = "Mayers Basic",
    ["117042998468241"] = "Mayers lunge",
    ["135002183282873"] = "cure lunge",
    ["121216847022485"] = "cure Basic",
    ["132817836308238"] = "Jeff Basic",
    ["129784271201071"] = "Jeff lunge",
    ["82666958311998"] = "Jeff Frenzy",
    ["78432063483146"] = "Abyssal Basic",
    ["118907603246885"] = "Abyssal lunge",
    ["139369275981139"] = "Jason Basic",
    ["110355011987939"] = "Jason lunge",
    ["111920872708571"] = "Masked Basic",
    ["105374834496520"] = "Masked lunge",
    ["138720291317243"] = "Masked Tony",
    ["106871536134254"] = "Masked Alex",
    ["130593238885843"] = "Masked Cobra",
    ["115244153053858"] = "Masked Cobra lunge",
    ["74968262036854"] = "Hidden Basic",
    ["113255068724446"] = "Hidden lunge",
    ["98163597193511"] = "Hidden S1",
}

local ParryClientModule = require(ReplicatedStorage:WaitForChild("Modules", 10):WaitForChild("Items", 10):WaitForChild("ParryClient", 10))
local parryClient = nil
local HookedParryCharacters = {}
local FacingCones = {}
local RadiusRing = nil
local ConeLength = 15

local function FindParryClient()
    for _, obj in ipairs(getgc(true)) do
        if type(obj) == "table" and getmetatable(obj) == ParryClientModule then
            return obj
        end
    end
    return nil
end

task.spawn(function()
    while true do
        local found = FindParryClient()
        if found then
            parryClient = found
        end
        task.wait(1)
    end
end)

local function IsParryOnCooldown()
    return not parryClient or parryClient.isParryOnCooldown or parryClient.isParryResolving
end

local function isParryBlocked()
    local char = LocalPlayer.Character
    if not char then return true end
    if char:GetAttribute("Knocked") == true then return true end
    if char:GetAttribute("IsHooked") == true then return true end
    if char:GetAttribute("IsCarried") == true then return true end
    return false
end

local function TriggerParry()
    if parryClient then
        parryClient:Parry()
    end
end

local function SetupFacingCone(character, root)
    local segments = 48
    local slices = {}

    for i = 1, segments do
        local slice = Instance.new("Part")
        slice.Name = "ParryConeSlice" .. i
        slice.Anchored = true
        slice.CanCollide = false
        slice.CanQuery = false
        slice.CanTouch = false
        slice.CastShadow = false
        slice.Material = Enum.Material.Neon
        slice.Transparency = 1
        slice.Color = Color3.fromRGB(255, 0, 0)
        slice.Size = Vector3.new(1, 0.05, 1)
        slice.Parent = root

        slices[i] = slice
    end

    FacingCones[character] = { Slices = slices, Root = root }
end

local function HookParryCharacter(character)
    if HookedParryCharacters[character] then return end
    HookedParryCharacters[character] = true

    local Humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5)
    if not Humanoid then return end

    local Animator = Humanoid:FindFirstChildOfClass("Animator") or Humanoid:WaitForChild("Animator", 5)
    if not Animator then return end

    local root = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 5)
    if root then
        SetupFacingCone(character, root)
    end

    character.AncestryChanged:Connect(function(_, parent)
        if not parent then
            HookedParryCharacters[character] = nil
        end
    end)

    Animator.AnimationPlayed:Connect(function(track)
        if not State.Parry.Enabled then return end
        if GetRole() ~= "Survivor" then return end
        if IsParryOnCooldown() then return end
        if isParryBlocked() then return end

        local id = (track.Animation and track.Animation.AnimationId or ""):match("%d+")
        if not id or not AttackAnimations[id] then return end

        local LocalCharacter = LocalPlayer.Character
        local LocalHumanoid = LocalCharacter and LocalCharacter:FindFirstChildOfClass("Humanoid")
        local LocalRoot = LocalCharacter and LocalCharacter:FindFirstChild("HumanoidRootPart")
        local KillerRoot = character:FindFirstChild("HumanoidRootPart")

        if not LocalHumanoid or LocalHumanoid.Health <= 0 then return end
        if not LocalRoot or not KillerRoot then return end

        local distance = (LocalRoot.Position - KillerRoot.Position).Magnitude
        if distance > State.Parry.Radius then return end

        local flatDir = Vector3.new(LocalRoot.Position.X, 0, LocalRoot.Position.Z) - Vector3.new(KillerRoot.Position.X, 0, KillerRoot.Position.Z)

        if flatDir.Magnitude > 0 then
            local killerLookFlat = Vector3.new(KillerRoot.CFrame.LookVector.X, 0, KillerRoot.CFrame.LookVector.Z).Unit
            if killerLookFlat:Dot(flatDir.Unit) < math.cos(math.rad(State.Parry.FaceAngle)) then
                return
            end
        end

        TriggerParry()
    end)
end

local function TryHookParryPlayer(player)
    if player.Team and player.Team.Name == "Killer" and player.Character then
        HookParryCharacter(player.Character)
    end
end

local function OnParryPlayerAdded(player)
    if player == LocalPlayer then return end

    player:GetPropertyChangedSignal("Team"):Connect(function()
        TryHookParryPlayer(player)
    end)

    player.CharacterAdded:Connect(function()
        TryHookParryPlayer(player)
    end)

    TryHookParryPlayer(player)
end

for _, player in pairs(Players:GetPlayers()) do
    OnParryPlayerAdded(player)
end

Players.PlayerAdded:Connect(OnParryPlayerAdded)

local function SetupParryRadiusRing(character)
    local root = character:WaitForChild("HumanoidRootPart", 5)
    if not root then return end

    if RadiusRing then
        RadiusRing:Destroy()
    end

    RadiusRing = Instance.new("CylinderHandleAdornment")
    RadiusRing.Name = "ParryRadiusESP"
    RadiusRing.Height = 0.02
    RadiusRing.Transparency = 0.4
    RadiusRing.Color3 = Color3.fromRGB(255, 255, 255)
    RadiusRing.AlwaysOnTop = true
    RadiusRing.ZIndex = 0
    RadiusRing.Visible = false
    RadiusRing.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(math.pi / 2, 0, 0)
    RadiusRing.Adornee = root
    RadiusRing.Parent = root
end

LocalPlayer.CharacterAdded:Connect(SetupParryRadiusRing)
if LocalPlayer.Character then
    SetupParryRadiusRing(LocalPlayer.Character)
end

RunService.Heartbeat:Connect(function()
    local LocalCharacter = LocalPlayer.Character
    local LocalRoot = LocalCharacter and LocalCharacter:FindFirstChild("HumanoidRootPart")

    if RadiusRing then
        RadiusRing.Radius = State.Parry.Radius
        RadiusRing.InnerRadius = math.max(0.1, State.Parry.Radius - 0.2)
        RadiusRing.Visible = State.Parry.ShowRadiusVisualizer and State.Parry.Enabled
    end

    for character, cone in pairs(FacingCones) do
        local root = character:FindFirstChild("HumanoidRootPart")

        if not root or root ~= cone.Root or not cone.Slices[1].Parent then
            FacingCones[character] = nil
        else
            local halfAngle = math.rad(State.Parry.FaceAngle)
            local aligned = false
            local visible = State.Parry.ShowConeVisualizer and State.Parry.Enabled

            if visible and LocalRoot then
                local distance = (LocalRoot.Position - root.Position).Magnitude

                if distance <= State.Parry.Radius then
                    local flatDir = Vector3.new(LocalRoot.Position.X, 0, LocalRoot.Position.Z) - Vector3.new(root.Position.X, 0, root.Position.Z)

                    if flatDir.Magnitude > 0 then
                        local killerLookFlat = Vector3.new(root.CFrame.LookVector.X, 0, root.CFrame.LookVector.Z).Unit
                        aligned = killerLookFlat:Dot(flatDir.Unit) >= math.cos(halfAngle)
                    end
                end
            end

            local color = aligned and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            local segments = #cone.Slices
            local fullAngle = halfAngle * 2

            for i, slice in ipairs(cone.Slices) do
                local angleStart = -halfAngle + (i - 1) / segments * fullAngle
                local angleEnd = -halfAngle + i / segments * fullAngle
                local angleMid = (angleStart + angleEnd) / 2
                local chordWidth = 2 * ConeLength * math.sin((angleEnd - angleStart) / 2)

                slice.Size = Vector3.new(math.max(chordWidth, 0.1), 0.05, ConeLength)
                slice.CFrame = root.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, angleMid, 0) * CFrame.new(0, 0, -ConeLength / 2)
                slice.Transparency = visible and 0.5 or 1
                slice.Color = color
            end
        end
    end
end)

local Window = WindUI:CreateWindow({
    Title = "diddyboy | VD",
    Icon = "gamepad-2",
    Theme = "Dark"
})

local MainTab   = Window:Tab({ Title = "Main",   Icon = "" })
local PlayerTab = Window:Tab({ Title = "Player", Icon = "" })
local KillerTab = Window:Tab({ Title = "Killer", Icon = "" })
local GameTab   = Window:Tab({ Title = "Game",   Icon = "" })

-- ==========================================
-- MAIN TAB: HIGHLIGHTS & ESP CHECKBOXES
-- ==========================================
local HighlightSection = MainTab:Section({ Title = "Highlights" })

HighlightSection:Toggle({ 
    Title = "Enable Highlight", 
    Default = false, 
    Callback = function(v) 
        State.MasterHighlight = v 
        refreshAllHighlights() 
    end 
})

local function checkSelection(selectedValues, target)
    if type(selectedValues) == "table" then
        for k, val in pairs(selectedValues) do
            if val == target then return true end
            if k == target and val == true then return true end
            if type(val) == "table" and val.Title == target then return true end
        end
    elseif type(selectedValues) == "string" then
        return selectedValues == target
    end
    return false
end

HighlightSection:Dropdown({
    Title = "Highlight Players",
    Multi = true,
    Values = {"Killer", "Survivor"},
    Value = {},
    Callback = function(v)
        State.Players.Killer = checkSelection(v, "Killer")
        State.Players.Survivor = checkSelection(v, "Survivor")
        refreshAllHighlights()
    end
})

HighlightSection:Dropdown({
    Title = "Highlight Objects",
    Multi = true,
    Values = {"Generator", "Windows", "Pallets", "Gate", "Hooks"},
    Value = {},
    Callback = function(v)
        State.Objects.Generator = checkSelection(v, "Generator")
        State.Objects.Windows = checkSelection(v, "Windows")
        State.Objects.Pallets = checkSelection(v, "Pallets")
        State.Objects.Gate = checkSelection(v, "Gate")
        State.Objects.Hooks = checkSelection(v, "Hooks")
        refreshAllHighlights()
    end
})

HighlightSection:Toggle({ Title = "Show Names", Type = "Checkbox", Default = false, Callback = function(v) State.ShowNames = v end })
HighlightSection:Toggle({ Title = "Show Distance", Type = "Checkbox", Default = false, Callback = function(v) State.ShowDistance = v end })
HighlightSection:Toggle({ Title = "Show Health", Type = "Checkbox", Default = false, Callback = function(v) State.ShowHealth = v end })
HighlightSection:Toggle({ Title = "Show Tracers", Type = "Checkbox", Default = false, Callback = function(v) State.ShowTracers = v end })

-- ==========================================
-- MAIN TAB: GENERATORS
-- ==========================================
local GeneratorSection = MainTab:Section({ Title = "Generators" })

GeneratorSection:Dropdown({
    Title = "Skill Check Method",
    Values = {"Normal", "Instant"},
    Value = "Normal",
    Callback = function(v)
        State.SkillCheckMethod = v
    end
})

GeneratorSection:Toggle({ 
    Title = "Auto Skill Check", 
    Default = false, 
    Callback = function(v) 
        State.AutoSkillCheck = v
        if v and CurrentCheckUI and CurrentCheckUI.Visible then
            CurrentCheckUI.Visible = false
            CurrentCheckUI.Visible = true
        end
    end 
})

GeneratorSection:Toggle({ 
    Title = "Disable Generator Skill Check", 
    Default = false, 
    Callback = function(v) 
        setSkillCheckBypass(v) 
    end 
})

GeneratorSection:Toggle({
    Title = "Show Generator Progress",
    Type = "Checkbox",
    Default = false,
    Callback = function(v)
        State.ShowGenProgress = v
    end
})

-- ==========================================
-- COMBAT TAB: AIMING
-- ==========================================
local CombatSection = PlayerTab:Section({ Title = "Aiming" })

CombatSection:Toggle({
    Title = "Toggle Aimbot",
    Desc = "use Revolver or Flashlight for this",
    Default = false,
    Callback = function(v)
        State.Aimbot.Enabled = v
    end
})

CombatSection:Dropdown({
    Title = "Aim Target",
    Multi = true,
    Values = {"Killer", "Survivor"},
    Value = {},
    Callback = function(v)
        State.Aimbot.Targets.Killer = checkSelection(v, "Killer")
        State.Aimbot.Targets.Survivor = checkSelection(v, "Survivor")
    end
})

CombatSection:Dropdown({
    Title = "Target Body Type",
    Multi = false,
    Values = {"Head", "HumanoidRootPart"},
    Value = "Head",
    Callback = function(v)
        if type(v) == "table" then
            State.Aimbot.AimPart = v[1] or v.Title or "Head"
        else
            State.Aimbot.AimPart = v or "Head"
        end
    end
})

CombatSection:Toggle({
    Title = "Wall Check",
    Type = "Checkbox",
    Default = false,
    Callback = function(v)
        State.Aimbot.WallCheck = v
    end
})

CombatSection:Slider({
    Title = "Aim Smoothness",
    Step = 1,
    Value = { Min = 1, Max = 30, Default = 30 },
    Callback = function(v)
        State.Aimbot.Smoothness = v
    end
})

-- ==========================================
-- COMBAT TAB: AUTO PARRY
-- ==========================================
local ParrySection = PlayerTab:Section({ Title = "Auto Parry" })

ParrySection:Toggle({
    Title = "Auto Parry",
    Default = false,
    Callback = function(v)
        State.Parry.Enabled = v
    end
})

ParrySection:Slider({
    Title = "Face Sensitivity",
    Step = 1,
    Value = { Min = 0, Max = 180, Default = 45 },
    Callback = function(v)
        State.Parry.FaceAngle = v
    end
})

ParrySection:Slider({
    Title = "Parry Radius",
    Step = 1,
    Value = { Min = 5, Max = 25, Default = 15 },
    Callback = function(v)
        State.Parry.Radius = v
    end
})

ParrySection:Toggle({
    Title = "Radius Visualizer",
    Default = false,
    Callback = function(v)
        State.Parry.ShowRadiusVisualizer = v
    end
})

ParrySection:Toggle({
    Title = "Cone Of Vision Visualizer",
    Default = false,
    Callback = function(v)
        State.Parry.ShowConeVisualizer = v
    end
})

-- ==========================================
-- MAIN TAB: VAULTING
-- ==========================================
local VaultingSection = MainTab:Section({ Title = "Vaulting" })

VaultingSection:Toggle({ Title = "Fast vaulting", Default = false, Callback = function(v) State.VaultEnabled = v applyVaultSpeed() end })
local VaultSlider = VaultingSection:Slider({ Title = "Set Vault Speed", Step = 0.1, Value = {Min = 1, Max = 3, Default = 1.5}, Callback = function(v) State.VaultSpeed = v applyVaultSpeed() end })
VaultingSection:Input({ Title = "Vault Speed Input", Placeholder = "", Numeric = true, Finished = true, Callback = function(t) local n = math.clamp(tonumber(t) or 1.5, 1, 3) State.VaultSpeed = n pcall(function() VaultSlider:Set(n) end) applyVaultSpeed() end })
VaultingSection:Toggle({ Title = "Imitate FlowState Vaulting", Default = false, Callback = function(v) State.FlowstateEnabled = v applyVaultSpeed() end })
VaultingSection:Toggle({ Title = "Fast Vault Only", Default = false, Callback = function(v) State.FastVaultOnly = v installFastVaultHooks() end })
VaultingSection:Toggle({ Title = "Fast Pallet Slide Only", Default = false, Callback = function(v) State.FastPalletSlide = v installFastVaultHooks() end })
VaultingSection:Toggle({ Title = "Vault On Spiked Windows", Default = false, Callback = function(v) State.SpikedWindows = v installSpikedWindowsListener() if v then pcall(sweepSpikedWindows) else pcall(restoreAllSpiked) end end })

-- ==========================================
-- PLAYER TAB: FOV CHANGER SECTION
-- ==========================================
local FOVSection = GameTab:Section({ Title = "FOV Changer" })

FOVSection:Toggle({
    Title = "Enable FOV",
    Default = false,
    Callback = function(v)
        State.FOVEnabled = v
        updateFOV()
    end
})

local FOVSlider = FOVSection:Slider({
    Title = "Set FOV",
    Step = 1,
    Value = {Min = 30, Max = 120, Default = 70},
    Callback = function(v)
        State.FOVValue = v
    end
})

FOVSection:Input({
    Title = "FOV Input",
    Placeholder = "",
    Numeric = true,
    Finished = true,
    Callback = function(t)
        local n = math.clamp(tonumber(t) or 70, 30, 120)
        State.FOVValue = n
        pcall(function() FOVSlider:Set(n) end)
    end
})

-- ==========================================
-- PLAYER TAB: TPWALK SECTION
-- ==========================================
local TpWalkSection = PlayerTab:Section({ Title = "Walkspeed" })
TpWalkSection:Toggle({ Title = "Enable Walkspeed", Default = false, Callback = function(v) State.TpWalkEnabled = v updateWalkspeed() end })

local dropdownInitialized = false
TpWalkSection:Dropdown({ Title = "Speed Method", Values = { "Tp", "Attribute" }, Callback = function(v)
    if not dropdownInitialized then
        dropdownInitialized = true
        return
    end
    State.WalkspeedMethod = v
    if State.TpWalkEnabled then updateWalkspeed() end
end })

local TpWalkSlider = TpWalkSection:Slider({ Title = "Set Speed", Step = 0.1, Value = { Min = 0.1, Max = 1, Default = 0.1 }, Callback = function(v) State.TpWalkSpeed = v if State.TpWalkEnabled and State.WalkspeedMethod == "Attribute" then updateWalkspeed() end end })
TpWalkSection:Input({ Title = "Speed Input", Placeholder = "", Numeric = true, Finished = true, Callback = function(t) local n = math.clamp(tonumber(t) or 0.1, 0.1, 1) State.TpWalkSpeed = n pcall(function() TpWalkSlider:Set(n) end) if State.TpWalkEnabled and State.WalkspeedMethod == "Attribute" then updateWalkspeed() end end })

-- ==========================================
-- PLAYER TAB: MOONWALK SECTION
-- ==========================================
local MoonwalkSection = GameTab:Section({ Title = "Moonwalk" })

MoonwalkSection:Button({
    Title = "Moonwalk Gui",
    Callback = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local TweenService = game:GetService("TweenService")
        local LocalPlayer = Players.LocalPlayer

        local TargetParent = nil
        if gethui then
            TargetParent = gethui() 
        elseif game:GetService("CoreGui") then
            TargetParent = game:GetService("CoreGui")
        else
            TargetParent = LocalPlayer:WaitForChild("PlayerGui") 
        end

        local MoonwalkGui = Instance.new("ScreenGui")
        MoonwalkGui.Name = "AutoMoonwalkGui"
        MoonwalkGui.ResetOnSpawn = false
        MoonwalkGui.Parent = TargetParent

        local FULL_SIZE = UDim2.new(0, 220, 0, 205)
        local MIN_SIZE = UDim2.new(0, 220, 0, 35)

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = FULL_SIZE
        MainFrame.Position = UDim2.new(0.5, -110, 0.5, -100)
        MainFrame.BackgroundColor3 = Color3.fromRGB(25, 10, 45)
        MainFrame.BorderSizePixel = 0
        MainFrame.Active = true
        MainFrame.ClipsDescendants = true 
        MainFrame.Parent = MoonwalkGui

        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 12)
        MainCorner.Parent = MainFrame

        local function createStars(amount)
            for i = 1, amount do
                local star = Instance.new("Frame")
                local size = math.random(1, 3)
                star.Size = UDim2.new(0, size, 0, size)
                star.Position = UDim2.new(math.random(), 0, math.random(), 0)
                star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                star.BackgroundTransparency = math.random(30, 80) / 100
                star.BorderSizePixel = 0
                
                local starCorner = Instance.new("UICorner")
                starCorner.CornerRadius = UDim.new(1, 0)
                starCorner.Parent = star
                
                star.Parent = MainFrame
            end
        end
        createStars(35)

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, -70, 0, 35)
        Title.Position = UDim2.new(0, 10, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = "AUTO MOONWALK"
        Title.TextColor3 = Color3.fromRGB(220, 200, 255)
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 13
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = MainFrame

        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Size = UDim2.new(0, 25, 0, 25)
        CloseBtn.Position = UDim2.new(1, -30, 0, 5)
        CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 70)
        CloseBtn.Text = "X"
        CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.Parent = MainFrame
        local CloseCorner = Instance.new("UICorner")
        CloseCorner.CornerRadius = UDim.new(0, 6)
        CloseCorner.Parent = CloseBtn

        local MinBtn = Instance.new("TextButton")
        MinBtn.Size = UDim2.new(0, 25, 0, 25)
        MinBtn.Position = UDim2.new(1, -60, 0, 5)
        MinBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 100)
        MinBtn.Text = "-"
        MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinBtn.Font = Enum.Font.GothamBold
        MinBtn.Parent = MainFrame
        local MinCorner = Instance.new("UICorner")
        MinCorner.CornerRadius = UDim.new(0, 6)
        MinCorner.Parent = MinBtn

        local ContentFrame = Instance.new("Frame")
        ContentFrame.Size = UDim2.new(1, 0, 1, -40)
        ContentFrame.Position = UDim2.new(0, 0, 0, 40)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.Parent = MainFrame

        local ListLayout = Instance.new("UIListLayout")
        ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        ListLayout.Padding = UDim.new(0, 8)
        ListLayout.Parent = ContentFrame

        local ToggleRow = Instance.new("Frame")
        ToggleRow.LayoutOrder = 1
        ToggleRow.Size = UDim2.new(0.85, 0, 0, 32)
        ToggleRow.BackgroundTransparency = 1
        ToggleRow.Parent = ContentFrame

        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(1, -36, 1, 0)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 70)
        ToggleBtn.Text = "Moonwalk: OFF"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleBtn.Font = Enum.Font.GothamBold
        ToggleBtn.TextSize = 13
        ToggleBtn.Parent = ToggleRow
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 8)
        ToggleCorner.Parent = ToggleBtn

        local HiderBtn = Instance.new("TextButton")
        HiderBtn.Size = UDim2.new(0, 28, 1, 0)
        HiderBtn.Position = UDim2.new(1, 0, 0, 0)
        HiderBtn.AnchorPoint = Vector2.new(1, 0)
        HiderBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 95)
        HiderBtn.Text = "-"
        HiderBtn.TextColor3 = Color3.fromRGB(220, 200, 255)
        HiderBtn.Font = Enum.Font.GothamBold
        HiderBtn.TextSize = 15
        HiderBtn.Parent = ToggleRow
        local HiderCorner = Instance.new("UICorner")
        HiderCorner.CornerRadius = UDim.new(0, 8)
        HiderCorner.Parent = HiderBtn

        local function createAdjuster(parent, layoutOrder, labelText, defaultVal, minVal, maxVal, onChange)
            local Container = Instance.new("Frame")
            Container.LayoutOrder = layoutOrder
            Container.Size = UDim2.new(0.85, 0, 0, 52)
            Container.BackgroundColor3 = Color3.fromRGB(40, 20, 65)
            Container.ClipsDescendants = true 
            Container.Parent = parent
            
            local ContCorner = Instance.new("UICorner")
            ContCorner.CornerRadius = UDim.new(0, 8)
            ContCorner.Parent = Container

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 20)
            Label.Position = UDim2.new(0, 8, 0, 3)
            Label.BackgroundTransparency = 1
            Label.Text = labelText
            Label.TextColor3 = Color3.fromRGB(200, 180, 255)
            Label.Font = Enum.Font.GothamSemibold
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Container

            local ControlRow = Instance.new("Frame")
            ControlRow.Size = UDim2.new(1, -20, 0, 22)
            ControlRow.Position = UDim2.new(0, 10, 0, 23)
            ControlRow.BackgroundTransparency = 1
            ControlRow.Parent = Container

            local function makeBtn(text, posX)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0, 22, 1, 0)
                btn.Position = UDim2.new(posX, 0, 0, 0)
                btn.BackgroundColor3 = Color3.fromRGB(60, 30, 95)
                btn.Text = text
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Font = Enum.Font.GothamBold
                btn.TextSize = 13
                btn.Parent = ControlRow
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = btn
                return btn
            end

            local LeftBtn = makeBtn("<", 0)
            local RightBtn = makeBtn(">", 1 - (22/ControlRow.AbsoluteSize.X)) 
            RightBtn.AnchorPoint = Vector2.new(1, 0)
            RightBtn.Position = UDim2.new(1, 0, 0, 0)

            local ValueBox = Instance.new("TextBox")
            ValueBox.Size = UDim2.new(1, -54, 1, 0)
            ValueBox.Position = UDim2.new(0, 27, 0, 0)
            ValueBox.BackgroundColor3 = Color3.fromRGB(25, 10, 45)
            ValueBox.Text = tostring(defaultVal)
            ValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueBox.Font = Enum.Font.GothamBold
            ValueBox.TextSize = 13
            ValueBox.Parent = ControlRow
            local BoxCorner = Instance.new("UICorner")
            BoxCorner.CornerRadius = UDim.new(0, 6)
            BoxCorner.Parent = ValueBox

            local currentValue = defaultVal

            local function updateValue(newVal)
                local parsed = tonumber(newVal)
                if parsed then
                    currentValue = math.clamp(parsed, minVal, maxVal)
                end
                ValueBox.Text = tostring(currentValue)
                onChange(currentValue)
            end

            LeftBtn.MouseButton1Click:Connect(function() updateValue(currentValue - 1) end)
            RightBtn.MouseButton1Click:Connect(function() updateValue(currentValue + 1) end)
            ValueBox.FocusLost:Connect(function() updateValue(ValueBox.Text) end)

            return Container
        end

        local isEnabled = false
        local moonwalkConn = nil
        local moonwalkGyro = nil

        local MOONWALK_SPEED = 35 
        local MOONWALK_ANGLE = 45 

        local Adjuster1 = createAdjuster(ContentFrame, 2, "Turn Intensity (Speed)", MOONWALK_SPEED, 1, 100, function(val)
            MOONWALK_SPEED = val
        end)

        local Adjuster2 = createAdjuster(ContentFrame, 3, "Turn Angle", MOONWALK_ANGLE, 5, 180, function(val)
            MOONWALK_ANGLE = val
        end)

        local isMinimized = false
        local adjustersVisible = true
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

        ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            FULL_SIZE = UDim2.new(0, 220, 0, 40 + ListLayout.AbsoluteContentSize.Y + 12)
            if not isMinimized then
                MainFrame.Size = FULL_SIZE 
            end
        end)

        HiderBtn.MouseButton1Click:Connect(function()
            adjustersVisible = not adjustersVisible
            HiderBtn.Text = adjustersVisible and "-" or "+"
            
            local targetHeight = adjustersVisible and 52 or 0
            
            local tween1 = TweenService:Create(Adjuster1, tweenInfo, {Size = UDim2.new(0.85, 0, 0, targetHeight)})
            local tween2 = TweenService:Create(Adjuster2, tweenInfo, {Size = UDim2.new(0.85, 0, 0, targetHeight)})
            
            tween1:Play()
            tween2:Play()
        end)

        MinBtn.MouseButton1Click:Connect(function()
            isMinimized = not isMinimized
            local targetSize = isMinimized and MIN_SIZE or FULL_SIZE
            MinBtn.Text = isMinimized and "+" or "-"
            
            local tween = TweenService:Create(MainFrame, tweenInfo, {Size = targetSize})
            tween:Play()
        end)

        local dragging, dragInput, dragStart, startPos

        MainFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if input.Position.Y - MainFrame.AbsolutePosition.Y <= 35 then
                    dragging = true
                    dragStart = input.Position
                    startPos = MainFrame.Position
                    
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end
        end)

        MainFrame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                 dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        local function stopMoonwalk()
            if moonwalkConn then
                moonwalkConn:Disconnect()
                moonwalkConn = nil
            end
             if moonwalkGyro then
                moonwalkGyro:Destroy()
                moonwalkGyro = nil
            end
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildWhichIsA("Humanoid")
            if hum then hum.AutoRotate = true end
        end

        local function toggleMoonwalk()
            isEnabled = not isEnabled
            
            if not isEnabled then
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 70)
                ToggleBtn.Text = "Moonwalk: OFF"
                stopMoonwalk()
                return
            end
            
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(70, 180, 100)
            ToggleBtn.Text = "Moonwalk: ON"
             
            moonwalkConn = RunService.Heartbeat:Connect(function()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildWhichIsA("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if not hum or not hrp or hum.Health <= 0 then return end
                
                local moveDir = hum.MoveDirection
                
                if moveDir.Magnitude > 0 then
                    hum.AutoRotate = false
                    
                    if not moonwalkGyro or moonwalkGyro.Parent ~= hrp then
                        if moonwalkGyro then moonwalkGyro:Destroy() end
                        moonwalkGyro = Instance.new("BodyGyro")
                        moonwalkGyro.MaxTorque = Vector3.new(0, 400000, 0)
                        moonwalkGyro.P = 30000
                        moonwalkGyro.Parent = hrp
                    end
                    
                    local baseDir = -moveDir 
                    local timeCalc = tick() * MOONWALK_SPEED
                    local wiggle = math.rad(MOONWALK_ANGLE) * math.sin(timeCalc)
                    
                    moonwalkGyro.CFrame = CFrame.lookAt(Vector3.zero, baseDir) * CFrame.Angles(0, wiggle, 0)
                else
                    hum.AutoRotate = true
                     if moonwalkGyro then
                        moonwalkGyro:Destroy()
                        moonwalkGyro = nil
                    end
                end
            end)
        end

        ToggleBtn.MouseButton1Click:Connect(toggleMoonwalk)

        CloseBtn.MouseButton1Click:Connect(function()
            stopMoonwalk()
            MoonwalkGui:Destroy()
        end)
    end
})

-- ==========================================
-- PLAYER TAB: ANTI FLING SECTION
-- ==========================================
local FlingSection = PlayerTab:Section({ Title = "Anti Fling" })

FlingSection:Button({
    Title = "Execute Anti Fling",
    Callback = function()
        enableAntiFling()
    end
})

-- ==========================================
-- GAME TAB: WORLD EFFECTS SECTION
-- ==========================================
local GameSection = GameTab:Section({ Title = "World Effects" })

GameSection:Button({
    Title = "Nofog",
    Callback = function()
        Lighting.FogEnd = 100000
        for _,v in pairs(Lighting:GetDescendants()) do
            if v:IsA("Atmosphere") then v:Destroy() end
        end
    end
})

GameSection:Button({
    Title = "Antilag",
    Callback = function()
        local Terrain = Workspace:FindFirstChildWhichIsA("Terrain")
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
        end
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 9e9
        settings().Rendering.QualityLevel = 1
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CastShadow = false
                v.Material = "Plastic"
                v.Reflectance = 0
                for _, surface in ipairs({"Back", "Bottom", "Front", "Left", "Right", "Top"}) do
                    v[surface.."Surface"] = "SmoothNoOutlines"
                end
            elseif v:IsA("Decal") then
                v.Transparency = 1
                v.Texture = ""
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            end
        end
        for _, v in pairs(Lighting:GetDescendants()) do
            if v:IsA("PostEffect") then v.Enabled = false end
        end
        Workspace.DescendantAdded:Connect(function(child)
            task.spawn(function()
                if child:IsA("ForceField") or child:IsA("Sparkles") or child:IsA("Smoke") or child:IsA("Fire") or child:IsA("Beam") then
                    RunService.Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA("BasePart") then
                    child.CastShadow = false
                end
            end)
        end)
    end
})

GameSection:Button({
    Title = "Day",
    Callback = function()
        Lighting.ClockTime = 14
    end
})

GameSection:Button({
    Title = "No Shadows",
    Callback = function()
        Lighting.GlobalShadows = false
    end
})

-- ==========================================
-- KILLER TAB
-- ==========================================
local KillerSection = KillerTab:Section({ Title = "Combat" })

KillerSection:Toggle({
    Title = "Auto Attack",
    Default = false,
    Callback = function(v)
        KillerState.AutoAttack = v
        if v and KillerState.MultipleLunge then
            WindUI:Notify({
                Title = "⚠️",
                Content = "Auto Attack & Multiple Lunge Is Both Running",
                Duration = 2
            })
        end
    end
})

KillerSection:Slider({
    Title = "Attack Range",
    Step = 1,
    Value = { Min = 5, Max = 20, Default = 12 },
    Callback = function(v)
        KillerState.AttackRange = v
    end
})

KillerSection:Toggle({
    Title = "Multiple Lunge",
    Default = false,
    Callback = function(v)
        KillerState.MultipleLunge = v
        if v and KillerState.AutoAttack then
            WindUI:Notify({
                Title = "⚠️",
                Content = "Auto Attack & Multiple Lunge Is Both Running",
                Duration = 2
            })
        end
    end
})

print("diddyboy | vd loaded.")