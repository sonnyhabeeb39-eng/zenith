function getPlayerImage(userId : number)
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size420x420
	local content, isReady = 
		game:GetService("Players"):GetUserThumbnailAsync(userId, thumbType, thumbSize)
	return content, isReady
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
Name = "Scarlet V5",
Icon = getPlayerImage(game.Players.LocalPlayer.UserId),
LoadingTitle = "Scarlet",
LoadingSubtitle = "Best Touch Football Script",
ConfigurationSaving = {
        Enabled = true,
        FolderName = "ScarletHub",
        FileName = "Config"
    },
Discord = { Enabled = false },
KeySystem = false,
Keybind = Enum.KeyCode.K,

Theme = {
    TextColor = Color3.fromRGB(240, 228, 255),

    Background = Color3.fromRGB(14, 8, 24),
    Topbar = Color3.fromRGB(22, 12, 38),
    Shadow = Color3.fromRGB(6, 3, 12),

    NotificationBackground = Color3.fromRGB(26, 16, 44),
    NotificationActionsBackground = Color3.fromRGB(44, 28, 68),

    TabBackground = Color3.fromRGB(30, 18, 50),
    TabStroke = Color3.fromRGB(153, 85, 205),
    TabBackgroundSelected = Color3.fromRGB(44, 26, 68),

    TabTextColor = Color3.fromRGB(240, 228, 255),
    SelectedTabTextColor = Color3.fromRGB(220, 190, 255),

    ElementBackground = Color3.fromRGB(30, 18, 50),
    ElementBackgroundHover = Color3.fromRGB(48, 30, 72),
    SecondaryElementBackground = Color3.fromRGB(40, 24, 62),

    ElementStroke = Color3.fromRGB(80, 48, 110),
    SecondaryElementStroke = Color3.fromRGB(100, 60, 140),

    SliderBackground = Color3.fromRGB(55, 34, 80),
    SliderProgress = Color3.fromRGB(153, 85, 205),
    SliderStroke = Color3.fromRGB(180, 110, 230),

    ToggleBackground = Color3.fromRGB(55, 34, 80),

    ToggleEnabled = Color3.fromRGB(153, 85, 205),
    ToggleDisabled = Color3.fromRGB(80, 65, 100),

    ToggleEnabledStroke = Color3.fromRGB(190, 130, 240),
    ToggleDisabledStroke = Color3.fromRGB(110, 95, 130),

    ToggleEnabledOuterStroke = Color3.fromRGB(210, 165, 255),
    ToggleDisabledOuterStroke = Color3.fromRGB(90, 78, 112),

    DropdownSelected = Color3.fromRGB(153, 85, 205),
    DropdownUnselected = Color3.fromRGB(30, 18, 50),

    InputBackground = Color3.fromRGB(30, 18, 50),
    InputStroke = Color3.fromRGB(153, 85, 205),
    PlaceholderColor = Color3.fromRGB(160, 135, 185)
},
})

local TabMain = Window:CreateTab("Profile", 110377773671530)
local TabMobile = Window:CreateTab("Mobile", 86468353359787)
local TabStats = Window:CreateTab("Stats", 84225609346234)
local TabVisuals = Window:CreateTab("Visuals", 77854163344605)
local TabSkills = Window:CreateTab("Skills", 84385569968466)
local TabScripts = Window:CreateTab("Scripts", 126344222962901)
local TabReach = Window:CreateTab("Reach", 138060378648535)
local TabKeybinds = Window:CreateTab("Keybinds", 100215994431874)
local TabFun = Window:CreateTab("Fun", 87169227269676)
local TabPerformance = Window:CreateTab("FPS", 139874562310221)

TabMain:CreateParagraph({Title = "Made By Lennox", Content = "Click 'Show Scarlet' for Mobile and press 'K' for PC.\nGo to Keybinds to customize shortcuts!"})



local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RS = game:GetService("ReplicatedStorage")

local me = Players.LocalPlayer



local states = {
    activePokers = false,
    manualPokers = false,
    trackerActive = false,
    trajectoryActive = false,
    reachActive = false,
	mode = "Regular",
    sneakyActive = false,

    juggleActive = false,
    autoGk = false,
    groundShotActive = false,
    groundShotPower = 4.6,
	gkEnabled = false,
    gsEnabled = false,

	--
	Aimbot = false,
	Goal = "",
	Type = "Random",
	Height = 34, -- unremoved btw
	ShowGoals = false, -- removed btw
	NoSpin = false,
    FurthestCorner = false,

    --

    RankBypass = false,

	-- see how my comments are normal and not skiddy skid skidded


    BallFreeze = false,

    --

    SaveFarm = false,

    --

    IncreaseMaxSpeed = false,
    MaxSpeed = 23,

    --

	powerShotActive = false,
	powerShotPower = 86,
    
    shoeColor = Color3.fromRGB(220, 40, 40),
    shoeGlow = false,
    rainbowShoes = false,
    customShirtName = "",
    customShirtNumber = "",
    stats = {Goals = "", Clan = "", BPA = "", Wins = ""},
    guiAccentColor = Color3.fromRGB(220, 40, 40),
    
    sneakyRadius = 4.1, 
    juggleRadius = 4.1, 
    reachRange = 4.1, 
    lastSneakyHit = 0,

    pitchColorActive = false,
    selectedPitchColor = "Default",
    rainbowPitch = false,
	rainbowFlickActive = false,
	rainbowFlickRange = 3.5
}

	   
	   

task.spawn(function()
if game.PlaceId == 16447934574 then

-- Script Path: game:GetService("Workspace").SilverLeaf135.BallHandler
-- Took 0.05s to decompile.
-- Executor: Potassium (v2.3.3)

-- Decompiled with Potassium's decompiler.
local BallHandler
if game.Players.LocalPlayer.Character:FindFirstChild("BallHandler") then
	game.Players.LocalPlayer.Character:FindFirstChild("BallHandler"):Destroy()
end

local Humanoid
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
game.Players.LocalPlayer.CharacterAdded:Connect(function ()
	Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
	BallHandler = game.Players.LocalPlayer.Character:WaitForChild("BallHandler")
	BallHandler:Destroy()
end)
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KickBall = ReplicatedStorage:WaitForChild("KickBall");
local DropBallEvent = ReplicatedStorage:WaitForChild("DropBallEvent");
local RemoveBallEvent = ReplicatedStorage:WaitForChild("RemoveBallEvent");
local BallPositionEvent = ReplicatedStorage:WaitForChild("BallPositionEvent");
local KickBallEvent = ReplicatedStorage:WaitForChild("KickBallEvent");
local LocalPlayer = Players.LocalPlayer;
local MeasureLag = ReplicatedStorage:WaitForChild("MeasureLag");
local MeasureLagEvent = ReplicatedStorage:WaitForChild("MeasureLagEvent");
local GoalEvent = ReplicatedStorage:WaitForChild("GoalEvent");
local NearGoalEvent = ReplicatedStorage:WaitForChild("NearGoalEvent");
local u1 = nil;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local u5 = 0.55;
local u6 = 55;
local u7 = 0;
local u8 = 0;
local u9 = 0;
local u10 = 5.473;
local u11 = 0;
local u12 = nil;
local u13 = 0;
local u14 = 0;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = false;
local u24 = 0;
local u25 = false;
local u26 = 0;
local Sound = Instance.new("Sound", game.Workspace);
Sound.SoundId = "rbxassetid://82599119475859";
Sound.Volume = 0.4;
local Sound2 = Instance.new("Sound", game.Workspace);
Sound2.SoundId = "rbxassetid://74303966391925";
Sound2.Volume = 0.4;
local Sound3 = Instance.new("Sound", game.Workspace);
Sound3.SoundId = "rbxassetid://122054734580185";
Sound3.Volume = 0.5;
local Sound4 = Instance.new("Sound", game.Workspace);
Sound4.SoundId = "rbxassetid://9119319842";
Sound4.Volume = 1;

function ballBouncedFloor(p27)
    -- upvalues: u10 (ref)
    return p27.Y < u10;
end;

function ballInGoalA(p28)
    -- upvalues: u7 (ref), u8 (ref)
    return p28.X < -313.13 and (p28.Z >= u7 + 78.036 and (p28.Z <= 107.715 - u7 and p28.Y <= u8 + 17));
end;

function ballInGoalB(p29)
    -- upvalues: u7 (ref), u8 (ref)
    return p29.X > -115.936 and (p29.Z >= u7 + 78.036 and (p29.Z <= 107.715 - u7 and p29.Y <= u8 + 17));
end;

local function copyVec(p30) -- Line: 138
    return {
        X = p30.X,
        Y = p30.Y,
        Z = p30.Z
    };
end;

local function reflectVelocity(p31, p32) -- Line: 142
    local v33 = p31.X * p32.X + p31.Y * p32.Y + p31.Z * p32.Z;

    return {
        X = p31.X - 2 * v33 * p32.X,
        Y = p31.Y - 2 * v33 * p32.Y,
        Z = p31.Z - 2 * v33 * p32.Z
    };
end;

local function length2(p34, p35) -- Line: 147
    return math.sqrt(p34 * p34 + p35 * p35);
end;

local function hitPost(p36, p37, p38, p39) -- Line: 151
    -- upvalues: reflectVelocity (copy)
    local v40 = p38.X - p36;
    local v41 = p38.Z - p37;
    local v42 = math.sqrt(v40 * v40 + v41 * v41);

    if v42 > 1.825 or (p38.Y < -1.5 or p38.Y > 19.5) then
        return false, p38, {
            X = p39.X,
            Y = p39.Y,
            Z = p39.Z
        };
    end;

    local v43, v44;

    if v42 > 1e-9 then
        v43 = v40 / v42;
        v44 = v41 / v42;
    else
        v43 = 0;
        v44 = 1;
        v42 = 1e-9;
    end;

    if p39.X * v43 + p39.Z * v44 >= 0 then
        return false, p38, {
            X = p39.X,
            Y = p39.Y,
            Z = p39.Z
        };
    end;

    local v45 = 1.8259999999999998 - v42;

    return true, Vector3.new(p38.X + v43 * v45, p38.Y, p38.Z + v44 * v45), reflectVelocity(p39, {
        Y = 0,
        X = v43,
        Z = v44
    });
end;

local function hitBar(p46, p47, p48) -- Line: 193
    -- upvalues: reflectVelocity (copy)
    if p47.Z >= 76.536 and p47.Z <= 109.215 then
        local v49 = p47.X - p46;
        local v50 = p47.Y - 18;
        local v51 = math.sqrt(v49 * v49 + v50 * v50);

        if v51 <= 1.825 then
            local v52, v53;

            if v51 > 1e-9 then
                v52 = v49 / v51;
                v53 = v50 / v51;
            else
                v52 = 0;
                v53 = 1;
                v51 = 1e-9;
            end;

            if p48.X * v52 + p48.Y * v53 >= 0 then
                return false, p47, {
                    X = p48.X,
                    Y = p48.Y,
                    Z = p48.Z
                };
            end;

            local v54 = 1.8259999999999998 - v51;

            return true, Vector3.new(p47.X + v52 * v54, p47.Y + v53 * v54, p47.Z), reflectVelocity(p48, {
                Z = 0,
                X = v52,
                Y = v53
            });
        end;
    end;

    return false, p47, {
        X = p48.X,
        Y = p48.Y,
        Z = p48.Z
    };
end;

function ballHitsLeftPoleA(p55, p56)
    -- upvalues: hitPost (copy)
    return hitPost(-313.13, 78.036, p55, p56);
end;

function ballHitsRightPoleA(p57, p58)
    -- upvalues: hitPost (copy)
    return hitPost(-313.13, 107.715, p57, p58);
end;

function ballHitsCrossbarA(p59, p60)
    -- upvalues: hitBar (copy)
    return hitBar(-313.13, p59, p60);
end;

function ballHitsLeftPoleB(p61, p62)
    -- upvalues: hitPost (copy)
    return hitPost(-115.936, 78.036, p61, p62);
end;

function ballHitsRightPoleB(p63, p64)
    -- upvalues: hitPost (copy)
    return hitPost(-115.936, 107.715, p63, p64);
end;

function ballHitsCrossbarB(p65, p66)
    -- upvalues: hitBar (copy)
    return hitBar(-115.936, p65, p66);
end;

function ballHitsGoalFrame(p67, p68)
    local v69, v70, v71 = ballHitsLeftPoleA(p67, p68);

    if v69 then
        return true, v70, v71, "LeftPoleA";
    end;

    local v72, v73, v74 = ballHitsRightPoleA(p67, p68);

    if v72 then
        return true, v73, v74, "RightPoleA";
    end;

    local v75, v76, v77 = ballHitsCrossbarA(p67, p68);

    if v75 then
        return true, v76, v77, "CrossbarA";
    end;

    local v78, v79, v80 = ballHitsLeftPoleB(p67, p68);

    if v78 then
        return true, v79, v80, "LeftPoleB";
    end;

    local v81, v82, v83 = ballHitsRightPoleB(p67, p68);

    if v81 then
        return true, v82, v83, "RightPoleB";
    end;

    local v84, v85, v86 = ballHitsCrossbarB(p67, p68);

    if v84 then
        return true, v85, v86, "CrossbarB";
    end;

    return false, p67, {
        X = p68.X,
        Y = p68.Y,
        Z = p68.Z
    }, "";
end;

function checkNearGoal()
    -- upvalues: u1 (ref), u26 (ref), u7 (ref), u8 (ref), NearGoalEvent (copy)
    if u1 and (tick() - u26 > 5 and u1.Velocity.Magnitude > 10) then
        if u1.Position.X < -309 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u26 = tick();
            NearGoalEvent:FireServer("B");

            return;
        end;

        if u1.Position.X > -120 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u26 = tick();
            NearGoalEvent:FireServer("A");
        end;
    end;
end;

function soccerBallTrajectory(p87, p88, p89, p90, p91)
    local X = p88.X;
    local Z = p88.Z;
    local Y = p88.Y;
    local X2 = p89.X;
    local Z2 = p89.Z;
    local Y2 = p89.Y;
    local v92 = p91 * p87;
    local v93 = X * math.cos(v92) - Z * math.sin(v92);
    local v94 = X * math.sin(v92) + Z * math.cos(v92);

    return Vector3.new(X2 + X * p87 + 0.5 * (v93 - X) * p87, Y2 + Y * p87 - 0.5 * p90 * p87 ^ 2, Z2 + Z * p87 + 0.5 * (v94 - Z) * p87), Vector3.new(v93, Y - p90 * p87, v94);
end;

function getBallRotationOnImpact(p95)
    local v96 = Vector3.new(p95.X, 0, p95.Z);

    return (Vector3.new(0, 1, 0)):Cross(v96.Unit).Unit * (v96.Magnitude * 0.8 / 1.5);
end;

function getBounceVelocity(p97, p98, p99, p100, p101, p102)
    -- upvalues: u9 (ref)
    local v103;

    if p97.Z > p102 - u9 then
        local X = p98.X;
        local Y = p98.Y;
        local v104 = -math.abs(p98.Z);
        p98 = Vector3.new(X, Y, v104);
        v103 = true;
    else
        v103 = false;
    end;

    if p97.Z < p101 + u9 then
        local X = p98.X;
        local Y = p98.Y;
        local v105 = math.abs(p98.Z);
        p98 = Vector3.new(X, Y, v105);
        v103 = true;
    end;

    if p100 < p97.X then
        local v106 = -math.abs(p98.X);
        p98 = Vector3.new(v106, p98.Y, p98.Z);
        v103 = true;
    end;

    if p97.X < p99 then
        local v107 = math.abs(p98.X);
        p98 = Vector3.new(v107, p98.Y, p98.Z);
        v103 = true;
    end;

    return p98, v103;
end;

function ensureInside(p108, p109, p110, p111, p112)
    local v113 = math.clamp(p108.X, p109, p110);
    local v114 = math.clamp(p108.Z, p111, p112);

    return Vector3.new(v113, p108.Y, v114);
end;

function recordBallAnimation(p115, p116, p117)
    -- upvalues: u13 (ref), u6 (ref), u10 (ref), u5 (ref), Sound (copy), Sound4 (copy), Sound2 (copy)
    local v118 = {};
    local v119 = {};
    local v120 = {};
    local v121 = {};
    table.insert(v118, p115);
    table.insert(v119, p116);
    table.insert(v120, p117);
    table.insert(v121, false);
    local v122 = 0;
    local v123 = p117.Y / -45;
    local v124 = nil;
    u13 = 0;
    local v125 = p115;

    for i = 1, 2000 do
        local v126 = ensureInside(p115, -313.13, -115.936, 23.443, 161.748);
        local v127, v128 = soccerBallTrajectory(v122, p116, v125, u6, v123);

        if v128.Magnitude < 0.5 then
            break;
        end;

        local v129 = nil;
        local v130 = false;
        local v131, v132;
        v131, p115, v132 = ballHitsGoalFrame(v127, v128);

        if v131 then
            p116 = Vector3.new(v132.X * 0.6, v132.Y * 0.7, v132.Z * 0.6);
            p117 = p117 * 0.8;
            v123 = p117.Y / -45;
            v125 = p115;
            v128 = p116;
            v122 = 0;
        else
            if ballInGoalA(v127) then
                v124 = "B";
                table.insert(v118, v127);
                table.insert(v119, v128);
                table.insert(v120, p117);
                table.insert(v121, false);

                if u13 == 0 then
                    u13 = i;
                end;

                break;
            end;

            if ballInGoalB(v127) then
                v124 = "A";
                table.insert(v118, v127);
                table.insert(v119, v128);
                table.insert(v120, p117);
                table.insert(v121, false);

                if u13 == 0 then
                    u13 = i;
                end;

                break;
            end;

            local v133;
            v133, v129 = getBounceVelocity(v127, v128, -313.13, -115.936, 23.443, 161.748);

            if v129 then
                p115 = Vector3.new(v126.X, v127.Y, v126.Z);
                p116 = Vector3.new(v133.X * 0.6, v133.Y * 0.7, v133.Z * 0.6);
                p117 = p117 * 0.8;
                v123 = p117.Y / -45;
                v125 = p115;
                v128 = p116;
                v122 = 0;
            else
                p115 = v127;
            end;

            v130 = ballBouncedFloor(p115);

            if v130 then
                p115 = Vector3.new(p115.X, u10, p115.Z);

                if u13 == 0 then
                    u13 = i;
                end;

                p117 = getBallRotationOnImpact(v128) + Vector3.new(0, p117.Y * 0.8, 0);
                local v134 = math.abs(v128.Y) < 10 and 0.99 or 0.8;
                p116 = Vector3.new(v128.X * v134, v128.Y * -u5, v128.Z * v134);
                v123 = p117.Y / -45;
                v125 = p115;
                v128 = p116;
                v122 = 0;
            end;
        end;

        table.insert(v118, p115);
        table.insert(v119, v128);
        table.insert(v120, p117);

        if v131 then
            table.insert(v121, Sound);
        elseif v130 and math.abs(v128.Y) >= 10 then
            table.insert(v121, Sound4);
        elseif v129 then
            table.insert(v121, Sound2);
        else
            table.insert(v121, false);
        end;

        v122 = v122 + 0.005;
    end;

    return v118, v119, v120, v121, v124;
end;

function softImpact(p135, p136)
    if p136 <= 0 then
        return 0;
    end;

    if p136 < p135 then
        p135 = p136;
    end;

    return math.sin(1.57 * p135 / p136);
end;

function animateBall()
    -- upvalues: u1 (ref), u21 (ref), u23 (ref), u14 (ref), u11 (ref), u15 (ref), u24 (ref), u18 (ref), u16 (ref), u17 (ref), u12 (ref), u13 (ref), u10 (ref), u22 (ref), u25 (ref), GoalEvent (copy), Sound3 (copy)
    if not (u1 and u21) then
        if u1 and u23 then
            local v137 = (tick() - u14) / (u11 + 0.005);
            local v138 = math.floor(v137);

            if v138 < 1 then
                return;
            end;

            if v138 <= #u15 then
                for i = math.max(u24 + 1, 1), math.min(v138, #u18) do
                    local v139 = u18[i];

                    if v139 then
                        if not v139.IsPlaying then
                            v139:Play();
                        end;

                        u18[i] = false;
                    end;
                end;

                u24 = v138;
                u1.Position = u15[v138];
                u1.Velocity = u16[v138];
                u1.RotVelocity = u17[v138];
                local v140 = u12 * (1 - softImpact(v138, u13));
                u1.Position = u1.Position - v140;

                if u1.Position.Y < u10 then
                    u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);

                    return;
                end;
            else
                if u22 then
                    u23 = false;
                    u25 = false;
                    GoalEvent:FireServer(u22);
                    wait(0.3);

                    if not u25 then
                        Sound3:Play();
                    end;

                    u1.Velocity = Vector3.new(u1.Velocity.X * 0.3, u1.Velocity.Y * 0.3, u1.Velocity.Z * 0.3);
                    u1.RotVelocity = Vector3.new(u1.RotVelocity.X * 0.3, u1.RotVelocity.Y * 0.3, u1.RotVelocity.Z * 0.3);

                    return;
                end;

                u21 = u1.Position;
            end;
        end;

        return;
    end;

    u1.Position = Vector3.new(u21.X, u1.Position.Y, u21.Z);
    u1.Velocity = Vector3.new(0, u1.Velocity.Y, 0);
    u1.RotVelocity = Vector3.new(0, 0, 0);
end;

function startAnimation(p141, p142, p143, p144, p145)
    -- upvalues: u15 (ref), u16 (ref), u17 (ref), u18 (ref), u22 (ref), u23 (ref), u21 (ref), u14 (ref), u12 (ref), u11 (ref), u24 (ref)
    local v146, v147, v148, v149, v150 = recordBallAnimation(p141, p142, p143);
    u15 = v146;
    u16 = v147;
    u17 = v148;
    u18 = v149;
    u22 = v150;
    u23 = true;
    u21 = nil;
    u14 = tick();
    u12 = p144;
    u11 = p145 / #v146;
    u24 = 0;
end;

function createBall(p151)
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    u1 = workspace.FootballField:FindFirstChild("SoccerBall");

    if u1 == nil then
        u1 = ReplicatedStorage:WaitForChild("SoccerBall"):Clone();
        u1.Parent = workspace.FootballField;
    end;
end;

function onDropBall(p152)
    -- upvalues: u1 (ref), u21 (ref), u2 (ref), u22 (ref)
    pcall(createBall, p152);

    if u1 then
        if p152 then
            u1.Position = Vector3.new(-214.544, 25, 92.531) + p152;
        else
            u1.Position = Vector3.new(-214.544, 25, 92.531);
        end;

        u21 = u1.Position;
    end;

    u2 = 0;
    u22 = nil;
end;

DropBallEvent.OnClientEvent:Connect(onDropBall);

function onRemoveBall()
    -- upvalues: u1 (ref)
    if u1 then
        u1:Destroy();
        u1 = nil;
    end;
end;

RemoveBallEvent.OnClientEvent:Connect(onRemoveBall);

function onMeasureLagEvent(p153)
    -- upvalues: u1 (ref), MeasureLag (copy)
    if u1 then
        MeasureLag:FireServer(p153);
    end;
end;

MeasureLagEvent.OnClientEvent:Connect(onMeasureLagEvent);

function onBallPositionEvent(p154, p155, p156)
    -- upvalues: u4 (ref), u19 (ref), u20 (ref), LocalPlayer (copy)
    u4 = p154;
    u19 = p155;
    u20 = p156;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local v157 = PlayerGui and PlayerGui:FindFirstChild("Ping", true);

    if v157 then
        local v158 = math.round(u4 * 2000);
        v157.Text = v158 .. "ms";

        if v158 <= 60 then
            v157.TextColor3 = Color3.new(0, 1, 0);

            return;
        end;

        if v158 <= 120 then
            v157.TextColor3 = Color3.new(1, 1, 0.498039);

            return;
        end;

        v157.TextColor3 = Color3.new(1, 0, 0);
    end;
end;

BallPositionEvent.OnClientEvent:Connect(onBallPositionEvent);

function onKickBallEvent(p159, p160, p161, p162)
    -- upvalues: u25 (ref), LocalPlayer (copy), u3 (ref), u1 (ref)
    u25 = true;

    if LocalPlayer.UserId ~= p159.UserId then
        u3 = tick();
        pcall(createBall, nil);

        if u1 then
            startAnimation(p160, p161, p162, p160 - u1.Position, 0);
        end;
    end;
end;

KickBallEvent.OnClientEvent:Connect(onKickBallEvent);

function getClosestPlayerName()
    -- upvalues: u19 (ref), u20 (ref), u1 (ref)
    local v163 = nil;
    local v164 = 10000;

    if u19 and u20 then
        for i, v in pairs(u20) do
            local Magnitude = (u1.Position - v).Magnitude;

            if Magnitude < v164 then
                v163 = u19[i];
                v164 = Magnitude;
            end;
        end;
    end;

    return v163;
end;

function touchDetect()
local maxRange = 4
if states.reachActive then
	maxRange = states.reachRange
end
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), Humanoid (copy), u10 (ref), KickBall (copy), u4 (ref)
if LocalPlayer and (LocalPlayer.Character and (u1 and (tick() - u2 >= 0.6 and (tick() - u3 >= 0.3 and (states.mode == "Regular" or getClosestPlayerName() == LocalPlayer.Name))))) then
        local Position = LocalPlayer.Character.UpperTorso.Position;
        local Position2 = u1.Position;
        local Magnitude = (Position2 - Position).Magnitude;

        if Magnitude > 0.01 and Magnitude <= maxRange then
            u2 = tick();
            local v165 = Position + Vector3.new(0, -3, 0);
            local v166 = Position + Vector3.new(0, 1.3, 0);
            local v167 = 34;
            local v168;

            if (v166 - Position2).Magnitude < (v165 - Position2).Magnitude then
                v168 = Position2 - v166;
                v167 = 0;
            else
                local v169 = Position2 - v165;
                v168 = Vector3.new(v169.X, 0, v169.Z);
            end;

			if game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamA") and game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamB") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Team") then
	local NameTeamA = game:GetService("ReplicatedStorage").NameTeamA.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
local NameTeamB = game:GetService("ReplicatedStorage").NameTeamB.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
if NameTeamA == Team then
	
	states.Goal = "B"
	elseif NameTeamB == Team then
		
		 states.Goal = "A"

end
	else

local fp = Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)
local sp = Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)

if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - fp).Magnitude < (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - sp).Magnitude then
    states.Goal = "A"
else
    states.Goal = "B"
end
end
			




local Unit
			if states.Aimbot then
				if states.Goal == "A" then
if states.Type == "Random" then
    local goal1randomizers = {
        Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219), -- net
        Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
    }

    local randomposition = goal1randomizers[math.random(1, #goal1randomizers)]
    Unit = (randomposition - u1.Position).Unit

elseif states.Type == "Top Left Corner" then
    Unit = (Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562)-u1.Position).Unit

elseif states.Type == "Top Right Corner" then
    Unit = (Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656)-u1.Position).Unit

elseif states.Type == "Net" then
    Unit = (Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)-u1.Position).Unit

elseif states.Type == "Bottom Left Corner" then
    Unit = (Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938)-u1.Position).Unit

elseif states.Type == "Bottom Right Corner" then
    Unit = (Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781)-u1.Position).Unit
end
					else
if states.Type == "Random" then
local goal2randomizers = {
	Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578), -- net
	Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)

}
local randomposition = goal2randomizers[math.random(1, #goal2randomizers)]
Unit = (randomposition - u1.Position).Unit
elseif states.Type == "Top Left Corner" then
Unit = (Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312)-u1.Position).Unit
	elseif states.Type == "Top Right Corner" then

Unit = (Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)-u1.Position).Unit
elseif states.Type == "Net" then
	Unit = (Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)-u1.Position).Unit
	elseif states.Type == "Bottom Left Corner" then
		Unit = (Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961)-u1.Position).Unit
		elseif states.Type == "Bottom Right Corner" then
			Unit = (Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297)-u1.Position).Unit
end
				end
			else
			Unit = v168.Unit;
			end

            if states.Aimbot and states.Goal == "A" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalA = {
    Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
}

for _, position in cornersGoalA do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

              if states.Aimbot and states.Goal == "B" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalB = {
    Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)
}

for _, position in cornersGoalB do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end



            if Unit.Magnitude > 0.01 then
                local v170 = Vector3.new(0, 0, 0);
                local LookVector = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector;
                local Unit2 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
                local v171 = math.atan2(Unit2.X, Unit2.Z) - math.atan2(Unit.X, Unit.Z);
                local v172 = math.abs(v171);
                local v173 = math.deg(v172);

                if v173 <= 20 then
                    Unit = (Unit2 + Unit).Unit;
                end;

                if v173 < 90 then
                    local v174 = v173 / 3;

                    if v171 < 0 then
                        v170 = Vector3.new(0, v174, 0);
                    else
                        v170 = Vector3.new(0, -v174, 0);
                    end;
                end;

                local WalkSpeed = Humanoid.WalkSpeed;

                if WalkSpeed <= 46 then
                    local v175;

                    if WalkSpeed >= 19 then
						local v176
						if states.Aimbot then
							v176 = Vector3.new(0, states.Height, 0);
							else
							v176 = Vector3.new(0, 34, 0);
						end
                         
                        local v177 = (WalkSpeed - 19) * 10 + 40 + Vector3.new(u1.Velocity.X, 0, u1.Velocity.Z).Magnitude;
						local power = 85
						local v178
						if states.powerShotActive then
							power = states.powerShotPower
							v178 = Unit * power + v176;
							else
							v178 = Unit * (v177 > power and power or v177) + v176;
						end
						
                        local X = v178.X;
                        local v179 = math.min(v178.Y, 40);
                        v175 = Vector3.new(X, v179, v178.Z);
                    elseif WalkSpeed == 16 then
                        v175 = Unit * 20 + Vector3.new(0, 0, 0);
                    else
                        v175 = Unit * ((WalkSpeed - 16) * 15 + 25) + Vector3.new(0, 5, 0);
                    end;

                    if u1.Position.Y < u10 then
                        u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);
                    end;

					if states.NoSpin and states.Aimbot then
						v170 = Vector3.new(0, 0, 0)
					end

                    KickBall:FireServer(u1.Position, v175, v170, Magnitude, "dihtelkds");
                    startAnimation(u1.Position, v175, v170, Vector3.new(0, 0, 0), u4);
                end;
            end;
        end;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 742
   pcall(touchDetect)
    pcall(animateBall)
   pcall(checkNearGoal)
	
end);


-- ===== SETTINGS =====
local LINE_COLOR = Color3.fromRGB(120,150,255)
local LINE_MATERIAL = Enum.Material.Neon
local DRAW_THICKNESS = 0.5
local LINE_TRANSPARENCY = 0
local SEG_MIN_DIST = 0.03
local FLOOR_Y = 5.473

-- ===== VISUAL FOLDER =====
local visuals = workspace:FindFirstChild("trajectory")
if not visuals then
    visuals = Instance.new("Folder")
    visuals.Name = "trajectory"
    visuals.Parent = workspace
end

local function clearVisuals()
    for _,v in ipairs(visuals:GetChildren()) do
        v:Destroy()
    end
end

-- ===== DRAW HELPERS =====
local function createSegment(a,b)
    local dir = b-a
    local d = dir.Magnitude
    if d < SEG_MIN_DIST then return end

    local mid = (a+b)*0.5

    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.CastShadow = false
    p.Material = LINE_MATERIAL
    p.Color = LINE_COLOR
    p.Transparency = LINE_TRANSPARENCY
    p.Size = Vector3.new(DRAW_THICKNESS,2,d)
    p.CFrame = CFrame.new(mid,mid+dir)*CFrame.Angles(math.pi/2,0,0)
    p.Parent = visuals
end

local function drawPath(points)
    for i=1,#points-1 do
        local a = Vector3.new(points[i].X, math.max(points[i].Y,FLOOR_Y), points[i].Z)
        local b = Vector3.new(points[i+1].X, math.max(points[i+1].Y,FLOOR_Y), points[i+1].Z)
        createSegment(a,b)
    end
end

local function createMarker(pos)
    local m = Instance.new("Part")
    m.Shape = Enum.PartType.Ball
    m.Anchored = true
    m.CanCollide = false
    m.CastShadow = false
    m.Material = Enum.Material.Neon
    m.Color = Color3.fromRGB(211,211,211)
    m.Size = Vector3.new(1.5,1.5,1.5)
    m.CFrame = CFrame.new(pos)
    m.Parent = visuals
end

-- ===== EVENT HOOK =====
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local event = RS:FindFirstChild("KickBallEvent")
if not event then return end

event.OnClientEvent:Connect(function(...)
    if not states.trajectoryActive then
        clearVisuals()
        return
    end
  

    clearVisuals()

    local player = Players.LocalPlayer
    local char = player.Character
    if not char then return end

    

  

    local args = {...}
    local pos,vel,spin = args[2],args[3],args[4]

    if typeof(pos) ~= "Vector3" and typeof(args[1])=="Vector3" then
        pos,vel,spin = args[1],args[2],args[3]
    end

    if typeof(pos)~="Vector3" or typeof(vel)~="Vector3" then return end

    local pts
    local success = pcall(function()
        pts = recordBallAnimation(pos,vel,spin)
    end)

    if not success or not pts or #pts < 2 then return end

    task.defer(function()
        drawPath(pts)
       
    end)

    pcall(function()
        createMarker(pts[1])

        if ballInGoalA(pts[#pts])
        or ballInGoalB(pts[#pts]) then
            createMarker(pts[#pts])
        else
            createMarker(pts[math.round(#pts/1.6)])
        end
    end)
end)

end
			end)
			task.spawn(function()
if game.PlaceId ~= 16447934574 and game.PlaceId ~= 16452705111 and game.PlaceId ~= 16452707989 and game.PlaceId ~= 116508908172411 and game.PlaceId ~= 102267554763849 and game.PlaceId ~= 83225464801601 then

-- Script Path: game:GetService("Workspace").r0pl0its.BallHandler
-- Took 0.12s to decompile.
-- Executor: Potassium (v2.3.3)

-- Decompiled with Potassium's decompiler.

local BallHandler
if game.Players.LocalPlayer.Character:FindFirstChild("BallHandler") then
	game.Players.LocalPlayer.Character:FindFirstChild("BallHandler"):Destroy()
end

local Humanoid
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
game.Players.LocalPlayer.CharacterAdded:Connect(function ()
	Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
	BallHandler = game.Players.LocalPlayer.Character:WaitForChild("BallHandler")
	BallHandler:Destroy()
end)
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KickBall = ReplicatedStorage:WaitForChild("KickBall");
local DropBallEvent = ReplicatedStorage:WaitForChild("DropBallEvent");
local RemoveBallEvent = ReplicatedStorage:WaitForChild("RemoveBallEvent");
local BallPositionEvent = ReplicatedStorage:WaitForChild("BallPositionEvent");
local KickBallEvent = ReplicatedStorage:WaitForChild("KickBallEvent");
local LocalPlayer = Players.LocalPlayer;
local MeasureLag = ReplicatedStorage:WaitForChild("MeasureLag");
local MeasureLagEvent = ReplicatedStorage:WaitForChild("MeasureLagEvent");
local GoalEvent = ReplicatedStorage:WaitForChild("GoalEvent");
local NearGoalEvent = ReplicatedStorage:WaitForChild("NearGoalEvent");
local u1 = nil;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local Value = workspace.FootballField.SoccerGameMode.Value;
local u5 = 0.55;
local u6 = 55;
local u7 = 0;
local u8 = 0;
local u9 = 0;
local u10 = 5.473;

if Value == 2 then
    u9 = 20;
    u7 = 2.2;
    u8 = 2.2;
    u5 = 0.5;
elseif Value == 3 then
    u10 = u10 + 0.5;
    u6 = 45;
    u8 = 6.4;
    u5 = 0.6;
elseif Value == 4 then
    u7 = 2.2;
    u8 = 2.2;
    u5 = 0.6;
end;

local u11 = u7 + 78.036;
local u12 = 107.715 - u7;
local u13 = u8 + 18;
local u14 = u8 + 17;
local u15 = 0;
local u16 = nil;
local u17 = 0;
local u18 = 0;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = false;
local u28 = 0;
local u29 = false;
local u30 = 0;
local Sound = Instance.new("Sound", game.Workspace);
Sound.SoundId = "rbxassetid://82599119475859";
Sound.Volume = 0.4;
local Sound2 = Instance.new("Sound", game.Workspace);
Sound2.SoundId = "rbxassetid://74303966391925";
Sound2.Volume = 0.4;
local Sound3 = Instance.new("Sound", game.Workspace);
Sound3.SoundId = "rbxassetid://122054734580185";
Sound3.Volume = 0.5;
local Sound4 = Instance.new("Sound", game.Workspace);
Sound4.SoundId = "rbxassetid://9119319842";
Sound4.Volume = 1;

function ballBouncedFloor(p31)
    -- upvalues: u10 (ref)
    return p31.Y < u10;
end;

function ballInGoalA(p32)
    -- upvalues: u11 (copy), u12 (copy), u14 (copy)
    return p32.X < -313.13 and (u11 <= p32.Z and (p32.Z <= u12 and p32.Y <= u14));
end;

function ballInGoalB(p33)
    -- upvalues: u11 (copy), u12 (copy), u14 (copy)
    return p33.X > -115.936 and (u11 <= p33.Z and (p33.Z <= u12 and p33.Y <= u14));
end;

local function copyVec(p34) -- Line: 155
    return {
        X = p34.X,
        Y = p34.Y,
        Z = p34.Z
    };
end;

local function reflectVelocity(p35, p36) -- Line: 159
    local v37 = p35.X * p36.X + p35.Y * p36.Y + p35.Z * p36.Z;

    return {
        X = p35.X - 2 * v37 * p36.X,
        Y = p35.Y - 2 * v37 * p36.Y,
        Z = p35.Z - 2 * v37 * p36.Z
    };
end;

local function length2(p38, p39) -- Line: 164
    return math.sqrt(p38 * p38 + p39 * p39);
end;

local function hitPost(p40, p41, p42, p43) -- Line: 168
    -- upvalues: u13 (copy), reflectVelocity (copy)
    local v44 = p42.X - p40;
    local v45 = p42.Z - p41;
    local v46 = math.sqrt(v44 * v44 + v45 * v45);

    if v46 > 1.825 or (p42.Y < -1.5 or p42.Y > u13 + 1.5) then
        return false, p42, {
            X = p43.X,
            Y = p43.Y,
            Z = p43.Z
        };
    end;

    local v47, v48;

    if v46 > 1e-9 then
        v47 = v44 / v46;
        v48 = v45 / v46;
    else
        v47 = 0;
        v48 = 1;
        v46 = 1e-9;
    end;

    if p43.X * v47 + p43.Z * v48 >= 0 then
        return false, p42, {
            X = p43.X,
            Y = p43.Y,
            Z = p43.Z
        };
    end;

    local v49 = 1.8259999999999998 - v46;

    return true, Vector3.new(p42.X + v47 * v49, p42.Y, p42.Z + v48 * v49), reflectVelocity(p43, {
        Y = 0,
        X = v47,
        Z = v48
    });
end;

local function hitBar(p50, p51, p52) -- Line: 210
    -- upvalues: u11 (copy), u12 (copy), u13 (copy), reflectVelocity (copy)
    if p51.Z >= u11 - 1.5 and p51.Z <= u12 + 1.5 then
        local v53 = p51.X - p50;
        local v54 = p51.Y - u13;
        local v55 = math.sqrt(v53 * v53 + v54 * v54);

        if v55 <= 1.825 then
            local v56, v57;

            if v55 > 1e-9 then
                v56 = v53 / v55;
                v57 = v54 / v55;
            else
                v56 = 0;
                v57 = 1;
                v55 = 1e-9;
            end;

            if p52.X * v56 + p52.Y * v57 >= 0 then
                return false, p51, {
                    X = p52.X,
                    Y = p52.Y,
                    Z = p52.Z
                };
            end;

            local v58 = 1.8259999999999998 - v55;

            return true, Vector3.new(p51.X + v56 * v58, p51.Y + v57 * v58, p51.Z), reflectVelocity(p52, {
                Z = 0,
                X = v56,
                Y = v57
            });
        end;
    end;

    return false, p51, {
        X = p52.X,
        Y = p52.Y,
        Z = p52.Z
    };
end;

function ballHitsLeftPoleA(p59, p60)
    -- upvalues: hitPost (copy), u11 (copy)
    return hitPost(-313.13, u11, p59, p60);
end;

function ballHitsRightPoleA(p61, p62)
    -- upvalues: hitPost (copy), u12 (copy)
    return hitPost(-313.13, u12, p61, p62);
end;

function ballHitsCrossbarA(p63, p64)
    -- upvalues: hitBar (copy)
    return hitBar(-313.13, p63, p64);
end;

function ballHitsLeftPoleB(p65, p66)
    -- upvalues: hitPost (copy), u11 (copy)
    return hitPost(-115.936, u11, p65, p66);
end;

function ballHitsRightPoleB(p67, p68)
    -- upvalues: hitPost (copy), u12 (copy)
    return hitPost(-115.936, u12, p67, p68);
end;

function ballHitsCrossbarB(p69, p70)
    -- upvalues: hitBar (copy)
    return hitBar(-115.936, p69, p70);
end;

function ballHitsGoalFrame(p71, p72)
    local v73, v74, v75 = ballHitsLeftPoleA(p71, p72);

    if v73 then
        return true, v74, v75, "LeftPoleA";
    end;

    local v76, v77, v78 = ballHitsRightPoleA(p71, p72);

    if v76 then
        return true, v77, v78, "RightPoleA";
    end;

    local v79, v80, v81 = ballHitsCrossbarA(p71, p72);

    if v79 then
        return true, v80, v81, "CrossbarA";
    end;

    local v82, v83, v84 = ballHitsLeftPoleB(p71, p72);

    if v82 then
        return true, v83, v84, "LeftPoleB";
    end;

    local v85, v86, v87 = ballHitsRightPoleB(p71, p72);

    if v85 then
        return true, v86, v87, "RightPoleB";
    end;

    local v88, v89, v90 = ballHitsCrossbarB(p71, p72);

    if v88 then
        return true, v89, v90, "CrossbarB";
    end;

    return false, p71, {
        X = p72.X,
        Y = p72.Y,
        Z = p72.Z
    }, "";
end;

function checkNearGoal()
    -- upvalues: u1 (ref), u30 (ref), u7 (ref), u8 (ref), NearGoalEvent (copy)
    if u1 and (tick() - u30 > 5 and u1.Velocity.Magnitude > 10) then
        if u1.Position.X < -309 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u30 = tick();
            NearGoalEvent:FireServer("B");

            return;
        end;

        if u1.Position.X > -120 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u30 = tick();
            NearGoalEvent:FireServer("A");
        end;
    end;
end;

function soccerBallTrajectory(p91, p92, p93, p94, p95)
    local X = p92.X;
    local Z = p92.Z;
    local Y = p92.Y;
    local X2 = p93.X;
    local Z2 = p93.Z;
    local Y2 = p93.Y;
    local v96 = p95 * p91;
    local v97 = X * math.cos(v96) - Z * math.sin(v96);
    local v98 = X * math.sin(v96) + Z * math.cos(v96);

    return Vector3.new(X2 + X * p91 + 0.5 * (v97 - X) * p91, Y2 + Y * p91 - 0.5 * p94 * p91 ^ 2, Z2 + Z * p91 + 0.5 * (v98 - Z) * p91), Vector3.new(v97, Y - p94 * p91, v98);
end;

function getBallRotationOnImpact(p99)
    local v100 = Vector3.new(p99.X, 0, p99.Z);

    return (Vector3.new(0, 1, 0)):Cross(v100.Unit).Unit * (v100.Magnitude * 0.8 / 1.5);
end;

function getBounceVelocity(p101, p102, p103, p104, p105, p106)
    -- upvalues: u9 (ref)
    local v107;

    if p101.Z > p106 - u9 then
        local X = p102.X;
        local Y = p102.Y;
        local v108 = -math.abs(p102.Z);
        p102 = Vector3.new(X, Y, v108);
        v107 = true;
    else
        v107 = false;
    end;

    if p101.Z < p105 + u9 then
        local X = p102.X;
        local Y = p102.Y;
        local v109 = math.abs(p102.Z);
        p102 = Vector3.new(X, Y, v109);
        v107 = true;
    end;

    if p104 < p101.X then
        local v110 = -math.abs(p102.X);
        p102 = Vector3.new(v110, p102.Y, p102.Z);
        v107 = true;
    end;

    if p101.X < p103 then
        local v111 = math.abs(p102.X);
        p102 = Vector3.new(v111, p102.Y, p102.Z);
        v107 = true;
    end;

    return p102, v107;
end;

function ensureInside(p112, p113, p114, p115, p116)
    local v117 = math.clamp(p112.X, p113, p114);
    local v118 = math.clamp(p112.Z, p115, p116);

    return Vector3.new(v117, p112.Y, v118);
end;

function recordBallAnimation(p119, p120, p121)
    -- upvalues: u17 (ref), u6 (ref), u10 (ref), u5 (ref), Sound (copy), Sound4 (copy), Sound2 (copy)
    local v122 = {};
    local v123 = {};
    local v124 = {};
    local v125 = {};
    table.insert(v122, p119);
    table.insert(v123, p120);
    table.insert(v124, p121);
    table.insert(v125, false);
    local v126 = 0;
    local v127 = p121.Y / -45;
    local v128 = nil;
    u17 = 0;
    local v129 = p119;

    for i = 1, 2000 do
        local v130 = ensureInside(p119, -313.13, -115.936, 23.443, 161.748);
        local v131, v132 = soccerBallTrajectory(v126, p120, v129, u6, v127);

        if v132.Magnitude < 0.5 then
            break;
        end;

        local v133 = nil;
        local v134 = false;
        local v135, v136;
        v135, p119, v136 = ballHitsGoalFrame(v131, v132);

        if v135 then
            v132 = Vector3.new(v136.X * 0.6, v136.Y * 0.7, v136.Z * 0.6);
            p121 = p121 * 0.8;
            v127 = p121.Y / -45;
            v129 = p119;
            p120 = v132;
            v126 = 0;
        else
            if ballInGoalA(v131) then
                v128 = "B";
                table.insert(v122, v131);
                table.insert(v123, v132);
                table.insert(v124, p121);
                table.insert(v125, false);

                if u17 == 0 then
                    u17 = i;
                end;

                break;
            end;

            if ballInGoalB(v131) then
                v128 = "A";
                table.insert(v122, v131);
                table.insert(v123, v132);
                table.insert(v124, p121);
                table.insert(v125, false);

                if u17 == 0 then
                    u17 = i;
                end;

                break;
            end;

            local v137;
            v137, v133 = getBounceVelocity(v131, v132, -313.13, -115.936, 23.443, 161.748);

            if v133 then
                p119 = Vector3.new(v130.X, v131.Y, v130.Z);
                v132 = Vector3.new(v137.X * 0.6, v137.Y * 0.7, v137.Z * 0.6);
                p121 = p121 * 0.8;
                v127 = p121.Y / -45;
                v129 = p119;
                p120 = v132;
                v126 = 0;
            else
                p119 = v131;
            end;

            v134 = ballBouncedFloor(p119);

            if v134 then
                p119 = Vector3.new(p119.X, u10, p119.Z);

                if u17 == 0 then
                    u17 = i;
                end;

                p121 = getBallRotationOnImpact(v132) + Vector3.new(0, p121.Y * 0.8, 0);
                local v138 = math.abs(v132.Y) < 10 and 0.99 or 0.8;
                v132 = Vector3.new(v132.X * v138, v132.Y * -u5, v132.Z * v138);
                v127 = p121.Y / -45;
                v129 = p119;
                p120 = v132;
                v126 = 0;
            end;
        end;

        table.insert(v122, p119);
        table.insert(v123, v132);
        table.insert(v124, p121);

        if v135 then
            table.insert(v125, Sound);
        elseif v134 and math.abs(v132.Y) >= 10 then
            table.insert(v125, Sound4);
        elseif v133 then
            table.insert(v125, Sound2);
        else
            table.insert(v125, false);
        end;

        v126 = v126 + 0.005;
    end;

    return v122, v123, v124, v125, v128;
end;

function softImpact(p139, p140)
    if p140 <= 0 then
        return 0;
    end;

    if p140 < p139 then
        p139 = p140;
    end;

    return math.sin(1.57 * p139 / p140);
end;

function animateBall()
    -- upvalues: u1 (ref), u25 (ref), u27 (ref), u18 (ref), u15 (ref), u19 (ref), u28 (ref), u22 (ref), u20 (ref), u21 (ref), u16 (ref), u17 (ref), u10 (ref), u26 (ref), u29 (ref), GoalEvent (copy), Sound3 (copy)
    if not (u1 and u25) then
        if u1 and u27 then
            local v141 = (tick() - u18) / (u15 + 0.005);
            local v142 = math.floor(v141);

            if v142 < 1 then
                return;
            end;

            if v142 <= #u19 then
                for i = math.max(u28 + 1, 1), math.min(v142, #u22) do
                    local v143 = u22[i];

                    if v143 then
                        if not v143.IsPlaying then
                            v143:Play();
                        end;

                        u22[i] = false;
                    end;
                end;

                u28 = v142;
                u1.Position = u19[v142];
                u1.Velocity = u20[v142];
                u1.RotVelocity = u21[v142];
                local v144 = u16 * (1 - softImpact(v142, u17));
                u1.Position = u1.Position - v144;

                if u1.Position.Y < u10 then
                    u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);

                    return;
                end;
            else
                if u26 then
                    u27 = false;
                    u29 = false;
                    GoalEvent:FireServer(u26, "dihtelkds");
                    wait(0.3);

                    if not u29 then
                        Sound3:Play();
                    end;

                    u1.Velocity = Vector3.new(u1.Velocity.X * 0.3, u1.Velocity.Y * 0.3, u1.Velocity.Z * 0.3);
                    u1.RotVelocity = Vector3.new(u1.RotVelocity.X * 0.3, u1.RotVelocity.Y * 0.3, u1.RotVelocity.Z * 0.3);

                    return;
                end;

                u25 = u1.Position;
            end;
        end;

        return;
    end;

    u1.Position = Vector3.new(u25.X, u1.Position.Y, u25.Z);
    u1.Velocity = Vector3.new(0, u1.Velocity.Y, 0);
    u1.RotVelocity = Vector3.new(0, 0, 0);
end;

function startAnimation(p145, p146, p147, p148, p149)
    -- upvalues: u19 (ref), u20 (ref), u21 (ref), u22 (ref), u26 (ref), u27 (ref), u25 (ref), u18 (ref), u16 (ref), u15 (ref), u28 (ref)
    local v150, v151, v152, v153, v154 = recordBallAnimation(p145, p146, p147);
    u19 = v150;
    u20 = v151;
    u21 = v152;
    u22 = v153;
    u26 = v154;
    u27 = true;
    u25 = nil;
    u18 = tick();
    u16 = p148;
    u15 = p149 / #v150;
    u28 = 0;
end;

function createBall(p155)
    -- upvalues: u1 (ref), Value (copy), ReplicatedStorage (copy)
    u1 = workspace.FootballField:FindFirstChild("SoccerBall");

    if u1 == nil then
        if Value == 3 then
            u1 = ReplicatedStorage:WaitForChild("BeachBall"):Clone();
            u1.Name = "SoccerBall";
        else
            u1 = ReplicatedStorage:WaitForChild("SoccerBall"):Clone();
        end;

        u1.Parent = workspace.FootballField;
    end;
end;

function onDropBall(p156)
    -- upvalues: u1 (ref), u25 (ref), u2 (ref), u26 (ref)
    pcall(createBall, p156);

    if u1 then
        if p156 then
            u1.Position = Vector3.new(-214.544, 25, 92.531) + p156;
        else
            u1.Position = Vector3.new(-214.544, 25, 92.531);
        end;

        u25 = u1.Position;
    end;

    u2 = 0;
    u26 = nil;
end;

DropBallEvent.OnClientEvent:Connect(onDropBall);

function onRemoveBall()
    -- upvalues: u1 (ref)
    if u1 then
        u1:Destroy();
        u1 = nil;
    end;
end;

RemoveBallEvent.OnClientEvent:Connect(onRemoveBall);

function onMeasureLagEvent(p157)
    -- upvalues: u1 (ref), MeasureLag (copy)
    if u1 then
        MeasureLag:FireServer(p157);
    end;
end;

MeasureLagEvent.OnClientEvent:Connect(onMeasureLagEvent);

function onBallPositionEvent(p158, p159, p160)
    -- upvalues: u4 (ref), u23 (ref), u24 (ref), LocalPlayer (copy)
    u4 = p158;
    u23 = p159;
    u24 = p160;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local v161 = PlayerGui and PlayerGui:FindFirstChild("Ping", true);

    if v161 then
        local v162 = math.round(u4 * 2000);
        v161.Text = v162 .. "ms";

        if v162 <= 60 then
            v161.TextColor3 = Color3.new(0, 1, 0);

            return;
        end;

        if v162 <= 120 then
            v161.TextColor3 = Color3.new(1, 1, 0.498039);

            return;
        end;

        v161.TextColor3 = Color3.new(1, 0, 0);
    end;
end;

BallPositionEvent.OnClientEvent:Connect(onBallPositionEvent);

function onKickBallEvent(p163, p164, p165, p166)
    -- upvalues: u29 (ref), LocalPlayer (copy), u3 (ref), u1 (ref)
    u29 = true;

    if LocalPlayer.UserId ~= p163.UserId then
        u3 = tick();
        pcall(createBall, nil);

        if u1 then
            startAnimation(p164, p165, p166, p164 - u1.Position, 0);
        end;
    end;
end;

KickBallEvent.OnClientEvent:Connect(onKickBallEvent);

function getClosestPlayerName()
    -- upvalues: u23 (ref), u24 (ref), u1 (ref)
    local v167 = nil;
    local v168 = 10000;

    if u23 and u24 then
        for i, v in pairs(u24) do
            local Magnitude = (u1.Position - v).Magnitude;

            if Magnitude < v168 then
                v167 = u23[i];
                v168 = Magnitude;
            end;
        end;
    end;

    return v167;
end;

function touchDetect()
local maxRange = 4
if states.reachActive then
	maxRange = states.reachRange
end
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), Humanoid (copy), u10 (ref), KickBall (copy), u4 (ref)
    if LocalPlayer and (LocalPlayer.Character and (u1 and (tick() - u2 >= 0.6 and (tick() - u3 >= 0.3 and (states.mode == "Regular" or getClosestPlayerName() == LocalPlayer.Name))))) then
        local Position = LocalPlayer.Character.UpperTorso.Position;
        local Position2 = u1.Position;
        local Magnitude = (Position2 - Position).Magnitude;

        if Magnitude > 0.01 and Magnitude <= maxRange then
            u2 = tick();
            local v169 = Position + Vector3.new(0, -3, 0);
            local v170 = Position + Vector3.new(0, 1.3, 0);
            local v171 = 34;
            local v172;

            if (v170 - Position2).Magnitude < (v169 - Position2).Magnitude then
                v172 = Position2 - v170;
                v171 = 0;
            else
                local v173 = Position2 - v169;
                v172 = Vector3.new(v173.X, 0, v173.Z);
            end;

if game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamA") and game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamB") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Team") then
	local NameTeamA = game:GetService("ReplicatedStorage").NameTeamA.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
local NameTeamB = game:GetService("ReplicatedStorage").NameTeamB.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
if NameTeamA == Team then

	states.Goal = "B"
	elseif NameTeamB == Team then
		
		 states.Goal = "A"

end
	else

local fp = Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)
local sp = Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)

if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - fp).Magnitude < (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - sp).Magnitude then
    states.Goal = "A"
else
    states.Goal = "B"
end
end




            local Unit
			if states.Aimbot then
				if states.Goal == "A" then
if states.Type == "Random" then
    local goal1randomizers = {
        Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219), -- net
        Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
    }

    local randomposition = goal1randomizers[math.random(1, #goal1randomizers)]
    Unit = (randomposition - u1.Position).Unit

elseif states.Type == "Top Left Corner" then
    Unit = (Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562)-u1.Position).Unit

elseif states.Type == "Top Right Corner" then
    Unit = (Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656)-u1.Position).Unit

elseif states.Type == "Net" then
    Unit = (Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)-u1.Position).Unit

elseif states.Type == "Bottom Left Corner" then
    Unit = (Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938)-u1.Position).Unit

elseif states.Type == "Bottom Right Corner" then
    Unit = (Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781)-u1.Position).Unit
end
					else
if states.Type == "Random" then
	
local goal2randomizers = {
	Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578), -- net
	Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)

}
local randomposition = goal2randomizers[math.random(1, #goal2randomizers)]
Unit = (randomposition - u1.Position).Unit
elseif states.Type == "Top Left Corner" then
Unit = (Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312)-u1.Position).Unit
	elseif states.Type == "Top Right Corner" then

Unit = (Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)-u1.Position).Unit
elseif states.Type == "Net" then
	Unit = (Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)-u1.Position).Unit
	elseif states.Type == "Bottom Left Corner" then
		Unit = (Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961)-u1.Position).Unit
		elseif states.Type == "Bottom Right Corner" then
			Unit = (Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297)-u1.Position).Unit
end
				end
			else
			Unit = v172.Unit;
			end

            if states.Aimbot and states.Goal == "A" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalA = {
    Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
}

for _, position in cornersGoalA do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

              if states.Aimbot and states.Goal == "B" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalB = {
    Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)
}

for _, position in cornersGoalB do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

            if Unit.Magnitude > 0.01 then
                local v174 = Vector3.new(0, 0, 0);
                local LookVector = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector;
                local Unit2 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
                local v175 = math.atan2(Unit2.X, Unit2.Z) - math.atan2(Unit.X, Unit.Z);
                local v176 = math.abs(v175);
                local v177 = math.deg(v176);

                if v177 <= 20 then
                    Unit = (Unit2 + Unit).Unit;
                end;

                if v177 < 90 then
                    local v178 = v177 / 3;

                    if v175 < 0 then
                        v174 = Vector3.new(0, v178, 0);
                    else
                        v174 = Vector3.new(0, -v178, 0);
                    end;
                end;

                local WalkSpeed = Humanoid.WalkSpeed;

                if WalkSpeed <= 46 then
                    local v179;

                    if WalkSpeed >= 19 then
						local v180
                        if states.Aimbot then
							v180 = Vector3.new(0, states.Height, 0);
							else
							v180 = Vector3.new(0, 34, 0);
						end
                        local v181 = (WalkSpeed - 19) * 10 + 40 + Vector3.new(u1.Velocity.X, 0, u1.Velocity.Z).Magnitude;
						local power = 85
						local v182
						if states.powerShotActive then
							power = states.powerShotPower
							v182 = Unit * power + v180;
							else
							v182 = Unit * (v181 > power and power or v181) + v180;
						end
                        local X = v182.X;
                        local v183 = math.min(v182.Y, 40);
                        v179 = Vector3.new(X, v183, v182.Z);
                    elseif WalkSpeed == 16 then
                        v179 = Unit * 20 + Vector3.new(0, 0, 0);
                    else
                        v179 = Unit * ((WalkSpeed - 16) * 15 + 25) + Vector3.new(0, 5, 0);
                    end;

                    if u1.Position.Y < u10 then
                        u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);
                    end;

					if states.NoSpin and states.Aimbot then
						v174 = Vector3.new(0, 0, 0)
					end

                    KickBall:FireServer(u1.Position, v179, v174, Magnitude, "dihtelkds");
                    startAnimation(u1.Position, v179, v174, Vector3.new(0, 0, 0), u4);
                end;
            end;
        end;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 756
    pcall(touchDetect);
    pcall(animateBall);
    pcall(checkNearGoal);
end);

-- ===== SETTINGS =====
local LINE_COLOR = Color3.fromRGB(120,150,255)
local LINE_MATERIAL = Enum.Material.Neon
local DRAW_THICKNESS = 0.5
local LINE_TRANSPARENCY = 0
local SEG_MIN_DIST = 0.03
local FLOOR_Y = 5.473

-- ===== VISUAL FOLDER =====
local visuals = workspace:FindFirstChild("trajectory")
if not visuals then
    visuals = Instance.new("Folder")
    visuals.Name = "trajectory"
    visuals.Parent = workspace
end

local function clearVisuals()
    for _,v in ipairs(visuals:GetChildren()) do
        v:Destroy()
    end
end

-- ===== DRAW HELPERS =====
local function createSegment(a,b)
    local dir = b-a
    local d = dir.Magnitude
    if d < SEG_MIN_DIST then return end

    local mid = (a+b)*0.5

    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.CastShadow = false
    p.Material = LINE_MATERIAL
    p.Color = LINE_COLOR
    p.Transparency = LINE_TRANSPARENCY
    p.Size = Vector3.new(DRAW_THICKNESS,2,d)
    p.CFrame = CFrame.new(mid,mid+dir)*CFrame.Angles(math.pi/2,0,0)
    p.Parent = visuals
end

local function drawPath(points)
    for i=1,#points-1 do
        local a = Vector3.new(points[i].X, math.max(points[i].Y,FLOOR_Y), points[i].Z)
        local b = Vector3.new(points[i+1].X, math.max(points[i+1].Y,FLOOR_Y), points[i+1].Z)
        createSegment(a,b)
    end
end

local function createMarker(pos)
    local m = Instance.new("Part")
    m.Shape = Enum.PartType.Ball
    m.Anchored = true
    m.CanCollide = false
    m.CastShadow = false
    m.Material = Enum.Material.Neon
    m.Color = Color3.fromRGB(211,211,211)
    m.Size = Vector3.new(1.5,1.5,1.5)
    m.CFrame = CFrame.new(pos)
    m.Parent = visuals
end

-- ===== EVENT HOOK =====
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local event = RS:FindFirstChild("KickBallEvent")
if not event then return end

event.OnClientEvent:Connect(function(...)
    if not states.trajectoryActive then
        clearVisuals()
        return
    end
 

    clearVisuals()

    local player = Players.LocalPlayer
    local char = player.Character
    if not char then return end

    

  

    local args = {...}
    local pos,vel,spin = args[2],args[3],args[4]

    if typeof(pos) ~= "Vector3" and typeof(args[1])=="Vector3" then
        pos,vel,spin = args[1],args[2],args[3]
    end

    if typeof(pos)~="Vector3" or typeof(vel)~="Vector3" then return end

    local pts
    local success = pcall(function()
        pts = recordBallAnimation(pos,vel,spin)
    end)

    if not success or not pts or #pts < 2 then return end

    task.defer(function()
        drawPath(pts)

    end)

    pcall(function()
        createMarker(pts[1])

        if ballInGoalA(pts[#pts])
        or ballInGoalB(pts[#pts]) then
            createMarker(pts[#pts])
        else
            createMarker(pts[math.round(#pts/1.6)])
        end
    end)
end)
end
			end)
			task.spawn(function()
if game.Workspace:FindFirstChild("PrivateServer") then

-- Script Path: game:GetService("Workspace").puccibarbiefifi.BallHandler
-- Took 0.05s to decompile.
-- Executor: Potassium (v2.3.3)

-- Decompiled with Potassium's decompiler.

-- Decompiled with Potassium's decompiler.
local BallHandler
if game.Players.LocalPlayer.Character:FindFirstChild("BallHandler") then
	game.Players.LocalPlayer.Character:FindFirstChild("BallHandler"):Destroy()
end

local Humanoid
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
game.Players.LocalPlayer.CharacterAdded:Connect(function ()
	Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
	BallHandler = game.Players.LocalPlayer.Character:WaitForChild("BallHandler")
	BallHandler:Destroy()
end)
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KickBall = ReplicatedStorage:WaitForChild("KickBall");
local DropBallEvent = ReplicatedStorage:WaitForChild("DropBallEvent");
local RemoveBallEvent = ReplicatedStorage:WaitForChild("RemoveBallEvent");
local BallPositionEvent = ReplicatedStorage:WaitForChild("BallPositionEvent");
local KickBallEvent = ReplicatedStorage:WaitForChild("KickBallEvent");
local LocalPlayer = Players.LocalPlayer;
local MeasureLag = ReplicatedStorage:WaitForChild("MeasureLag");
local MeasureLagEvent = ReplicatedStorage:WaitForChild("MeasureLagEvent");
local GoalEvent = ReplicatedStorage:WaitForChild("GoalEvent");
local NearGoalEvent = ReplicatedStorage:WaitForChild("NearGoalEvent");
local u1 = nil;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local u5 = 0.55;
local u6 = 55;
local u7 = 0;
local u8 = 0;
local u9 = 0;
local u10 = 5.473;
local u11 = 0;
local u12 = nil;
local u13 = 0;
local u14 = 0;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = false;
local u24 = 0;
local u25 = false;
local u26 = 0;
local Sound = Instance.new("Sound", game.Workspace);
Sound.SoundId = "rbxassetid://82599119475859";
Sound.Volume = 0.4;
local Sound2 = Instance.new("Sound", game.Workspace);
Sound2.SoundId = "rbxassetid://74303966391925";
Sound2.Volume = 0.4;
local Sound3 = Instance.new("Sound", game.Workspace);
Sound3.SoundId = "rbxassetid://122054734580185";
Sound3.Volume = 0.5;
local Sound4 = Instance.new("Sound", game.Workspace);
Sound4.SoundId = "rbxassetid://9119319842";
Sound4.Volume = 1;

function ballBouncedFloor(p27)
    -- upvalues: u10 (ref)
    return p27.Y < u10;
end;

function ballInGoalA(p28)
    -- upvalues: u7 (ref), u8 (ref)
    return p28.X < -313.13 and (p28.Z >= u7 + 78.036 and (p28.Z <= 107.715 - u7 and p28.Y <= u8 + 17));
end;

function ballInGoalB(p29)
    -- upvalues: u7 (ref), u8 (ref)
    return p29.X > -115.936 and (p29.Z >= u7 + 78.036 and (p29.Z <= 107.715 - u7 and p29.Y <= u8 + 17));
end;

local function copyVec(p30) -- Line: 138
    return {
        X = p30.X,
        Y = p30.Y,
        Z = p30.Z
    };
end;

local function reflectVelocity(p31, p32) -- Line: 142
    local v33 = p31.X * p32.X + p31.Y * p32.Y + p31.Z * p32.Z;

    return {
        X = p31.X - 2 * v33 * p32.X,
        Y = p31.Y - 2 * v33 * p32.Y,
        Z = p31.Z - 2 * v33 * p32.Z
    };
end;

local function length2(p34, p35) -- Line: 147
    return math.sqrt(p34 * p34 + p35 * p35);
end;

local function hitPost(p36, p37, p38, p39) -- Line: 151
    -- upvalues: reflectVelocity (copy)
    local v40 = p38.X - p36;
    local v41 = p38.Z - p37;
    local v42 = math.sqrt(v40 * v40 + v41 * v41);

    if v42 > 1.825 or (p38.Y < -1.5 or p38.Y > 19.5) then
        return false, p38, {
            X = p39.X,
            Y = p39.Y,
            Z = p39.Z
        };
    end;

    local v43, v44;

    if v42 > 1e-9 then
        v43 = v40 / v42;
        v44 = v41 / v42;
    else
        v43 = 0;
        v44 = 1;
        v42 = 1e-9;
    end;

    if p39.X * v43 + p39.Z * v44 >= 0 then
        return false, p38, {
            X = p39.X,
            Y = p39.Y,
            Z = p39.Z
        };
    end;

    local v45 = 1.8259999999999998 - v42;

    return true, Vector3.new(p38.X + v43 * v45, p38.Y, p38.Z + v44 * v45), reflectVelocity(p39, {
        Y = 0,
        X = v43,
        Z = v44
    });
end;

local function hitBar(p46, p47, p48) -- Line: 193
    -- upvalues: reflectVelocity (copy)
    if p47.Z >= 76.536 and p47.Z <= 109.215 then
        local v49 = p47.X - p46;
        local v50 = p47.Y - 18;
        local v51 = math.sqrt(v49 * v49 + v50 * v50);

        if v51 <= 1.825 then
            local v52, v53;

            if v51 > 1e-9 then
                v52 = v49 / v51;
                v53 = v50 / v51;
            else
                v52 = 0;
                v53 = 1;
                v51 = 1e-9;
            end;

            if p48.X * v52 + p48.Y * v53 >= 0 then
                return false, p47, {
                    X = p48.X,
                    Y = p48.Y,
                    Z = p48.Z
                };
            end;

            local v54 = 1.8259999999999998 - v51;

            return true, Vector3.new(p47.X + v52 * v54, p47.Y + v53 * v54, p47.Z), reflectVelocity(p48, {
                Z = 0,
                X = v52,
                Y = v53
            });
        end;
    end;

    return false, p47, {
        X = p48.X,
        Y = p48.Y,
        Z = p48.Z
    };
end;

function ballHitsLeftPoleA(p55, p56)
    -- upvalues: hitPost (copy)
    return hitPost(-313.13, 78.036, p55, p56);
end;

function ballHitsRightPoleA(p57, p58)
    -- upvalues: hitPost (copy)
    return hitPost(-313.13, 107.715, p57, p58);
end;

function ballHitsCrossbarA(p59, p60)
    -- upvalues: hitBar (copy)
    return hitBar(-313.13, p59, p60);
end;

function ballHitsLeftPoleB(p61, p62)
    -- upvalues: hitPost (copy)
    return hitPost(-115.936, 78.036, p61, p62);
end;

function ballHitsRightPoleB(p63, p64)
    -- upvalues: hitPost (copy)
    return hitPost(-115.936, 107.715, p63, p64);
end;

function ballHitsCrossbarB(p65, p66)
    -- upvalues: hitBar (copy)
    return hitBar(-115.936, p65, p66);
end;

function ballHitsGoalFrame(p67, p68)
    local v69, v70, v71 = ballHitsLeftPoleA(p67, p68);

    if v69 then
        return true, v70, v71, "LeftPoleA";
    end;

    local v72, v73, v74 = ballHitsRightPoleA(p67, p68);

    if v72 then
        return true, v73, v74, "RightPoleA";
    end;

    local v75, v76, v77 = ballHitsCrossbarA(p67, p68);

    if v75 then
        return true, v76, v77, "CrossbarA";
    end;

    local v78, v79, v80 = ballHitsLeftPoleB(p67, p68);

    if v78 then
        return true, v79, v80, "LeftPoleB";
    end;

    local v81, v82, v83 = ballHitsRightPoleB(p67, p68);

    if v81 then
        return true, v82, v83, "RightPoleB";
    end;

    local v84, v85, v86 = ballHitsCrossbarB(p67, p68);

    if v84 then
        return true, v85, v86, "CrossbarB";
    end;

    return false, p67, {
        X = p68.X,
        Y = p68.Y,
        Z = p68.Z
    }, "";
end;

function checkNearGoal()
    -- upvalues: u1 (ref), u26 (ref), u7 (ref), u8 (ref), NearGoalEvent (copy)
    if u1 and (tick() - u26 > 5 and u1.Velocity.Magnitude > 10) then
        if u1.Position.X < -309 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u26 = tick();
            NearGoalEvent:FireServer("B");

            return;
        end;

        if u1.Position.X > -120 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u26 = tick();
            NearGoalEvent:FireServer("A");
        end;
    end;
end;

function soccerBallTrajectory(p87, p88, p89, p90, p91)
    local X = p88.X;
    local Z = p88.Z;
    local Y = p88.Y;
    local X2 = p89.X;
    local Z2 = p89.Z;
    local Y2 = p89.Y;
    local v92 = p91 * p87;
    local v93 = X * math.cos(v92) - Z * math.sin(v92);
    local v94 = X * math.sin(v92) + Z * math.cos(v92);

    return Vector3.new(X2 + X * p87 + 0.5 * (v93 - X) * p87, Y2 + Y * p87 - 0.5 * p90 * p87 ^ 2, Z2 + Z * p87 + 0.5 * (v94 - Z) * p87), Vector3.new(v93, Y - p90 * p87, v94);
end;

function getBallRotationOnImpact(p95)
    local v96 = Vector3.new(p95.X, 0, p95.Z);

    return (Vector3.new(0, 1, 0)):Cross(v96.Unit).Unit * (v96.Magnitude * 0.8 / 1.5);
end;

function getBounceVelocity(p97, p98, p99, p100, p101, p102)
    -- upvalues: u9 (ref)
    local v103;

    if p97.Z > p102 - u9 then
        local X = p98.X;
        local Y = p98.Y;
        local v104 = -math.abs(p98.Z);
        p98 = Vector3.new(X, Y, v104);
        v103 = true;
    else
        v103 = false;
    end;

    if p97.Z < p101 + u9 then
        local X = p98.X;
        local Y = p98.Y;
        local v105 = math.abs(p98.Z);
        p98 = Vector3.new(X, Y, v105);
        v103 = true;
    end;

    if p100 < p97.X then
        local v106 = -math.abs(p98.X);
        p98 = Vector3.new(v106, p98.Y, p98.Z);
        v103 = true;
    end;

    if p97.X < p99 then
        local v107 = math.abs(p98.X);
        p98 = Vector3.new(v107, p98.Y, p98.Z);
        v103 = true;
    end;

    return p98, v103;
end;

function ensureInside(p108, p109, p110, p111, p112)
    local v113 = math.clamp(p108.X, p109, p110);
    local v114 = math.clamp(p108.Z, p111, p112);

    return Vector3.new(v113, p108.Y, v114);
end;

function recordBallAnimation(p115, p116, p117)
    -- upvalues: u13 (ref), u6 (ref), u10 (ref), u5 (ref), Sound (copy), Sound4 (copy), Sound2 (copy)
    local v118 = {};
    local v119 = {};
    local v120 = {};
    local v121 = {};
    table.insert(v118, p115);
    table.insert(v119, p116);
    table.insert(v120, p117);
    table.insert(v121, false);
    local v122 = 0;
    local v123 = p117.Y / -45;
    local v124 = nil;
    u13 = 0;
    local v125 = p115;

    for i = 1, 2000 do
        local v126 = ensureInside(p115, -313.13, -115.936, 23.443, 161.748);
        local v127;
        p115, v127 = soccerBallTrajectory(v122, p116, v125, u6, v123);

        if v127.Magnitude < 0.5 then
            break;
        end;

        local v128 = nil;
        local v129 = false;
        local v130, v131, v132 = ballHitsGoalFrame(p115, v127);

        if v130 then
            p116 = Vector3.new(v132.X * 0.6, v132.Y * 0.7, v132.Z * 0.6);
            p117 = p117 * 0.8;
            v123 = p117.Y / -45;
            v127 = p116;
            p115 = v131;
            v122 = 0;
        else
            if ballInGoalA(p115) then
                v124 = "B";
                table.insert(v118, p115);
                table.insert(v119, v127);
                table.insert(v120, p117);
                table.insert(v121, false);

                if u13 == 0 then
                    u13 = i;
                end;

                break;
            end;

            if ballInGoalB(p115) then
                v124 = "A";
                table.insert(v118, p115);
                table.insert(v119, v127);
                table.insert(v120, p117);
                table.insert(v121, false);

                if u13 == 0 then
                    u13 = i;
                end;

                break;
            end;

            local v133;
            v133, v128 = getBounceVelocity(p115, v127, -313.13, -115.936, 23.443, 161.748);

            if v128 then
                p115 = Vector3.new(v126.X, p115.Y, v126.Z);
                p116 = Vector3.new(v133.X * 0.6, v133.Y * 0.7, v133.Z * 0.6);
                p117 = p117 * 0.8;
                v123 = p117.Y / -45;
                v127 = p116;
                v131 = p115;
                v122 = 0;
            else
                v131 = v125;
            end;

            v129 = ballBouncedFloor(p115);

            if v129 then
                v131 = Vector3.new(p115.X, u10, p115.Z);

                if u13 == 0 then
                    u13 = i;
                end;

                p117 = getBallRotationOnImpact(v127) + Vector3.new(0, p117.Y * 0.8, 0);
                local v134 = math.abs(v127.Y) < 10 and 0.99 or 0.8;
                p116 = Vector3.new(v127.X * v134, v127.Y * -u5, v127.Z * v134);
                v123 = p117.Y / -45;
                v127 = p116;
                p115 = v131;
                v122 = 0;
            end;
        end;

        table.insert(v118, p115);
        table.insert(v119, v127);
        table.insert(v120, p117);

        if v130 then
            table.insert(v121, Sound);
        elseif v129 and math.abs(v127.Y) >= 10 then
            table.insert(v121, Sound4);
        elseif v128 then
            table.insert(v121, Sound2);
        else
            table.insert(v121, false);
        end;

        v122 = v122 + 0.005;
        v125 = v131;
    end;

    return v118, v119, v120, v121, v124;
end;

function softImpact(p135, p136)
    if p136 <= 0 then
        return 0;
    end;

    if p136 < p135 then
        p135 = p136;
    end;

    return math.sin(1.57 * p135 / p136);
end;

function animateBall()
    -- upvalues: u1 (ref), u21 (ref), u23 (ref), u14 (ref), u11 (ref), u15 (ref), u24 (ref), u18 (ref), u16 (ref), u17 (ref), u12 (ref), u13 (ref), u10 (ref), u22 (ref), u25 (ref), GoalEvent (copy), Sound3 (copy)
    if not (u1 and u21) then
        if u1 and u23 then
            local v137 = (tick() - u14) / (u11 + 0.005);
            local v138 = math.floor(v137);

            if v138 < 1 then
                return;
            end;

            if v138 <= #u15 then
                for i = math.max(u24 + 1, 1), math.min(v138, #u18) do
                    local v139 = u18[i];

                    if v139 then
                        if not v139.IsPlaying then
                            v139:Play();
                        end;

                        u18[i] = false;
                    end;
                end;

                u24 = v138;
                u1.Position = u15[v138];
                u1.Velocity = u16[v138];
                u1.RotVelocity = u17[v138];
                local v140 = u12 * (1 - softImpact(v138, u13));
                u1.Position = u1.Position - v140;

                if u1.Position.Y < u10 then
                    u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);

                    return;
                end;
            else
                if u22 then
                    u23 = false;
                    u25 = false;
                    GoalEvent:FireServer(u22);
                    wait(0.3);

                    if not u25 then
                        Sound3:Play();
                    end;

                    u1.Velocity = Vector3.new(u1.Velocity.X * 0.3, u1.Velocity.Y * 0.3, u1.Velocity.Z * 0.3);
                    u1.RotVelocity = Vector3.new(u1.RotVelocity.X * 0.3, u1.RotVelocity.Y * 0.3, u1.RotVelocity.Z * 0.3);

                    return;
                end;

                u21 = u1.Position;
            end;
        end;

        return;
    end;

    u1.Position = Vector3.new(u21.X, u1.Position.Y, u21.Z);
    u1.Velocity = Vector3.new(0, u1.Velocity.Y, 0);
    u1.RotVelocity = Vector3.new(0, 0, 0);
end;

function startAnimation(p141, p142, p143, p144, p145)
    -- upvalues: u15 (ref), u16 (ref), u17 (ref), u18 (ref), u22 (ref), u23 (ref), u21 (ref), u14 (ref), u12 (ref), u11 (ref), u24 (ref)
    local v146, v147, v148, v149, v150 = recordBallAnimation(p141, p142, p143);
    u15 = v146;
    u16 = v147;
    u17 = v148;
    u18 = v149;
    u22 = v150;
    u23 = true;
    u21 = nil;
    u14 = tick();
    u12 = p144;
    u11 = p145 / #v146;
    u24 = 0;
end;

function createBall(p151)
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    u1 = workspace.FootballField:FindFirstChild("SoccerBall");

    if u1 == nil then
        u1 = ReplicatedStorage:WaitForChild("SoccerBall"):Clone();
        u1.Parent = workspace.FootballField;
    end;
end;

function onDropBall(p152)
    -- upvalues: u1 (ref), u21 (ref), u2 (ref), u22 (ref)
    pcall(createBall, p152);

    if u1 then
        if p152 then
            u1.Position = Vector3.new(-214.544, 25, 92.531) + p152;
        else
            u1.Position = Vector3.new(-214.544, 25, 92.531);
        end;

        u21 = u1.Position;
    end;

    u2 = 0;
    u22 = nil;
end;

DropBallEvent.OnClientEvent:Connect(onDropBall);

function onRemoveBall()
    -- upvalues: u1 (ref)
    if u1 then
        u1.Enabled = false
        u1 = nil;
    end;
end;

RemoveBallEvent.OnClientEvent:Connect(onRemoveBall);

function onMeasureLagEvent(p153)
    -- upvalues: u1 (ref), MeasureLag (copy)
    if u1 then
        MeasureLag:FireServer(p153);
    end;
end;

MeasureLagEvent.OnClientEvent:Connect(onMeasureLagEvent);

function onBallPositionEvent(p154, p155, p156)
    -- upvalues: u4 (ref), u19 (ref), u20 (ref), LocalPlayer (copy)
    u4 = p154;
    u19 = p155;
    u20 = p156;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local v157 = PlayerGui and PlayerGui:FindFirstChild("Ping", true);

    if v157 then
        local v158 = math.round(u4 * 2000);
        v157.Text = v158 .. "ms";

        if v158 <= 60 then
            v157.TextColor3 = Color3.new(0, 1, 0);

            return;
        end;

        if v158 <= 120 then
            v157.TextColor3 = Color3.new(1, 1, 0.498039);

            return;
        end;

        v157.TextColor3 = Color3.new(1, 0, 0);
    end;
end;

BallPositionEvent.OnClientEvent:Connect(onBallPositionEvent);

function onKickBallEvent(p159, p160, p161, p162)
    -- upvalues: u25 (ref), LocalPlayer (copy), u3 (ref), u1 (ref)
    u25 = true;

    if LocalPlayer.UserId ~= p159.UserId then
        u3 = tick();
        pcall(createBall, nil);

        if u1 then
            startAnimation(p160, p161, p162, p160 - u1.Position, 0);
        end;
    end;
end;

KickBallEvent.OnClientEvent:Connect(onKickBallEvent);

function getClosestPlayerName()
    -- upvalues: u19 (ref), u20 (ref), u1 (ref)
    local v163 = nil;
    local v164 = 10000;

    if u19 and u20 then
        for i, v in pairs(u20) do
            local Magnitude = (u1.Position - v).Magnitude;

            if Magnitude < v164 then
                v163 = u19[i];
                v164 = Magnitude;
            end;
        end;
    end;

    return v163;
end;

function touchDetect()
local maxRange = 4
if states.reachActive then
	maxRange = states.reachRange
end
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), Humanoid (copy), u10 (ref), KickBall (copy), u4 (ref)
    if LocalPlayer and (LocalPlayer.Character and (u1 and (tick() - u2 >= 0.6 and (tick() - u3 >= 0.3 and (states.mode == "Regular" or getClosestPlayerName() == LocalPlayer.Name))))) then
        local Position = LocalPlayer.Character.UpperTorso.Position;
        local Position2 = u1.Position;
        local Magnitude = (Position2 - Position).Magnitude;

        if Magnitude > 0.01 and Magnitude <= maxRange then
            u2 = tick();
            local v165 = Position + Vector3.new(0, -3, 0);
            local v166 = Position + Vector3.new(0, 1.3, 0);
            local v167 = 34;
            local v168;

            if (v166 - Position2).Magnitude < (v165 - Position2).Magnitude then
                v168 = Position2 - v166;
                v167 = 0;
            else
                local v169 = Position2 - v165;
                v168 = Vector3.new(v169.X, 0, v169.Z);
            end;

if game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamA") and game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamB") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Team") then
	local NameTeamA = game:GetService("ReplicatedStorage").NameTeamA.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
local NameTeamB = game:GetService("ReplicatedStorage").NameTeamB.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
if NameTeamA == Team then

	states.Goal = "B"
	elseif NameTeamB == Team then

		 states.Goal = "A"

end
	else

local fp = Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)
local sp = Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)

if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - fp).Magnitude < (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - sp).Magnitude then
    states.Goal = "A"
else
    states.Goal = "B"
end
end

            local Unit
			if states.Aimbot then
				if states.Goal == "A" then
if states.Type == "Random" then
    local goal1randomizers = {
        Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219), -- net
        Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
    }

    local randomposition = goal1randomizers[math.random(1, #goal1randomizers)]
    Unit = (randomposition - u1.Position).Unit

elseif states.Type == "Top Left Corner" then
    Unit = (Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562)-u1.Position).Unit

elseif states.Type == "Top Right Corner" then
    Unit = (Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656)-u1.Position).Unit

elseif states.Type == "Net" then
    Unit = (Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)-u1.Position).Unit

elseif states.Type == "Bottom Left Corner" then
    Unit = (Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938)-u1.Position).Unit

elseif states.Type == "Bottom Right Corner" then
    Unit = (Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781)-u1.Position).Unit
end
					else
if states.Type == "Random" then
local goal2randomizers = {
	Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578), -- net
	Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)

}
local randomposition = goal2randomizers[math.random(1, #goal2randomizers)]
Unit = (randomposition - u1.Position).Unit
elseif states.Type == "Top Left Corner" then
Unit = (Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312)-u1.Position).Unit
	elseif states.Type == "Top Right Corner" then

Unit = (Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)-u1.Position).Unit
elseif states.Type == "Net" then
	Unit = (Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)-u1.Position).Unit
	elseif states.Type == "Bottom Left Corner" then
		Unit = (Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961)-u1.Position).Unit
		elseif states.Type == "Bottom Right Corner" then
			Unit = (Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297)-u1.Position).Unit
end
				end
			else
			Unit = v168.Unit;
			end

            if states.Aimbot and states.Goal == "A" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalA = {
    Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
}

for _, position in cornersGoalA do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

              if states.Aimbot and states.Goal == "B" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalB = {
    Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)
}

for _, position in cornersGoalB do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

            if Unit.Magnitude > 0.01 then
                local v170 = Vector3.new(0, 0, 0);
                local LookVector = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector;
                local Unit2 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
                local v171 = math.atan2(Unit2.X, Unit2.Z) - math.atan2(Unit.X, Unit.Z);
                local v172 = math.abs(v171);
                local v173 = math.deg(v172);

                if v173 <= 20 then
                    Unit = (Unit2 + Unit).Unit;
                end;

                if v173 < 90 then
                    local v174 = v173 / 3;

                    if v171 < 0 then
                        v170 = Vector3.new(0, v174, 0);
                    else
                        v170 = Vector3.new(0, -v174, 0);
                    end;
                end;

                local WalkSpeed = Humanoid.WalkSpeed;

                if WalkSpeed <= 46 then
                    local v175;

                    if WalkSpeed >= 19 then
						local v176
                        if states.Aimbot then
							v176 = Vector3.new(0, states.Height, 0);
							else
							v176 = Vector3.new(0, 34, 0);
						end
                        local v177 = (WalkSpeed - 19) * 10 + 40 + Vector3.new(u1.Velocity.X, 0, u1.Velocity.Z).Magnitude;
						local power = 85
						local v178
						if states.powerShotActive then
							power = states.powerShotPower
							v178 = Unit * power + v176;
							else
							v178 = Unit * (v177 > power and power or v177) + v176;
						end
                        local X = v178.X;
                        local v179 = math.min(v178.Y, 40);
                        v175 = Vector3.new(X, v179, v178.Z);
                    elseif WalkSpeed == 16 then
                        v175 = Unit * 20 + Vector3.new(0, 0, 0);
                    else
                        v175 = Unit * ((WalkSpeed - 16) * 15 + 25) + Vector3.new(0, 5, 0);
                    end;

                    if u1.Position.Y < u10 then
                        u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);
                    end;

					if states.NoSpin and states.Aimbot then
						v170 = Vector3.new(0, 0, 0)
					end

                    KickBall:FireServer(u1.Position, v175, v170, Magnitude, "dihtelkds");
                    startAnimation(u1.Position, v175, v170, Vector3.new(0, 0, 0), u4);
                end;
            end;
        end;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 742
    pcall(touchDetect);
    pcall(animateBall);
    pcall(checkNearGoal);
end);

-- ===== SETTINGS =====
local LINE_COLOR = Color3.fromRGB(120,150,255)
local LINE_MATERIAL = Enum.Material.Neon
local DRAW_THICKNESS = 0.5
local LINE_TRANSPARENCY = 0
local SEG_MIN_DIST = 0.03
local FLOOR_Y = 5.473

-- ===== VISUAL FOLDER =====
local visuals = workspace:FindFirstChild("trajectory")
if not visuals then
    visuals = Instance.new("Folder")
    visuals.Name = "trajectory"
    visuals.Parent = workspace
end

local function clearVisuals()
    for _,v in ipairs(visuals:GetChildren()) do
        v:Destroy()
    end
end

-- ===== DRAW HELPERS =====
local function createSegment(a,b)
    local dir = b-a
    local d = dir.Magnitude
    if d < SEG_MIN_DIST then return end

    local mid = (a+b)*0.5

    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.CastShadow = false
    p.Material = LINE_MATERIAL
    p.Color = LINE_COLOR
    p.Transparency = LINE_TRANSPARENCY
    p.Size = Vector3.new(DRAW_THICKNESS,2,d)
    p.CFrame = CFrame.new(mid,mid+dir)*CFrame.Angles(math.pi/2,0,0)
    p.Parent = visuals
end

local function drawPath(points)
    for i=1,#points-1 do
        local a = Vector3.new(points[i].X, math.max(points[i].Y,FLOOR_Y), points[i].Z)
        local b = Vector3.new(points[i+1].X, math.max(points[i+1].Y,FLOOR_Y), points[i+1].Z)
        createSegment(a,b)
    end
end

local function createMarker(pos)
    local m = Instance.new("Part")
    m.Shape = Enum.PartType.Ball
    m.Anchored = true
    m.CanCollide = false
    m.CastShadow = false
    m.Material = Enum.Material.Neon
    m.Color = Color3.fromRGB(211,211,211)
    m.Size = Vector3.new(1.5,1.5,1.5)
    m.CFrame = CFrame.new(pos)
    m.Parent = visuals
end

-- ===== EVENT HOOK =====
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local event = RS:FindFirstChild("KickBallEvent")
if not event then return end

event.OnClientEvent:Connect(function(...)
    if not states.trajectoryActive then
        clearVisuals()
        return
    end
  

    clearVisuals()

    local player = Players.LocalPlayer
    local char = player.Character
    if not char then return end

    

  

    local args = {...}
    local pos,vel,spin = args[2],args[3],args[4]

    if typeof(pos) ~= "Vector3" and typeof(args[1])=="Vector3" then
        pos,vel,spin = args[1],args[2],args[3]
    end

    if typeof(pos)~="Vector3" or typeof(vel)~="Vector3" then return end

    local pts
    local success = pcall(function()
        pts = recordBallAnimation(pos,vel,spin)
    end)

    if not success or not pts or #pts < 2 then return end

    task.defer(function()
        drawPath(pts)
      
    end)

    pcall(function()
        createMarker(pts[1])

        if ballInGoalA(pts[#pts])
        or ballInGoalB(pts[#pts]) then
            createMarker(pts[#pts])
        else
            createMarker(pts[math.round(#pts/1.6)])
        end
    end)
end)
end
			end)

			task.spawn(function()
				if game.PlaceId == 16452705111 then

local BallHandler
if game.Players.LocalPlayer.Character:FindFirstChild("BallHandler") then
	game.Players.LocalPlayer.Character:FindFirstChild("BallHandler"):Destroy()
end

local Humanoid
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
game.Players.LocalPlayer.CharacterAdded:Connect(function ()
	Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
	BallHandler = game.Players.LocalPlayer.Character:WaitForChild("BallHandler")
	BallHandler:Destroy()
end)
-- Script Path: game:GetService("Workspace").ILOVEJUICEWRLDGOAT.BallHandler
-- Took 0.09s to decompile.
-- Executor: Potassium (v2.3.5)

-- Decompiled with Potassium's decompiler.


local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KickBall = ReplicatedStorage:WaitForChild("KickBall");
local DropBallEvent = ReplicatedStorage:WaitForChild("DropBallEvent");
local RemoveBallEvent = ReplicatedStorage:WaitForChild("RemoveBallEvent");
local BallPositionEvent = ReplicatedStorage:WaitForChild("BallPositionEvent");
local KickBallEvent = ReplicatedStorage:WaitForChild("KickBallEvent");
local LocalPlayer = Players.LocalPlayer;
local MeasureLag = ReplicatedStorage:WaitForChild("MeasureLag");
local MeasureLagEvent = ReplicatedStorage:WaitForChild("MeasureLagEvent");
local GoalEvent = ReplicatedStorage:WaitForChild("GoalEvent");
local NearGoalEvent = ReplicatedStorage:WaitForChild("NearGoalEvent");
local u1 = nil;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local u5 = 0.55;
local u6 = 55;
local u7 = 0;
local u8 = 0;
local u9 = 0;
local u10 = 5.473;
local u11 = 0;
local u12 = nil;
local u13 = 0;
local u14 = 0;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = false;
local u24 = 0;
local u25 = false;
local u26 = 0;
local Sound = Instance.new("Sound", game.Workspace);
Sound.SoundId = "rbxassetid://82599119475859";
Sound.Volume = 0.4;
local Sound2 = Instance.new("Sound", game.Workspace);
Sound2.SoundId = "rbxassetid://74303966391925";
Sound2.Volume = 0.4;
local Sound3 = Instance.new("Sound", game.Workspace);
Sound3.SoundId = "rbxassetid://122054734580185";
Sound3.Volume = 0.5;
local Sound4 = Instance.new("Sound", game.Workspace);
Sound4.SoundId = "rbxassetid://9119319842";
Sound4.Volume = 1;

function ballBouncedFloor(p27)
    -- upvalues: u10 (ref)
    return p27.Y < u10;
end;

function ballInGoalA(p28)
    -- upvalues: u7 (ref), u8 (ref)
    return p28.X < -313.13 and (p28.Z >= u7 + 78.036 and (p28.Z <= 107.715 - u7 and p28.Y <= u8 + 17));
end;

function ballInGoalB(p29)
    -- upvalues: u7 (ref), u8 (ref)
    return p29.X > -115.936 and (p29.Z >= u7 + 78.036 and (p29.Z <= 107.715 - u7 and p29.Y <= u8 + 17));
end;

local function copyVec(p30) -- Line: 138
    return {
        X = p30.X,
        Y = p30.Y,
        Z = p30.Z
    };
end;

local function reflectVelocity(p31, p32) -- Line: 142
    local v33 = p31.X * p32.X + p31.Y * p32.Y + p31.Z * p32.Z;

    return {
        X = p31.X - 2 * v33 * p32.X,
        Y = p31.Y - 2 * v33 * p32.Y,
        Z = p31.Z - 2 * v33 * p32.Z
    };
end;

local function length2(p34, p35) -- Line: 147
    return math.sqrt(p34 * p34 + p35 * p35);
end;

local function hitPost(p36, p37, p38, p39) -- Line: 151
    -- upvalues: reflectVelocity (copy)
    local v40 = p38.X - p36;
    local v41 = p38.Z - p37;
    local v42 = math.sqrt(v40 * v40 + v41 * v41);

    if v42 > 1.825 or (p38.Y < -1.5 or p38.Y > 19.5) then
        return false, p38, {
            X = p39.X,
            Y = p39.Y,
            Z = p39.Z
        };
    end;

    local v43, v44;

    if v42 > 1e-9 then
        v43 = v40 / v42;
        v44 = v41 / v42;
    else
        v43 = 0;
        v44 = 1;
        v42 = 1e-9;
    end;

    if p39.X * v43 + p39.Z * v44 >= 0 then
        return false, p38, {
            X = p39.X,
            Y = p39.Y,
            Z = p39.Z
        };
    end;

    local v45 = 1.8259999999999998 - v42;

    return true, Vector3.new(p38.X + v43 * v45, p38.Y, p38.Z + v44 * v45), reflectVelocity(p39, {
        Y = 0,
        X = v43,
        Z = v44
    });
end;

local function hitBar(p46, p47, p48) -- Line: 193
    -- upvalues: reflectVelocity (copy)
    if p47.Z >= 76.536 and p47.Z <= 109.215 then
        local v49 = p47.X - p46;
        local v50 = p47.Y - 18;
        local v51 = math.sqrt(v49 * v49 + v50 * v50);

        if v51 <= 1.825 then
            local v52, v53;

            if v51 > 1e-9 then
                v52 = v49 / v51;
                v53 = v50 / v51;
            else
                v52 = 0;
                v53 = 1;
                v51 = 1e-9;
            end;

            if p48.X * v52 + p48.Y * v53 >= 0 then
                return false, p47, {
                    X = p48.X,
                    Y = p48.Y,
                    Z = p48.Z
                };
            end;

            local v54 = 1.8259999999999998 - v51;

            return true, Vector3.new(p47.X + v52 * v54, p47.Y + v53 * v54, p47.Z), reflectVelocity(p48, {
                Z = 0,
                X = v52,
                Y = v53
            });
        end;
    end;

    return false, p47, {
        X = p48.X,
        Y = p48.Y,
        Z = p48.Z
    };
end;

function ballHitsLeftPoleA(p55, p56)
    -- upvalues: hitPost (copy)
    return hitPost(-313.13, 78.036, p55, p56);
end;

function ballHitsRightPoleA(p57, p58)
    -- upvalues: hitPost (copy)
    return hitPost(-313.13, 107.715, p57, p58);
end;

function ballHitsCrossbarA(p59, p60)
    -- upvalues: hitBar (copy)
    return hitBar(-313.13, p59, p60);
end;

function ballHitsLeftPoleB(p61, p62)
    -- upvalues: hitPost (copy)
    return hitPost(-115.936, 78.036, p61, p62);
end;

function ballHitsRightPoleB(p63, p64)
    -- upvalues: hitPost (copy)
    return hitPost(-115.936, 107.715, p63, p64);
end;

function ballHitsCrossbarB(p65, p66)
    -- upvalues: hitBar (copy)
    return hitBar(-115.936, p65, p66);
end;

function ballHitsGoalFrame(p67, p68)
    local v69, v70, v71 = ballHitsLeftPoleA(p67, p68);

    if v69 then
        return true, v70, v71, "LeftPoleA";
    end;

    local v72, v73, v74 = ballHitsRightPoleA(p67, p68);

    if v72 then
        return true, v73, v74, "RightPoleA";
    end;

    local v75, v76, v77 = ballHitsCrossbarA(p67, p68);

    if v75 then
        return true, v76, v77, "CrossbarA";
    end;

    local v78, v79, v80 = ballHitsLeftPoleB(p67, p68);

    if v78 then
        return true, v79, v80, "LeftPoleB";
    end;

    local v81, v82, v83 = ballHitsRightPoleB(p67, p68);

    if v81 then
        return true, v82, v83, "RightPoleB";
    end;

    local v84, v85, v86 = ballHitsCrossbarB(p67, p68);

    if v84 then
        return true, v85, v86, "CrossbarB";
    end;

    return false, p67, {
        X = p68.X,
        Y = p68.Y,
        Z = p68.Z
    }, "";
end;

function checkNearGoal()
    -- upvalues: u1 (ref), u26 (ref), u7 (ref), u8 (ref), NearGoalEvent (copy)
    if u1 and (tick() - u26 > 5 and u1.Velocity.Magnitude > 10) then
        if u1.Position.X < -309 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u26 = tick();
            NearGoalEvent:FireServer("B");

            return;
        end;

        if u1.Position.X > -120 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u26 = tick();
            NearGoalEvent:FireServer("A");
        end;
    end;
end;

function soccerBallTrajectory(p87, p88, p89, p90, p91)
    local X = p88.X;
    local Z = p88.Z;
    local Y = p88.Y;
    local X2 = p89.X;
    local Z2 = p89.Z;
    local Y2 = p89.Y;
    local v92 = p91 * p87;
    local v93 = X * math.cos(v92) - Z * math.sin(v92);
    local v94 = X * math.sin(v92) + Z * math.cos(v92);

    return Vector3.new(X2 + X * p87 + 0.5 * (v93 - X) * p87, Y2 + Y * p87 - 0.5 * p90 * p87 ^ 2, Z2 + Z * p87 + 0.5 * (v94 - Z) * p87), Vector3.new(v93, Y - p90 * p87, v94);
end;

function getBallRotationOnImpact(p95)
    local v96 = Vector3.new(p95.X, 0, p95.Z);

    return (Vector3.new(0, 1, 0)):Cross(v96.Unit).Unit * (v96.Magnitude * 0.8 / 1.5);
end;

function getBounceVelocity(p97, p98, p99, p100, p101, p102)
    -- upvalues: u9 (ref)
    local v103;

    if p97.Z > p102 - u9 then
        local X = p98.X;
        local Y = p98.Y;
        local v104 = -math.abs(p98.Z);
        p98 = Vector3.new(X, Y, v104);
        v103 = true;
    else
        v103 = false;
    end;

    if p97.Z < p101 + u9 then
        local X = p98.X;
        local Y = p98.Y;
        local v105 = math.abs(p98.Z);
        p98 = Vector3.new(X, Y, v105);
        v103 = true;
    end;

    if p100 < p97.X then
        local v106 = -math.abs(p98.X);
        p98 = Vector3.new(v106, p98.Y, p98.Z);
        v103 = true;
    end;

    if p97.X < p99 then
        local v107 = math.abs(p98.X);
        p98 = Vector3.new(v107, p98.Y, p98.Z);
        v103 = true;
    end;

    return p98, v103;
end;

function ensureInside(p108, p109, p110, p111, p112)
    local v113 = math.clamp(p108.X, p109, p110);
    local v114 = math.clamp(p108.Z, p111, p112);

    return Vector3.new(v113, p108.Y, v114);
end;

function recordBallAnimation(p115, p116, p117)
    -- upvalues: u13 (ref), u6 (ref), u10 (ref), u5 (ref), Sound (copy), Sound4 (copy), Sound2 (copy)
    local v118 = {};
    local v119 = {};
    local v120 = {};
    local v121 = {};
    table.insert(v118, p115);
    table.insert(v119, p116);
    table.insert(v120, p117);
    table.insert(v121, false);
    local v122 = 0;
    local v123 = p117.Y / -45;
    local v124 = nil;
    u13 = 0;
    local v125 = p115;

    for i = 1, 2000 do
        local v126 = ensureInside(p115, -313.13, -115.936, 23.443, 161.748);
        local v127;
        p115, v127 = soccerBallTrajectory(v122, p116, v125, u6, v123);

        if v127.Magnitude < 0.5 then
            break;
        end;

        local v128 = nil;
        local v129 = false;
        local v130, v131, v132 = ballHitsGoalFrame(p115, v127);

        if v130 then
            p116 = Vector3.new(v132.X * 0.6, v132.Y * 0.7, v132.Z * 0.6);
            p117 = p117 * 0.8;
            v123 = p117.Y / -45;
            v127 = p116;
            p115 = v131;
            v122 = 0;
        else
            if ballInGoalA(p115) then
                v124 = "B";
                table.insert(v118, p115);
                table.insert(v119, v127);
                table.insert(v120, p117);
                table.insert(v121, false);

                if u13 == 0 then
                    u13 = i;
                end;

                break;
            end;

            if ballInGoalB(p115) then
                v124 = "A";
                table.insert(v118, p115);
                table.insert(v119, v127);
                table.insert(v120, p117);
                table.insert(v121, false);

                if u13 == 0 then
                    u13 = i;
                end;

                break;
            end;

            local v133;
            v133, v128 = getBounceVelocity(p115, v127, -313.13, -115.936, 23.443, 161.748);

            if v128 then
                p115 = Vector3.new(v126.X, p115.Y, v126.Z);
                p116 = Vector3.new(v133.X * 0.6, v133.Y * 0.7, v133.Z * 0.6);
                p117 = p117 * 0.8;
                v123 = p117.Y / -45;
                v127 = p116;
                v131 = p115;
                v122 = 0;
            else
                v131 = v125;
            end;

            v129 = ballBouncedFloor(p115);

            if v129 then
                v131 = Vector3.new(p115.X, u10, p115.Z);

                if u13 == 0 then
                    u13 = i;
                end;

                p117 = getBallRotationOnImpact(v127) + Vector3.new(0, p117.Y * 0.8, 0);
                local v134 = math.abs(v127.Y) < 10 and 0.99 or 0.8;
                p116 = Vector3.new(v127.X * v134, v127.Y * -u5, v127.Z * v134);
                v123 = p117.Y / -45;
                v127 = p116;
                p115 = v131;
                v122 = 0;
            end;
        end;

        table.insert(v118, p115);
        table.insert(v119, v127);
        table.insert(v120, p117);

        if v130 then
            table.insert(v121, Sound);
        elseif v129 and math.abs(v127.Y) >= 10 then
            table.insert(v121, Sound4);
        elseif v128 then
            table.insert(v121, Sound2);
        else
            table.insert(v121, false);
        end;

        v122 = v122 + 0.005;
        v125 = v131;
    end;

    return v118, v119, v120, v121, v124;
end;

function softImpact(p135, p136)
    if p136 <= 0 then
        return 0;
    end;

    if p136 < p135 then
        p135 = p136;
    end;

    return math.sin(1.57 * p135 / p136);
end;

function animateBall()
    -- upvalues: u1 (ref), u21 (ref), u23 (ref), u14 (ref), u11 (ref), u15 (ref), u24 (ref), u18 (ref), u16 (ref), u17 (ref), u12 (ref), u13 (ref), u10 (ref), u22 (ref), u25 (ref), GoalEvent (copy), Sound3 (copy)
    if not (u1 and u21) then
        if u1 and u23 then
            local v137 = (tick() - u14) / (u11 + 0.005);
            local v138 = math.floor(v137);

            if v138 < 1 then
                return;
            end;

            if v138 <= #u15 then
                for i = math.max(u24 + 1, 1), math.min(v138, #u18) do
                    local v139 = u18[i];

                    if v139 then
                        if not v139.IsPlaying then
                            v139:Play();
                        end;

                        u18[i] = false;
                    end;
                end;

                u24 = v138;
                u1.Position = u15[v138];
                u1.Velocity = u16[v138];
                u1.RotVelocity = u17[v138];
                local v140 = u12 * (1 - softImpact(v138, u13));
                u1.Position = u1.Position - v140;

                if u1.Position.Y < u10 then
                    u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);

                    return;
                end;
            else
                if u22 then
                    u23 = false;
                    u25 = false;
                    GoalEvent:FireServer(u22, "dihtelkds");
                    wait(0.3);

                    if not u25 then
                        Sound3:Play();
                    end;

                    u1.Velocity = Vector3.new(u1.Velocity.X * 0.3, u1.Velocity.Y * 0.3, u1.Velocity.Z * 0.3);
                    u1.RotVelocity = Vector3.new(u1.RotVelocity.X * 0.3, u1.RotVelocity.Y * 0.3, u1.RotVelocity.Z * 0.3);

                    return;
                end;

                u21 = u1.Position;
            end;
        end;

        return;
    end;

    u1.Position = Vector3.new(u21.X, u1.Position.Y, u21.Z);
    u1.Velocity = Vector3.new(0, u1.Velocity.Y, 0);
    u1.RotVelocity = Vector3.new(0, 0, 0);
end;

function startAnimation(p141, p142, p143, p144, p145)
    -- upvalues: u15 (ref), u16 (ref), u17 (ref), u18 (ref), u22 (ref), u23 (ref), u21 (ref), u14 (ref), u12 (ref), u11 (ref), u24 (ref)
    local v146, v147, v148, v149, v150 = recordBallAnimation(p141, p142, p143);
    u15 = v146;
    u16 = v147;
    u17 = v148;
    u18 = v149;
    u22 = v150;
    u23 = true;
    u21 = nil;
    u14 = tick();
    u12 = p144;
    u11 = p145 / #v146;
    u24 = 0;
end;

function createBall(p151)
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    u1 = workspace.FootballField:FindFirstChild("SoccerBall");

    if u1 == nil then
        u1 = ReplicatedStorage:WaitForChild("SoccerBall"):Clone();
        u1.Parent = workspace.FootballField;
    end;
end;

function onDropBall(p152)
    -- upvalues: u1 (ref), u21 (ref), u2 (ref), u22 (ref)
    pcall(createBall, p152);

    if u1 then
        if p152 then
            u1.Position = Vector3.new(-214.544, 25, 92.531) + p152;
        else
            u1.Position = Vector3.new(-214.544, 25, 92.531);
        end;

        u21 = u1.Position;
    end;

    u2 = 0;
    u22 = nil;
end;

DropBallEvent.OnClientEvent:Connect(onDropBall);

function onRemoveBall()
    -- upvalues: u1 (ref)
    if u1 then
        u1:Destroy();
        u1 = nil;
    end;
end;

RemoveBallEvent.OnClientEvent:Connect(onRemoveBall);

function onMeasureLagEvent(p153)
    -- upvalues: u1 (ref), MeasureLag (copy)
    if u1 then
        MeasureLag:FireServer(p153);
    end;
end;

MeasureLagEvent.OnClientEvent:Connect(onMeasureLagEvent);

function onBallPositionEvent(p154, p155, p156)
    -- upvalues: u4 (ref), u19 (ref), u20 (ref), LocalPlayer (copy)
    u4 = p154;
    u19 = p155;
    u20 = p156;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local v157 = PlayerGui and PlayerGui:FindFirstChild("Ping", true);

    if v157 then
        local v158 = math.round(u4 * 2000);
        v157.Text = v158 .. "ms";

        if v158 <= 60 then
            v157.TextColor3 = Color3.new(0, 1, 0);

            return;
        end;

        if v158 <= 120 then
            v157.TextColor3 = Color3.new(1, 1, 0.498039);

            return;
        end;

        v157.TextColor3 = Color3.new(1, 0, 0);
    end;
end;

BallPositionEvent.OnClientEvent:Connect(onBallPositionEvent);

function onKickBallEvent(p159, p160, p161, p162)
    -- upvalues: u25 (ref), LocalPlayer (copy), u3 (ref), u1 (ref)
    u25 = true;

    if LocalPlayer.UserId ~= p159.UserId then
        u3 = tick();
        pcall(createBall, nil);

        if u1 then
            startAnimation(p160, p161, p162, p160 - u1.Position, 0);
        end;
    end;
end;

KickBallEvent.OnClientEvent:Connect(onKickBallEvent);

function getClosestPlayerName()
    -- upvalues: u19 (ref), u20 (ref), u1 (ref)
    local v163 = nil;
    local v164 = 10000;

    if u19 and u20 then
        for i, v in pairs(u20) do
            local Magnitude = (u1.Position - v).Magnitude;

            if Magnitude < v164 then
                v163 = u19[i];
                v164 = Magnitude;
            end;
        end;
    end;

    return v163;
end;

function touchDetect()
local maxRange = 4
if states.reachActive then
	maxRange = states.reachRange
end
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), Humanoid (copy), u10 (ref), KickBall (copy), u4 (ref)
    if LocalPlayer and (LocalPlayer.Character and (u1 and (tick() - u2 >= 0.6 and (tick() - u3 >= 0.3 and getClosestPlayerName() == LocalPlayer.Name)))) then
        local Position = LocalPlayer.Character.UpperTorso.Position;
        local Position2 = u1.Position;
        local Magnitude = (Position2 - Position).Magnitude;

        if Magnitude > 0.01 and Magnitude <= maxRange then
            u2 = tick();
            local v165 = Position + Vector3.new(0, -3, 0);
            local v166 = Position + Vector3.new(0, 1.3, 0);
            local v167 = 34;
            local v168;

            if (v166 - Position2).Magnitude < (v165 - Position2).Magnitude then
                v168 = Position2 - v166;
                v167 = 0;
            else
                local v169 = Position2 - v165;
                v168 = Vector3.new(v169.X, 0, v169.Z);
            end;

		if game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamA") and game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamB") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Team") then
	local NameTeamA = game:GetService("ReplicatedStorage").NameTeamA.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
local NameTeamB = game:GetService("ReplicatedStorage").NameTeamB.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
if NameTeamA == Team then

	states.Goal = "B"
	elseif NameTeamB == Team then

		 states.Goal = "A"

end
	else

local fp = Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)
local sp = Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)

if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - fp).Magnitude < (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - sp).Magnitude then
    states.Goal = "A"
else
    states.Goal = "B"
end
end


            local Unit
			if states.Aimbot then
				if states.Goal == "A" then
if states.Type == "Random" then
    local goal1randomizers = {
        Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219), -- net
        Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
    }

    local randomposition = goal1randomizers[math.random(1, #goal1randomizers)]
    Unit = (randomposition - u1.Position).Unit

elseif states.Type == "Top Left Corner" then
    Unit = (Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562)-u1.Position).Unit

elseif states.Type == "Top Right Corner" then
    Unit = (Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656)-u1.Position).Unit

elseif states.Type == "Net" then
    Unit = (Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)-u1.Position).Unit

elseif states.Type == "Bottom Left Corner" then
    Unit = (Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938)-u1.Position).Unit

elseif states.Type == "Bottom Right Corner" then
    Unit = (Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781)-u1.Position).Unit
end
					else
if states.Type == "Random" then
local goal2randomizers = {
	Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578), -- net
	Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)

}
local randomposition = goal2randomizers[math.random(1, #goal2randomizers)]
Unit = (randomposition - u1.Position).Unit
elseif states.Type == "Top Left Corner" then
Unit = (Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312)-u1.Position).Unit
	elseif states.Type == "Top Right Corner" then

Unit = (Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)-u1.Position).Unit
elseif states.Type == "Net" then
	Unit = (Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)-u1.Position).Unit
	elseif states.Type == "Bottom Left Corner" then
		Unit = (Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961)-u1.Position).Unit
		elseif states.Type == "Bottom Right Corner" then
			Unit = (Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297)-u1.Position).Unit
end
				end
			else
			Unit = v168.Unit;
			end

            if states.Aimbot and states.Goal == "A" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalA = {
    Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
}

for _, position in cornersGoalA do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

              if states.Aimbot and states.Goal == "B" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalB = {
    Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)
}

for _, position in cornersGoalB do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

            if Unit.Magnitude > 0.01 then
                local v170 = Vector3.new(0, 0, 0);
                local LookVector = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector;
                local Unit2 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
                local v171 = math.atan2(Unit2.X, Unit2.Z) - math.atan2(Unit.X, Unit.Z);
                local v172 = math.abs(v171);
                local v173 = math.deg(v172);

                if v173 <= 20 then
                    Unit = (Unit2 + Unit).Unit;
                end;

                if v173 < 90 then
                    local v174 = v173 / 3;

                    if v171 < 0 then
                        v170 = Vector3.new(0, v174, 0);
                    else
                        v170 = Vector3.new(0, -v174, 0);
                    end;
                end;

                local WalkSpeed = Humanoid.WalkSpeed;

                if WalkSpeed <= 46 then
                    local v175;

                    if WalkSpeed >= 19 then
                        local v176
						if states.Aimbot then
							v176 = Vector3.new(0, states.Height, 0);
							else
							v176 = Vector3.new(0, 34, 0);
						end
                        local v177 = (WalkSpeed - 19) * 10 + 40 + Vector3.new(u1.Velocity.X, 0, u1.Velocity.Z).Magnitude;
                       local power = 85
						local v178
						if states.powerShotActive then
							power = states.powerShotPower
							v178 = Unit * power + v176;
							else
							v178 = Unit * (v177 > power and power or v177) + v176;
						end
                        local X = v178.X;
                        local v179 = math.min(v178.Y, 40);
                        v175 = Vector3.new(X, v179, v178.Z);
                    elseif WalkSpeed == 16 then
                        v175 = Unit * 20 + Vector3.new(0, 0, 0);
                    else
                        v175 = Unit * ((WalkSpeed - 16) * 15 + 25) + Vector3.new(0, 5, 0);
                    end;

                    if u1.Position.Y < u10 then
                        u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);
                    end;

					if states.NoSpin and states.Aimbot then
						v170 = Vector3.new(0, 0, 0)
					end

                    KickBall:FireServer(u1.Position, v175, v170, Magnitude, "dihtelkds");
                    startAnimation(u1.Position, v175, v170, Vector3.new(0, 0, 0), u4);
                end;
            end;
        end;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 742
    pcall(touchDetect);
    pcall(animateBall);
    pcall(checkNearGoal);
end);


-- ===== SETTINGS =====
local LINE_COLOR = Color3.fromRGB(120,150,255)
local LINE_MATERIAL = Enum.Material.Neon
local DRAW_THICKNESS = 0.5
local LINE_TRANSPARENCY = 0
local SEG_MIN_DIST = 0.03
local FLOOR_Y = 5.473

-- ===== VISUAL FOLDER =====
local visuals = workspace:FindFirstChild("trajectory")
if not visuals then
    visuals = Instance.new("Folder")
    visuals.Name = "trajectory"
    visuals.Parent = workspace
end

local function clearVisuals()
    for _,v in ipairs(visuals:GetChildren()) do
        v:Destroy()
    end
end

-- ===== DRAW HELPERS =====
local function createSegment(a,b)
    local dir = b-a
    local d = dir.Magnitude
    if d < SEG_MIN_DIST then return end

    local mid = (a+b)*0.5

    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.CastShadow = false
    p.Material = LINE_MATERIAL
    p.Color = LINE_COLOR
    p.Transparency = LINE_TRANSPARENCY
    p.Size = Vector3.new(DRAW_THICKNESS,2,d)
    p.CFrame = CFrame.new(mid,mid+dir)*CFrame.Angles(math.pi/2,0,0)
    p.Parent = visuals
end

local function drawPath(points)
    for i=1,#points-1 do
        local a = Vector3.new(points[i].X, math.max(points[i].Y,FLOOR_Y), points[i].Z)
        local b = Vector3.new(points[i+1].X, math.max(points[i+1].Y,FLOOR_Y), points[i+1].Z)
        createSegment(a,b)
    end
end

local function createMarker(pos)
    local m = Instance.new("Part")
    m.Shape = Enum.PartType.Ball
    m.Anchored = true
    m.CanCollide = false
    m.CastShadow = false
    m.Material = Enum.Material.Neon
    m.Color = Color3.fromRGB(211,211,211)
    m.Size = Vector3.new(1.5,1.5,1.5)
    m.CFrame = CFrame.new(pos)
    m.Parent = visuals
end

-- ===== EVENT HOOK =====
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local event = RS:FindFirstChild("KickBallEvent")
if not event then return end

event.OnClientEvent:Connect(function(...)
    if not states.trajectoryActive then
        clearVisuals()
        return
    end


    clearVisuals()

    local player = Players.LocalPlayer
    local char = player.Character
    if not char then return end

    

  

    local args = {...}
    local pos,vel,spin = args[2],args[3],args[4]

    if typeof(pos) ~= "Vector3" and typeof(args[1])=="Vector3" then
        pos,vel,spin = args[1],args[2],args[3]
    end

    if typeof(pos)~="Vector3" or typeof(vel)~="Vector3" then return end

    local pts
    local success = pcall(function()
        pts = recordBallAnimation(pos,vel,spin)
    end)

    if not success or not pts or #pts < 2 then return end

    task.defer(function()
        drawPath(pts)
 
    end)

    pcall(function()
        createMarker(pts[1])

        if ballInGoalA(pts[#pts])
        or ballInGoalB(pts[#pts]) then
            createMarker(pts[#pts])
        else
            createMarker(pts[math.round(#pts/1.6)])
        end
    end)
end)
				end
			end)

			task.spawn(function()
				if game.PlaceId == 16452707989 then

local BallHandler
if game.Players.LocalPlayer.Character:FindFirstChild("BallHandler") then
	game.Players.LocalPlayer.Character:FindFirstChild("BallHandler"):Destroy()
end

local Humanoid
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
game.Players.LocalPlayer.CharacterAdded:Connect(function ()
	Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
	BallHandler = game.Players.LocalPlayer.Character:WaitForChild("BallHandler")
	BallHandler:Destroy()
end)
-- Script Path: game:GetService("Workspace").ILOVEJUICEWRLDGOAT.BallHandler
-- Took 0.07s to decompile.
-- Executor: Potassium (v2.3.5)

-- Decompiled with Potassium's decompiler.


local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KickBall = ReplicatedStorage:WaitForChild("KickBall");
local DropBallEvent = ReplicatedStorage:WaitForChild("DropBallEvent");
local RemoveBallEvent = ReplicatedStorage:WaitForChild("RemoveBallEvent");
local BallPositionEvent = ReplicatedStorage:WaitForChild("BallPositionEvent");
local KickBallEvent = ReplicatedStorage:WaitForChild("KickBallEvent");
local LocalPlayer = Players.LocalPlayer;
local MeasureLag = ReplicatedStorage:WaitForChild("MeasureLag");
local MeasureLagEvent = ReplicatedStorage:WaitForChild("MeasureLagEvent");
local GoalEvent = ReplicatedStorage:WaitForChild("GoalEvent");
local NearGoalEvent = ReplicatedStorage:WaitForChild("NearGoalEvent");
local u1 = nil;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local u5 = 0.55;
local u6 = 55;
local u7 = 0;
local u8 = 0;
local u9 = 0;
local u10 = 5.473;
local u11 = 0;
local u12 = nil;
local u13 = 0;
local u14 = 0;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = false;
local u24 = 0;
local u25 = false;
local u26 = 0;
local Sound = Instance.new("Sound", game.Workspace);
Sound.SoundId = "rbxassetid://82599119475859";
Sound.Volume = 0.4;
local Sound2 = Instance.new("Sound", game.Workspace);
Sound2.SoundId = "rbxassetid://74303966391925";
Sound2.Volume = 0.4;
local Sound3 = Instance.new("Sound", game.Workspace);
Sound3.SoundId = "rbxassetid://122054734580185";
Sound3.Volume = 0.5;
local Sound4 = Instance.new("Sound", game.Workspace);
Sound4.SoundId = "rbxassetid://9119319842";
Sound4.Volume = 1;

function ballBouncedFloor(p27)
    -- upvalues: u10 (ref)
    return p27.Y < u10;
end;

function ballInGoalA(p28)
    -- upvalues: u7 (ref), u8 (ref)
    return p28.X < -313.13 and (p28.Z >= u7 + 78.036 and (p28.Z <= 107.715 - u7 and p28.Y <= u8 + 17));
end;

function ballInGoalB(p29)
    -- upvalues: u7 (ref), u8 (ref)
    return p29.X > -115.936 and (p29.Z >= u7 + 78.036 and (p29.Z <= 107.715 - u7 and p29.Y <= u8 + 17));
end;

local function copyVec(p30) -- Line: 138
    return {
        X = p30.X,
        Y = p30.Y,
        Z = p30.Z
    };
end;

local function reflectVelocity(p31, p32) -- Line: 142
    local v33 = p31.X * p32.X + p31.Y * p32.Y + p31.Z * p32.Z;

    return {
        X = p31.X - 2 * v33 * p32.X,
        Y = p31.Y - 2 * v33 * p32.Y,
        Z = p31.Z - 2 * v33 * p32.Z
    };
end;

local function length2(p34, p35) -- Line: 147
    return math.sqrt(p34 * p34 + p35 * p35);
end;

local function hitPost(p36, p37, p38, p39) -- Line: 151
    -- upvalues: reflectVelocity (copy)
    local v40 = p38.X - p36;
    local v41 = p38.Z - p37;
    local v42 = math.sqrt(v40 * v40 + v41 * v41);

    if v42 > 1.825 or (p38.Y < -1.5 or p38.Y > 19.5) then
        return false, p38, {
            X = p39.X,
            Y = p39.Y,
            Z = p39.Z
        };
    end;

    local v43, v44;

    if v42 > 1e-9 then
        v43 = v40 / v42;
        v44 = v41 / v42;
    else
        v43 = 0;
        v44 = 1;
        v42 = 1e-9;
    end;

    if p39.X * v43 + p39.Z * v44 >= 0 then
        return false, p38, {
            X = p39.X,
            Y = p39.Y,
            Z = p39.Z
        };
    end;

    local v45 = 1.8259999999999998 - v42;

    return true, Vector3.new(p38.X + v43 * v45, p38.Y, p38.Z + v44 * v45), reflectVelocity(p39, {
        Y = 0,
        X = v43,
        Z = v44
    });
end;

local function hitBar(p46, p47, p48) -- Line: 193
    -- upvalues: reflectVelocity (copy)
    if p47.Z >= 76.536 and p47.Z <= 109.215 then
        local v49 = p47.X - p46;
        local v50 = p47.Y - 18;
        local v51 = math.sqrt(v49 * v49 + v50 * v50);

        if v51 <= 1.825 then
            local v52, v53;

            if v51 > 1e-9 then
                v52 = v49 / v51;
                v53 = v50 / v51;
            else
                v52 = 0;
                v53 = 1;
                v51 = 1e-9;
            end;

            if p48.X * v52 + p48.Y * v53 >= 0 then
                return false, p47, {
                    X = p48.X,
                    Y = p48.Y,
                    Z = p48.Z
                };
            end;

            local v54 = 1.8259999999999998 - v51;

            return true, Vector3.new(p47.X + v52 * v54, p47.Y + v53 * v54, p47.Z), reflectVelocity(p48, {
                Z = 0,
                X = v52,
                Y = v53
            });
        end;
    end;

    return false, p47, {
        X = p48.X,
        Y = p48.Y,
        Z = p48.Z
    };
end;

function ballHitsLeftPoleA(p55, p56)
    -- upvalues: hitPost (copy)
    return hitPost(-313.13, 78.036, p55, p56);
end;

function ballHitsRightPoleA(p57, p58)
    -- upvalues: hitPost (copy)
    return hitPost(-313.13, 107.715, p57, p58);
end;

function ballHitsCrossbarA(p59, p60)
    -- upvalues: hitBar (copy)
    return hitBar(-313.13, p59, p60);
end;

function ballHitsLeftPoleB(p61, p62)
    -- upvalues: hitPost (copy)
    return hitPost(-115.936, 78.036, p61, p62);
end;

function ballHitsRightPoleB(p63, p64)
    -- upvalues: hitPost (copy)
    return hitPost(-115.936, 107.715, p63, p64);
end;

function ballHitsCrossbarB(p65, p66)
    -- upvalues: hitBar (copy)
    return hitBar(-115.936, p65, p66);
end;

function ballHitsGoalFrame(p67, p68)
    local v69, v70, v71 = ballHitsLeftPoleA(p67, p68);

    if v69 then
        return true, v70, v71, "LeftPoleA";
    end;

    local v72, v73, v74 = ballHitsRightPoleA(p67, p68);

    if v72 then
        return true, v73, v74, "RightPoleA";
    end;

    local v75, v76, v77 = ballHitsCrossbarA(p67, p68);

    if v75 then
        return true, v76, v77, "CrossbarA";
    end;

    local v78, v79, v80 = ballHitsLeftPoleB(p67, p68);

    if v78 then
        return true, v79, v80, "LeftPoleB";
    end;

    local v81, v82, v83 = ballHitsRightPoleB(p67, p68);

    if v81 then
        return true, v82, v83, "RightPoleB";
    end;

    local v84, v85, v86 = ballHitsCrossbarB(p67, p68);

    if v84 then
        return true, v85, v86, "CrossbarB";
    end;

    return false, p67, {
        X = p68.X,
        Y = p68.Y,
        Z = p68.Z
    }, "";
end;

function checkNearGoal()
    -- upvalues: u1 (ref), u26 (ref), u7 (ref), u8 (ref), NearGoalEvent (copy)
    if u1 and (tick() - u26 > 5 and u1.Velocity.Magnitude > 10) then
        if u1.Position.X < -309 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u26 = tick();
            NearGoalEvent:FireServer("B");

            return;
        end;

        if u1.Position.X > -120 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u26 = tick();
            NearGoalEvent:FireServer("A");
        end;
    end;
end;

function soccerBallTrajectory(p87, p88, p89, p90, p91)
    local X = p88.X;
    local Z = p88.Z;
    local Y = p88.Y;
    local X2 = p89.X;
    local Z2 = p89.Z;
    local Y2 = p89.Y;
    local v92 = p91 * p87;
    local v93 = X * math.cos(v92) - Z * math.sin(v92);
    local v94 = X * math.sin(v92) + Z * math.cos(v92);

    return Vector3.new(X2 + X * p87 + 0.5 * (v93 - X) * p87, Y2 + Y * p87 - 0.5 * p90 * p87 ^ 2, Z2 + Z * p87 + 0.5 * (v94 - Z) * p87), Vector3.new(v93, Y - p90 * p87, v94);
end;

function getBallRotationOnImpact(p95)
    local v96 = Vector3.new(p95.X, 0, p95.Z);

    return (Vector3.new(0, 1, 0)):Cross(v96.Unit).Unit * (v96.Magnitude * 0.8 / 1.5);
end;

function getBounceVelocity(p97, p98, p99, p100, p101, p102)
    -- upvalues: u9 (ref)
    local v103;

    if p97.Z > p102 - u9 then
        local X = p98.X;
        local Y = p98.Y;
        local v104 = -math.abs(p98.Z);
        p98 = Vector3.new(X, Y, v104);
        v103 = true;
    else
        v103 = false;
    end;

    if p97.Z < p101 + u9 then
        local X = p98.X;
        local Y = p98.Y;
        local v105 = math.abs(p98.Z);
        p98 = Vector3.new(X, Y, v105);
        v103 = true;
    end;

    if p100 < p97.X then
        local v106 = -math.abs(p98.X);
        p98 = Vector3.new(v106, p98.Y, p98.Z);
        v103 = true;
    end;

    if p97.X < p99 then
        local v107 = math.abs(p98.X);
        p98 = Vector3.new(v107, p98.Y, p98.Z);
        v103 = true;
    end;

    return p98, v103;
end;

function ensureInside(p108, p109, p110, p111, p112)
    local v113 = math.clamp(p108.X, p109, p110);
    local v114 = math.clamp(p108.Z, p111, p112);

    return Vector3.new(v113, p108.Y, v114);
end;

function recordBallAnimation(p115, p116, p117)
    -- upvalues: u13 (ref), u6 (ref), u10 (ref), u5 (ref), Sound (copy), Sound4 (copy), Sound2 (copy)
    local v118 = {};
    local v119 = {};
    local v120 = {};
    local v121 = {};
    table.insert(v118, p115);
    table.insert(v119, p116);
    table.insert(v120, p117);
    table.insert(v121, false);
    local v122 = 0;
    local v123 = p117.Y / -45;
    local v124 = nil;
    u13 = 0;
    local v125 = p115;

    for i = 1, 2000 do
        local v126 = ensureInside(p115, -313.13, -115.936, 23.443, 161.748);
        local v127, v128 = soccerBallTrajectory(v122, p116, v125, u6, v123);

        if v128.Magnitude < 0.5 then
            break;
        end;

        local v129 = nil;
        local v130 = false;
        local v131, v132;
        v131, p115, v132 = ballHitsGoalFrame(v127, v128);

        if v131 then
            p116 = Vector3.new(v132.X * 0.6, v132.Y * 0.7, v132.Z * 0.6);
            p117 = p117 * 0.8;
            v123 = p117.Y / -45;
            v128 = p116;
            v125 = p115;
            v122 = 0;
        else
            if ballInGoalA(v127) then
                v124 = "B";
                table.insert(v118, v127);
                table.insert(v119, v128);
                table.insert(v120, p117);
                table.insert(v121, false);

                if u13 == 0 then
                    u13 = i;
                end;

                break;
            end;

            if ballInGoalB(v127) then
                v124 = "A";
                table.insert(v118, v127);
                table.insert(v119, v128);
                table.insert(v120, p117);
                table.insert(v121, false);

                if u13 == 0 then
                    u13 = i;
                end;

                break;
            end;

            local v133;
            v133, v129 = getBounceVelocity(v127, v128, -313.13, -115.936, 23.443, 161.748);

            if v129 then
                p115 = Vector3.new(v126.X, v127.Y, v126.Z);
                p116 = Vector3.new(v133.X * 0.6, v133.Y * 0.7, v133.Z * 0.6);
                p117 = p117 * 0.8;
                v123 = p117.Y / -45;
                v128 = p116;
                v125 = p115;
                v122 = 0;
            else
                p115 = v127;
            end;

            v130 = ballBouncedFloor(p115);

            if v130 then
                p115 = Vector3.new(p115.X, u10, p115.Z);

                if u13 == 0 then
                    u13 = i;
                end;

                p117 = getBallRotationOnImpact(v128) + Vector3.new(0, p117.Y * 0.8, 0);
                local v134 = math.abs(v128.Y) < 10 and 0.99 or 0.8;
                p116 = Vector3.new(v128.X * v134, v128.Y * -u5, v128.Z * v134);
                v123 = p117.Y / -45;
                v128 = p116;
                v125 = p115;
                v122 = 0;
            end;
        end;

        table.insert(v118, p115);
        table.insert(v119, v128);
        table.insert(v120, p117);

        if v131 then
            table.insert(v121, Sound);
        elseif v130 and math.abs(v128.Y) >= 10 then
            table.insert(v121, Sound4);
        elseif v129 then
            table.insert(v121, Sound2);
        else
            table.insert(v121, false);
        end;

        v122 = v122 + 0.005;
    end;

    return v118, v119, v120, v121, v124;
end;

function softImpact(p135, p136)
    if p136 <= 0 then
        return 0;
    end;

    if p136 < p135 then
        p135 = p136;
    end;

    return math.sin(1.57 * p135 / p136);
end;

function animateBall()
    -- upvalues: u1 (ref), u21 (ref), u23 (ref), u14 (ref), u11 (ref), u15 (ref), u24 (ref), u18 (ref), u16 (ref), u17 (ref), u12 (ref), u13 (ref), u10 (ref), u22 (ref), u25 (ref), GoalEvent (copy), Sound3 (copy)
    if not (u1 and u21) then
        if u1 and u23 then
            local v137 = (tick() - u14) / (u11 + 0.005);
            local v138 = math.floor(v137);

            if v138 < 1 then
                return;
            end;

            if v138 <= #u15 then
                for i = math.max(u24 + 1, 1), math.min(v138, #u18) do
                    local v139 = u18[i];

                    if v139 then
                        if not v139.IsPlaying then
                            v139:Play();
                        end;

                        u18[i] = false;
                    end;
                end;

                u24 = v138;
                u1.Position = u15[v138];
                u1.Velocity = u16[v138];
                u1.RotVelocity = u17[v138];
                local v140 = u12 * (1 - softImpact(v138, u13));
                u1.Position = u1.Position - v140;

                if u1.Position.Y < u10 then
                    u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);

                    return;
                end;
            else
                if u22 then
                    u23 = false;
                    u25 = false;
                    GoalEvent:FireServer(u22, "dihtelkds");
                    wait(0.3);

                    if not u25 then
                        Sound3:Play();
                    end;

                    u1.Velocity = Vector3.new(u1.Velocity.X * 0.3, u1.Velocity.Y * 0.3, u1.Velocity.Z * 0.3);
                    u1.RotVelocity = Vector3.new(u1.RotVelocity.X * 0.3, u1.RotVelocity.Y * 0.3, u1.RotVelocity.Z * 0.3);

                    return;
                end;

                u21 = u1.Position;
            end;
        end;

        return;
    end;

    u1.Position = Vector3.new(u21.X, u1.Position.Y, u21.Z);
    u1.Velocity = Vector3.new(0, u1.Velocity.Y, 0);
    u1.RotVelocity = Vector3.new(0, 0, 0);
end;

function startAnimation(p141, p142, p143, p144, p145)
    -- upvalues: u15 (ref), u16 (ref), u17 (ref), u18 (ref), u22 (ref), u23 (ref), u21 (ref), u14 (ref), u12 (ref), u11 (ref), u24 (ref)
    local v146, v147, v148, v149, v150 = recordBallAnimation(p141, p142, p143);
    u15 = v146;
    u16 = v147;
    u17 = v148;
    u18 = v149;
    u22 = v150;
    u23 = true;
    u21 = nil;
    u14 = tick();
    u12 = p144;
    u11 = p145 / #v146;
    u24 = 0;
end;

function createBall(p151)
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    u1 = workspace.FootballField:FindFirstChild("SoccerBall");

    if u1 == nil then
        u1 = ReplicatedStorage:WaitForChild("SoccerBall"):Clone();
        u1.Parent = workspace.FootballField;
    end;
end;

function onDropBall(p152)
    -- upvalues: u1 (ref), u21 (ref), u2 (ref), u22 (ref)
    pcall(createBall, p152);

    if u1 then
        if p152 then
            u1.Position = Vector3.new(-214.544, 25, 92.531) + p152;
        else
            u1.Position = Vector3.new(-214.544, 25, 92.531);
        end;

        u21 = u1.Position;
    end;

    u2 = 0;
    u22 = nil;
end;

DropBallEvent.OnClientEvent:Connect(onDropBall);

function onRemoveBall()
    -- upvalues: u1 (ref)
    if u1 then
        u1:Destroy();
        u1 = nil;
    end;
end;

RemoveBallEvent.OnClientEvent:Connect(onRemoveBall);

function onMeasureLagEvent(p153)
    -- upvalues: u1 (ref), MeasureLag (copy)
    if u1 then
        MeasureLag:FireServer(p153);
    end;
end;

MeasureLagEvent.OnClientEvent:Connect(onMeasureLagEvent);

function onBallPositionEvent(p154, p155, p156)
    -- upvalues: u4 (ref), u19 (ref), u20 (ref), LocalPlayer (copy)
    u4 = p154;
    u19 = p155;
    u20 = p156;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local v157 = PlayerGui and PlayerGui:FindFirstChild("Ping", true);

    if v157 then
        local v158 = math.round(u4 * 2000);
        v157.Text = v158 .. "ms";

        if v158 <= 60 then
            v157.TextColor3 = Color3.new(0, 1, 0);

            return;
        end;

        if v158 <= 120 then
            v157.TextColor3 = Color3.new(1, 1, 0.498039);

            return;
        end;

        v157.TextColor3 = Color3.new(1, 0, 0);
    end;
end;

BallPositionEvent.OnClientEvent:Connect(onBallPositionEvent);

function onKickBallEvent(p159, p160, p161, p162)
    -- upvalues: u25 (ref), LocalPlayer (copy), u3 (ref), u1 (ref)
    u25 = true;

    if LocalPlayer.UserId ~= p159.UserId then
        u3 = tick();
        pcall(createBall, nil);

        if u1 then
            startAnimation(p160, p161, p162, p160 - u1.Position, 0);
        end;
    end;
end;

KickBallEvent.OnClientEvent:Connect(onKickBallEvent);

function getClosestPlayerName()
    -- upvalues: u19 (ref), u20 (ref), u1 (ref)
    local v163 = nil;
    local v164 = 10000;

    if u19 and u20 then
        for i, v in pairs(u20) do
            local Magnitude = (u1.Position - v).Magnitude;

            if Magnitude < v164 then
                v163 = u19[i];
                v164 = Magnitude;
            end;
        end;
    end;

    return v163;
end;

function touchDetect()
local maxRange = 4
if states.reachActive then
	maxRange = states.reachRange
end
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), Humanoid (copy), u10 (ref), KickBall (copy), u4 (ref)
    if LocalPlayer and (LocalPlayer.Character and (u1 and (tick() - u2 >= 0.6 and (tick() - u3 >= 0.3 and getClosestPlayerName() == LocalPlayer.Name)))) then
        local Position = LocalPlayer.Character.UpperTorso.Position;
        local Position2 = u1.Position;
        local Magnitude = (Position2 - Position).Magnitude;

        if Magnitude > 0.01 and Magnitude <= maxRange then
            u2 = tick();
            local v165 = Position + Vector3.new(0, -3, 0);
            local v166 = Position + Vector3.new(0, 1.3, 0);
            local v167 = 34;
            local v168;

            if (v166 - Position2).Magnitude < (v165 - Position2).Magnitude then
                v168 = Position2 - v166;
                v167 = 0;
            else
                local v169 = Position2 - v165;
                v168 = Vector3.new(v169.X, 0, v169.Z);
            end;

			if game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamA") and game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamB") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Team") then
	local NameTeamA = game:GetService("ReplicatedStorage").NameTeamA.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
local NameTeamB = game:GetService("ReplicatedStorage").NameTeamB.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
if NameTeamA == Team then

	states.Goal = "B"
	elseif NameTeamB == Team then
	
		 states.Goal = "A"

end
	else

local fp = Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)
local sp = Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)

if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - fp).Magnitude < (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - sp).Magnitude then
    states.Goal = "A"
else
    states.Goal = "B"
end
end



           local Unit
			if states.Aimbot then
				if states.Goal == "A" then
if states.Type == "Random" then
    local goal1randomizers = {
        Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219), -- net
        Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
    }

    local randomposition = goal1randomizers[math.random(1, #goal1randomizers)]
    Unit = (randomposition - u1.Position).Unit

elseif states.Type == "Top Left Corner" then
    Unit = (Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562)-u1.Position).Unit

elseif states.Type == "Top Right Corner" then
    Unit = (Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656)-u1.Position).Unit

elseif states.Type == "Net" then
    Unit = (Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)-u1.Position).Unit

elseif states.Type == "Bottom Left Corner" then
    Unit = (Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938)-u1.Position).Unit

elseif states.Type == "Bottom Right Corner" then
    Unit = (Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781)-u1.Position).Unit
end
					else
if states.Type == "Random" then
local goal2randomizers = {
	Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578), -- net
	Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)

}
local randomposition = goal2randomizers[math.random(1, #goal2randomizers)]
Unit = (randomposition - u1.Position).Unit
elseif states.Type == "Top Left Corner" then
Unit = (Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312)-u1.Position).Unit
	elseif states.Type == "Top Right Corner" then

Unit = (Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)-u1.Position).Unit
elseif states.Type == "Net" then
	Unit = (Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)-u1.Position).Unit
	elseif states.Type == "Bottom Left Corner" then
		Unit = (Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961)-u1.Position).Unit
		elseif states.Type == "Bottom Right Corner" then
			Unit = (Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297)-u1.Position).Unit
end
				end
			else
			Unit = v168.Unit;
			end

            if states.Aimbot and states.Goal == "A" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalA = {
    Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
}

for _, position in cornersGoalA do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

              if states.Aimbot and states.Goal == "B" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalB = {
    Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)
}

for _, position in cornersGoalB do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

            if Unit.Magnitude > 0.01 then
                local v170 = Vector3.new(0, 0, 0);
                local LookVector = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector;
                local Unit2 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
                local v171 = math.atan2(Unit2.X, Unit2.Z) - math.atan2(Unit.X, Unit.Z);
                local v172 = math.abs(v171);
                local v173 = math.deg(v172);

                if v173 <= 20 then
                    Unit = (Unit2 + Unit).Unit;
                end;

                if v173 < 90 then
                    local v174 = v173 / 3;

                    if v171 < 0 then
                        v170 = Vector3.new(0, v174, 0);
                    else
                        v170 = Vector3.new(0, -v174, 0);
                    end;
                end;

                local WalkSpeed = Humanoid.WalkSpeed;

                if WalkSpeed <= 46 then
                    local v175;

					

                    if WalkSpeed >= 19 then
                        local v176
						if states.Aimbot then
							v176 = Vector3.new(0, states.Height, 0);
							else
							v176 = Vector3.new(0, 34, 0);
						end
                        local v177 = (WalkSpeed - 19) * 10 + 40 + Vector3.new(u1.Velocity.X, 0, u1.Velocity.Z).Magnitude;
                       local power = 85
						local v178
						if states.powerShotActive then
							power = states.powerShotPower
							v178 = Unit * power + v176;
							else
							v178 = Unit * (v177 > power and power or v177) + v176;
						end
                        local X = v178.X;
                        local v179 = math.min(v178.Y, 40);
                        v175 = Vector3.new(X, v179, v178.Z);
                    elseif WalkSpeed == 16 then
                        v175 = Unit * 20 + Vector3.new(0, 0, 0);
                    else
                        v175 = Unit * ((WalkSpeed - 16) * 15 + 25) + Vector3.new(0, 5, 0);
                    end;

                    if u1.Position.Y < u10 then
                        u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);
                    end;

					if states.NoSpin and states.Aimbot then
						v170 = Vector3.new(0, 0, 0)
					end

                    KickBall:FireServer(u1.Position, v175, v170, Magnitude, "dihtelkds");
                    startAnimation(u1.Position, v175, v170, Vector3.new(0, 0, 0), u4);
                end;
            end;
        end;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 742
    pcall(touchDetect);
    pcall(animateBall);
    pcall(checkNearGoal);
end);

-- ===== SETTINGS =====
local LINE_COLOR = Color3.fromRGB(120,150,255)
local LINE_MATERIAL = Enum.Material.Neon
local DRAW_THICKNESS = 0.5
local LINE_TRANSPARENCY = 0
local SEG_MIN_DIST = 0.03
local FLOOR_Y = 5.473

-- ===== VISUAL FOLDER =====
local visuals = workspace:FindFirstChild("trajectory")
if not visuals then
    visuals = Instance.new("Folder")
    visuals.Name = "trajectory"
    visuals.Parent = workspace
end

local function clearVisuals()
    for _,v in ipairs(visuals:GetChildren()) do
        v:Destroy()
    end
end

-- ===== DRAW HELPERS =====
local function createSegment(a,b)
    local dir = b-a
    local d = dir.Magnitude
    if d < SEG_MIN_DIST then return end

    local mid = (a+b)*0.5

    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.CastShadow = false
    p.Material = LINE_MATERIAL
    p.Color = LINE_COLOR
    p.Transparency = LINE_TRANSPARENCY
    p.Size = Vector3.new(DRAW_THICKNESS,2,d)
    p.CFrame = CFrame.new(mid,mid+dir)*CFrame.Angles(math.pi/2,0,0)
    p.Parent = visuals
end

local function drawPath(points)
    for i=1,#points-1 do
        local a = Vector3.new(points[i].X, math.max(points[i].Y,FLOOR_Y), points[i].Z)
        local b = Vector3.new(points[i+1].X, math.max(points[i+1].Y,FLOOR_Y), points[i+1].Z)
        createSegment(a,b)
    end
end

local function createMarker(pos)
    local m = Instance.new("Part")
    m.Shape = Enum.PartType.Ball
    m.Anchored = true
    m.CanCollide = false
    m.CastShadow = false
    m.Material = Enum.Material.Neon
    m.Color = Color3.fromRGB(211,211,211)
    m.Size = Vector3.new(1.5,1.5,1.5)
    m.CFrame = CFrame.new(pos)
    m.Parent = visuals
end

-- ===== EVENT HOOK =====
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local event = RS:FindFirstChild("KickBallEvent")
if not event then return end

event.OnClientEvent:Connect(function(...)
    if not states.trajectoryActive then
        clearVisuals()
        return
    end


    clearVisuals()

    local player = Players.LocalPlayer
    local char = player.Character
    if not char then return end

    

  

    local args = {...}
    local pos,vel,spin = args[2],args[3],args[4]

    if typeof(pos) ~= "Vector3" and typeof(args[1])=="Vector3" then
        pos,vel,spin = args[1],args[2],args[3]
    end

    if typeof(pos)~="Vector3" or typeof(vel)~="Vector3" then return end

    local pts
    local success = pcall(function()
        pts = recordBallAnimation(pos,vel,spin)
    end)

    if not success or not pts or #pts < 2 then return end

    task.defer(function()
        drawPath(pts)

    end)

    pcall(function()
        createMarker(pts[1])

        if ballInGoalA(pts[#pts])
        or ballInGoalB(pts[#pts]) then
            createMarker(pts[#pts])
        else
            createMarker(pts[math.round(#pts/1.6)])
        end
    end)
end)
				end
			end)

            task.spawn(function()
            if game.PlaceId == 116508908172411 then
           -- Script Path: game:GetService("Workspace").cowhousecandyisthetr.BallHandler
-- Took 0.07s to decompile.
-- Executor: Potassium (v2.4.4)

-- Decompiled with Potassium's decompiler.

-- Script Path: game:GetService("Workspace").SilverLeaf135.BallHandler
-- Took 0.05s to decompile.
-- Executor: Potassium (v2.3.3)

-- Decompiled with Potassium's decompiler.
local BallHandler
if game.Players.LocalPlayer.Character:FindFirstChild("BallHandler") then
	game.Players.LocalPlayer.Character:FindFirstChild("BallHandler"):Destroy()
end

local Humanoid
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
game.Players.LocalPlayer.CharacterAdded:Connect(function ()
	Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
	BallHandler = game.Players.LocalPlayer.Character:WaitForChild("BallHandler")
	BallHandler:Destroy()
end)
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KickBall = ReplicatedStorage:WaitForChild("KickBall");
local DropBallEvent = ReplicatedStorage:WaitForChild("DropBallEvent");
local RemoveBallEvent = ReplicatedStorage:WaitForChild("RemoveBallEvent");
local BallPositionEvent = ReplicatedStorage:WaitForChild("BallPositionEvent");
local KickBallEvent = ReplicatedStorage:WaitForChild("KickBallEvent");
local LocalPlayer = Players.LocalPlayer;
local MeasureLag = ReplicatedStorage:WaitForChild("MeasureLag");
local MeasureLagEvent = ReplicatedStorage:WaitForChild("MeasureLagEvent");
local GoalEvent = ReplicatedStorage:WaitForChild("GoalEvent");
local NearGoalEvent = ReplicatedStorage:WaitForChild("NearGoalEvent");
local u1 = nil;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local u5 = 0.55;
local u6 = 55;
local u7 = 0;
local u8 = 0;
local u9 = 0;
local u10 = 5.473;
local u11 = u7 + 78.036;
local u12 = 107.715 - u7;
local u13 = u8 + 18;
local u14 = u8 + 17;
local u15 = 0;
local u16 = nil;
local u17 = 0;
local u18 = 0;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = false;
local u28 = 0;
local u29 = false;
local u30 = 0;
local Sound = Instance.new("Sound", game.Workspace);
Sound.SoundId = "rbxassetid://82599119475859";
Sound.Volume = 0.4;
local Sound2 = Instance.new("Sound", game.Workspace);
Sound2.SoundId = "rbxassetid://74303966391925";
Sound2.Volume = 0.4;
local Sound3 = Instance.new("Sound", game.Workspace);
Sound3.SoundId = "rbxassetid://122054734580185";
Sound3.Volume = 0.5;
local Sound4 = Instance.new("Sound", game.Workspace);
Sound4.SoundId = "rbxassetid://9119319842";
Sound4.Volume = 1;

function ballBouncedFloor(p31)
    -- upvalues: u10 (ref)
    return p31.Y < u10;
end;

function ballInGoalA(p32)
    -- upvalues: u11 (copy), u12 (copy), u14 (copy)
    return p32.X < -313.13 and (u11 <= p32.Z and (p32.Z <= u12 and p32.Y <= u14));
end;

function ballInGoalB(p33)
    -- upvalues: u11 (copy), u12 (copy), u14 (copy)
    return p33.X > -115.936 and (u11 <= p33.Z and (p33.Z <= u12 and p33.Y <= u14));
end;

local function copyVec(p34) -- Line: 157
    return {
        X = p34.X,
        Y = p34.Y,
        Z = p34.Z
    };
end;

local function reflectVelocity(p35, p36) -- Line: 161
    local v37 = p35.X * p36.X + p35.Y * p36.Y + p35.Z * p36.Z;

    return {
        X = p35.X - 2 * v37 * p36.X,
        Y = p35.Y - 2 * v37 * p36.Y,
        Z = p35.Z - 2 * v37 * p36.Z
    };
end;

local function length2(p38, p39) -- Line: 166
    return math.sqrt(p38 * p38 + p39 * p39);
end;

local function hitPost(p40, p41, p42, p43) -- Line: 170
    -- upvalues: u13 (copy), reflectVelocity (copy)
    local v44 = p42.X - p40;
    local v45 = p42.Z - p41;
    local v46 = math.sqrt(v44 * v44 + v45 * v45);

    if v46 > 1.825 or (p42.Y < -1.5 or p42.Y > u13 + 1.5) then
        return false, p42, {
            X = p43.X,
            Y = p43.Y,
            Z = p43.Z
        };
    end;

    local v47, v48;

    if v46 > 1e-9 then
        v47 = v44 / v46;
        v48 = v45 / v46;
    else
        v47 = 0;
        v48 = 1;
        v46 = 1e-9;
    end;

    if p43.X * v47 + p43.Z * v48 >= 0 then
        return false, p42, {
            X = p43.X,
            Y = p43.Y,
            Z = p43.Z
        };
    end;

    local v49 = 1.8259999999999998 - v46;

    return true, Vector3.new(p42.X + v47 * v49, p42.Y, p42.Z + v48 * v49), reflectVelocity(p43, {
        Y = 0,
        X = v47,
        Z = v48
    });
end;

local function hitBar(p50, p51, p52) -- Line: 212
    -- upvalues: u11 (copy), u12 (copy), u13 (copy), reflectVelocity (copy)
    if p51.Z >= u11 - 1.5 and p51.Z <= u12 + 1.5 then
        local v53 = p51.X - p50;
        local v54 = p51.Y - u13;
        local v55 = math.sqrt(v53 * v53 + v54 * v54);

        if v55 <= 1.825 then
            local v56, v57;

            if v55 > 1e-9 then
                v56 = v53 / v55;
                v57 = v54 / v55;
            else
                v56 = 0;
                v57 = 1;
                v55 = 1e-9;
            end;

            if p52.X * v56 + p52.Y * v57 >= 0 then
                return false, p51, {
                    X = p52.X,
                    Y = p52.Y,
                    Z = p52.Z
                };
            end;

            local v58 = 1.8259999999999998 - v55;

            return true, Vector3.new(p51.X + v56 * v58, p51.Y + v57 * v58, p51.Z), reflectVelocity(p52, {
                Z = 0,
                X = v56,
                Y = v57
            });
        end;
    end;

    return false, p51, {
        X = p52.X,
        Y = p52.Y,
        Z = p52.Z
    };
end;

function ballHitsLeftPoleA(p59, p60)
    -- upvalues: hitPost (copy), u11 (copy)
    return hitPost(-313.13, u11, p59, p60);
end;

function ballHitsRightPoleA(p61, p62)
    -- upvalues: hitPost (copy), u12 (copy)
    return hitPost(-313.13, u12, p61, p62);
end;

function ballHitsCrossbarA(p63, p64)
    -- upvalues: hitBar (copy)
    return hitBar(-313.13, p63, p64);
end;

function ballHitsLeftPoleB(p65, p66)
    -- upvalues: hitPost (copy), u11 (copy)
    return hitPost(-115.936, u11, p65, p66);
end;

function ballHitsRightPoleB(p67, p68)
    -- upvalues: hitPost (copy), u12 (copy)
    return hitPost(-115.936, u12, p67, p68);
end;

function ballHitsCrossbarB(p69, p70)
    -- upvalues: hitBar (copy)
    return hitBar(-115.936, p69, p70);
end;

function ballHitsGoalFrame(p71, p72)
    local v73, v74, v75 = ballHitsLeftPoleA(p71, p72);

    if v73 then
        return true, v74, v75, "LeftPoleA";
    end;

    local v76, v77, v78 = ballHitsRightPoleA(p71, p72);

    if v76 then
        return true, v77, v78, "RightPoleA";
    end;

    local v79, v80, v81 = ballHitsCrossbarA(p71, p72);

    if v79 then
        return true, v80, v81, "CrossbarA";
    end;

    local v82, v83, v84 = ballHitsLeftPoleB(p71, p72);

    if v82 then
        return true, v83, v84, "LeftPoleB";
    end;

    local v85, v86, v87 = ballHitsRightPoleB(p71, p72);

    if v85 then
        return true, v86, v87, "RightPoleB";
    end;

    local v88, v89, v90 = ballHitsCrossbarB(p71, p72);

    if v88 then
        return true, v89, v90, "CrossbarB";
    end;

    return false, p71, {
        X = p72.X,
        Y = p72.Y,
        Z = p72.Z
    }, "";
end;

function checkNearGoal()
    -- upvalues: u1 (ref), u30 (ref), u7 (ref), u8 (ref), NearGoalEvent (copy)
    if u1 and (tick() - u30 > 5 and u1.Velocity.Magnitude > 10) then
        if u1.Position.X < -309 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u30 = tick();
            NearGoalEvent:FireServer("B");

            return;
        end;

        if u1.Position.X > -120 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u30 = tick();
            NearGoalEvent:FireServer("A");
        end;
    end;
end;

function soccerBallTrajectory(p91, p92, p93, p94, p95)
    local X = p92.X;
    local Z = p92.Z;
    local Y = p92.Y;
    local X2 = p93.X;
    local Z2 = p93.Z;
    local Y2 = p93.Y;
    local v96 = p95 * p91;
    local v97 = X * math.cos(v96) - Z * math.sin(v96);
    local v98 = X * math.sin(v96) + Z * math.cos(v96);

    return Vector3.new(X2 + X * p91 + 0.5 * (v97 - X) * p91, Y2 + Y * p91 - 0.5 * p94 * p91 ^ 2, Z2 + Z * p91 + 0.5 * (v98 - Z) * p91), Vector3.new(v97, Y - p94 * p91, v98);
end;

function getBallRotationOnImpact(p99)
    local v100 = Vector3.new(p99.X, 0, p99.Z);

    return (Vector3.new(0, 1, 0)):Cross(v100.Unit).Unit * (v100.Magnitude * 0.8 / 1.5);
end;

function getBounceVelocity(p101, p102, p103, p104, p105, p106)
    -- upvalues: u9 (ref)
    local v107;

    if p101.Z > p106 - u9 then
        local X = p102.X;
        local Y = p102.Y;
        local v108 = -math.abs(p102.Z);
        p102 = Vector3.new(X, Y, v108);
        v107 = true;
    else
        v107 = false;
    end;

    if p101.Z < p105 + u9 then
        local X = p102.X;
        local Y = p102.Y;
        local v109 = math.abs(p102.Z);
        p102 = Vector3.new(X, Y, v109);
        v107 = true;
    end;

    if p104 < p101.X then
        local v110 = -math.abs(p102.X);
        p102 = Vector3.new(v110, p102.Y, p102.Z);
        v107 = true;
    end;

    if p101.X < p103 then
        local v111 = math.abs(p102.X);
        p102 = Vector3.new(v111, p102.Y, p102.Z);
        v107 = true;
    end;

    return p102, v107;
end;

local function getWallFrictionRotation(p112, p113, p114, p115, p116, p117, p118) -- Line: 363
    -- upvalues: u9 (ref)
    local Y = p114.Y;

    local function applyFriction(p119) -- Line: 366
        -- upvalues: Y (ref)
        Y = Y + (p119 - Y) * 0.35;
    end;

    if p112.Z > p118 - u9 then
        Y = Y + (-p113.X / 1.5 - Y) * 0.35;
    end;

    if p112.Z < p117 + u9 then
        Y = Y + (p113.X / 1.5 - Y) * 0.35;
    end;

    if p116 < p112.X then
        Y = Y + (p113.Z / 1.5 - Y) * 0.35;
    end;

    if p112.X < p115 then
        Y = Y + (-p113.Z / 1.5 - Y) * 0.35;
    end;

    return Vector3.new(p114.X, Y, p114.Z);
end;

function ensureInside(p120, p121, p122, p123, p124)
    local v125 = math.clamp(p120.X, p121, p122);
    local v126 = math.clamp(p120.Z, p123, p124);

    return Vector3.new(v125, p120.Y, v126);
end;

function recordBallAnimation(p127, p128, p129)
    -- upvalues: u17 (ref), u6 (ref), getWallFrictionRotation (copy), u10 (ref), u5 (ref), Sound (copy), Sound4 (copy), Sound2 (copy)
    local v130 = {};
    local v131 = {};
    local v132 = {};
    local v133 = {};
    table.insert(v130, p127);
    table.insert(v131, p128);
    table.insert(v132, p129);
    table.insert(v133, false);
    local v134 = 0;
    local v135 = p129.Y / -45;
    local v136 = nil;
    u17 = 0;
    local v137 = p127;

    for i = 1, 2000 do
        local v138 = ensureInside(p127, -313.13, -115.936, 23.443, 161.748);
        local v139;
        p127, v139 = soccerBallTrajectory(v134, p128, v137, u6, v135);

        if v139.Magnitude < 0.5 then
            break;
        end;

        local v140 = nil;
        local v141 = false;
        local v142, v143, v144 = ballHitsGoalFrame(p127, v139);

        if v142 then
            p128 = Vector3.new(v144.X * 0.6, v144.Y * 0.7, v144.Z * 0.6);
            p129 = p129 * 0.8;
            v135 = p129.Y / -45;
            v139 = p128;
            p127 = v143;
            v134 = 0;
        else
            if ballInGoalA(p127) then
                v136 = "B";
                table.insert(v130, p127);
                table.insert(v131, v139);
                table.insert(v132, p129);
                table.insert(v133, false);

                if u17 == 0 then
                    u17 = i;
                end;

                break;
            end;

            if ballInGoalB(p127) then
                v136 = "A";
                table.insert(v130, p127);
                table.insert(v131, v139);
                table.insert(v132, p129);
                table.insert(v133, false);

                if u17 == 0 then
                    u17 = i;
                end;

                break;
            end;

            local v145;
            v145, v140 = getBounceVelocity(p127, v139, -313.13, -115.936, 23.443, 161.748);

            if v140 then
                p129 = getWallFrictionRotation(p127, v139, p129, -313.13, -115.936, 23.443, 161.748);
                p127 = Vector3.new(v138.X, p127.Y, v138.Z);
                p128 = Vector3.new(v145.X * 0.6, v145.Y * 0.7, v145.Z * 0.6);
                v135 = p129.Y / -45;
                v139 = p128;
                v143 = p127;
                v134 = 0;
            else
                v143 = v137;
            end;

            v141 = ballBouncedFloor(p127);

            if v141 then
                v143 = Vector3.new(p127.X, u10, p127.Z);

                if u17 == 0 then
                    u17 = i;
                end;

                p129 = getBallRotationOnImpact(v139) + Vector3.new(0, p129.Y * 0.8, 0);
                local v146 = math.abs(v139.Y) < 10 and 0.99 or 0.8;
                p128 = Vector3.new(v139.X * v146, v139.Y * -u5, v139.Z * v146);
                v135 = p129.Y / -45;
                v139 = p128;
                p127 = v143;
                v134 = 0;
            end;
        end;

        table.insert(v130, p127);
        table.insert(v131, v139);
        table.insert(v132, p129);

        if v142 then
            table.insert(v133, Sound);
        elseif v141 and math.abs(v139.Y) >= 10 then
            table.insert(v133, Sound4);
        elseif v140 then
            table.insert(v133, Sound2);
        else
            table.insert(v133, false);
        end;

        v134 = v134 + 0.005;
        v137 = v143;
    end;

    return v130, v131, v132, v133, v136;
end;

function softImpact(p147, p148)
    if p148 <= 0 then
        return 0;
    end;

    if p148 < p147 then
        p147 = p148;
    end;

    return math.sin(1.57 * p147 / p148);
end;

function animateBall()
    -- upvalues: u1 (ref), u25 (ref), u27 (ref), u18 (ref), u15 (ref), u19 (ref), u28 (ref), u22 (ref), u20 (ref), u21 (ref), u16 (ref), u17 (ref), u10 (ref), u26 (ref), u29 (ref), GoalEvent (copy), Sound3 (copy)
    if not (u1 and u25) then
        if u1 and u27 then
            local v149 = (tick() - u18) / (u15 + 0.005);
            local v150 = math.floor(v149);

            if v150 < 1 then
                return;
            end;

            if v150 <= #u19 then
                for i = math.max(u28 + 1, 1), math.min(v150, #u22) do
                    local v151 = u22[i];

                    if v151 then
                        if not v151.IsPlaying then
                            v151:Play();
                        end;

                        u22[i] = false;
                    end;
                end;

                u28 = v150;
                u1.Position = u19[v150];
                u1.Velocity = u20[v150];
                u1.RotVelocity = u21[v150];
                local v152 = u16 * (1 - softImpact(v150, u17));
                u1.Position = u1.Position - v152;

                if u1.Position.Y < u10 then
                    u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);

                    return;
                end;
            else
                if u26 then
                    u27 = false;
                    u29 = false;
                    GoalEvent:FireServer(u26, "dihtelkds");
                    wait(0.3);

                    if not u29 then
                        Sound3:Play();
                    end;

                    u1.Velocity = Vector3.new(u1.Velocity.X * 0.3, u1.Velocity.Y * 0.3, u1.Velocity.Z * 0.3);
                    u1.RotVelocity = Vector3.new(u1.RotVelocity.X * 0.3, u1.RotVelocity.Y * 0.3, u1.RotVelocity.Z * 0.3);

                    return;
                end;

                u25 = u1.Position;
            end;
        end;

        return;
    end;

    u1.Position = Vector3.new(u25.X, u1.Position.Y, u25.Z);
    u1.Velocity = Vector3.new(0, u1.Velocity.Y, 0);
    u1.RotVelocity = Vector3.new(0, 0, 0);
end;

function startAnimation(p153, p154, p155, p156, p157)
    -- upvalues: u19 (ref), u20 (ref), u21 (ref), u22 (ref), u26 (ref), u27 (ref), u25 (ref), u18 (ref), u16 (ref), u15 (ref), u28 (ref)
    local v158, v159, v160, v161, v162 = recordBallAnimation(p153, p154, p155);
    u19 = v158;
    u20 = v159;
    u21 = v160;
    u22 = v161;
    u26 = v162;
    u27 = true;
    u25 = nil;
    u18 = tick();
    u16 = p156;
    u15 = p157 / #v158;
    u28 = 0;
end;

function createBall(p163)
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    u1 = workspace.FootballField:FindFirstChild("SoccerBall");

    if u1 == nil then
        u1 = ReplicatedStorage:WaitForChild("SoccerBall"):Clone();
        u1.Parent = workspace.FootballField;
    end;
end;

function onDropBall(p164)
    -- upvalues: u1 (ref), u25 (ref), u2 (ref), u26 (ref)
    pcall(createBall, p164);

    if u1 then
        if p164 then
            u1.Position = Vector3.new(-214.544, 25, 92.531) + p164;
        else
            u1.Position = Vector3.new(-214.544, 25, 92.531);
        end;

        u25 = u1.Position;
    end;

    u2 = 0;
    u26 = nil;
end;

DropBallEvent.OnClientEvent:Connect(onDropBall);

function onRemoveBall()
    -- upvalues: u1 (ref)
    if u1 then
        u1:Destroy();
        u1 = nil;
    end;
end;

RemoveBallEvent.OnClientEvent:Connect(onRemoveBall);

function onMeasureLagEvent(p165)
    -- upvalues: u1 (ref), MeasureLag (copy)
    if u1 then
        MeasureLag:FireServer(p165);
    end;
end;

MeasureLagEvent.OnClientEvent:Connect(onMeasureLagEvent);

function onBallPositionEvent(p166, p167, p168)
    -- upvalues: u4 (ref), u23 (ref), u24 (ref), LocalPlayer (copy)
    u4 = p166;
    u23 = p167;
    u24 = p168;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local v169 = PlayerGui and PlayerGui:FindFirstChild("Ping", true);

    if v169 then
        local v170 = math.round(u4 * 2000);
        v169.Text = v170 .. "ms";

        if v170 <= 60 then
            v169.TextColor3 = Color3.new(0, 1, 0);

            return;
        end;

        if v170 <= 120 then
            v169.TextColor3 = Color3.new(1, 1, 0.498039);

            return;
        end;

        v169.TextColor3 = Color3.new(1, 0, 0);
    end;
end;

BallPositionEvent.OnClientEvent:Connect(onBallPositionEvent);

function onKickBallEvent(p171, p172, p173, p174)
    -- upvalues: u29 (ref), LocalPlayer (copy), u3 (ref), u1 (ref)
    u29 = true;

    if LocalPlayer.UserId ~= p171.UserId then
        u3 = tick();
        pcall(createBall, nil);

        if u1 then
            startAnimation(p172, p173, p174, p172 - u1.Position, 0);
        end;
    end;
end;

KickBallEvent.OnClientEvent:Connect(onKickBallEvent);

function getClosestPlayerName()
    -- upvalues: u23 (ref), u24 (ref), u1 (ref)
    local v175 = nil;
    local v176 = 10000;

    if u23 and u24 then
        for i, v in pairs(u24) do
            local Magnitude = (u1.Position - v).Magnitude;

            if Magnitude < v176 then
                v175 = u23[i];
                v176 = Magnitude;
            end;
        end;
    end;

    return v175;
end;

function touchDetect()
    local maxRange = 4
if states.reachActive then
	maxRange = states.reachRange
end
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), Humanoid (copy), u10 (ref), KickBall (copy), u4 (ref)
if LocalPlayer and (LocalPlayer.Character and (u1 and (tick() - u2 >= 0.6 and (tick() - u3 >= 0.3 and (states.mode == "Regular" or getClosestPlayerName() == LocalPlayer.Name))))) then
        local Position = LocalPlayer.Character.UpperTorso.Position;
        local Position2 = u1.Position;
        local Magnitude = (Position2 - Position).Magnitude;

        if Magnitude > 0.01 and Magnitude <= 4 then
            u2 = tick();
            local v177 = Position + Vector3.new(0, -3, 0);
            local v178 = Position + Vector3.new(0, 1.3, 0);
            local v179 = 34;
            local v180;

            if (v178 - Position2).Magnitude < (v177 - Position2).Magnitude then
                v180 = Position2 - v178;
                v179 = 0;
            else
                local v181 = Position2 - v177;
                v180 = Vector3.new(v181.X, 0, v181.Z);
            end;

            

            if game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamA") and game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamB") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Team") then
	local NameTeamA = game:GetService("ReplicatedStorage").NameTeamA.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
local NameTeamB = game:GetService("ReplicatedStorage").NameTeamB.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
if NameTeamA == Team then
	
	states.Goal = "B"
	elseif NameTeamB == Team then
		
		 states.Goal = "A"

end
	else

local fp = Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)
local sp = Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)

if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - fp).Magnitude < (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - sp).Magnitude then
    states.Goal = "A"
else
    states.Goal = "B"
end
end
			




local Unit
			if states.Aimbot then
				if states.Goal == "A" then
if states.Type == "Random" then
    local goal1randomizers = {
        Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219), -- net
        Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
    }

    local randomposition = goal1randomizers[math.random(1, #goal1randomizers)]
    Unit = (randomposition - u1.Position).Unit

elseif states.Type == "Top Left Corner" then
    Unit = (Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562)-u1.Position).Unit

elseif states.Type == "Top Right Corner" then
    Unit = (Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656)-u1.Position).Unit

elseif states.Type == "Net" then
    Unit = (Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)-u1.Position).Unit

elseif states.Type == "Bottom Left Corner" then
    Unit = (Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938)-u1.Position).Unit

elseif states.Type == "Bottom Right Corner" then
    Unit = (Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781)-u1.Position).Unit
end
					else
if states.Type == "Random" then
local goal2randomizers = {
	Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578), -- net
	Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)

}
local randomposition = goal2randomizers[math.random(1, #goal2randomizers)]
Unit = (randomposition - u1.Position).Unit
elseif states.Type == "Top Left Corner" then
Unit = (Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312)-u1.Position).Unit
	elseif states.Type == "Top Right Corner" then

Unit = (Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)-u1.Position).Unit
elseif states.Type == "Net" then
	Unit = (Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)-u1.Position).Unit
	elseif states.Type == "Bottom Left Corner" then
		Unit = (Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961)-u1.Position).Unit
		elseif states.Type == "Bottom Right Corner" then
			Unit = (Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297)-u1.Position).Unit
end
				end
			else
			Unit = v180.Unit;
			end

            if states.Aimbot and states.Goal == "A" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalA = {
    Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
}

for _, position in cornersGoalA do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

              if states.Aimbot and states.Goal == "B" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalB = {
    Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)
}

for _, position in cornersGoalB do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

            

            if Unit.Magnitude > 0.01 then
                local v182 = Vector3.new(0, 0, 0);
                local LookVector = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector;
                local Unit2 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
                local v183 = math.atan2(Unit2.X, Unit2.Z) - math.atan2(Unit.X, Unit.Z);
                local v184 = math.abs(v183);
                local v185 = math.deg(v184);

                if v185 <= 20 then
                    Unit = (Unit2 + Unit).Unit;
                end;

                if v185 < 90 then
                    local v186 = v185 / 3;

                    if v183 < 0 then
                        v182 = Vector3.new(0, v186, 0);
                    else
                        v182 = Vector3.new(0, -v186, 0);
                    end;
                end;

                local WalkSpeed = Humanoid.WalkSpeed;

                if WalkSpeed <= 46 then
                    local v187;

                    

                    if WalkSpeed >= 19 then
                        local v188
                        if states.Aimbot then
							v188 = Vector3.new(0, states.Height, 0);
							else
							v188 = Vector3.new(0, 34, 0);
						end
                        local v189 = (WalkSpeed - 19) * 10 + 40 + Vector3.new(u1.Velocity.X, 0, u1.Velocity.Z).Magnitude;
                        
                        
                        local power = 85
						local v190
						if states.powerShotActive then
							power = states.powerShotPower
							v190 = Unit * power + v188;
							else
							v190 = Unit * (v189 > power and power or v189) + v188;
						end
                        local X = v190.X;
                        local v191 = math.min(v190.Y, 40);
                        v187 = Vector3.new(X, v191, v190.Z);
                    elseif WalkSpeed == 16 then
                        v187 = Unit * 20 + Vector3.new(0, 0, 0);
                    else
                        v187 = Unit * ((WalkSpeed - 16) * 15 + 25) + Vector3.new(0, 5, 0);
                    end;

                    if u1.Position.Y < u10 then
                        u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);
                    end;

                    KickBall:FireServer(u1.Position, v187, v182, Magnitude, "dihtelkds");
                    startAnimation(u1.Position, v187, v182, Vector3.new(0, 0, 0), u4);
                end;
            end;
        end;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 796
    pcall(touchDetect);
    pcall(animateBall);
    pcall(checkNearGoal);
end);


-- ===== SETTINGS =====
local LINE_COLOR = Color3.fromRGB(120,150,255)
local LINE_MATERIAL = Enum.Material.Neon
local DRAW_THICKNESS = 0.5
local LINE_TRANSPARENCY = 0
local SEG_MIN_DIST = 0.03
local FLOOR_Y = 5.473

-- ===== VISUAL FOLDER =====
local visuals = workspace:FindFirstChild("trajectory")
if not visuals then
    visuals = Instance.new("Folder")
    visuals.Name = "trajectory"
    visuals.Parent = workspace
end

local function clearVisuals()
    for _,v in ipairs(visuals:GetChildren()) do
        v:Destroy()
    end
end

-- ===== DRAW HELPERS =====
local function createSegment(a,b)
    local dir = b-a
    local d = dir.Magnitude
    if d < SEG_MIN_DIST then return end

    local mid = (a+b)*0.5

    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.CastShadow = false
    p.Material = LINE_MATERIAL
    p.Color = LINE_COLOR
    p.Transparency = LINE_TRANSPARENCY
    p.Size = Vector3.new(DRAW_THICKNESS,2,d)
    p.CFrame = CFrame.new(mid,mid+dir)*CFrame.Angles(math.pi/2,0,0)
    p.Parent = visuals
end

local function drawPath(points)
    for i=1,#points-1 do
        local a = Vector3.new(points[i].X, math.max(points[i].Y,FLOOR_Y), points[i].Z)
        local b = Vector3.new(points[i+1].X, math.max(points[i+1].Y,FLOOR_Y), points[i+1].Z)
        createSegment(a,b)
    end
end

local function createMarker(pos)
    local m = Instance.new("Part")
    m.Shape = Enum.PartType.Ball
    m.Anchored = true
    m.CanCollide = false
    m.CastShadow = false
    m.Material = Enum.Material.Neon
    m.Color = Color3.fromRGB(211,211,211)
    m.Size = Vector3.new(1.5,1.5,1.5)
    m.CFrame = CFrame.new(pos)
    m.Parent = visuals
end

-- ===== EVENT HOOK =====
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local event = RS:FindFirstChild("KickBallEvent")
if not event then return end

event.OnClientEvent:Connect(function(...)
    if not states.trajectoryActive then
        clearVisuals()
        return
    end


    clearVisuals()

    local player = Players.LocalPlayer
    local char = player.Character
    if not char then return end

    

  

    local args = {...}
    local pos,vel,spin = args[2],args[3],args[4]

    if typeof(pos) ~= "Vector3" and typeof(args[1])=="Vector3" then
        pos,vel,spin = args[1],args[2],args[3]
    end

    if typeof(pos)~="Vector3" or typeof(vel)~="Vector3" then return end

    local pts
    local success = pcall(function()
        pts = recordBallAnimation(pos,vel,spin)
    end)

    if not success or not pts or #pts < 2 then return end

    task.defer(function()
        drawPath(pts)
   
    end)

    pcall(function()
        createMarker(pts[1])

        if ballInGoalA(pts[#pts])
        or ballInGoalB(pts[#pts]) then
            createMarker(pts[#pts])
        else
            createMarker(pts[math.round(#pts/1.6)])
        end
    end)
end)
            end
            end)
            task.spawn(function()
            if game.PlaceId == 83225464801601 then
            -- Script Path: game:GetService("Workspace").cowhousecandyisthetr.BallHandler
-- Took 0.04s to decompile.
-- Executor: Potassium (v2.4.4)

-- Decompiled with Potassium's decompiler.

local BallHandler
if game.Players.LocalPlayer.Character:FindFirstChild("BallHandler") then
	game.Players.LocalPlayer.Character:FindFirstChild("BallHandler"):Destroy()
end

local Humanoid
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
game.Players.LocalPlayer.CharacterAdded:Connect(function ()
	Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
	BallHandler = game.Players.LocalPlayer.Character:WaitForChild("BallHandler")
	BallHandler:Destroy()
end)
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KickBall = ReplicatedStorage:WaitForChild("KickBall");
local DropBallEvent = ReplicatedStorage:WaitForChild("DropBallEvent");
local RemoveBallEvent = ReplicatedStorage:WaitForChild("RemoveBallEvent");
local BallPositionEvent = ReplicatedStorage:WaitForChild("BallPositionEvent");
local KickBallEvent = ReplicatedStorage:WaitForChild("KickBallEvent");
local LocalPlayer = Players.LocalPlayer;
local MeasureLag = ReplicatedStorage:WaitForChild("MeasureLag");
local MeasureLagEvent = ReplicatedStorage:WaitForChild("MeasureLagEvent");
local GoalEvent = ReplicatedStorage:WaitForChild("GoalEvent");
local NearGoalEvent = ReplicatedStorage:WaitForChild("NearGoalEvent");
local u1 = nil;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local u5 = 0.55;
local u6 = 55;
local u7 = 0;
local u8 = 0;
local u9 = 0;
local u10 = 5.473;
local u11 = u7 + 78.036;
local u12 = 107.715 - u7;
local u13 = u8 + 18;
local u14 = u8 + 17;
local u15 = 0;
local u16 = nil;
local u17 = 0;
local u18 = 0;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = false;
local u28 = 0;
local u29 = false;
local u30 = 0;
local Sound = Instance.new("Sound", game.Workspace);
Sound.SoundId = "rbxassetid://82599119475859";
Sound.Volume = 0.4;
local Sound2 = Instance.new("Sound", game.Workspace);
Sound2.SoundId = "rbxassetid://74303966391925";
Sound2.Volume = 0.4;
local Sound3 = Instance.new("Sound", game.Workspace);
Sound3.SoundId = "rbxassetid://122054734580185";
Sound3.Volume = 0.5;
local Sound4 = Instance.new("Sound", game.Workspace);
Sound4.SoundId = "rbxassetid://9119319842";
Sound4.Volume = 1;

function ballBouncedFloor(p31)
    -- upvalues: u10 (ref)
    return p31.Y < u10;
end;

function ballInGoalA(p32)
    -- upvalues: u11 (copy), u12 (copy), u14 (copy)
    return p32.X < -313.13 and (u11 <= p32.Z and (p32.Z <= u12 and p32.Y <= u14));
end;

function ballInGoalB(p33)
    -- upvalues: u11 (copy), u12 (copy), u14 (copy)
    return p33.X > -115.936 and (u11 <= p33.Z and (p33.Z <= u12 and p33.Y <= u14));
end;

local function copyVec(p34) -- Line: 157
    return {
        X = p34.X,
        Y = p34.Y,
        Z = p34.Z
    };
end;

local function reflectVelocity(p35, p36) -- Line: 161
    local v37 = p35.X * p36.X + p35.Y * p36.Y + p35.Z * p36.Z;

    return {
        X = p35.X - 2 * v37 * p36.X,
        Y = p35.Y - 2 * v37 * p36.Y,
        Z = p35.Z - 2 * v37 * p36.Z
    };
end;

local function length2(p38, p39) -- Line: 166
    return math.sqrt(p38 * p38 + p39 * p39);
end;

local function hitPost(p40, p41, p42, p43) -- Line: 170
    -- upvalues: u13 (copy), reflectVelocity (copy)
    local v44 = p42.X - p40;
    local v45 = p42.Z - p41;
    local v46 = math.sqrt(v44 * v44 + v45 * v45);

    if v46 > 1.825 or (p42.Y < -1.5 or p42.Y > u13 + 1.5) then
        return false, p42, {
            X = p43.X,
            Y = p43.Y,
            Z = p43.Z
        };
    end;

    local v47, v48;

    if v46 > 1e-9 then
        v47 = v44 / v46;
        v48 = v45 / v46;
    else
        v47 = 0;
        v48 = 1;
        v46 = 1e-9;
    end;

    if p43.X * v47 + p43.Z * v48 >= 0 then
        return false, p42, {
            X = p43.X,
            Y = p43.Y,
            Z = p43.Z
        };
    end;

    local v49 = 1.8259999999999998 - v46;

    return true, Vector3.new(p42.X + v47 * v49, p42.Y, p42.Z + v48 * v49), reflectVelocity(p43, {
        Y = 0,
        X = v47,
        Z = v48
    });
end;

local function hitBar(p50, p51, p52) -- Line: 212
    -- upvalues: u11 (copy), u12 (copy), u13 (copy), reflectVelocity (copy)
    if p51.Z >= u11 - 1.5 and p51.Z <= u12 + 1.5 then
        local v53 = p51.X - p50;
        local v54 = p51.Y - u13;
        local v55 = math.sqrt(v53 * v53 + v54 * v54);

        if v55 <= 1.825 then
            local v56, v57;

            if v55 > 1e-9 then
                v56 = v53 / v55;
                v57 = v54 / v55;
            else
                v56 = 0;
                v57 = 1;
                v55 = 1e-9;
            end;

            if p52.X * v56 + p52.Y * v57 >= 0 then
                return false, p51, {
                    X = p52.X,
                    Y = p52.Y,
                    Z = p52.Z
                };
            end;

            local v58 = 1.8259999999999998 - v55;

            return true, Vector3.new(p51.X + v56 * v58, p51.Y + v57 * v58, p51.Z), reflectVelocity(p52, {
                Z = 0,
                X = v56,
                Y = v57
            });
        end;
    end;

    return false, p51, {
        X = p52.X,
        Y = p52.Y,
        Z = p52.Z
    };
end;

function ballHitsLeftPoleA(p59, p60)
    -- upvalues: hitPost (copy), u11 (copy)
    return hitPost(-313.13, u11, p59, p60);
end;

function ballHitsRightPoleA(p61, p62)
    -- upvalues: hitPost (copy), u12 (copy)
    return hitPost(-313.13, u12, p61, p62);
end;

function ballHitsCrossbarA(p63, p64)
    -- upvalues: hitBar (copy)
    return hitBar(-313.13, p63, p64);
end;

function ballHitsLeftPoleB(p65, p66)
    -- upvalues: hitPost (copy), u11 (copy)
    return hitPost(-115.936, u11, p65, p66);
end;

function ballHitsRightPoleB(p67, p68)
    -- upvalues: hitPost (copy), u12 (copy)
    return hitPost(-115.936, u12, p67, p68);
end;

function ballHitsCrossbarB(p69, p70)
    -- upvalues: hitBar (copy)
    return hitBar(-115.936, p69, p70);
end;

function ballHitsGoalFrame(p71, p72)
    local v73, v74, v75 = ballHitsLeftPoleA(p71, p72);

    if v73 then
        return true, v74, v75, "LeftPoleA";
    end;

    local v76, v77, v78 = ballHitsRightPoleA(p71, p72);

    if v76 then
        return true, v77, v78, "RightPoleA";
    end;

    local v79, v80, v81 = ballHitsCrossbarA(p71, p72);

    if v79 then
        return true, v80, v81, "CrossbarA";
    end;

    local v82, v83, v84 = ballHitsLeftPoleB(p71, p72);

    if v82 then
        return true, v83, v84, "LeftPoleB";
    end;

    local v85, v86, v87 = ballHitsRightPoleB(p71, p72);

    if v85 then
        return true, v86, v87, "RightPoleB";
    end;

    local v88, v89, v90 = ballHitsCrossbarB(p71, p72);

    if v88 then
        return true, v89, v90, "CrossbarB";
    end;

    return false, p71, {
        X = p72.X,
        Y = p72.Y,
        Z = p72.Z
    }, "";
end;

function checkNearGoal()
    -- upvalues: u1 (ref), u30 (ref), u7 (ref), u8 (ref), NearGoalEvent (copy)
    if u1 and (tick() - u30 > 5 and u1.Velocity.Magnitude > 10) then
        if u1.Position.X < -309 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u30 = tick();
            NearGoalEvent:FireServer("B");

            return;
        end;

        if u1.Position.X > -120 and (u1.Position.Z + u7 >= 70 and (u1.Position.Z - u7 <= 114 and u1.Position.Y < u8 + 19)) then
            u30 = tick();
            NearGoalEvent:FireServer("A");
        end;
    end;
end;

function soccerBallTrajectory(p91, p92, p93, p94, p95)
    local X = p92.X;
    local Z = p92.Z;
    local Y = p92.Y;
    local X2 = p93.X;
    local Z2 = p93.Z;
    local Y2 = p93.Y;
    local v96 = p95 * p91;
    local v97 = X * math.cos(v96) - Z * math.sin(v96);
    local v98 = X * math.sin(v96) + Z * math.cos(v96);

    return Vector3.new(X2 + X * p91 + 0.5 * (v97 - X) * p91, Y2 + Y * p91 - 0.5 * p94 * p91 ^ 2, Z2 + Z * p91 + 0.5 * (v98 - Z) * p91), Vector3.new(v97, Y - p94 * p91, v98);
end;

function getBallRotationOnImpact(p99)
    local v100 = Vector3.new(p99.X, 0, p99.Z);

    return (Vector3.new(0, 1, 0)):Cross(v100.Unit).Unit * (v100.Magnitude * 0.8 / 1.5);
end;

function getBounceVelocity(p101, p102, p103, p104, p105, p106)
    -- upvalues: u9 (ref)
    local v107;

    if p101.Z > p106 - u9 then
        local X = p102.X;
        local Y = p102.Y;
        local v108 = -math.abs(p102.Z);
        p102 = Vector3.new(X, Y, v108);
        v107 = true;
    else
        v107 = false;
    end;

    if p101.Z < p105 + u9 then
        local X = p102.X;
        local Y = p102.Y;
        local v109 = math.abs(p102.Z);
        p102 = Vector3.new(X, Y, v109);
        v107 = true;
    end;

    if p104 < p101.X then
        local v110 = -math.abs(p102.X);
        p102 = Vector3.new(v110, p102.Y, p102.Z);
        v107 = true;
    end;

    if p101.X < p103 then
        local v111 = math.abs(p102.X);
        p102 = Vector3.new(v111, p102.Y, p102.Z);
        v107 = true;
    end;

    return p102, v107;
end;

local function getWallFrictionRotation(p112, p113, p114, p115, p116, p117, p118) -- Line: 363
    -- upvalues: u9 (ref)
    local Y = p114.Y;

    local function applyFriction(p119) -- Line: 366
        -- upvalues: Y (ref)
        Y = Y + (p119 - Y) * 0.35;
    end;

    if p112.Z > p118 - u9 then
        Y = Y + (-p113.X / 1.5 - Y) * 0.35;
    end;

    if p112.Z < p117 + u9 then
        Y = Y + (p113.X / 1.5 - Y) * 0.35;
    end;

    if p116 < p112.X then
        Y = Y + (p113.Z / 1.5 - Y) * 0.35;
    end;

    if p112.X < p115 then
        Y = Y + (-p113.Z / 1.5 - Y) * 0.35;
    end;

    return Vector3.new(p114.X, Y, p114.Z);
end;

function ensureInside(p120, p121, p122, p123, p124)
    local v125 = math.clamp(p120.X, p121, p122);
    local v126 = math.clamp(p120.Z, p123, p124);

    return Vector3.new(v125, p120.Y, v126);
end;

function recordBallAnimation(p127, p128, p129)
    -- upvalues: u17 (ref), u6 (ref), getWallFrictionRotation (copy), u10 (ref), u5 (ref), Sound (copy), Sound4 (copy), Sound2 (copy)
    local v130 = {};
    local v131 = {};
    local v132 = {};
    local v133 = {};
    table.insert(v130, p127);
    table.insert(v131, p128);
    table.insert(v132, p129);
    table.insert(v133, false);
    local v134 = 0;
    local v135 = p129.Y / -45;
    local v136 = nil;
    u17 = 0;
    local v137 = p127;

    for i = 1, 2000 do
        local v138 = ensureInside(p127, -313.13, -115.936, 23.443, 161.748);
        local v139, v140 = soccerBallTrajectory(v134, p128, v137, u6, v135);

        if v140.Magnitude < 0.5 then
            break;
        end;

        local v141 = nil;
        local v142 = false;
        local v143, v144;
        v143, p127, v144 = ballHitsGoalFrame(v139, v140);

        if v143 then
            v140 = Vector3.new(v144.X * 0.6, v144.Y * 0.7, v144.Z * 0.6);
            p129 = p129 * 0.8;
            v135 = p129.Y / -45;
            v137 = p127;
            p128 = v140;
            v134 = 0;
        else
            if ballInGoalA(v139) then
                v136 = "B";
                table.insert(v130, v139);
                table.insert(v131, v140);
                table.insert(v132, p129);
                table.insert(v133, false);

                if u17 == 0 then
                    u17 = i;
                end;

                break;
            end;

            if ballInGoalB(v139) then
                v136 = "A";
                table.insert(v130, v139);
                table.insert(v131, v140);
                table.insert(v132, p129);
                table.insert(v133, false);

                if u17 == 0 then
                    u17 = i;
                end;

                break;
            end;

            local v145;
            v145, v141 = getBounceVelocity(v139, v140, -313.13, -115.936, 23.443, 161.748);

            if v141 then
                p129 = getWallFrictionRotation(v139, v140, p129, -313.13, -115.936, 23.443, 161.748);
                p127 = Vector3.new(v138.X, v139.Y, v138.Z);
                v140 = Vector3.new(v145.X * 0.6, v145.Y * 0.7, v145.Z * 0.6);
                v135 = p129.Y / -45;
                v137 = p127;
                p128 = v140;
                v134 = 0;
            else
                p127 = v139;
            end;

            v142 = ballBouncedFloor(p127);

            if v142 then
                p127 = Vector3.new(p127.X, u10, p127.Z);

                if u17 == 0 then
                    u17 = i;
                end;

                p129 = getBallRotationOnImpact(v140) + Vector3.new(0, p129.Y * 0.8, 0);
                local v146 = math.abs(v140.Y) < 10 and 0.99 or 0.8;
                v140 = Vector3.new(v140.X * v146, v140.Y * -u5, v140.Z * v146);
                v135 = p129.Y / -45;
                v137 = p127;
                p128 = v140;
                v134 = 0;
            end;
        end;

        table.insert(v130, p127);
        table.insert(v131, v140);
        table.insert(v132, p129);

        if v143 then
            table.insert(v133, Sound);
        elseif v142 and math.abs(v140.Y) >= 10 then
            table.insert(v133, Sound4);
        elseif v141 then
            table.insert(v133, Sound2);
        else
            table.insert(v133, false);
        end;

        v134 = v134 + 0.005;
    end;

    return v130, v131, v132, v133, v136;
end;

function softImpact(p147, p148)
    if p148 <= 0 then
        return 0;
    end;

    if p148 < p147 then
        p147 = p148;
    end;

    return math.sin(1.57 * p147 / p148);
end;

function animateBall()
    -- upvalues: u1 (ref), u25 (ref), u27 (ref), u18 (ref), u15 (ref), u19 (ref), u28 (ref), u22 (ref), u20 (ref), u21 (ref), u16 (ref), u17 (ref), u10 (ref), u26 (ref), u29 (ref), GoalEvent (copy), Sound3 (copy)
    if not (u1 and u25) then
        if u1 and u27 then
            local v149 = (tick() - u18) / (u15 + 0.005);
            local v150 = math.floor(v149);

            if v150 < 1 then
                return;
            end;

            if v150 <= #u19 then
                for i = math.max(u28 + 1, 1), math.min(v150, #u22) do
                    local v151 = u22[i];

                    if v151 then
                        if not v151.IsPlaying then
                            v151:Play();
                        end;

                        u22[i] = false;
                    end;
                end;

                u28 = v150;
                u1.Position = u19[v150];
                u1.Velocity = u20[v150];
                u1.RotVelocity = u21[v150];
                local v152 = u16 * (1 - softImpact(v150, u17));
                u1.Position = u1.Position - v152;

                if u1.Position.Y < u10 then
                    u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);

                    return;
                end;
            else
                if u26 then
                    u27 = false;
                    u29 = false;
                    GoalEvent:FireServer(u26, "dihtelkds");
                    wait(0.3);

                    if not u29 then
                        Sound3:Play();
                    end;

                    u1.Velocity = Vector3.new(u1.Velocity.X * 0.3, u1.Velocity.Y * 0.3, u1.Velocity.Z * 0.3);
                    u1.RotVelocity = Vector3.new(u1.RotVelocity.X * 0.3, u1.RotVelocity.Y * 0.3, u1.RotVelocity.Z * 0.3);

                    return;
                end;

                u25 = u1.Position;
            end;
        end;

        return;
    end;

    u1.Position = Vector3.new(u25.X, u1.Position.Y, u25.Z);
    u1.Velocity = Vector3.new(0, u1.Velocity.Y, 0);
    u1.RotVelocity = Vector3.new(0, 0, 0);
end;

function startAnimation(p153, p154, p155, p156, p157)
    -- upvalues: u19 (ref), u20 (ref), u21 (ref), u22 (ref), u26 (ref), u27 (ref), u25 (ref), u18 (ref), u16 (ref), u15 (ref), u28 (ref)
    local v158, v159, v160, v161, v162 = recordBallAnimation(p153, p154, p155);
    u19 = v158;
    u20 = v159;
    u21 = v160;
    u22 = v161;
    u26 = v162;
    u27 = true;
    u25 = nil;
    u18 = tick();
    u16 = p156;
    u15 = p157 / #v158;
    u28 = 0;
end;

function createBall(p163)
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    u1 = workspace.FootballField:FindFirstChild("SoccerBall");

    if u1 == nil then
        u1 = ReplicatedStorage:WaitForChild("SoccerBall"):Clone();
        u1.Parent = workspace.FootballField;
    end;
end;

function onDropBall(p164)
    -- upvalues: u1 (ref), u25 (ref), u2 (ref), u26 (ref)
    pcall(createBall, p164);

    if u1 then
        if p164 then
            u1.Position = Vector3.new(-214.544, 25, 92.531) + p164;
        else
            u1.Position = Vector3.new(-214.544, 25, 92.531);
        end;

        u25 = u1.Position;
    end;

    u2 = 0;
    u26 = nil;
end;

DropBallEvent.OnClientEvent:Connect(onDropBall);

function onRemoveBall()
    -- upvalues: u1 (ref)
    if u1 then
        u1:Destroy();
        u1 = nil;
    end;
end;

RemoveBallEvent.OnClientEvent:Connect(onRemoveBall);

function onMeasureLagEvent(p165)
    -- upvalues: u1 (ref), MeasureLag (copy)
    if u1 then
        MeasureLag:FireServer(p165);
    end;
end;

MeasureLagEvent.OnClientEvent:Connect(onMeasureLagEvent);

function onBallPositionEvent(p166, p167, p168)
    -- upvalues: u4 (ref), u23 (ref), u24 (ref), LocalPlayer (copy)
    u4 = p166;
    u23 = p167;
    u24 = p168;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local v169 = PlayerGui and PlayerGui:FindFirstChild("Ping", true);

    if v169 then
        local v170 = math.round(u4 * 2000);
        v169.Text = v170 .. "ms";

        if v170 <= 60 then
            v169.TextColor3 = Color3.new(0, 1, 0);

            return;
        end;

        if v170 <= 120 then
            v169.TextColor3 = Color3.new(1, 1, 0.498039);

            return;
        end;

        v169.TextColor3 = Color3.new(1, 0, 0);
    end;
end;

BallPositionEvent.OnClientEvent:Connect(onBallPositionEvent);

function onKickBallEvent(p171, p172, p173, p174)
    -- upvalues: u29 (ref), LocalPlayer (copy), u3 (ref), u1 (ref)
    u29 = true;

    if LocalPlayer.UserId ~= p171.UserId then
        u3 = tick();
        pcall(createBall, nil);

        if u1 then
            startAnimation(p172, p173, p174, p172 - u1.Position, 0);
        end;
    end;
end;

KickBallEvent.OnClientEvent:Connect(onKickBallEvent);

function getClosestPlayerName()
    -- upvalues: u23 (ref), u24 (ref), u1 (ref)
    local v175 = nil;
    local v176 = 10000;

    if u23 and u24 then
        for i, v in pairs(u24) do
            local Magnitude = (u1.Position - v).Magnitude;

            if Magnitude < v176 then
                v175 = u23[i];
                v176 = Magnitude;
            end;
        end;
    end;

    return v175;
end;

function touchDetect()
    local maxRange = 4
if states.reachActive then
	maxRange = states.reachRange
end
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), Humanoid (copy), u10 (ref), KickBall (copy), u4 (ref)
if LocalPlayer and (LocalPlayer.Character and (u1 and (tick() - u2 >= 0.6 and (tick() - u3 >= 0.3 and (states.mode == "Regular" or getClosestPlayerName() == LocalPlayer.Name))))) then
        local Position = LocalPlayer.Character.UpperTorso.Position;
        local Position2 = u1.Position;
        local Magnitude = (Position2 - Position).Magnitude;

        if Magnitude > 0.01 and Magnitude <= 4 then
            u2 = tick();
            local v177 = Position + Vector3.new(0, -3, 0);
            local v178 = Position + Vector3.new(0, 1.3, 0);
            local v179 = 34;
            local v180;

            if (v178 - Position2).Magnitude < (v177 - Position2).Magnitude then
                v180 = Position2 - v178;
                v179 = 0;
            else
                local v181 = Position2 - v177;
                v180 = Vector3.new(v181.X, 0, v181.Z);
            end;

            

            if game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamA") and game:GetService("ReplicatedStorage"):FindFirstChild("NameTeamB") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Team") then
	local NameTeamA = game:GetService("ReplicatedStorage").NameTeamA.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
local NameTeamB = game:GetService("ReplicatedStorage").NameTeamB.Value
local Team = game.Players.LocalPlayer.Character.Team.Value
if NameTeamA == Team then
	
	states.Goal = "B"
	elseif NameTeamB == Team then
		
		 states.Goal = "A"

end
	else

local fp = Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)
local sp = Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)

if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - fp).Magnitude < (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - sp).Magnitude then
    states.Goal = "A"
else
    states.Goal = "B"
end
end
			




local Unit
			if states.Aimbot then
				if states.Goal == "A" then
if states.Type == "Random" then
    local goal1randomizers = {
        Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219), -- net
        Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
    }

    local randomposition = goal1randomizers[math.random(1, #goal1randomizers)]
    Unit = (randomposition - u1.Position).Unit

elseif states.Type == "Top Left Corner" then
    Unit = (Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562)-u1.Position).Unit

elseif states.Type == "Top Right Corner" then
    Unit = (Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656)-u1.Position).Unit

elseif states.Type == "Net" then
    Unit = (Vector3.new(-323.91107177734375, 7.71235466003418, 92.11845397949219)-u1.Position).Unit

elseif states.Type == "Bottom Left Corner" then
    Unit = (Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938)-u1.Position).Unit

elseif states.Type == "Bottom Right Corner" then
    Unit = (Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781)-u1.Position).Unit
end
					else
if states.Type == "Random" then
local goal2randomizers = {
	Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578), -- net
	Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)

}
local randomposition = goal2randomizers[math.random(1, #goal2randomizers)]
Unit = (randomposition - u1.Position).Unit
elseif states.Type == "Top Left Corner" then
Unit = (Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312)-u1.Position).Unit
	elseif states.Type == "Top Right Corner" then

Unit = (Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)-u1.Position).Unit
elseif states.Type == "Net" then
	Unit = (Vector3.new(-104.86092376708984, 9.353096961975098, 92.90460968017578)-u1.Position).Unit
	elseif states.Type == "Bottom Left Corner" then
		Unit = (Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961)-u1.Position).Unit
		elseif states.Type == "Bottom Right Corner" then
			Unit = (Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297)-u1.Position).Unit
end
				end
			else
			Unit = v180.Unit;
			end

            if states.Aimbot and states.Goal == "A" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalA = {
    Vector3.new(-313.17388916015625, 4.993070602416992, 105.49398803710938), -- bottom left
        Vector3.new(-313.2939758300781, 5.006017684936523, 79.10322570800781), -- bottom right
        Vector3.new(-313.1204833984375, 15.373732566833496, 105.34121704101562), -- top left
        Vector3.new(-313.1168212890625, 14.769414901733398, 78.57752990722656) -- top right
}

for _, position in cornersGoalA do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

              if states.Aimbot and states.Goal == "B" and states.FurthestCorner then
            local checkingposition
local farthest = 0
local farthestposition

local cornersGoalB = {
    Vector3.new(-115.78116607666016, 5.3203582763671875, 79.4884262084961), -- bottom left
	Vector3.new(-115.88164520263672, 5.489896774291992, 106.34947967529297), -- bottom right
	Vector3.new(-115.86947631835938, 14.99127197265625, 79.41970825195312),
	Vector3.new(-115.89704895019531, 15.17265796661377, 106.12665557861328)
}

for _, position in cornersGoalB do
if (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude > farthest then
farthestposition = position
farthest = (position-game.Players.LocalPlayer.Character.UpperTorso.Position).magnitude
end

end

Unit = (farthestposition-u1.Position).Unit

            end

            

            if Unit.Magnitude > 0.01 then
                local v182 = Vector3.new(0, 0, 0);
                local LookVector = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector;
                local Unit2 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
                local v183 = math.atan2(Unit2.X, Unit2.Z) - math.atan2(Unit.X, Unit.Z);
                local v184 = math.abs(v183);
                local v185 = math.deg(v184);

                if v185 <= 20 then
                    Unit = (Unit2 + Unit).Unit;
                end;

                if v185 < 90 then
                    local v186 = v185 / 3;

                    if v183 < 0 then
                        v182 = Vector3.new(0, v186, 0);
                    else
                        v182 = Vector3.new(0, -v186, 0);
                    end;
                end;

                local WalkSpeed = Humanoid.WalkSpeed;

                if WalkSpeed <= 46 then
                    local v187;

                    

                    if WalkSpeed >= 19 then
                        local v188
                        if states.Aimbot then
							v188 = Vector3.new(0, states.Height, 0);
							else
							v188 = Vector3.new(0, 34, 0);
						end
                        local v189 = (WalkSpeed - 19) * 10 + 40 + Vector3.new(u1.Velocity.X, 0, u1.Velocity.Z).Magnitude;
                        
                        
                        local power = 85
						local v190
						if states.powerShotActive then
							power = states.powerShotPower
							v190 = Unit * power + v188;
							else
							v190 = Unit * (v189 > power and power or v189) + v188;
						end
                        local X = v190.X;
                        local v191 = math.min(v190.Y, 40);
                        v187 = Vector3.new(X, v191, v190.Z);
                    elseif WalkSpeed == 16 then
                        v187 = Unit * 20 + Vector3.new(0, 0, 0);
                    else
                        v187 = Unit * ((WalkSpeed - 16) * 15 + 25) + Vector3.new(0, 5, 0);
                    end;

                    if u1.Position.Y < u10 then
                        u1.Position = Vector3.new(u1.Position.X, u10, u1.Position.Z);
                    end;

                    KickBall:FireServer(u1.Position, v187, v182, Magnitude, "dihtelkds");
                    startAnimation(u1.Position, v187, v182, Vector3.new(0, 0, 0), u4);
                end;
            end;
        end;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 796
    pcall(touchDetect);
    pcall(animateBall);
    pcall(checkNearGoal);
end);

            end
            end)
            

local antiCancelActive = true
local isContested = false
local lastKickTime = 0
local hitboxSize = Vector3.new(12, 12, 12)
local INFLUENCE_RADIUS = 12.8
local PULL_STRENGTH_BASE = 5.9
local EDGE_MULT = 2.35
local FORWARD_HELP = 11.0
local FORWARD_MIN_DOT = 0.42
local SIDE_DAMP = 0.145
local ESCAPE_DAMP = 2.4
local MAX_DELTA_NORMAL = 26
local BALL_SPEED_LIMIT = 50
local noiseT = 0
local POKER_SPEED = 16

local HIDDEN_BUFFER = 0.45 
local HIDDEN_DROP = 0.0
local HIGH_HIT_FORCE = 60
local TOUCH_DIST = 4.0
local ANGLE_THRESHOLD = 0.5
local MAX_SPOOF_SHIFT = 2.6

local lastStatUpdate = 0
local lastGkBodyVelocity = nil
local rainbowHue = 0
local rainbowPitchHue = 0
local predictionFolder = nil
local dots = {}
local bigDot = nil
local DOT_COUNT = 20
local RayfieldElements = {} 
local MobileButtons = {}
local cachedBall = nil
local lastCacheCheck = 0
local lastKick = 0
local lastHitbox = 0
local lastTrajTick = 0

local config = {
    minimized = false,
    diveSpeed = 27, 
    gsSpeed = 22,   
    isDiving = false,    
    isGsDashing = false, 
    clearPower = 85,
    boxWidth = 145,  
    boxDepth = 60,   
    boxHeight = 32  
}

local position_history = {}
local max_history = 5
local smoothed_velocity = Vector3.new(0, 0, 0)
local traj_folder = Workspace:FindFirstChild("NamelessTrajFolder") or Instance.new("Folder", Workspace)
traj_folder.Name = "NamelessTrajFolder"

local trajPartsPool = {}

local MeasureLag = RS:FindFirstChild("MeasureLag")
local MeasureLagEvent = RS:FindFirstChild("MeasureLagEvent")

local function getKickRemote()
    return RS:FindFirstChild("KickBall") or RS:FindFirstChild("KickBallEvent") or RS:WaitForChild("KickBallEvent", 3)
end

local function getBall()
    local now = os.clock()
    if now - lastCacheCheck > 0.3 then
        lastCacheCheck = now
        local field = Workspace:FindFirstChild("FootballField")
        cachedBall = field and (field:FindFirstChild("SoccerBall") or field:FindFirstChild("FutsalBall") or field:FindFirstChild("Ball"))
    end
    return cachedBall
end

local function forceHitboxUpdate()
    local char = me.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = root.CFrame * CFrame.new(0, 0, 0.001)
        end
    end
end

local function clampDelta(delta, maxPerSec, dt)
    local cap = maxPerSec * dt
    local mag = delta.Magnitude
    if mag <= cap then return delta end
    return delta.Unit * cap
end

local function fireKick(ballPos, vec, count)
    local remote = getKickRemote()
    if not remote then return end
    for i = 1, count do
        pcall(function() remote:FireServer(ballPos, vec) end)
    end
end

local function ApplyShoeChangerLogic()
    local char = me.Character
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and (part.Name:lower():find("shoe") or part.Name:lower():find("foot")) then
            part.Color = states.shoeColor
            part.Material = states.shoeGlow and Enum.Material.Neon or Enum.Material.Plastic
        end
    end
end

local function ApplyShirtCustomizerLogic()
    local char = me.Character
    if not char then return end
    for _, d in pairs(char:GetDescendants()) do
        if d:IsA("TextLabel") or d:IsA("TextBox") then
            if d.Name:lower():find("name") or d.Parent.Name:lower():find("name") then
                if states.customShirtName ~= "" then d.Text = states.customShirtName end
            elseif d.Name:lower():find("num") or d.Parent.Name:lower():find("num") then
                if states.customShirtNumber ~= "" then d.Text = states.customShirtNumber end
            end
        end
    end
end

local function CreatePredictionVisuals()
    if predictionFolder then return end
    predictionFolder = Instance.new("Folder", Workspace)
    predictionFolder.Name = "PredictionVisuals"

    for i = 1, DOT_COUNT do
        local dot = Instance.new("Part", predictionFolder)
        dot.Shape, dot.Size = Enum.PartType.Ball, Vector3.new(0.45, 0.45, 0.45)
        dot.Color, dot.Material = states.guiAccentColor, Enum.Material.Neon
        dot.Transparency, dot.Anchored, dot.CanCollide, dot.CastShadow = 0.2, true, false, false
        dots[i] = dot
    end

    bigDot = Instance.new("Part", predictionFolder)
    bigDot.Shape, bigDot.Size = Enum.PartType.Ball, Vector3.new(3.5, 3.5, 3.5)
    bigDot.Color, bigDot.Material = states.guiAccentColor, Enum.Material.Neon
    bigDot.Transparency, bigDot.Anchored, bigDot.CanCollide, bigDot.CastShadow = 0.0, true, false, false
end

local function DestroyPredictionVisuals()
    if predictionFolder then predictionFolder:Destroy() predictionFolder = nil bigDot = nil dots = {} end
end

local function clear_trajectory()
    for _, p in pairs(trajPartsPool) do
        p.Transparency = 1
        p.CFrame = CFrame.new(0, -1000, 0)
    end
end

local function update_trajectory()
    local ball = getBall()
    if not ball or not ball:IsA("BasePart") then 
        clear_trajectory()
        return 
    end
    
    if not ball:FindFirstChild("BallRedHighlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "BallRedHighlight"
        highlight.FillColor = states.guiAccentColor
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
        highlight.FillTransparency = 0.4
        highlight.OutlineTransparency = 0
        highlight.Parent = ball
    end
    
    local current_pos = ball.Position
    table.insert(position_history, current_pos)
    if #position_history > max_history then
        table.remove(position_history, 1)
    end
    
    if #position_history < 2 then 
        clear_trajectory()
        return 
    end
    
    local rough_velocity = ball.AssemblyLinearVelocity
    
    if not rough_velocity or rough_velocity.Magnitude < 1 then
        local pos_delta = position_history[#position_history] - position_history[1]
        rough_velocity = pos_delta / (0.033 * (#position_history - 1))
    end
    
    smoothed_velocity = smoothed_velocity:Lerp(rough_velocity, 0.25)
    
    if smoothed_velocity.Magnitude < 5 then 
        clear_trajectory()
        return 
    end
    
    local current_velocity = smoothed_velocity
    local gravity = Workspace.Gravity
    local time_step = 0.07 
    local max_points = 25
    local elasticity = 0.50
    
    local last_pos = current_pos
    local partIndex = 0
    
    for i = 1, max_points do
        local next_pos = current_pos + (current_velocity * time_step) + (0.5 * Vector3.new(0, -gravity, 0) * (time_step * time_step))
        
        local ray_param = RaycastParams.new()
        local char = me.Character
        ray_param.FilterDescendantsInstances = {ball, char, traj_folder}
        ray_param.FilterType = Enum.RaycastFilterType.Exclude
        
        local displacement = next_pos - last_pos
        local cast_result = Workspace:Raycast(last_pos, displacement, ray_param)
        
        if cast_result then
            next_pos = cast_result.Position
            local normal = cast_result.Normal
            local dot_val = current_velocity:Dot(normal)
            
            current_velocity = (current_velocity - (2 * dot_val * normal)) * elasticity
            current_pos = next_pos
            
            if current_velocity.Magnitude < 3 then break end
        else
            current_velocity = current_velocity + Vector3.new(0, -gravity, 0) * time_step
            current_pos = current_pos + (current_velocity * time_step)
        end
        
        local segment_distance = (next_pos - last_pos).Magnitude
        if segment_distance > 0.05 then
            partIndex = partIndex + 1
            local p = trajPartsPool[partIndex]
            if not p then
                p = Instance.new("Part")
                p.Anchored = true
                p.CanCollide = false
                p.Material = Enum.Material.Neon
                p.CastShadow = false
                p.Parent = traj_folder
                trajPartsPool[partIndex] = p
            end
            
            p.Size = Vector3.new(0.60, 0.60, segment_distance)
            p.CFrame = CFrame.new(last_pos:Lerp(next_pos, 0.5), next_pos)
            p.Color = states.guiAccentColor
            
            local life_percent = i / max_points
            p.Transparency = math.clamp(0.05 + (life_percent * 0.85), 0, 1)
        end
        
        last_pos = next_pos
    end

    for i = partIndex + 1, #trajPartsPool do
        trajPartsPool[i].Transparency = 1
        trajPartsPool[i].CFrame = CFrame.new(0, -1000, 0)
    end
end

local function executeStatSpoof()
    local statsFolder = me:FindFirstChild("leaderstats") or me:FindFirstChild("PlayerGui")
    for statName, targetText in pairs(states.stats) do
        if targetText ~= "" and statsFolder then
            for _, val in ipairs(statsFolder:GetDescendants()) do
                if val.Name:lower() == statName:lower() or val.Name:lower():find(statName:lower()) then
                    if val:IsA("StringValue") then val.Value = tostring(targetText)
                    elseif val:IsA("IntValue") or val:IsA("NumberValue") then val.Value = tonumber(targetText) or val.Value end
                end
            end
        end
    end
end
local localPlayer = game.Players.LocalPlayer
local function getDefendingGoalCenter()
    local field = workspace:FindFirstChild("FootballField")
    local targets = field and (field:FindFirstChild("Goals") or field) or workspace
    local closestGoal = nil
    local minDistance = math.huge
    
    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myPos = localPlayer.Character.HumanoidRootPart.Position
        for _, obj in pairs(targets:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("goal") or obj.Name:lower():find("net") or obj.Name:lower():find("post")) then
                local dist = (obj.Position - myPos).Magnitude
                if dist < minDistance then
                    minDistance = dist
                    closestGoal = obj
                end
            end
        end
    end
    
    if not closestGoal and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return localPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 0, 5)
    end
    
    return closestGoal and closestGoal.Position or nil
end

local function isInsideGKBox(rootPos)
    local goalCenter = getDefendingGoalCenter()
    if not goalCenter then return true end 
    
    local dx = math.abs(rootPos.X - goalCenter.X)
    local dz = (rootPos.Z - goalCenter.Z)
    local dy = rootPos.Y - goalCenter.Y
    
    return (dx <= config.boxWidth / 2) and (math.abs(dz) <= config.boxDepth) and (dy <= config.boxHeight)
end

local lastBallVel = Vector3.new()
local ballAccel = Vector3.new()
local runService = game:GetService("RunService")
runService.PostSimulation:Connect(function()
    local ball = getBall()
    if ball then
        local currentVel = ball.AssemblyLinearVelocity
        ballAccel = ballAccel:Lerp(currentVel - lastBallVel, 0.25)
        lastBallVel = currentVel
    end
end)

local function getBallTargetZone(predictedCrossX, predictedCrossY, goalCenter)
    if not goalCenter then return "Middle", "Low" end
    
    local goalWidthLimit = (config.boxWidth * 0.75) 
    local relativeX = predictedCrossX - goalCenter.X
    local segmentWidth = goalWidthLimit / 3
    
    local sideZone = "Middle"
    if relativeX < -segmentWidth then
        sideZone = "Left"
    elseif relativeX > segmentWidth then
        sideZone = "Right"
    end
    
    local heightZone = "Low"
    if predictedCrossY > 4.5 then 
        heightZone = "High"
    end
    
    return sideZone, heightZone
end

local function isTrajectoryHeadingToGoal(ballPos, ballVel, goalCenter)
    if not goalCenter then return false, "Middle", "Low" end
    if ballVel.Magnitude < 5.0 then return false, "Middle", "Low" end
    
    local directionToGoalLine = (goalCenter.Z - ballPos.Z)
    if (directionToGoalLine > 0 and ballVel.Z < 0) or (directionToGoalLine < 0 and ballVel.Z > 0) then
        return false, "Middle", "Low" 
    end
    
    local timeToGoalPlane = (goalCenter.Z - ballPos.Z) / ballVel.Z
    if timeToGoalPlane < 0 or timeToGoalPlane > 3.0 then return false, "Middle", "Low" end 
    
    local dist = (goalCenter - ballPos).Magnitude
    local useAccel = (dist > 25) and ballAccel or Vector3.new()
    
    local predictedCrossX = ballPos.X + (ballVel.X * timeToGoalPlane) + (0.5 * useAccel.X * timeToGoalPlane^2)
    local predictedCrossY = ballPos.Y + (ballVel.Y * timeToGoalPlane) - (0.5 * workspace.Gravity * timeToGoalPlane^2)
    
    local goalWidthLimit = (config.boxWidth * 0.75) 
    local insideGoal = (math.abs(predictedCrossX - goalCenter.X) <= goalWidthLimit) and (predictedCrossY >= -3 and predictedCrossY <= 22)
    
    if insideGoal then
        local sideZone, heightZone = getBallTargetZone(predictedCrossX, predictedCrossY, goalCenter)
        return true, sideZone, heightZone
    end
    
    return false, "Middle", "Low"
end

local function preventOwnGoal(point, rootPos, goalCenter)
    if not goalCenter then return point end
    
    -- Calculate vector from the bot to the goal to determine field direction
    local toGoal = goalCenter - rootPos
    local flatDir = Vector3.new(toGoal.X, 0, toGoal.Z).Unit
    
    local pointToGoal = goalCenter - point
    local dotProduct = pointToGoal:Dot(flatDir)
    
    -- If dot product is less than 4, the point is too close to or inside the net.
    -- Push the point 4 studs forward onto the field.
    if dotProduct < 4 then
        point = point + flatDir * (4 - dotProduct)
    end
    
    return point
end

local function getGKIntersection(ball, root, goalCenter)
    local ballPos = ball.Position
    local ballVel = ball.AssemblyLinearVelocity
    local rootPos = root.Position
    
    if ballVel.Magnitude < 5.0 then return nil, 0, "Middle", "Low" end 
    local headingToGoal, sideZone, heightZone = isTrajectoryHeadingToGoal(ballPos, ballVel, goalCenter)
    if not headingToGoal then return nil, 0, "Middle", "Low" end
    
    local pathVector = (rootPos - ballPos)
    local time = pathVector.Magnitude / ballVel.Magnitude
    if time < 0 or time > 2.5 then return nil, 0, "Middle", "Low" end 
    
    local dist = pathVector.Magnitude
    local useAccel = (dist > 25) and ballAccel or Vector3.new()
    
    local point = ballPos + (ballVel * time) + (0.5 * useAccel * time^2) - Vector3.new(0, 0.5 * workspace.Gravity * time^2, 0)
    
    -- Prevent own goals by stopping the player from diving backwards into the net
    point = preventOwnGoal(point, rootPos, goalCenter)

    local horizontalDist = (Vector3.new(point.X, 0, point.Z) - Vector3.new(rootPos.X, 0, rootPos.Z)).Magnitude
    local heightDelta = point.Y - rootPos.Y
    
    if horizontalDist <= 50 and heightDelta >= -1 and heightDelta <= 22 then
        return point, time, sideZone, heightZone
    end
    return nil, 0, "Middle", "Low"
end

local function getGSIntersection(ball, root, goalCenter)
    local ballPos = ball.Position
    local ballVel = ball.AssemblyLinearVelocity
    local rootPos = root.Position
    
    if ballVel.Magnitude < 5.0 then return nil end 
    local headingToGoal, _, _ = isTrajectoryHeadingToGoal(ballPos, ballVel, goalCenter)
    if not headingToGoal then
        local directDist = (rootPos - ballPos).Magnitude
        if directDist > 25 then return nil end 
    end
    
    local pathVector = (rootPos - ballPos)
    local time = pathVector.Magnitude / ballVel.Magnitude
    if time < 0 or time > 2.0 then return nil end 
    
    local dist = pathVector.Magnitude
    local useAccel = (dist > 25) and ballAccel or Vector3.new()
    
    local point = ballPos + (ballVel * time) + (0.5 * useAccel * time^2) - Vector3.new(0, 0.5 * workspace.Gravity * time^2, 0)
    
    -- Prevent own goals for ground shots as well
    point = preventOwnGoal(point, rootPos, goalCenter)

    local horizontalDist = (Vector3.new(point.X, 0, point.Z) - Vector3.new(rootPos.X, 0, rootPos.Z)).Magnitude
    local heightDelta = point.Y - rootPos.Y
    
    if horizontalDist <= 42 and heightDelta >= -4.0 and heightDelta <= 6.0 then
        return point
    end
    return nil
end

local function getInterceptVector(point, root, topCheck, isPenaltyMode, goalCenter)
    if topCheck then
        return Vector3.new(0, 1, 0)
    end
    local rootPos = root.Position
    local flatPoint = Vector3.new(point.X, rootPos.Y, point.Z)
    local diff = (flatPoint - rootPos)
    
    if diff.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0)
    end
    
    local dir = diff.Unit
    if isPenaltyMode and goalCenter then
        local vectorToGoal = (goalCenter - rootPos).Unit
        local lateralRight = Vector3.new(-vectorToGoal.Z, 0, vectorToGoal.X).Unit
        local dot = dir:Dot(lateralRight)
        return lateralRight * dot
    end
    
    return dir
end

local function kickBall(ball, root)
    local targetDir = (root.CFrame.LookVector * 0.7 + Vector3.new(0, 0.4, 0)).Unit
    pcall(function()
        ball.CanCollide = true
        ball.AssemblyLinearVelocity = targetDir * config.clearPower
        ball.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end)
    
    local currentTool = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Tool")
    if currentTool and currentTool:FindFirstChild("RemoteEvent") then
        currentTool.RemoteEvent:FireServer(ball, targetDir * config.clearPower)
    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Kick") then
        game:GetService("ReplicatedStorage").Remotes.Kick:FireServer(ball, targetDir * config.clearPower)
    end
end

local function setupCharacter(character)
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    local function processGoalkeeping()
        if not states.gkEnabled or config.isDiving or config.isGsDashing then return end
        
        local goalCenter = getDefendingGoalCenter()
        local ball = getBall()
        if not ball then return end
        
        local headingToGoal, sideZone, heightZone = isTrajectoryHeadingToGoal(ball.Position, ball.AssemblyLinearVelocity, goalCenter)
        if not headingToGoal then return end
        
        local directDist = (rootPart.Position - ball.Position).Magnitude
        local ballSpeed = ball.AssemblyLinearVelocity.Magnitude
        local isPenaltyMode = (directDist < 26)

        -- SNEAKY SHOT FIX: If the player is close but the ball isn't moving fast enough, ignore it until they kick.
        if isPenaltyMode and ballSpeed < 25 then return end 
        
        local ballHeadingToMe = ball.AssemblyLinearVelocity.Unit:Dot((rootPart.Position - ball.Position).Unit) > 0.45
        local isCloseShot = (directDist <= 30) or (directDist <= 50 and ballHeadingToMe and ballSpeed > 22)
        
        if not isCloseShot and not isInsideGKBox(rootPart.Position) then return end
        
        local intersectPoint, timeToArrival, predSide, predHeight = getGKIntersection(ball, rootPart, goalCenter)
        if not intersectPoint then return end
        
        local localPoint = rootPart.CFrame:PointToObjectSpace(intersectPoint)
        local isHighShot = (predHeight == "High") and (ball.AssemblyLinearVelocity.Y > 1.5)
        
        local safeVelocity = math.clamp(ballSpeed, 1, 65)
        
        -- RESPONSIVENESS FIX: Broadened arrival threshold so it attempts more shots
        local arrivalThreshold = math.clamp((directDist / safeVelocity) * 0.8, 0.15, 0.35)
        if isPenaltyMode then
            arrivalThreshold = arrivalThreshold * 0.75
        end
        
        local shouldPrejump = false
        if isCloseShot then
            shouldPrejump = isHighShot and (ballSpeed > 10)
        else
            shouldPrejump = (timeToArrival <= arrivalThreshold and isHighShot)
        end
        
        if shouldPrejump and humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and humanoid.FloorMaterial ~= Enum.Material.Air then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            local upVelocity = isPenaltyMode and 11.0 or 17.0
            rootPart.AssemblyLinearVelocity = Vector3.new(rootPart.AssemblyLinearVelocity.X, upVelocity, rootPart.AssemblyLinearVelocity.Z)
        end
        
        local isMidAir = (humanoid:GetState() == Enum.HumanoidStateType.Jumping or humanoid:GetState() == Enum.HumanoidStateType.FreeFall or humanoid.FloorMaterial == Enum.Material.Air)
        
        if (isMidAir or shouldPrejump or isCloseShot or timeToArrival <= arrivalThreshold) and not config.isDiving then
            local topCheck = (predSide == "Middle") and (predHeight == "High") and math.abs(localPoint.X) <= 5.0
            config.isDiving = true
            
            local executionSpeed = config.diveSpeed
            local lateralGap = math.abs(localPoint.X)
            
            if lateralGap > 8 then
                executionSpeed = executionSpeed + math.clamp(lateralGap * 0.8, 0, 20)
            end
            
            if ballSpeed > 35 then
                executionSpeed = math.clamp(executionSpeed * (ballSpeed / 30), config.diveSpeed, 65)
            elseif isPenaltyMode then
                executionSpeed = math.clamp(directDist * 1.1, 15, config.diveSpeed)
            elseif predSide == "Middle" then
                executionSpeed = config.diveSpeed * 0.80 
            end
            
            local moveVector = getInterceptVector(intersectPoint, rootPart, topCheck, isPenaltyMode, goalCenter)
            local bv = Instance.new("BodyVelocity")
            bv.Name = "GK_StealthDive"
            bv.MaxForce = Vector3.new(160000, 0, 160000) 
            bv.Velocity = Vector3.new(moveVector.X * executionSpeed, 0, moveVector.Z * executionSpeed)
            bv.Parent = rootPart
            
            local loopConnection
            local creationTime = tick()
            local smoothVector = moveVector
            
            loopConnection = runService.Heartbeat:Connect(function()
                local activeBall = getBall()
                local now = tick()
                local elapsed = (now - creationTime)
                
                if not activeBall or elapsed > 0.42 or not config.isDiving then
                    if elapsed > 0.18 or not activeBall then
                        config.isDiving = false
                        if bv then
                            for i = 1, 5 do
                                if bv and bv.Parent then
                                    bv.Velocity = bv.Velocity * 0.40
                                    task.wait(0.01)
                                end
                            end
                            if bv then bv:Destroy() end
                        end
                        loopConnection:Disconnect()
                        return
                    end
                end
                
                local liveIntersect, _, _, _ = getGKIntersection(activeBall, rootPart, goalCenter)
                if not liveIntersect then
                    liveIntersect = activeBall.Position + (activeBall.AssemblyLinearVelocity * 0.10)
                end
                
                if liveIntersect and bv and bv.Parent and elapsed > 0.12 then
                    local realDir = getInterceptVector(liveIntersect, rootPart, topCheck, isPenaltyMode, goalCenter)
                    smoothVector = smoothVector:Lerp(realDir, 0.38) 
                    bv.Velocity = Vector3.new(smoothVector.X * executionSpeed, 0, smoothVector.Z * executionSpeed)
                end
                
                local playerPos = rootPart.Position
                local ballPos = activeBall.Position
                local cylinderDist = Vector2.new(playerPos.X - ballPos.X, playerPos.Z - ballPos.Z).Magnitude
                local verticalDist = ballPos.Y - playerPos.Y
                
                local currentBallSpeed = activeBall.AssemblyLinearVelocity.Magnitude
                local touchDistance = isPenaltyMode and 13.5 or 12.0
                if currentBallSpeed > 40 then
                    touchDistance = touchDistance + math.clamp((currentBallSpeed - 40) * 0.15, 0, 4)
                end

                if (cylinderDist <= touchDistance and verticalDist >= -4.5 and verticalDist <= 20) or (playerPos - ballPos).Magnitude < touchDistance then
                    kickBall(activeBall, rootPart)
                    config.isDiving = false
                    if bv then bv:Destroy() end
                    loopConnection:Disconnect()
                end
            end)
        end
    end

    local function handleGroundShot()
        if not states.gkEnabled or not states.gsEnabled or config.isGsDashing or config.isDiving then return end
        
        local ball = getBall()
        if not ball then return end
        
        local goalCenter = getDefendingGoalCenter()
        local headingToGoal, predSide, predHeight = isTrajectoryHeadingToGoal(ball.Position, ball.AssemblyLinearVelocity, goalCenter)
        if not headingToGoal or predHeight == "High" then return end 
        
        local directDist = (rootPart.Position - ball.Position).Magnitude
        local ballSpeed = ball.AssemblyLinearVelocity.Magnitude
        local isPenaltyMode = (directDist < 26)

        -- SNEAKY SHOT FIX for ground shots as well
        if isPenaltyMode and ballSpeed < 25 then return end 
        
        local ballHeadingToMe = ball.AssemblyLinearVelocity.Unit:Dot((rootPart.Position - ball.Position).Unit) > 0.45
        local isCloseShot = (directDist <= 30) or (directDist <= 50 and ballHeadingToMe and ballSpeed > 22)
        
        if not isCloseShot and not isInsideGKBox(rootPart.Position) then return end
        
        local intersectPoint = getGSIntersection(ball, rootPart, goalCenter)
        if not intersectPoint then return end
        
        local localPoint = rootPart.CFrame:PointToObjectSpace(intersectPoint)
        local isFloorHit = (intersectPoint.Y - rootPart.Position.Y) <= 2.2 
        local timeToHit = directDist / math.max(ballSpeed, 1)
        
        local predHeightCalc = ball.Position.Y + (ball.AssemblyLinearVelocity.Y * timeToHit) - (0.5 * workspace.Gravity * timeToHit^2)
        local isLowBall = (predHeightCalc - rootPart.Position.Y) <= 3.5
        
        if (isFloorHit or isLowBall or directDist < 10) and math.abs(localPoint.X) > 0.4 then
            config.isGsDashing = true
            
            local activeSpeed = config.gsSpeed
            if ballSpeed > 35 then
                activeSpeed = math.clamp(config.gsSpeed * (ballSpeed / 25), config.gsSpeed, config.diveSpeed + 10)
            elseif directDist < 22 then
                activeSpeed = math.clamp(directDist * 1.1, 12, config.gsSpeed)
            elseif math.abs(ball.AssemblyLinearVelocity.X) > activeSpeed then
                activeSpeed = math.clamp(math.abs(ball.AssemblyLinearVelocity.X) * 1.02, config.gsSpeed, config.diveSpeed)
            end
            
            local moveVector = getInterceptVector(intersectPoint, rootPart, false, (directDist < 26), goalCenter)
            local bv = Instance.new("BodyVelocity")
            bv.Name = "GS_StealthDash"
            bv.MaxForce = Vector3.new(140000, 0, 140000) 
            bv.Velocity = Vector3.new(moveVector.X * activeSpeed, 0, moveVector.Z * activeSpeed)
            bv.Parent = rootPart
            
            local loopConnection
            local creationTime = tick()
            local smoothVector = moveVector
            
            loopConnection = runService.Heartbeat:Connect(function()
                local activeBall = getBall()
                local now = tick()
                local elapsed = (now - creationTime)
                
                if not activeBall or not config.isGsDashing or elapsed > 0.38 then
                    if elapsed > 0.15 or not activeBall then
                        config.isGsDashing = false
                        if bv then
                            for i = 1, 4 do
                                if bv and bv.Parent then
                                    bv.Velocity = bv.Velocity * 0.42
                                    task.wait(0.01)
                                end
                            end
                            if bv then bv:Destroy() end
                        end
                        loopConnection:Disconnect()
                        return
                    end
                end
                
                local liveIntersect = getGSIntersection(activeBall, rootPart, goalCenter)
                if not liveIntersect then
                    liveIntersect = activeBall.Position + (activeBall.AssemblyLinearVelocity * 0.08)
                end
                
                if elapsed > 0.10 then
                    local realDir = getInterceptVector(liveIntersect, rootPart, false, (directDist < 26), goalCenter)
                    smoothVector = smoothVector:Lerp(realDir, 0.38)
                end
                
                if bv and bv.Parent then
                    bv.Velocity = Vector3.new(smoothVector.X * activeSpeed, 0, smoothVector.Z * activeSpeed)
                end
                
                local currentBallSpeed = activeBall.AssemblyLinearVelocity.Magnitude
                local touchDistance = (directDist < 22) and 11.5 or 9.5
                if currentBallSpeed > 40 then
                    touchDistance = touchDistance + 2.5
                end
                
                if (rootPart.Position - activeBall.Position).Magnitude < touchDistance then
                    kickBall(activeBall, rootPart)
                    config.isGsDashing = false
                    if bv then bv:Destroy() end
                    loopConnection:Disconnect()
                end
            end)
        end
    end

    local gsConnection = runService.Heartbeat:Connect(handleGroundShot)
    local gkConnection = runService.Heartbeat:Connect(processGoalkeeping)
    
    humanoid.StateChanged:Connect(function(oldState, newState)
        if (newState == Enum.HumanoidStateType.Landed or newState == Enum.HumanoidStateType.Running) and not config.isDiving and not config.isGsDashing then
            config.isDiving = false
            config.isGsDashing = false
            local existingBv = rootPart:FindFirstChild("GK_StealthDive") or rootPart:FindFirstChild("GS_StealthDash")
            if existingBv then existingBv:Destroy() end
        end
    end)

    character.Destroying:Connect(function()
        if gsConnection then gsConnection:Disconnect() end
        if gkConnection then gkConnection:Disconnect() end
    end)
end

if localPlayer.Character then setupCharacter(localPlayer.Character) end
localPlayer.CharacterAdded:Connect(setupCharacter)


local mobileMatrixGui = Instance.new("ScreenGui")
mobileMatrixGui.Name = "ScarletHubMobileMatrix"
mobileMatrixGui.ResetOnSpawn = false
pcall(function() mobileMatrixGui.Parent = CoreGui end)
if not mobileMatrixGui.Parent then mobileMatrixGui.Parent = me:WaitForChild("PlayerGui", 5) end

local function SyncFloatingVisuals(stateKey, val)
    if MobileButtons[stateKey] and not MobileButtons[stateKey].isTrigger then
        local statusText = val and ": (ON)" or ": (OFF)"
        MobileButtons[stateKey].Label.Text = MobileButtons[stateKey].BaseName .. statusText
        
        if val then
            MobileButtons[stateKey].Frame.BackgroundColor3 = Color3.fromRGB(50, 200, 80)
            MobileButtons[stateKey].Frame.BackgroundTransparency = 0.7
            if MobileButtons[stateKey].Gradient then MobileButtons[stateKey].Gradient.Enabled = false end
        else
            MobileButtons[stateKey].Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            MobileButtons[stateKey].Frame.BackgroundTransparency = 0.5
            if MobileButtons[stateKey].Gradient then MobileButtons[stateKey].Gradient.Enabled = false end
        end
    end
end

local function BuildFloatingButton(label, stateKey, startPos, rayfieldElementKey, isTrigger)
    local btnFrame = Instance.new("Frame", mobileMatrixGui)
    btnFrame.Size = UDim2.new(0, 145, 0, 40)
    btnFrame.Position = startPos
    btnFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btnFrame.BackgroundTransparency = 0.5
    btnFrame.Active = true
    btnFrame.Visible = false
    
    local corner = Instance.new("UICorner", btnFrame)
    corner.CornerRadius = UDim.new(0, 8)
    
    local gradient = Instance.new("UIGradient", btnFrame)
    gradient.Enabled = false 
    
    local btnLabel = Instance.new("TextLabel", btnFrame)
    btnLabel.Size = UDim2.new(1, 0, 1, 0)
    btnLabel.BackgroundTransparency = 1
    btnLabel.Font = Enum.Font.GothamBold
    btnLabel.TextSize = 11.5
    btnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnLabel.Text = isTrigger and label or label .. ": (OFF)"

    local dragging, dragInput, dragStart, startPosFrame, hasMoved = false, nil, nil, nil, false
    local lastBtnToggleTime = 0

    btnFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not dragging then
            dragging = true; dragInput = input; hasMoved = false; dragStart = input.Position; startPosFrame = btnFrame.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            if delta.Magnitude > 8 then 
                hasMoved = true 
                btnFrame.Position = UDim2.new(startPosFrame.X.Scale, startPosFrame.X.Offset + delta.X, startPosFrame.Y.Scale, startPosFrame.Y.Offset + delta.Y)
            end
        end
    end)
    btnFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false; dragInput = nil
            if not hasMoved and tick() - lastBtnToggleTime > 0.3 then 
                lastBtnToggleTime = tick()
                if not isTrigger and RayfieldElements[rayfieldElementKey] then
                    RayfieldElements[rayfieldElementKey]:Set(not states[stateKey])
                end
            end
        end
    end)

    MobileButtons[stateKey] = {Frame = btnFrame, Label = btnLabel, Gradient = gradient, BaseName = label, isTrigger = isTrigger}
end

BuildFloatingButton("Active Pokers", "activePokers", UDim2.new(0.88, 0, 0.16, 0), "ActivePokers", false)
BuildFloatingButton("Manual Pokers", "manualPokers", UDim2.new(0.88, 0, 0.23, 0), "ManualPokers", false)
BuildFloatingButton("Aim Predict", "trackerActive", UDim2.new(0.88, 0, 0.30, 0), "AimPredictor", false)
BuildFloatingButton("Reach", "reachActive", UDim2.new(0.88, 0, 0.37, 0), "Reach", false)
BuildFloatingButton("Sneaky", "sneakyActive", UDim2.new(0.88, 0, 0.44, 0), "Sneaky", false)
BuildFloatingButton("Juggle", "juggleActive", UDim2.new(0.88, 0, 0.51, 0), "Juggle", false)

BuildFloatingButton("Ground Shot", "groundShotActive", UDim2.new(0.88, 0, 0.72, 0), "GroundShot", false)
BuildFloatingButton("Aimbot", "Aimbot", UDim2.new(0.88, 0, 0.79, 0), "Aimbot", false)
BuildFloatingButton("Rainbow Flick", "rainbowFlickActive", UDim2.new(0.88, 0, 0.86, 0), "RainbowFlick", false)
BuildFloatingButton("Power Shot", "powerShotActive", UDim2.new(0.88, 0, 0.93, 0), "PowerShot", false)

TabMobile:CreateSection("On Screen Toggles")
TabMobile:CreateToggle({Name = "Show Active Pokers", CurrentValue = false, Callback = function(v) MobileButtons["activePokers"].Frame.Visible = v end})
TabMobile:CreateToggle({Name = "Show Manual Pokers", CurrentValue = false, Callback = function(v) MobileButtons["manualPokers"].Frame.Visible = v end})
TabMobile:CreateToggle({Name = "Show Aim Predict", CurrentValue = false, Callback = function(v) MobileButtons["trackerActive"].Frame.Visible = v end})
TabMobile:CreateToggle({Name = "Show Reach", CurrentValue = false, Callback = function(v) MobileButtons["reachActive"].Frame.Visible = v end})
TabMobile:CreateToggle({Name = "Show Sneaky", CurrentValue = false, Callback = function(v) MobileButtons["sneakyActive"].Frame.Visible = v end})
TabMobile:CreateToggle({Name = "Show Juggle", CurrentValue = false, Callback = function(v) MobileButtons["juggleActive"].Frame.Visible = v end})

TabMobile:CreateToggle({Name = "Show Ground Shot", CurrentValue = false, Callback = function(v) MobileButtons["groundShotActive"].Frame.Visible = v end})
TabMobile:CreateToggle({Name = "Show Aimbot", CurrentValue = false, Callback = function(v) MobileButtons["Aimbot"].Frame.Visible = v end})
TabMobile:CreateToggle({Name = "Show Rainbow Flick", CurrentValue = false, Callback = function(v) MobileButtons["rainbowFlickActive"].Frame.Visible = v end})

-- New Tab Mobile elements
TabMobile:CreateToggle({Name = "Show Power Shot", CurrentValue = false, Callback = function(v) MobileButtons["powerShotActive"].Frame.Visible = v end})

TabStats:CreateSection("Custom Stats")

TabStats:CreateInput({
    Name = "Goals",
    PlaceholderText = "Goals",
    RemoveTextAfterFocusLost = false,
    Flag = "StatsGoals",
    Callback = function(t) states.stats.Goals = t end
})

TabStats:CreateInput({
    Name = "Clan",
    PlaceholderText = "Clan",
    RemoveTextAfterFocusLost = false,
    Flag = "StatsClan",
    Callback = function(t) states.stats.Clan = t end
})

TabStats:CreateInput({
    Name = "BPA",
    PlaceholderText = "BPA",
    RemoveTextAfterFocusLost = false,
    Flag = "StatsBPA",
    Callback = function(t) states.stats.BPA = t end
})

TabStats:CreateInput({
    Name = "Wins",
    PlaceholderText = "Wins",
    RemoveTextAfterFocusLost = false,
    Flag = "StatsWins",
    Callback = function(t) states.stats.Wins = t end
})

TabStats:CreateButton({
    Name = "Apply Visual Stats",
    Flag = "ApplyVisualStats",
    Callback = function() executeStatSpoof() end
})


TabVisuals:CreateSection("Lighting & Environment")

TabVisuals:CreateSlider({
    Name = "Time",
    Range = {0, 24},
    Increment = 1,
    CurrentValue = 0,
    Flag = "LightingTime",
    Callback = function(v) Lighting.ClockTime = v end
})

TabPerformance:CreateSection("Performance")

local performanceOriginals = {
    globalShadows = Lighting.GlobalShadows,
    brightness = Lighting.Brightness,
    fogEnd = Lighting.FogEnd,
    ambient = Lighting.Ambient,
    outdoorAmbient = Lighting.OutdoorAmbient,
    colorCorrection = nil,
    atmosphere = nil,
}

local performanceState = {
    lowGraphics = false,
    noShadows = false,
    greySky = false,
    lowEffects = false,
}

local function applyLowGraphics(enabled)
    performanceState.lowGraphics = enabled
    if enabled then
        pcall(function()
            local ugs = UserSettings():GetService("UserGameSettings")
            ugs.GraphicsQualityLevel = 1
        end)
        pcall(function() Lighting.Brightness = 1 end)
        pcall(function() Lighting.FogEnd = 500 end)
        pcall(function() Lighting.Ambient = Color3.fromRGB(128, 128, 128) end)
        pcall(function() Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128) end)
    else
        pcall(function() Lighting.Brightness = performanceOriginals.brightness end)
        pcall(function() Lighting.FogEnd = performanceOriginals.fogEnd end)
        pcall(function() Lighting.Ambient = performanceOriginals.ambient end)
        pcall(function() Lighting.OutdoorAmbient = performanceOriginals.outdoorAmbient end)
    end
end

local function applyNoShadows(enabled)
    performanceState.noShadows = enabled
    pcall(function()
        Lighting.GlobalShadows = not enabled and performanceOriginals.globalShadows or false
    end)
end

local function applyGreySky(enabled)
    performanceState.greySky = enabled
    local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
    if enabled then
        if not atmosphere then
            atmosphere = Instance.new("Atmosphere")
            atmosphere.Name = "VeloGreyAtmosphere"
            atmosphere.Parent = Lighting
            performanceOriginals.atmosphere = atmosphere
        end
        atmosphere.Color = Color3.fromRGB(145, 145, 145)
        atmosphere.Decay = Color3.fromRGB(105, 105, 105)
        atmosphere.Density = 0.15
        atmosphere.Glare = 0
        atmosphere.Haze = 0.5
    else
        if performanceOriginals.atmosphere and performanceOriginals.atmosphere.Parent then
            performanceOriginals.atmosphere:Destroy()
        end
        performanceOriginals.atmosphere = nil
    end
end

local function applyLowEffects(enabled)
    performanceState.lowEffects = enabled
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
            pcall(function() obj.Enabled = not enabled end)
        elseif obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or obj:IsA("DepthOfFieldEffect") or obj:IsA("SunRaysEffect") then
            pcall(function() obj.Enabled = not enabled end)
        end
    end
end

TabPerformance:CreateToggle({
    Name = "Low Graphics",
    CurrentValue = false,
    Flag = "PerformanceLowGraphics",
    Callback = applyLowGraphics
})

TabPerformance:CreateToggle({
    Name = "Disable Shadows",
    CurrentValue = false,
    Flag = "PerformanceNoShadows",
    Callback = applyNoShadows
})

TabPerformance:CreateToggle({
    Name = "Grey Sky",
    CurrentValue = false,
    Flag = "PerformanceGreySky",
    Callback = applyGreySky
})

TabPerformance:CreateToggle({
    Name = "Low Effects",
    CurrentValue = false,
    Flag = "PerformanceLowEffects",
    Callback = applyLowEffects
})

TabPerformance:CreateButton({
    Name = "Apply Low Quality Everything",
    Callback = function()
        applyLowGraphics(true)
        applyNoShadows(true)
        applyGreySky(true)
        applyLowEffects(true)
    end
})

TabPerformance:CreateParagraph({
    Title = "Network",
    Content = "Rendering changes can improve FPS and reduce client load. Actual server ping is controlled by the network/server and cannot be reliably lowered by a client script."
})

TabVisuals:CreateSection("Ball Modification")
RayfieldElements.AimPredictor = TabVisuals:CreateToggle({
    Name = "Aim Predict", CurrentValue = false, Flag = "AimPredict",
    Callback = function(v)
        states.trackerActive = v
        SyncFloatingVisuals("trackerActive", v)
        if v then CreatePredictionVisuals() else DestroyPredictionVisuals() end
    end
})
RayfieldElements.BallTrajectory = TabVisuals:CreateToggle({
    Name = "Ball Trajectory", CurrentValue = false, Flag = "BallTrajectory",
    Callback = function(v)
        states.trajectoryActive = v
        if not v then 
            clear_trajectory()
            local ball = getBall()
            if ball then
                local hl = ball:FindFirstChild("BallRedHighlight")
                if hl then hl:Destroy() end
            end
        end
    end
})

TabVisuals:CreateSection("Cosmetics")

TabVisuals:CreateColorPicker({
    Name = "Shoe Color",
    Color = Color3.fromRGB(220, 40, 40),
    Flag = "ShoeColor",
    Callback = function(v)
        states.shoeColor = v
        states.rainbowShoes = false
        ApplyShoeChangerLogic()
    end
})

TabVisuals:CreateToggle({
    Name = "Glow",
    CurrentValue = false,
    Flag = "ShoeGlow",
    Callback = function(v)
        states.shoeGlow = v
        ApplyShoeChangerLogic()
    end
})

TabVisuals:CreateToggle({
    Name = "Rainbow Shoes",
    CurrentValue = false,
    Flag = "RainbowShoes",
    Callback = function(v)
        states.rainbowShoes = v
    end
})


TabVisuals:CreateSection("Shirt Customization")

TabVisuals:CreateInput({
    Name = "Shirt Name",
    PlaceholderText = "Name",
    RemoveTextAfterFocusLost = false,
    Flag = "CustomShirtName",
    Callback = function(t)
        states.customShirtName = t
    end
})

TabVisuals:CreateInput({
    Name = "Shirt Number",
    PlaceholderText = "Number",
    RemoveTextAfterFocusLost = false,
    Flag = "CustomShirtNumber",
    Callback = function(t)
        states.customShirtNumber = t
    end
})

TabVisuals:CreateButton({
    Name = "Apply Shirt",
    Flag = "ApplyShirt",
    Callback = function()
        ApplyShirtCustomizerLogic()
    end
})


TabVisuals:CreateSection("Pitch")

local colorMap = {
    ["Default"] = Color3.fromRGB(75, 151, 75),
    ["Red"] = Color3.fromRGB(220, 40, 40),
    ["Orange"] = Color3.fromRGB(255, 125, 0),
    ["Yellow"] = Color3.fromRGB(255, 230, 50),
    ["Green"] = Color3.fromRGB(40, 220, 40),
    ["Blue"] = Color3.fromRGB(40, 100, 255),
    ["Purple"] = Color3.fromRGB(120, 40, 220),
    ["Pink"] = Color3.fromRGB(255, 105, 180),
    ["White"] = Color3.fromRGB(255, 255, 255),
    ["Black"] = Color3.fromRGB(15, 15, 15)
}

local pitchTarget = nil
local function getPitchTarget()
    if pitchTarget and pitchTarget.Parent then return pitchTarget end
    pitchTarget = workspace:FindFirstChild("Pitch", true) or 
                  workspace:FindFirstChild("Field", true) or 
                  workspace:FindFirstChild("Grass", true)
    if not pitchTarget then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Material == Enum.Material.Grass or v.Name:lower():find("pitch")) then
                pitchTarget = v
                break
            end
        end
    end
    return pitchTarget
end

local function applyColorToPitch(color)
    local target = getPitchTarget()
    if not target then return end
    
    if target:IsA("BasePart") then
        target.Color = color
    end
    
    for _, child in pairs(target:GetDescendants()) do
        if child:IsA("BasePart") then
            child.Color = color
        end
    end
end

TabVisuals:CreateDropdown({
    Name = "Pitch Colour",
    Options = {"Default", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink", "White", "Black", "Rainbow"},
    CurrentOption = {"Default"},
    MultipleOptions = false,
	Flag = "PitchColour",

    Callback = function(option)
        local selected = type(option) == "table" and option[1] or option
        states.selectedPitchColor = selected
        
        if selected == "Rainbow" then
            states.rainbowPitch = true
        else
            states.rainbowPitch = false
            if states.pitchColorActive then
                local color = colorMap[selected] or colorMap["Default"]
                applyColorToPitch(color)
            end
        end
    end,
})

TabVisuals:CreateToggle({
    Name = "Enable Pitch Colour",
    CurrentValue = false,
	Flag = "EnablePitchColour",
    Callback = function(v)
        states.pitchColorActive = v
        if v then
            if states.selectedPitchColor == "Rainbow" then
                states.rainbowPitch = true
            else
                local color = colorMap[states.selectedPitchColor] or colorMap["Default"]
                applyColorToPitch(color)
            end
        else
            states.rainbowPitch = false
            applyColorToPitch(colorMap["Default"])
        end
    end
})

local HAIR_LIST_LABELS = {
    "Default Hair",
    "Bacon",
    "Black",
    "Black Mask",
    "Blonde",
    "Bold",
    "Brown",
    "Cap",
    "Charmer",
    "Cool",
    "Dio",
    "Egg",
    "Floof",
    "Fluffed",
    "Green",
    "Halloween",
    "Hat",
    "Hockey Mask",
    "Knot",
    "Long Pink",
    "Messy",
    "Nerd"
}

local HAIR_LIST_IDS = {
    "DEFAULT",
    "HairBacon",
    "HairBlack",
    "HairBlackMask",
    "HairBlonde",
    "HairBold",
    "HairBrown",
    "HairCap",
    "HairCharmer",
    "HairCool",
    "HairDio",
    "HairEgg",
    "HairFloof",
    "HairFluffed",
    "HairGreen",
    "HairHalloween",
    "HairHat",
    "HairHockeyMask",
    "HairKnot",
    "HairLongPink",
    "HairMessy",
    "HairNerd"
}

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")

local Player    = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

getgenv().HairChanger = getgenv().HairChanger or {
    visible       = false,
    currentHairId = nil,
}
local config = getgenv().HairChanger

local EQUIP_TAG = "HairChangerEquipped"

if PlayerGui:FindFirstChild("HairChangerGui") then
    PlayerGui.HairChangerGui:Destroy()
end

local ATTACHMENT_MAP = {
    HairBacon      = "HairAttachment",
    HairBlack      = "HairAttachment",
    HairBlackMask  = "FaceFrontAttachment",
    HairBlonde     = "HairAttachment",
    HairBrown      = "HairAttachment",
    HairCap        = "HatAttachment",
    HairCharmer    = "HairAttachment",
    HairCool       = "HairAttachment",
    HairDio        = "HairAttachment",
    HairEgg        = "HatAttachment",
    HairFloof      = "HairAttachment",
    HairFluffed    = "HairAttachment",
    HairGreen      = "HairAttachment",
    HairHalloween  = "FaceFrontAttachment",
    HairHat        = "HatAttachment",
    HairHockeyMask = "FaceFrontAttachment",
    HairKnot       = "HairAttachment",
    HairLongPink   = "HairAttachment",
    HairMessy      = "HairAttachment",
    HairNerd       = "FaceFrontAttachment",
    HairBold       = "HairAttachment",
}

local OFFSET_TWEAKS = {
    HairBlackMask  = CFrame.new(0.00,  0.00, -0.59),
    HairHockeyMask = CFrame.new(0.00, -0.01, -0.02),
    HairHalloween  = CFrame.new(0.00,  0.05, -0.04),
    HairBrown      = CFrame.new(0.00,  0.65,  0.00),
    HairCap        = CFrame.new(0.00,  0.10,  0.30),
    HairCharmer    = CFrame.new(0.00,  0.15,  0.05),
    HairGreen      = CFrame.new(0.00,  0.20, -0.05),
    HairHat        = CFrame.new(0.00,  0.10, -0.25),
    HairKnot       = CFrame.new(0.00,  0.55, -0.05),
    HairNerd       = CFrame.new(0.00, -0.65, -0.60),
}

local ROTATION_TWEAKS = {
    HairHalloween = CFrame.Angles(math.rad(90), 0, 0),
}



local HAIR_LIST = {
    {id = "DEFAULT",        label = "Default Hair"},
    {id = "HairBacon",      label = "Bacon"},
    {id = "HairBlack",      label = "Black"},
    {id = "HairBlackMask",  label = "Black Mask"},
    {id = "HairBlonde",     label = "Blonde"},
    {id = "HairBold",       label = "Bold"},
    {id = "HairBrown",      label = "Brown"},
    {id = "HairCap",        label = "Cap"},
    {id = "HairCharmer",    label = "Charmer"},
    {id = "HairCool",       label = "Cool"},
    {id = "HairDio",        label = "Dio"},
    {id = "HairEgg",        label = "Egg"},
    {id = "HairFloof",      label = "Floof"},
    {id = "HairFluffed",    label = "Fluffed"},
    {id = "HairGreen",      label = "Green"},
    {id = "HairHalloween",  label = "Halloween"},
    {id = "HairHat",        label = "Hat"},
    {id = "HairHockeyMask", label = "Hockey Mask"},
    {id = "HairKnot",       label = "Knot"},
    {id = "HairLongPink",   label = "Long Pink"},
    {id = "HairMessy",      label = "Messy"},
    {id = "HairNerd",       label = "Nerd"},
}

local C = {
    bg          = Color3.fromRGB(22,  22,  32),
    titleBar    = Color3.fromRGB(36,  36,  54),
    btn         = Color3.fromRGB(42,  42,  62),
    btnHover    = Color3.fromRGB(60,  60, 100),
    btnActive   = Color3.fromRGB(88,  64, 170),
    btnDefault  = Color3.fromRGB(50,  40,  75),
    toggle      = Color3.fromRGB(88,  64, 170),
    toggleHover = Color3.fromRGB(110, 86, 200),
    accent      = Color3.fromRGB(140,110, 255),
    text        = Color3.fromRGB(200,200, 220),
    textBright  = Color3.fromRGB(255,255, 255),
    scrollBar   = Color3.fromRGB(140,110, 255),
}

local TWEEN_OPEN = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TWEEN_FAST = TweenInfo.new(0.15, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out)

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = p
end

local function addStroke(p, col, t, tr)
    local s = Instance.new("UIStroke")
    s.Color = col
    s.Thickness = t
    s.Transparency = tr or 0
    s.Parent = p
end

local currentClone          = nil
local currentHandle         = nil
local currentHeadAttachment = nil
local currentHandleAttachCF = CFrame.new()
local relativeMapGlobal     = {}

local function nukeAllHair(char)
    for _, obj in ipairs(char:GetChildren()) do
        if obj:GetAttribute(EQUIP_TAG) then
            obj:Destroy()
        end
    end
    for _, obj in ipairs(char:GetChildren()) do
        if obj.Name and typeof(obj.Name) == "string" and obj.Name:sub(1,4) == "Hair" and not obj:IsA("Attachment") then
            obj:Destroy()
        end
    end
    local head = char:FindFirstChild("Head")
    if head then
        for _, child in ipairs(head:GetChildren()) do
            if child:IsA("Weld") and (child.Name == "HairWeld" or child.Name == "SubWeld") then
                child:Destroy()
            end
        end
    end
    for _, desc in ipairs(char:GetDescendants()) do
        if desc:GetAttribute(EQUIP_TAG) then
            pcall(function() desc:Destroy() end)
        end
    end
    RunService.Heartbeat:Wait()
end

local function getHandle(clone)
    if clone:IsA("BasePart") then return clone end
    local function search(p, name)
        if p.Name == name and p:IsA("BasePart") then return p end
        for _, c in ipairs(p:GetChildren()) do
            local f = search(c, name)
            if f then return f end
        end
    end
    local h = search(clone, "Handle")
    if h then return h end
    if clone:IsA("Accessory") then
        for _, c in ipairs(clone:GetChildren()) do
            if c:IsA("BasePart") then return c end
        end
    end
    if clone:IsA("Model") and clone.PrimaryPart then return clone.PrimaryPart end
    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA("MeshPart") then return d end
    end
    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA("UnionOperation") then return d end
    end
    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA("BasePart") then return d end
    end
end

local function getAllParts(obj)
    local parts = {}
    if obj:IsA("BasePart") then
        table.insert(parts, obj)
    end
    for _, d in ipairs(obj:GetDescendants()) do
        if d:IsA("BasePart") then
            table.insert(parts, d)
        end
    end
    return parts
end

local function findAttachmentIn(obj)
    for _, c in ipairs(obj:GetChildren()) do
        if c:IsA("Attachment") then return c end
    end
    for _, d in ipairs(obj:GetDescendants()) do
        if d:IsA("Attachment") then return d end
    end
end

local function removeHair()
    local char = Player.Character
    if char then
        nukeAllHair(char)
    end
    currentClone = nil
    currentHandle = nil
    currentHeadAttachment = nil
end

local function equipHair(char, hairId)
    if hairId == "DEFAULT" or hairId == nil then
        removeHair()
        return
    end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local head = char:FindFirstChild("Head")
    if not humanoid or not head then return end
    
    nukeAllHair(char)
    
    local src = ReplicatedStorage:FindFirstChild(hairId)
    if not src then return end
    
    local clone = src:Clone()
    local handle = getHandle(clone)
    if not handle then
        clone:Destroy()
        return
    end
    
    local allParts = getAllParts(clone)
    relativeMapGlobal = {}
    for _, part in ipairs(allParts) do
        if part ~= handle then
            relativeMapGlobal[part] = handle.CFrame:ToObjectSpace(part.CFrame)
        end
    end
    
    local att = findAttachmentIn(handle)
    local handleAttachCF = att and att.CFrame or CFrame.new()
    
    local headAttachName = ATTACHMENT_MAP[hairId] or "HairAttachment"
    local headAttachment = head:FindFirstChild(headAttachName)
        or head:FindFirstChild("HairAttachment")
        or head:FindFirstChild("HatAttachment")
        or head:FindFirstChild("FaceFrontAttachment")
    
    if not headAttachment then
        clone:Destroy()
        return
    end
    
    for _, part in ipairs(allParts) do
        part.Anchored = false
        part.CanCollide = false
        part.Massless = true
    end
    
    for _, desc in ipairs(clone:GetDescendants()) do
        if desc:IsA("Weld") or desc:IsA("WeldConstraint") or desc:IsA("Motor6D") then
            desc:Destroy()
        end
    end
    
    local extraOffset = OFFSET_TWEAKS[hairId] or CFrame.new()
    local extraRotation = ROTATION_TWEAKS[hairId] or CFrame.new()
    
    local finalC1 = handleAttachCF * extraOffset * extraRotation
    handle.CFrame = head.CFrame * headAttachment.CFrame * finalC1:Inverse()
    
    for part, relCF in pairs(relativeMapGlobal) do
        part.CFrame = handle.CFrame * relCF
    end
    
    local mw = Instance.new("Weld")
    mw.Name = "HairWeld"
    mw.Part0 = head
    mw.Part1 = handle
    mw.C0 = headAttachment.CFrame
    mw.C1 = finalC1
    mw.Parent = head
    
    for part, relCF in pairs(relativeMapGlobal) do
        local sw = Instance.new("Weld")
        sw.Name = "SubWeld"
        sw.Part0 = handle
        sw.Part1 = part
        sw.C0 = relCF
        sw.C1 = CFrame.new()
        sw.Parent = handle
    end
    
    clone:SetAttribute(EQUIP_TAG, true)
    clone.Parent = char
    
    task.defer(function()
        for _, d in ipairs(clone:GetDescendants()) do
            if d:IsA("Weld") and d.Name == "AccessoryWeld" then
                d:Destroy()
            end
        end
        for _, part in ipairs(getAllParts(clone)) do
            part.Anchored = false
            part.CanCollide = false
        end
    end)
    
    currentClone = clone
    currentHandle = handle
    currentHeadAttachment = headAttachment
    currentHandleAttachCF = handleAttachCF
end

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "HairChangerGui"
Gui.ResetOnSpawn = false
Gui.DisplayOrder = 100
Gui.Enabled = config.visible
Gui.Parent = PlayerGui

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 46, 0, 46)
ToggleBtn.Position = UDim2.new(0, 14, 0.5, -23)
ToggleBtn.BackgroundColor3 = C.toggle
ToggleBtn.Text = "Hair"
ToggleBtn.TextColor3 = C.textBright
ToggleBtn.TextSize = 24
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.AutoButtonColor = false
ToggleBtn.BorderSizePixel = 0
ToggleBtn.ZIndex = 15
ToggleBtn.Parent = Gui
corner(ToggleBtn, 14)
addStroke(ToggleBtn, C.accent, 1.5, 0.4)

local Panel = Instance.new("Frame")
Panel.Name = "Panel"
Panel.Size = UDim2.new(0, 250, 0, 400)
Panel.Position = UDim2.new(0, -260, 0.5, -200)
Panel.BackgroundColor3 = C.bg
Panel.BorderSizePixel = 0
Panel.ClipsDescendants = true
Panel.Parent = Gui
corner(Panel, 14)
addStroke(Panel, C.accent, 1.5, 0.55)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 46)
TitleBar.BackgroundColor3 = C.titleBar
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Panel
corner(TitleBar, 14)

local TitleFill = Instance.new("Frame")
TitleFill.Size = UDim2.new(1, 0, 0, 14)
TitleFill.Position = UDim2.new(0, 0, 1, -14)
TitleFill.BackgroundColor3 = C.titleBar
TitleFill.BorderSizePixel = 0
TitleFill.Parent = TitleBar

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size = UDim2.new(1, -16, 1, 0)
TitleLbl.Position = UDim2.new(0, 16, 0, 0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "Hair  Hair Changer"
TitleLbl.TextColor3 = C.textBright
TitleLbl.TextSize = 17
TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.Parent = TitleBar

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -24, 0, 2)
Divider.Position = UDim2.new(0, 12, 0, 48)
Divider.BackgroundColor3 = C.accent
Divider.BorderSizePixel = 0
Divider.Parent = Panel
corner(Divider, 1)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -16, 1, -64)
Scroll.Position = UDim2.new(0, 8, 0, 56)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = C.scrollBar
Scroll.ScrollBarImageTransparency = 0.25
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.Parent = Panel

local listLayout = Instance.new("UIListLayout", Scroll)
listLayout.Padding = UDim.new(0, 5)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

local scrollPad = Instance.new("UIPadding", Scroll)
scrollPad.PaddingBottom = UDim.new(0, 6)
scrollPad.PaddingRight = UDim.new(0, 5)

local btnMap = {}

local function isActiveBtn(id)
    if id == "DEFAULT" then
        return config.currentHairId == nil
    end
    return id == config.currentHairId
end

local function updateButtonStates()
    for id, ui in pairs(btnMap) do
        if isActiveBtn(id) then
            ui.frame.BackgroundColor3 = id == "DEFAULT" and C.accent or C.btnActive
            ui.label.TextColor3 = C.textBright
            ui.dot.BackgroundTransparency = 0
        else
            ui.frame.BackgroundColor3 = id == "DEFAULT" and C.btnDefault or C.btn
            ui.label.TextColor3 = id == "DEFAULT" and C.textBright or C.text
            ui.dot.BackgroundTransparency = 1
        end
    end
end

for i, data in ipairs(HAIR_LIST) do
    local isDefault = data.id == "DEFAULT"
    local Btn = Instance.new("TextButton")
    Btn.Name = data.id
    Btn.Size = UDim2.new(1, 0, 0, isDefault and 42 or 36)
    Btn.BackgroundColor3 = isDefault and C.btnDefault or C.btn
    Btn.BorderSizePixel = 0
    Btn.Text = ""
    Btn.AutoButtonColor = false
    Btn.LayoutOrder = i
    Btn.Parent = Scroll
    corner(Btn, isDefault and 10 or 8)
    if isDefault then
        addStroke(Btn, C.accent, 1.5, 0.4)
    end
    
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -16, 1, 0)
    Lbl.Position = UDim2.new(0, 16, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = data.label
    Lbl.TextColor3 = isDefault and C.textBright or C.text
    Lbl.TextSize = isDefault and 14 or 13
    Lbl.Font = isDefault and Enum.Font.GothamBold or Enum.Font.GothamSemibold
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = Btn
    
    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 5, 0, 5)
    Dot.Position = UDim2.new(0, 5, 0.5, -2)
    Dot.BackgroundColor3 = C.accent
    Dot.BackgroundTransparency = 1
    Dot.BorderSizePixel = 0
    Dot.Parent = Btn
    corner(Dot, 3)
    
    btnMap[data.id] = {frame = Btn, label = Lbl, dot = Dot}
    
    Btn.MouseEnter:Connect(function()
        if not isActiveBtn(data.id) then
            TweenService:Create(Btn, TWEEN_FAST, {BackgroundColor3 = C.btnHover}):Play()
        end
    end)
    
    Btn.MouseLeave:Connect(function()
        if not isActiveBtn(data.id) then
            TweenService:Create(Btn, TWEEN_FAST, {BackgroundColor3 = isDefault and C.btnDefault or C.btn}):Play()
        end
    end)
    
    Btn.MouseButton1Click:Connect(function()
        local char = Player.Character
        if not char then return end
        
        if isDefault then
            config.currentHairId = nil
            removeHair()
        else
            config.currentHairId = data.id
            equipHair(char, data.id)
        end
        updateButtonStates()
    end)
end

local isOpen = false
local POS_OPEN = UDim2.new(0, 14, 0.5, -200)
local POS_CLOSED = UDim2.new(0, -260, 0.5, -200)
local TOG_OPEN = UDim2.new(0, 272, 0.5, -23)
local TOG_CLOSED = UDim2.new(0, 14, 0.5, -23)

ToggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        TweenService:Create(Panel, TWEEN_OPEN, {Position = POS_OPEN}):Play()
        TweenService:Create(ToggleBtn, TWEEN_OPEN, {Position = TOG_OPEN, Rotation = 180}):Play()
    else
        TweenService:Create(Panel, TWEEN_OPEN, {Position = POS_CLOSED}):Play()
        TweenService:Create(ToggleBtn, TWEEN_OPEN, {Position = TOG_CLOSED, Rotation = 0}):Play()
    end
end)

ToggleBtn.MouseEnter:Connect(function()
    TweenService:Create(ToggleBtn, TWEEN_FAST, {BackgroundColor3 = C.toggleHover}):Play()
end)

ToggleBtn.MouseLeave:Connect(function()
    TweenService:Create(ToggleBtn, TWEEN_FAST, {BackgroundColor3 = C.toggle}):Play()
end)

local function applyVisible(state)
    Gui.Enabled = state
    if not state then
        isOpen = false
        Panel.Position = POS_CLOSED
        ToggleBtn.Position = TOG_CLOSED
        ToggleBtn.Rotation = 0
    end
end

Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    if config.currentHairId then
        equipHair(char, config.currentHairId)
        updateButtonStates()
    end
end)

task.spawn(function()
    local last = config.visible
    while Gui and Gui.Parent do
        task.wait(0.2)
        if config.visible ~= last then
            last = config.visible
            applyVisible(config.visible)
        end
    end
end)

applyVisible(config.visible)
updateButtonStates()

if config.currentHairId and Player.Character then
    task.spawn(function()
        task.wait(0.5)
        equipHair(Player.Character, config.currentHairId)
        updateButtonStates()
    end)
    
end

TabVisuals:CreateSection("Hair Changer")


TabVisuals:CreateDropdown({
   Name = "Hair Changer",
   Options = HAIR_LIST_LABELS,
   CurrentOption = {HAIR_LIST_LABELS[1]},
   MultipleOptions = false,
   --Flag = "RankDropdown",
   Callback = function(Option)
      local selected = Option[1]
     print(selected)
     local index1
     local index2
     for i,v in pairs(HAIR_LIST_LABELS) do
     if v == selected then
     index1 = i
     end
     end
      for i,v in pairs(HAIR_LIST_IDS) do
     if i == index1 then
     index2 = i
     end
     end
     equipHair(Player.Character, HAIR_LIST_IDS[index2])
   end,
})

TabSkills:CreateSection("Dribbling")
RayfieldElements.ActivePokers = TabSkills:CreateToggle({
    Name = "Active Pokers",
    CurrentValue = false,
    Flag = "ActivePokers",
    Callback = function(v)
        states.activePokers = v
        SyncFloatingVisuals("activePokers", v)
    end
})

RayfieldElements.ManualPokers = TabSkills:CreateToggle({
    Name = "Manual Pokers",
    CurrentValue = false,
    Flag = "ManualPokers",
    Callback = function(v)
        states.manualPokers = v
        SyncFloatingVisuals("manualPokers", v)
    end
})

TabSkills:CreateSection("Sneaky Configuration")
RayfieldElements.Sneaky = TabSkills:CreateToggle({
    Name = "Enable Sneaky",
    CurrentValue = false,
    Flag = "Sneaky",
    Callback = function(v)
        states.sneakyActive = v
        SyncFloatingVisuals("sneakyActive", v)
        forceHitboxUpdate()
    end
})
TabSkills:CreateSlider({
    Name = "Sneaky Range", 
    Range = {4.1, 8.0}, 
    Increment = 0.1, 
    CurrentValue = 4.1,
	Flag = "SneakyRange",
    Callback = function(v) 
        states.sneakyRadius = math.clamp(v, 4.1, 8.0);
        forceHitboxUpdate() 
    end
})

TabSkills:CreateSection("Juggle Configuration")
RayfieldElements.Juggle = TabSkills:CreateToggle({
    Name = "Enable Juggle",
    CurrentValue = false,
    Flag = "Juggle",
    Callback = function(v)
        states.juggleActive = v
        SyncFloatingVisuals("juggleActive", v)
        forceHitboxUpdate()
    end
})
TabSkills:CreateSlider({
    Name = "Juggle Radius", 
    Range = {4.1, 8.0}, 
    Increment = 0.1, 
    CurrentValue = 4.1, 
	Flag = "Juggle Radius",
    Callback = function(v) 
        states.juggleRadius = v; 
        forceHitboxUpdate() 
    end
})

TabSkills:CreateSection("Rainbow Flick")

RayfieldElements.RainbowFlick = TabSkills:CreateToggle({
    Name = "Rainbow Flick",
    CurrentValue = false,
	Flag = "RainbowFlick",
    Callback = function(v)
        states.rainbowFlickActive = v
        SyncFloatingVisuals("rainbowFlickActive", v)
        forceHitboxUpdate()
    end
})

TabSkills:CreateSlider({
    Name = "Rainbow Flick Range",
    Range = {3.5, 10},
    Increment = 0.1,
    CurrentValue = 3.5,
	Flag = "RainbowFlickRange",
    Callback = function(v)
        states.rainbowFlickRange = v
        forceHitboxUpdate()
    end
})


TabScripts:CreateSection("Shooting")
RayfieldElements.GroundShot = TabScripts:CreateToggle({
    Name = "Ground Shot",
    CurrentValue = false,
	Flag = "GroundShot",
    Callback = function(v)
        states.groundShotActive = v
        SyncFloatingVisuals("groundShotActive", v)
        forceHitboxUpdate()
    end
})
TabScripts:CreateSlider({
    Name = "Ground Shot Power",
    Range = {4.6, 10},
    Increment = 0.1,
    CurrentValue = 4.6,
	Flag = "GroundShotPower",
    Callback = function(v)
        states.groundShotPower = v
        forceHitboxUpdate()
    end
})
RayfieldElements.PowerShot = TabScripts:CreateToggle({
    Name = "Power Shot",
    CurrentValue = false,
	Flag = "PowerShot",
    Callback = function(v)
        states.powerShotActive = v
        SyncFloatingVisuals("powerShotActive", v)
        forceHitboxUpdate()
    end
})

TabScripts:CreateSlider({
    Name = "Power Shot Power",
    Range = {86, 150},
    Increment = 0.1,
    CurrentValue = 86,
	Flag = "PowerShotPower",
    Callback = function(v)
        states.powerShotPower = v
        forceHitboxUpdate()
    end
})





TabReach:CreateSection("Reach Configuration")
RayfieldElements.Reach = TabReach:CreateToggle({
    Name = "Reach", 
    CurrentValue = false, 
	Flag = "Reach",
    Callback = function(v) 
        states.reachActive = v 
        SyncFloatingVisuals("reachActive", v) 
        forceHitboxUpdate() 
    end
})
TabReach:CreateSlider({
    Name = "Reach Range",
    Range = {4.1, 14},
    Increment = 0.1,
    CurrentValue = 4.1,
	Flag = "ReachRange",
    Callback = function(v)
        states.reachRange = v
        forceHitboxUpdate()
    end
})
TabReach:CreateDropdown({
    Name = "Mode",
    Options = {"Regular", "Legit"},
    CurrentOption = {"Regular"},
    MultipleOptions = false,
	Flag = "Mode",
    Callback = function(option)
        local selected = type(option) == "table" and option[1] or option
        states.mode = selected
    end,
})

TabScripts:CreateSection("Aimbot")
RayfieldElements.Aimbot = TabScripts:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
	Flag = "Aimbot",
    Callback = function(v)
        states.Aimbot = v
        SyncFloatingVisuals("Aimbot", v)
        forceHitboxUpdate()
    end
})


TabScripts:CreateDropdown({
    Name = "Aim",
    Options = {"Random", "Top Left Corner", "Top Right Corner", "Net", "Bottom Left Corner", "Bottom Right Corner"},
    CurrentOption = {"Random"},
    MultipleOptions = false,
	Flag = "Aim",
    Callback = function(option)
        local selected = type(option) == "table" and option[1] or option
        states.Type = selected
    end,
})



RayfieldElements.FurthestCorner = TabScripts:CreateToggle({
    Name = "Furthest Corner",
    CurrentValue = false,
	Flag = "FurthestCorner",
    Callback = function(v)
        states.FurthestCorner = v
        SyncFloatingVisuals("FurthestCorner", v)
        forceHitboxUpdate()
    end
})


RayfieldElements.NoSpin = TabScripts:CreateToggle({
    Name = "No Spin",
    CurrentValue = false,
	Flag = "NoSpin",
    Callback = function(v)
        states.NoSpin = v
        SyncFloatingVisuals("NoSpin", v)
        forceHitboxUpdate()
    end
})

TabScripts:CreateSection("Rank Bypass")

local TPS = game:GetService("TeleportService")

local placeIDs = {
    ["ProCup"] = 138792551842718,
    ["Junior"] = 16452693191,
    ["Pro"] = 16452698027,
    ["Elite"] = 16876418704,
    ["Cup"] = 16453243555,
    ["Futsal"] = 16452721151,
    ["Street"] = 105531756926941,
    ["2vs2"] = 130754361889730,
    ["1vs1"] = 18738477182,
    ["Quest"] = 81844361462023,
    ["Academy"] = 16452695324,
}

RayfieldElements.RankBypass = TabScripts:CreateToggle({
    Name = "Rank Bypass",
    CurrentValue = false,
	Flag = "RankBypass",
    Callback = function(v)
        states.RankBypass = v
        SyncFloatingVisuals("RankBypass", v)
        forceHitboxUpdate()
    end
})


local options = {}
for name, _ in pairs(placeIDs) do
    table.insert(options, name)
end



TabScripts:CreateDropdown({
   Name = "Select Rank",
   Options = options,
   CurrentOption = {options[1]},
   MultipleOptions = false,
   --Flag = "RankDropdown",
   Callback = function(Option)
      local selected = Option[1]
      local id = placeIDs[selected]
      if id then
          task.spawn(function()
              for i = 1, 15 do
                  pcall(function()

                      TPS:Teleport(id, game.Players.LocalPlayer)
                  end)
                  task.wait(0.2)
              end
          end)
      end
   end,
})

TabScripts:CreateSection("Physics")

RayfieldElements.IncreaseMaxSpeed = TabScripts:CreateToggle({
    Name = "Increase Max Speed",
    CurrentValue = false,
	Flag = "IncreaseMaxSpeed",
    Callback = function(v)
        states.IncreaseMaxSpeed = v
        SyncFloatingVisuals("IncreaseMaxSpeed", v)
        forceHitboxUpdate()
    end
})

TabScripts:CreateSlider({
    Name = "Amount",
    Range = {24, 46},
    Increment = 0.1,
    CurrentValue = 24,
	Flag = "MaxSpeed",
    Callback = function(v)
        states.MaxSpeed = v
        forceHitboxUpdate()
    end
})

-- Script Path: game:GetService("Workspace").soesaytomakealts.WalkSpeed
-- Took 0s to decompile.
-- Executor: Potassium (v2.4.4)

-- Decompiled with Potassium's decompiler.

if game.Players.LocalPlayer.Character:FindFirstChild("WalkSpeed") then
game.Players.LocalPlayer.Character.WalkSpeed:Destroy()

local Humanoid = game.Players.LocalPlayer.Character.Humanoid
local UpdateWalkSpeed = game:GetService("ReplicatedStorage"):WaitForChild("UpdateWalkSpeed");
local u1 = false;
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true);

local speed

local function Moved() -- Line: 16
if states.IncreaseMaxSpeed then
        speed = states.MaxSpeed
        else
        speed = 23
        end
    -- upvalues: Humanoid (copy), u1 (ref), UpdateWalkSpeed (copy)
    if Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
        Humanoid.WalkSpeed = 16;
        UpdateWalkSpeed:FireServer(game.Players.LocalPlayer.Character.Name, Humanoid.WalkSpeed, "dihtelkds");
        
    elseif Humanoid.WalkSpeed < speed and not u1 then
        u1 = true;
        Humanoid.WalkSpeed = Humanoid.WalkSpeed + 1;
        UpdateWalkSpeed:FireServer(game.Players.LocalPlayer.Character.Name, Humanoid.WalkSpeed, "dihtelkds");
        wait(0.2);
        u1 = false;
    end;
end;

Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(Moved);
local LocalPlayer = game:GetService("Players").LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local UpperTorso = LocalPlayer.Character:WaitForChild("UpperTorso");
local Name = UpperTorso:FindFirstChild("Name", true);
local Number = UpperTorso:FindFirstChild("Number", true);
local Team = UpperTorso:FindFirstChild("Team", true);
task.spawn(function()
while true do
    if (CurrentCamera.CFrame.Position - CurrentCamera.Focus.Position).Magnitude < 1 and (LocalPlayer and LocalPlayer.Character) then
        Name.Visible = false;
        Number.Visible = false;
        Team.Visible = false;
    else
        Name.Visible = true;
        Number.Visible = true;
        Team.Visible = true;
    end;

    wait(2);
end;
end)

end







local sortedKeys = {}

for key in pairs(placeIDs) do
    table.insert(sortedKeys, key)
end

table.sort(sortedKeys, function(a, b)
    return #a > #b
end)

local function getPlaceID(portalName)
    local name = portalName
        :gsub("portal", "")
        :gsub(" ", "")
        :gsub("_", "")

    for _, key in ipairs(sortedKeys) do
        if name:find(key) then
            return placeIDs[key]
        end
    end

    return nil
end

local debounce = false

local function onTouch(portal, hit)
    if not states.RankBypass then return end
    if hit.Parent ~= game.Players.LocalPlayer.Character then return end
    if debounce then return end

    local id = getPlaceID(portal.Name)

    if not id then
        id = getPlaceID(portal.Parent.Name)
    end

    print(states.RankBypass)

    if id then
        debounce = true

        task.spawn(function()
            for i = 1, 15 do
                pcall(function()
                    TPS:Teleport(id, game.Players.LocalPlayer)
                end)
                task.wait(0.2)
            end

            debounce = false
        end)
    end
end

local portals = workspace:FindFirstChild("Lobby")
    and workspace.Lobby:FindFirstChild("Portals")

if portals then
print(portals)
    for _, portal in pairs(portals:GetDescendants()) do
        if portal:IsA("BasePart") then
            portal.Touched:Connect(function(hit)
                onTouch(portal, hit)
            end)
        end
    end
end






TabKeybinds:CreateSection("Keyboard Custom Keybinds")

TabKeybinds:CreateKeybind({
    Name = "Active Pokers Keybind",
    CurrentKeybind = "G",
    HoldToInteract = false,
    Flag = "ActivePokersKeybind",
    Callback = function()
        if RayfieldElements.ActivePokers then
            RayfieldElements.ActivePokers:Set(not states.activePokers)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Manual Pokers Keybind",
    CurrentKeybind = "C",
    HoldToInteract = false,
    Flag = "ManualPokersKeybind",
    Callback = function()
        if RayfieldElements.ManualPokers then
            RayfieldElements.ManualPokers:Set(not states.manualPokers)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Sneaky Keybind",
    CurrentKeybind = "Q",
    HoldToInteract = false,
    Flag = "SneakyKeybind",
    Callback = function()
        if RayfieldElements.Sneaky then
            RayfieldElements.Sneaky:Set(not states.sneakyActive)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Juggle Keybind",
    CurrentKeybind = "J",
    HoldToInteract = false,
    Flag = "JuggleKeybind",
    Callback = function()
        if RayfieldElements.Juggle then
            RayfieldElements.Juggle:Set(not states.juggleActive)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Reach Keybind",
    CurrentKeybind = "X",
    HoldToInteract = false,
    Flag = "ReachKeybind",
    Callback = function()
        if RayfieldElements.Reach then
            RayfieldElements.Reach:Set(not states.reachActive)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Ground Shot Keybind",
    CurrentKeybind = "V",
    HoldToInteract = false,
    Flag = "GroundShotKeybind",
    Callback = function()
        if RayfieldElements.GroundShot then
            RayfieldElements.GroundShot:Set(not states.groundShotActive)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Aimbot Keybind",
    CurrentKeybind = "B",
    HoldToInteract = false,
    Flag = "AimbotKeybind",
    Callback = function()
        if RayfieldElements.Aimbot then
            RayfieldElements.Aimbot:Set(not states.Aimbot)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Rainbow Flick Keybind",
    CurrentKeybind = "N",
    HoldToInteract = false,
    Flag = "RainbowFlickKeybind",
    Callback = function()
        if RayfieldElements.RainbowFlick then
            RayfieldElements.RainbowFlick:Set(not states.rainbowFlickActive)
        end
    end
})


TabKeybinds:CreateSection("Controller Controller Keybinds")

TabKeybinds:CreateKeybind({
    Name = "Reach Controller Bind",
    CurrentKeybind = "ButtonX",
    HoldToInteract = false,
    Flag = "ReachControllerBind",
    Callback = function()
        if RayfieldElements.Reach then
            RayfieldElements.Reach:Set(not states.reachActive)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Sneaky Controller Bind",
    CurrentKeybind = "ButtonA",
    HoldToInteract = false,
    Flag = "SneakyControllerBind",
    Callback = function()
        if RayfieldElements.Sneaky then
            RayfieldElements.Sneaky:Set(not states.sneakyActive)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Juggle Controller Bind",
    CurrentKeybind = "ButtonB",
    HoldToInteract = false,
    Flag = "JuggleControllerBind",
    Callback = function()
        if RayfieldElements.Juggle then
            RayfieldElements.Juggle:Set(not states.juggleActive)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Active Pokers Controller Bind",
    CurrentKeybind = "ButtonR1",
    HoldToInteract = false,
    Flag = "ActivePokersControllerBind",
    Callback = function()
        if RayfieldElements.ActivePokers then
            RayfieldElements.ActivePokers:Set(not states.activePokers)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Manual Pokers Controller Bind",
    CurrentKeybind = "ButtonL1",
    HoldToInteract = false,
    Flag = "ManualPokersControllerBind",
    Callback = function()
        if RayfieldElements.ManualPokers then
            RayfieldElements.ManualPokers:Set(not states.manualPokers)
        end
    end
})

TabKeybinds:CreateKeybind({
    Name = "Ground Shot Controller Bind",
    CurrentKeybind = "ButtonR2",
    HoldToInteract = false,
    Flag = "GroundShotControllerBind",
    Callback = function()
        if RayfieldElements.GroundShot then
            RayfieldElements.GroundShot:Set(not states.groundShotActive)
        end
    end
})

TabFun:CreateButton({
    Name = "Teleport Ball",
    Flag = "TeleportBall",
    Callback = function()
    
	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")

	local player = Players.LocalPlayer
	if not player then return end

	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local ReachDistance = 790

	local field = Workspace:FindFirstChild("FootballField")
	if not field then return end

	local soccerBall = field:FindFirstChild("SoccerBall")
	if not soccerBall then return end

	local distance = (hrp.Position - soccerBall.Position).Magnitude
	if distance > ReachDistance then return end

	local offset = hrp.CFrame.LookVector * 2
	local newPos = hrp.Position + offset

	soccerBall.CFrame =
		CFrame.new(newPos, newPos + hrp.CFrame.LookVector)


    end
})




if MeasureLagEvent and MeasureLag then
    MeasureLagEvent.OnClientEvent:Connect(function(serverTime)
    end)
end

local function handleHitboxExpander(now)
    if now - lastHitbox > 0.5 then
        lastHitbox = now
        local dynamicHitboxSize = hitboxSize
        
        if states.reachActive then
            --local adjustedSize = math.clamp(states.reachRange * 2.5, 12, 30)
            --dynamicHitboxSize = Vector3.new(adjustedSize, adjustedSize, adjustedSize)
        elseif states.groundShotActive then
            local adjustedSize = math.clamp(states.groundShotPower * 2.5, 12, 30)
            dynamicHitboxSize = Vector3.new(adjustedSize, adjustedSize, adjustedSize)
        end

        for _, p in pairs(Players:GetPlayers()) do
            if p == me then continue end
            local char = p.Character
            if not char then continue end
            local r = char:FindFirstChild("HumanoidRootPart")
            if not r then continue end
            r.Size = dynamicHitboxSize
            r.Transparency = 1
            r.CanCollide = false
        end
    end
end

local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, key)
    if false and checkcaller() and key == "Position" then
        if states.rainbowFlickActive then
		local char = me.Character
        if char and oldIndex(self, "Parent") == char then
            local ball = getBall()
            if ball then
                local rootPart = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChildOfClass("Humanoid")
                
                if rootPart and hum then
                    local realPos = oldIndex(self, key)
                    local ballPos = oldIndex(ball, "Position")
                    local ballVel = ball.AssemblyLinearVelocity
                    
                    -- Ping compensation & dynamic velocity projection to defeat low-ping players
                    local latencyPrediction = 0.045
                    local predictedBallPos = ballPos + (ballVel * latencyPrediction)
                    
                    local directionX, directionY, directionZ
                    local magnitude3D = 0
                    local isWithinRange = false
                    
                    local maxReachThreshold = states.rainbowFlickRange
                    if states.rainbowFlickRange >= 3.1 and states.rainbowFlickRange <= 3.5 then
                        -- High-efficiency adjustment for the 3.1 - 3.5 range to maximize cancel priority
                        maxReachThreshold = states.rainbowFlickRange * 1.15
                    end
                    
                    -- Check current position to guarantee zero phasing
                    local rawDx = ballPos.X - realPos.X
                    local rawDy = ballPos.Y - realPos.Y
                    local rawDz = ballPos.Z - realPos.Z
                    local rawMag = math.sqrt(rawDx*rawDx + rawDy*rawDy + rawDz*rawDz)
                    
                    if rawMag <= maxReachThreshold then
                        isWithinRange = true
                        directionX, directionY, directionZ = rawDx, rawDy, rawDz
                        magnitude3D = rawMag
                    else
                        -- Check predicted position to intercept early and overcome high latency (e.g. 200 ping)
                        local predDx = predictedBallPos.X - realPos.X
                        local predDy = predictedBallPos.Y - realPos.Y
                        local predDz = predictedBallPos.Z - realPos.Z
                        local predMag = math.sqrt(predDx*predDx + predDy*predDy + predDz*predDz)
                        
                        if predMag <= maxReachThreshold then
                            isWithinRange = true
                            directionX, directionY, directionZ = predDx, predDy, predDz
                            magnitude3D = predMag
                        end
                    end
                    
                    if isWithinRange and magnitude3D > 0.01 then
                        local dirUnitX = directionX / magnitude3D
                        local dirUnitY = directionY / magnitude3D
                        local dirUnitZ = directionZ / magnitude3D
                        
                        -- Microscopic stable offset to avoid 0-distance NaN division errors
                        local touchOffset = (states.rainbowFlickRange <= 3.5) and 0.15 or 0.22
                        local baseBallPos = (rawMag <= maxReachThreshold) and ballPos or predictedBallPos
                        
                        local targetX = baseBallPos.X - (dirUnitX * touchOffset)
                        local targetZ = baseBallPos.Z - (dirUnitZ * touchOffset)
                        local targetY
                        
                        -- Pure Ball Bounce Physics Modification
                        if (baseBallPos.Y - realPos.Y) > 1.8 then
                            -- Air Intercept: Tracks ball cleanly while high in the air
                            targetY = baseBallPos.Y - 1.5
                        else
                            -- Pure Under-Ball Lift: Positions the intercept vector below the ball's center.
                            -- This forces the physics engine to calculate an upward launch vector for an absolute bounce.
                            local currentVelocity = rootPart.AssemblyLinearVelocity or rootPart.Velocity
                            local horizontalSpeed = math.sqrt(currentVelocity.X * currentVelocity.X + currentVelocity.Z * currentVelocity.Z)
                            local underBallOffset = 1.2 + (math.clamp(horizontalSpeed / 16, 0, 1) * 0.8)
                            
                            targetY = baseBallPos.Y - underBallOffset
                        end
                        
                        return Vector3.new(targetX, targetY, targetZ)
                    end
                end
            end
        end

        end

        if states.juggleActive then
			
            local ball = getBall()
            if ball and ball.Parent then
                local char = me.Character
                if char and self.Parent == char then
                    local name = self.Name
                    if name == "UpperTorso" or name == "LowerTorso" or name == "HumanoidRootPart" or name == "Head" then
                        local realPos = oldIndex(self, key)
                        local ballPos = ball.Position
                        
                        local dx, dy, dz = ballPos.X - realPos.X, ballPos.Y - realPos.Y, ballPos.Z - realPos.Z
                        local magnitude = math.sqrt(dx*dx + dy*dy + dz*dz)
                        
                        local activeRange = states.reachRange
                        if states.groundShotActive then
                            activeRange = states.groundShotPower
                        elseif states.juggleActive then 
                            activeRange = states.juggleRadius
                        elseif states.sneakyActive then 
                            activeRange = math.clamp(states.sneakyRadius, 4.1, 8.0) 
                        end
                        
                        if magnitude <= activeRange then
                            local rootPart = char:FindFirstChild("HumanoidRootPart")
                            local hum = char:FindFirstChildOfClass("Humanoid")
                            
                            if rootPart and hum then
                                local rawMove = hum.MoveDirection
                                local moveDirection = Vector3.new(rawMove.X, 0, rawMove.Z)
                                local moveLen = moveDirection.Magnitude
                                local isMoving = moveLen > 0.05
                                
                                local camera = Workspace.CurrentCamera
                                local camLook = camera and camera.CFrame.LookVector or Vector3.new(0, 0, 1)
                                local lookDirX, lookDirZ = camLook.X, camLook.Z
                                local lookLen = math.sqrt(lookDirX*lookDirX + lookDirZ*lookDirZ)
                                if lookLen > 0 then
                                    lookDirX, lookDirZ = lookDirX / lookLen, lookDirZ / lookLen
                                else
                                    lookDirX, lookDirZ = 0, 1
                                end
                                
                                local alignment = 0
                                if isMoving then alignment = (moveDirection.X / moveLen) * lookDirX + (moveDirection.Z / moveLen) * lookDirZ end

                                if states.juggleActive then
                                    local speedFactor = isMoving and math.clamp(moveLen, 1.2, 2.5) or 1
                                    local dynamicModifier = (1.1 + (alignment * 0.45) * speedFactor)
                                    
                                    if name == "Head" then
                                        return Vector3.new(ballPos.X, realPos.Y - 0.12, ballPos.Z)
                                    else
                                        local flatMag = math.sqrt(dx*dx + dz*dz)
                                        local flatX, flatZ = 0, 0
                                        if flatMag > 0 then
                                            flatX = dx / flatMag
                                            flatZ = dz / flatMag
                                        end
                                        
                                        local buffer_x = flatX * (0.18 * dynamicModifier)
                                        local buffer_z = flatZ * (0.18 * dynamicModifier)
                                        
                                        return Vector3.new(ballPos.X - buffer_x, realPos.Y, ballPos.Z - buffer_z)
                                    end
                                    
                                elseif states.sneakyActive then
                                    -- Auto Sneaky: Legit gate for low range values
                                    local sneakyRange = math.clamp(states.sneakyRadius, 4.1, 8.0)
                                    local effectiveRange = sneakyRange
                                    if sneakyRange <= 4.6 then
                                        effectiveRange = 4.25
                                    end

                                    -- Use rootPart look vector for angle check (not camera)
                                    local rootLook = rootPart.CFrame.LookVector
                                    local rLookX, rLookZ = rootLook.X, rootLook.Z
                                    local rLookLen = math.sqrt(rLookX*rLookX + rLookZ*rLookZ)
                                    if rLookLen > 0 then
                                        rLookX, rLookZ = rLookX / rLookLen, rLookZ / rLookLen
                                    else
                                        rLookX, rLookZ = 0, 1
                                    end

                                    -- Compute horizontal direction from player to ball
                                    local toBallX = ballPos.X - realPos.X
                                    local toBallZ = ballPos.Z - realPos.Z
                                    local toBallLen = math.sqrt(toBallX*toBallX + toBallZ*toBallZ)
                                    local toBallDirX, toBallDirZ = 0, 1
                                    if toBallLen > 0 then
                                        toBallDirX, toBallDirZ = toBallX / toBallLen, toBallZ / toBallLen
                                    end

                                    -- Angle check (dot product of look direction and direction to ball)
                                    local angleDot = rLookX * toBallDirX + rLookZ * toBallDirZ
                                    local isInFront = angleDot >= ANGLE_THRESHOLD

                                    local speedFactor = isMoving and math.clamp(moveLen, 1.2, 2.5) or 1
                                    local dynamicModifier = (1.1 + (alignment * 0.45) * speedFactor)

                                    -- Re-Engineered Hit Physics
                                    local isBallInAir = ballPos.Y > 3.5
                                    if ball:IsA("BasePart") then
                                        local currentVel = ball.AssemblyLinearVelocity
                                        if (isBallInAir or math.abs(ballPos.Y - realPos.Y) < 3) and magnitude <= TOUCH_DIST and isInFront then
                                            local forcedLift
                                            local powerMultiplier = 1.25
                                            if isBallInAir then
                                                forcedLift = math.max(currentVel.Y, 52)
                                            else
                                                forcedLift = currentVel.Y
                                                if forcedLift < 6 then
                                                    forcedLift = 12
                                                end
                                            end
                                            ball.AssemblyLinearVelocity = Vector3.new(currentVel.X * powerMultiplier, forcedLift, currentVel.Z * powerMultiplier)
                                        end
                                    end

                                    -- Anti-Teleport Position Blending
                                    local buffer_x = rLookX * (HIDDEN_BUFFER * dynamicModifier)
                                    local buffer_z = rLookZ * (HIDDEN_BUFFER * dynamicModifier)
                                    local targetX = ballPos.X - buffer_x
                                    local targetZ = ballPos.Z - buffer_z

                                    local shiftX = targetX - realPos.X
                                    local shiftZ = targetZ - realPos.Z
                                    local shiftMag = math.sqrt(shiftX * shiftX + shiftZ * shiftZ)

                                    if shiftMag > MAX_SPOOF_SHIFT then
                                        targetX = realPos.X + (shiftX / shiftMag) * MAX_SPOOF_SHIFT
                                        targetZ = realPos.Z + (shiftZ / shiftMag) * MAX_SPOOF_SHIFT
                                    end

                                    return Vector3.new(targetX, realPos.Y - HIDDEN_DROP, targetZ)
                                    
                                else
                                    local speedFactor = isMoving and math.clamp(moveLen, 1, 2) or 1
                                    local dynamicModifier = (1.0 + (alignment * 0.35) * speedFactor)
                                    
                                    if name == "Head" then
                                        if isMoving then
                                            local localMove = rootPart.CFrame:VectorToObjectSpace(moveDirection)
                                            if localMove.Z > 0.1 then return realPos
                                            else
                                                local bX = (moveDirection.X / moveLen) * (1.5 * dynamicModifier)
                                                local bZ = (moveDirection.Z / moveLen) * (1.5 * dynamicModifier)
                                                return Vector3.new(realPos.X + bX, realPos.Y, realPos.Z + bZ)
                                            end
                                        else
                                            local offset_x = (dx / magnitude) * (0.2 * dynamicModifier)
                                            local offset_z = (dz / magnitude) * (0.2 * dynamicModifier)
                                            return Vector3.new(ballPos.X - offset_x, realPos.Y, ballPos.Z - offset_z)
                                        end
                                    else
                                        local flatMag = math.sqrt(dx*dx + dz*dz)
                                        local flatX, flatZ = dx / magnitude, dz / magnitude
                                        if flatMag > 0 then flatX, flatZ = dx / flatMag, dz / flatMag end
                                        
                                        local buffer_x = flatX * (0.35 * dynamicModifier)
                                        local buffer_z = flatZ * (0.35 * dynamicModifier)
                                        
                                        local ballVel = ball.AssemblyLinearVelocity
                                        local isKicking = false
                                        
                                        if hum and hum.MoveDirection.Magnitude > 0.5 then
                                            local forwardDot = lookDirX * (dx / magnitude) + lookDirZ * (dz / magnitude)
                                            if forwardDot > 0.3 and magnitude < 4 then
                                                isKicking = true
                                                lastKickTime = tick()
                                            end
                                        end
                                        
                                        if isKicking or (tick() - lastKickTime < 0.15) then
                                            local shotPower = 2
                                            buffer_x = buffer_x + lookDirX * 0.5 * shotPower
                                            buffer_z = buffer_z + lookDirZ * 0.5 * shotPower
                                        end
                                        
                                        if ballVel then
                                            local awaySpeed = ballVel.X * (dx / magnitude) + ballVel.Z * (dz / magnitude)
                                            if awaySpeed > 1.5 then
                                                local velBoost = 0.18
                                                buffer_x = buffer_x + flatX * velBoost
                                                buffer_z = buffer_z + flatZ * velBoost
                                            end
                                        end
                                        
                                        local targetY = realPos.Y
                                        if states.groundShotActive then
                                            targetY = ballPos.Y - 1.25
                                        elseif ballPos.Y > realPos.Y + 2 and magnitude < 5 then 
                                            targetY = realPos.Y + 0.5 
                                        end
                                        
                                        return Vector3.new(ballPos.X - buffer_x, targetY, ballPos.Z - buffer_z)
                                    end
                                end
                            end
                        end
                    end
                end
						end
						end
    end
    return oldIndex(self, key)
end)

if me.Character  then end
me.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    ApplyShoeChangerLogic()
    ApplyShirtCustomizerLogic()
    --setupGkCharacter(char)
end)

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.R then
        if RayfieldElements.Sneaky then
            RayfieldElements.Sneaky:Set(not states.sneakyActive)
        end
    end
end)

RunService.Heartbeat:Connect(function(dt)
    local char = me.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local ball = getBall()

    if states.groundShotActive then
        local now = tick()
        handleHitboxExpander(now)
    end

    if states.rainbowShoes then
        rainbowHue = (rainbowHue + dt * 0.2) % 1
        states.shoeColor = Color3.fromHSV(rainbowHue, 0.9, 1)
        ApplyShoeChangerLogic()
    end
    
    if states.pitchColorActive and states.rainbowPitch then
        rainbowPitchHue = (rainbowPitchHue + dt * 0.1) % 1
        applyColorToPitch(Color3.fromHSV(rainbowPitchHue, 0.8, 1))
    end

    if states.manualPokers and hum and hum.WalkSpeed ~= POKER_SPEED then
        hum.WalkSpeed = POKER_SPEED
    end

    if states.activePokers and root and ball then
        if not lastGkBodyVelocity or lastGkBodyVelocity.Parent ~= root then
            lastGkBodyVelocity = Instance.new("BodyVelocity")
            lastGkBodyVelocity.MaxForce = Vector3.new(1e7, 0, 1e7)
            lastGkBodyVelocity.Parent = root
        end
        local diff = ball.Position - root.Position
        lastGkBodyVelocity.Velocity = Vector3.new(diff.Unit.X * 26, 0, diff.Unit.Z * 26)
    else
        if lastGkBodyVelocity then
            lastGkBodyVelocity:Destroy()
            lastGkBodyVelocity = nil
        end
    end

    -- Loop logic for Auto Nero
    if states.autoNeroActive and root and ball then
        local now = tick()
        if now - lastKick > 0.1 then
            local dist = (ball.Position - root.Position).Magnitude
            if dist <= states.autoNeroRange * 2.2 then
                lastKick = now
                local targetDir = (root.CFrame.LookVector * 0.85 + Vector3.new(0, 0.25, 0)).Unit
                fireKick(ball.Position, targetDir * 85, 2)
            end
        end
    end

   

    if states.trackerActive then
        if not ball or not root then
            for _, dot in ipairs(dots) do if dot then dot.Position = Vector3.new(0, -1000, 0) end end
            if bigDot then bigDot.Position = Vector3.new(0, -1000, 0) end
        else
            local distanceToBall = (ball.Position - root.Position).Magnitude
            if distanceToBall < 20 then
                local pos = ball.Position
                local aimDirection = (root.CFrame.LookVector + Vector3.new(0, 0.35, 0)).Unit
                local simulatedVel = aimDirection * 90
                local gravity = Workspace.Gravity
                local points = {}
                local landingPos = pos
                
                for i = 1, 80 do
                    local t = i * 0.015
                    local predicted = Vector3.new(pos.X + simulatedVel.X * t, pos.Y + simulatedVel.Y * t - 0.5 * gravity * t * t, pos.Z + simulatedVel.Z * t)
                    if predicted.Y < 5.5 then landingPos = predicted break end
                    table.insert(points, predicted)
                end

                local step = math.max(1, math.floor(#points / DOT_COUNT))
                for i = 1, DOT_COUNT do
                    local idx = math.min(i * step, #points)
                    if points[idx] and dots[i] then
                        dots[i].Position = points[idx]
                        local alpha = i / DOT_COUNT
                        dots[i].Color = states.guiAccentColor
                        dots[i].Size = Vector3.new(0.5 - alpha * 0.3, 0.5 - alpha * 0.3, 0.5 - alpha * 0.3)
                    elseif dots[i] then dots[i].Position = Vector3.new(0, -1000, 0) end
                end

                if bigDot then
                    local pulse = 0.5 + 0.5 * math.sin(tick() * 8)
                    local size = 3 + pulse * 1.5
                    bigDot.Position = landingPos
                    bigDot.Size = Vector3.new(size, size, size)
                    bigDot.Transparency = pulse * 0.4
                    bigDot.Color = states.guiAccentColor
                end
            else
                for _, dot in ipairs(dots) do if dot then dot.Position = Vector3.new(0, -1000, 0) end end
                if bigDot then bigDot.Position = Vector3.new(0, -1000, 0) end
            end
        end
    end
end)

Rayfield:LoadConfiguration()

-- Updated movement/ball-contact implementations based on the supplied replacement files.
do
    local replacementOldIndex
    local replacementHooked = false

    local function replacementIsAirborne(char)
        if not char then return false end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return false end
        if hum.FloorMaterial == Enum.Material.Air then return true end
        local st = hum:GetState()
        return st == Enum.HumanoidStateType.Freefall or st == Enum.HumanoidStateType.Jumping
    end

    local function replacementSneaky(realPos, char, ball)
        if not states.sneakyActive then return realPos end
        if not replacementIsAirborne(char) then return realPos end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp or not ball or not ball:IsA("BasePart") then return realPos end

        local ballPos = ball.Position
        if ballPos.Y < 4.473 then return realPos end
        local reach = math.clamp(states.sneakyRadius, 4.0, 10.0)
        local dist = (ballPos - realPos).Magnitude
        if dist <= 0 or dist > reach then return realPos end

        local flat = Vector3.new(ballPos.X - realPos.X, 0, ballPos.Z - realPos.Z)
        local look = hrp.CFrame.LookVector
        local flatLook = Vector3.new(look.X, 0, look.Z)
        local contactDir
        if flat.Magnitude > 0.05 then
            contactDir = flat.Unit
        elseif flatLook.Magnitude > 0.05 then
            contactDir = flatLook.Unit
        else
            contactDir = Vector3.new(0, 0, 1)
        end
        if flatLook.Magnitude > 0.05 then
            flatLook = flatLook.Unit
            if contactDir:Dot(flatLook) < -0.1 then return realPos end
        end

        local bias = 0.70
        local mixed = contactDir
        if flatLook.Magnitude > 0.05 then
            local blend = Vector3.new(
                (1 - bias) * contactDir.X + bias * flatLook.X,
                0,
                (1 - bias) * contactDir.Z + bias * flatLook.Z
            )
            if blend.Magnitude > 0.01 then mixed = blend.Unit end
        end

        local targetVy = math.clamp(math.sqrt(2 * 55 * 10.5), 0, 40)
        local u = flatLook.Magnitude >= 0.5 and flatLook or mixed
        local cosTheta = math.clamp(mixed:Dot(u), -1, 1)
        local merges = cosTheta >= 0.93969
        local bv = ball.AssemblyLinearVelocity
        local horiz = math.sqrt(bv.X * bv.X + bv.Z * bv.Z)
        local needed = targetVy * (merges and 1.49 or 1.05)
        local baseWanted = math.clamp(needed - horiz, 40, 80)
        local power = math.min(baseWanted + horiz, 85)
        local q = math.clamp(targetVy / math.max(power, 1), 0, 0.999)
        local ss
        if merges then
            local lo, hi = 0, 0.999
            for _ = 1, 30 do
                local mid = (lo + hi) * 0.5
                local cv = math.sqrt(math.max(1 - mid * mid, 0))
                if (mid / math.sqrt(2 + 2 * cosTheta * cv)) < q then lo = mid else hi = mid end
            end
            ss = (lo + hi) * 0.5
        else
            ss = q
        end
        local cosP = math.sqrt(math.max(1 - ss * ss, 0))
        local launchDir = Vector3.new(mixed.X * cosP, ss, mixed.Z * cosP)
        local spoof = (ballPos - launchDir * 1.8) - Vector3.new(0, 1.3, 0)
        if (ballPos - spoof).Magnitude > 3.9 then
            spoof = (ballPos - launchDir * 1.2) - Vector3.new(0, 1.3, 0)
        end
        return spoof
    end

    local function replacementRainbow(realPos, char, ball)
        if not states.rainbowFlickActive then return realPos end
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not root or not hum or not ball or not ball:IsA("BasePart") then return realPos end

        local ballPos = ball.Position
        local ballVel = ball.AssemblyLinearVelocity
        local prediction = ballPos + (ballVel * 0.045)
        local maxReach = math.clamp(states.rainbowFlickRange, 3.5, 10.0)
        if maxReach >= 3.1 and maxReach <= 3.5 then maxReach = maxReach * 1.15 end

        local raw = ballPos - realPos
        local rawMag = raw.Magnitude
        local target = nil
        if rawMag <= maxReach then
            target = ballPos
        else
            local pred = prediction - realPos
            if pred.Magnitude <= maxReach then target = prediction end
        end
        if not target then return realPos end

        local direction = target - realPos
        local mag = direction.Magnitude
        if mag <= 0.01 then return realPos end
        local dir = direction.Unit
        local touchOffset = (states.rainbowFlickRange <= 3.5) and 0.15 or 0.22
        local targetX = target.X - dir.X * touchOffset
        local targetZ = target.Z - dir.Z * touchOffset
        local targetY
        if (target.Y - realPos.Y) > 1.8 then
            targetY = target.Y - 1.5
        else
            local v = root.AssemblyLinearVelocity
            local horizontalSpeed = math.sqrt(v.X * v.X + v.Z * v.Z)
            local underBallOffset = 1.2 + math.clamp(horizontalSpeed / 16, 0, 1) * 0.8
            targetY = target.Y - underBallOffset
        end
        return Vector3.new(targetX, targetY, targetZ)
    end

    local function replacementGround(realPos, char, ball)
        if not states.groundShotActive then return realPos end
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not root or not hum or not ball or not ball:IsA("BasePart") then return realPos end

        local ballPos = ball.Position
        local dx, dy, dz = ballPos.X - realPos.X, ballPos.Y - realPos.Y, ballPos.Z - realPos.Z
        local magnitude = math.sqrt(dx * dx + dy * dy + dz * dz)
        local reach = math.clamp(states.groundShotPower, 1, 20)
        if magnitude <= 0 or magnitude > reach then return realPos end

        local move = hum.MoveDirection
        local moveDir = Vector3.new(move.X, 0, move.Z)
        local moveLen = moveDir.Magnitude
        local camera = Workspace.CurrentCamera
        local camLook = camera and camera.CFrame.LookVector or Vector3.new(0, 0, 1)
        local lookLen = math.sqrt(camLook.X * camLook.X + camLook.Z * camLook.Z)
        local lookX, lookZ = 0, 1
        if lookLen > 0 then lookX, lookZ = camLook.X / lookLen, camLook.Z / lookLen end

        local flatMag = math.sqrt(dx * dx + dz * dz)
        local flatX, flatZ = dx / magnitude, dz / magnitude
        if flatMag > 0 then flatX, flatZ = dx / flatMag, dz / flatMag end
        local dynamicModifier = 1.0 + (math.clamp(moveLen, 1, 2) * 0.35)
        local buffer = 0.35 * dynamicModifier
        local bx, bz = flatX * buffer, flatZ * buffer
        local ballVel = ball.AssemblyLinearVelocity
        local forwardDot = lookX * (dx / magnitude) + lookZ * (dz / magnitude)
        if moveLen > 0.5 and forwardDot > 0.3 and magnitude < 4 then
            bx = bx + lookX
            bz = bz + lookZ
        end
        if ballVel then
            local awaySpeed = ballVel.X * (dx / magnitude) + ballVel.Z * (dz / magnitude)
            if awaySpeed > 1.5 then
                bx = bx + flatX * 0.18
                bz = bz + flatZ * 0.18
            end
        end
        return Vector3.new(ballPos.X - bx, ballPos.Y - 1.25, ballPos.Z - bz)
    end

    local function installReplacementHook()
        if replacementHooked then return end
        local ok = pcall(function()
            replacementOldIndex = hookmetamethod(game, "__index", function(self, key)
                if key == "Position" and not checkcaller() then
                    local char = me.Character
                    if char and self.Parent == char then
                        local name = self.Name
                        if name == "UpperTorso" or name == "LowerTorso" or name == "HumanoidRootPart" or name == "Head" then
                            local ball = getBall()
                            if ball then
                                local realPos = replacementOldIndex(self, key)
                                local result
                                if states.sneakyActive then
                                    result = replacementSneaky(realPos, char, ball)
                                elseif states.rainbowFlickActive then
                                    result = replacementRainbow(realPos, char, ball)
                                elseif states.groundShotActive then
                                    result = replacementGround(realPos, char, ball)
                                end
                                if result and result ~= realPos then return result end
                            end
                        end
                    end
                end
                return replacementOldIndex(self, key)
            end)
        end)
        replacementHooked = ok
    end

    task.spawn(function()
        task.wait(0.75)
        installReplacementHook()
    end)
end



-- ============================================================
-- SCARLET AIMPASS MODULE
-- ============================================================

task.spawn(function()

local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

if Workspace:FindFirstChild("AimPassHighlightFolder") then
    pcall(function() Workspace.AimPassHighlightFolder:Destroy() end)
end

local Config = {
    Enabled = false,
    TargetMode = "Look At",
    TeammatesOnly = true,
    ThroughBallEnabled = false,
    ThroughBallDistance = 25,
    MinPower = 35,
    MaxPassPower = 75,
    LobHeight = 45
}

local AssignedPositions = {
    RW = nil,
    LW = nil,
    CDM = nil,
    GK = nil
}

local GoalA = Vector3.new(-315, 12, 93)
local GoalB = Vector3.new(-114, 12, 93)

local function isTeammate(player)
    local myChar = LocalPlayer.Character
    local theirChar = player.Character
    if myChar and theirChar then
        local myTorso = myChar:FindFirstChild("Torso") or myChar:FindFirstChild("UpperTorso")
        local theirTorso = theirChar:FindFirstChild("Torso") or theirChar:FindFirstChild("UpperTorso")
        if myTorso and theirTorso then return myTorso.BrickColor == theirTorso.BrickColor end
    end
    if player.Team and LocalPlayer.Team then return player.Team == LocalPlayer.Team end
    return false
end

local function isValidTarget(player)
    if player == LocalPlayer then return false end
    if Config.TeammatesOnly then
        return isTeammate(player)
    end
    return true
end

local AimPassWindow = Window:CreateTab("AimPass", 4483362458)
local AimPassPositions = Window:CreateTab("Positions", 4483362458)
local AimPassSettings = Window:CreateTab("Pass Physics", 4483362458)

local TargetDropdown
local PosDropdowns = {}

local function UpdatePlayerLists()
    local mainList = {"Look At", "Tactical (Goal)", "RW", "LW", "CDM", "GK"}
    local posList = {"None"}
    for _, p in ipairs(Players:GetPlayers()) do
        if isValidTarget(p) then
            table.insert(mainList, p.Name)
            table.insert(posList, p.Name)
        end
    end
    if TargetDropdown then TargetDropdown:Refresh(mainList, true) end
    for _, dropdown in pairs(PosDropdowns) do
        dropdown:Refresh(posList, true)
    end
end

AimPassWindow:CreateToggle({
    Name = "Enable AimPass",
    CurrentValue = false,
    Flag = "AP_EnableToggle",
    Callback = function(Value) Config.Enabled = Value end,
})

AimPassWindow:CreateToggle({
    Name = "Teammates Only",
    CurrentValue = true,
    Flag = "AP_TeammateToggle",
    Callback = function(Value)
        Config.TeammatesOnly = Value
        UpdatePlayerLists()
    end,
})

TargetDropdown = AimPassWindow:CreateDropdown({
    Name = "Target",
    Options = {"Look At", "Tactical (Goal)", "RW", "LW", "CDM", "GK"},
    CurrentOption = {"Look At"},
    MultipleOptions = false,
    Flag = "AP_TargetDropdown",
    Callback = function(Option) Config.TargetMode = Option[1] end,
})

AimPassWindow:CreateButton({
    Name = "Refresh Players",
    Callback = function() UpdatePlayerLists() end,
})

local positionsToCreate = {"RW", "LW", "CDM", "GK"}
for _, pos in ipairs(positionsToCreate) do
    AimPassPositions:CreateLabel(pos .. " — Assign & Bind")
    PosDropdowns[pos] = AimPassPositions:CreateDropdown({
        Name = "Assign " .. pos,
        Options = {"None"},
        CurrentOption = {"None"},
        MultipleOptions = false,
        Flag = "AP_Dropdown_" .. pos,
        Callback = function(Option)
            local pName = Option[1]
            if pName == "None" then
                AssignedPositions[pos] = nil
            else
                AssignedPositions[pos] = Players:FindFirstChild(pName)
            end
        end,
    })
    AimPassPositions:CreateKeybind({
        Name = pos .. " Keybind",
        CurrentKeybind = "",
        HoldToInteract = false,
        Flag = "AP_Keybind_" .. pos,
        Callback = function()
            if AssignedPositions[pos] then
                Config.TargetMode = pos
                if TargetDropdown then TargetDropdown:Set({pos}) end
                Rayfield:Notify({
                    Title = "Target Acquired",
                    Content = "Targeting " .. pos .. " (" .. AssignedPositions[pos].Name .. ")",
                    Duration = 2,
                    Image = 4483362458
                })
            else
                Rayfield:Notify({
                    Title = "No Assignment",
                    Content = pos .. " has no player assigned.",
                    Duration = 2,
                    Image = 4483362458
                })
            end
        end,
    })
    AimPassPositions:CreateDivider()
end

UpdatePlayerLists()

AimPassSettings:CreateToggle({
    Name = "Through Balls",
    CurrentValue = false,
    Flag = "AP_ThroughBall",
    Callback = function(Value) Config.ThroughBallEnabled = Value end,
})
AimPassSettings:CreateSlider({
    Name = "Through Ball Distance",
    Range = {5, 60}, Increment = 1, CurrentValue = 25,
    Flag = "AP_ThroughDist",
    Callback = function(Value) Config.ThroughBallDistance = Value end,
})
AimPassSettings:CreateSlider({
    Name = "Min Pass Power",
    Range = {10, 85}, Increment = 1, CurrentValue = 35,
    Flag = "AP_MinPower",
    Callback = function(Value) Config.MinPower = Value end,
})
AimPassSettings:CreateSlider({
    Name = "Max Pass Power",
    Range = {10, 85}, Increment = 1, CurrentValue = 75,
    Flag = "AP_MaxPower",
    Callback = function(Value) Config.MaxPassPower = Value end,
})
AimPassSettings:CreateSlider({
    Name = "Max Lob Height",
    Range = {15, 100}, Increment = 1, CurrentValue = 45,
    Flag = "AP_LobHeight",
    Callback = function(Value) Config.LobHeight = Value end,
})

local highlightFolder = Instance.new("Folder", Workspace)
highlightFolder.Name = "AimPassHighlightFolder"
local targetHighlight = Instance.new("Highlight")
targetHighlight.FillColor = Color3.fromRGB(50, 255, 50)
targetHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
targetHighlight.FillTransparency = 0.5
targetHighlight.Parent = highlightFolder
targetHighlight.Adornee = nil

local function getLookAtTarget()
    local bestTarget = nil
    local maxDot = -math.huge
    local camCFrame = Camera.CFrame
    for _, p in ipairs(Players:GetPlayers()) do
        if isValidTarget(p) and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dir = (p.Character.HumanoidRootPart.Position - camCFrame.Position).Unit
            local dot = camCFrame.LookVector:Dot(dir)
            if dot > maxDot and dot > 0.75 then
                maxDot = dot
                bestTarget = p
            end
        end
    end
    return bestTarget
end

local function getTacticalTarget()
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local myLook = myRoot.CFrame.LookVector
    local oppGoal = ((GoalB - myRoot.Position).Unit:Dot(myLook) > (GoalA - myRoot.Position).Unit:Dot(myLook)) and GoalB or GoalA
    local bestTarget = nil
    local minDist = math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if isValidTarget(p) and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position - oppGoal).Magnitude
            if dist < minDist then
                minDist = dist
                bestTarget = p
            end
        end
    end
    return bestTarget
end

local currentTargetPlayer = nil
RunService.RenderStepped:Connect(function()
    if Config.Enabled then
        if Config.TargetMode == "Look At" then
            currentTargetPlayer = getLookAtTarget()
        elseif Config.TargetMode == "Tactical (Goal)" then
            currentTargetPlayer = getTacticalTarget()
        elseif AssignedPositions[Config.TargetMode] then
            currentTargetPlayer = AssignedPositions[Config.TargetMode]
            if not currentTargetPlayer.Parent then currentTargetPlayer = nil end
        else
            currentTargetPlayer = Players:FindFirstChild(Config.TargetMode)
        end

        if currentTargetPlayer and currentTargetPlayer.Character then
            if isTeammate(currentTargetPlayer) then
                targetHighlight.FillColor = Color3.fromRGB(50, 255, 50)
            else
                targetHighlight.FillColor = Color3.fromRGB(255, 50, 50)
            end
            targetHighlight.Adornee = currentTargetPlayer.Character
        else
            targetHighlight.Adornee = nil
        end
    else
        targetHighlight.Adornee = nil
        currentTargetPlayer = nil
    end
end)

local KickBallAP = ReplicatedStorage:WaitForChild("KickBall")
local kickKey = "dihtelkds"

local ap_u1 = nil
local ap_u2 = 0
local ap_u3 = 0
local ap_u4 = 0
local ap_u10 = 5.473

local function ap_createBall()
    local field = workspace:FindFirstChild("FootballField")
    if field then ap_u1 = field:FindFirstChild("SoccerBall") end
end

local function ap_startAnimation(p153, p154, p155, p156, p157) end

local function touchDetectAimPass()
    if Config.Enabled and LocalPlayer and LocalPlayer.Character and ap_u1 then
        if tick() - ap_u2 >= 0.6 and tick() - ap_u3 >= 0.3 then
            local UpperTorso = LocalPlayer.Character:FindFirstChild("UpperTorso") or LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not UpperTorso then return end
            local Position = UpperTorso.Position
            local Position2 = ap_u1.Position
            local Magnitude = (Position2 - Position).Magnitude
            if Magnitude > 0.01 and Magnitude <= 4 then
                if not currentTargetPlayer or not currentTargetPlayer.Character then return end
                local targetRoot = currentTargetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not targetRoot then return end
                ap_u2 = tick()
                local targetPos = targetRoot.Position
                local targetVel = targetRoot.AssemblyLinearVelocity
                if Config.ThroughBallEnabled then
                    if targetVel.Magnitude > 3 then
                        local moveDirection = Vector3.new(targetVel.X, 0, targetVel.Z).Unit
                        targetPos = targetPos + (moveDirection * Config.ThroughBallDistance)
                    else
                        local lookDirection = Vector3.new(targetRoot.CFrame.LookVector.X, 0, targetRoot.CFrame.LookVector.Z).Unit
                        targetPos = targetPos + (lookDirection * Config.ThroughBallDistance)
                    end
                else
                    targetPos = targetPos + (targetVel * 0.4)
                end
                local distToTarget = (targetPos - Position2).Magnitude
                local v180 = Vector3.new(targetPos.X - Position2.X, 0, targetPos.Z - Position2.Z)
                local Unit = v180.Unit
                if Unit.Magnitude > 0.01 then
                    local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    local WalkSpeed = Humanoid and Humanoid.WalkSpeed or 16
                    local maxLegalPower = 85
                    if WalkSpeed >= 19 then
                        maxLegalPower = (WalkSpeed - 19) * 10 + 40 + Vector3.new(ap_u1.Velocity.X, 0, ap_u1.Velocity.Z).Magnitude
                    elseif WalkSpeed == 16 then
                        maxLegalPower = 20
                    else
                        maxLegalPower = (WalkSpeed - 16) * 15 + 25
                    end
                    local distanceScale = math.clamp(distToTarget / 120, 0, 1)
                    local requiredPower = Config.MinPower + (distanceScale * (Config.MaxPassPower - Config.MinPower))
                    local finalPower = math.min(requiredPower, maxLegalPower)
                    local v187
                    local v182 = Vector3.new(0, 0, 0)
                    local isLob = (WalkSpeed >= 19) or (finalPower >= 70)
                    if isLob then
                        local lobScale = math.clamp(distToTarget / 150, 0, 1)
                        local lobHeight = 10 + (lobScale * (Config.LobHeight - 10))
                        local v190 = Unit * finalPower + Vector3.new(0, lobHeight, 0)
                        v187 = Vector3.new(v190.X, math.min(v190.Y, Config.LobHeight), v190.Z)
                    else
                        v187 = Unit * finalPower
                    end
                    if v187.Magnitude > 85 then v187 = v187.Unit * 85 end
                    if ap_u1.Position.Y < ap_u10 then
                        ap_u1.Position = Vector3.new(ap_u1.Position.X, ap_u10, ap_u1.Position.Z)
                    end
                    KickBallAP:FireServer(ap_u1.Position, v187, v182, Magnitude, kickKey)
                    ap_startAnimation(ap_u1.Position, v187, v182, Vector3.new(0, 0, 0), ap_u4)
                end
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    pcall(ap_createBall)
    pcall(touchDetectAimPass)
end)

local pendingPassVelocity = nil
local pendingPassSpin = nil
local pendingPassTime = 0

local hookedFunctions = {}
task.spawn(function()
    for _, func in pairs(getgc(true)) do
        if type(func) == "function" and islclosure(func) and not hookedFunctions[func] then
            local successInfo, info = pcall(debug.getinfo, func)
            if successInfo and info and info.numparams == 3 then
                local successConst, constants = pcall(debug.getconstants, func)
                if successConst and type(constants) == "table" then
                    for _, val in pairs(constants) do
                        if val == 161.748 or val == 23.443 or val == -45 then
                            hookedFunctions[func] = true
                            local oldRecordAnimation
                            oldRecordAnimation = hookfunction(func, function(pos, velocity, spin)
                                if Config.Enabled and pendingPassVelocity and (tick() - pendingPassTime < 0.5) then
                                    velocity = pendingPassVelocity
                                    spin = pendingPassSpin
                                    pendingPassVelocity = nil
                                end
                                return oldRecordAnimation(pos, velocity, spin)
                            end)
                            break
                        end
                    end
                end
            end
        end
    end
end)

ap_startAnimation = function(p153, p154, p155, p156, p157)
    pendingPassVelocity = p154
    pendingPassSpin = p155
    pendingPassTime = tick()
end

end) -- end task.spawn AimPass
