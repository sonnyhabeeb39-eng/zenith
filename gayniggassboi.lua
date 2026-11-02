local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local CONFIG_VERSION = 7
local CONFIG_FOLDER = "Scarlet_Configs"
local CONFIG_FILE = CONFIG_FOLDER .. "/default.json"

local function round01(v) return math.floor(v * 10 + 0.5) / 10 end

local function ensureConfigFolder()
	if isfolder and writefile and not isfolder(CONFIG_FOLDER) then pcall(function() makefolder(CONFIG_FOLDER) end) end
end

local function saveConfigToDisk(data)
	ensureConfigFolder()
	if writefile and HttpService then pcall(function() writefile(CONFIG_FILE, HttpService:JSONEncode(data)) end) end
end

local function loadConfigFromDisk()
	ensureConfigFolder()
	if isfile and readfile and HttpService then
		local ok = pcall(function() return isfile(CONFIG_FILE) end)
		if ok and isfile(CONFIG_FILE) then
			local readOk, content = pcall(function() return readfile(CONFIG_FILE) end)
			if readOk and content then
				local decodeOk, decoded = pcall(function() return HttpService:JSONDecode(content) end)
				if decodeOk and type(decoded) == "table" and decoded._v == CONFIG_VERSION then return decoded end
			end
		end
	end
	return nil
end

local persisted = loadConfigFromDisk() or {}
getgenv()._lastEnabledFeature = getgenv()._lastEnabledFeature or nil

getgenv().JuggleV2Config = getgenv().JuggleV2Config or {
	enabled = persisted.juggleV2 and persisted.juggleV2.enabled or false,
	reach = persisted.juggleV2 and persisted.juggleV2.reach or 7.5,
	forceSpeed = persisted.juggleV2 and persisted.juggleV2.forceSpeed or 24,
}
local juggleV2 = getgenv().JuggleV2Config

getgenv().BallReach = getgenv().BallReach or {
	enabled = persisted.sneaky and persisted.sneaky.enabled or false,
	reach = persisted.sneaky and persisted.sneaky.reach or 4.1,
	heightLevel = persisted.sneaky and persisted.sneaky.heightLevel or "High",
	aimBias = 0.7,
	airOnly = true,
}
local c = getgenv().BallReach

getgenv().SneakyV2Config = getgenv().SneakyV2Config or {
	enabled = persisted.sneakyV2 and persisted.sneakyV2.enabled or false,
	reach = persisted.sneakyV2 and persisted.sneakyV2.reach or 4.1,
	buffer = 0.45,
	yDrop = 0.0,
}
local sneakyV2 = getgenv().SneakyV2Config

local HEIGHT_STUDS = { ["Low"] = 8.0, ["High"] = 10.5, ["Extra High"] = 14.5 }
if not HEIGHT_STUDS[c.heightLevel] then c.heightLevel = "High" end
local GRAVITY = 55
local BALL_FLOOR = 5.473
local function vyForLevel(level) return math.sqrt(2 * GRAVITY * (HEIGHT_STUDS[level] or HEIGHT_STUDS["High"])) end

getgenv().LobShotConfig = getgenv().LobShotConfig or { enabled = false, reach = 4.5, heightLevel = "High", aimBias = 0.70, powerBoost = 0 }
local lobCfg = getgenv().LobShotConfig
local LOB_HEIGHT_STUDS = { ["Low"] = 5.0, ["Medium"] = 9.0, ["High"] = 13.0, ["Very High"] = 20.0 }
local function lobVyForLevel(level) return math.sqrt(2 * GRAVITY * (LOB_HEIGHT_STUDS[level] or LOB_HEIGHT_STUDS["High"])) end
getgenv().LobShotKickWalkSpeed = 23
getgenv().LobShotState = getgenv().LobShotState or {}
local LOB_STATE = getgenv().LobShotState
LOB_STATE.active = false
getgenv().SneakyKickWalkSpeed = 23
getgenv().SneakyState = getgenv().SneakyState or {}
local STATE = getgenv().SneakyState
STATE.reachActive = false

getgenv().AutoJuggleV1 = getgenv().AutoJuggleV1 or {
	enabled = persisted.juggle and persisted.juggle.enabled or false,
	reach = persisted.juggle and persisted.juggle.reach or 4.1,
}
getgenv().PokersConfig = getgenv().PokersConfig or { enabled = false, forceSpeed = 16 }
getgenv().JuvsReachConfig = getgenv().JuvsReachConfig or {
	Enabled = persisted.groundShots and persisted.groundShots.Enabled or false,
	Range = persisted.groundShots and persisted.groundShots.Range or 3.5,
}
getgenv().MeasureLagEnabled = false
getgenv().ReachConfig = getgenv().ReachConfig or {
	enabled = persisted.reach and persisted.reach.enabled or false,
	range = persisted.reach and persisted.reach.range or 3.5,
	forceField = 10,
	cancelPower = 10,
}
getgenv().RainbowFlickConfig = getgenv().RainbowFlickConfig or {
	enabled = persisted.rainbowFlick and persisted.rainbowFlick.enabled or false,
	reachScale = persisted.rainbowFlick and persisted.rainbowFlick.reachScale or 3.5,
}
getgenv().ShowRainbowFlickEnabled = false
getgenv().HairChanger = getgenv().HairChanger or { currentHairId = nil }
local HairConfig = getgenv().HairChanger
getgenv().ShirtChanger = getgenv().ShirtChanger or { currentNumber = nil, currentName = nil, currentClan = nil }
local ShirtConfig = getgenv().ShirtChanger
getgenv().NeroConfig = getgenv().NeroConfig or { enabled = false }
getgenv().NeroGUI = getgenv().NeroGUI or { visible = false }
getgenv().AutoSave = getgenv().AutoSave or { enabled = persisted.saveFarm and persisted.saveFarm.enabled or false }
getgenv().VelocityConfig = getgenv().VelocityConfig or {
	enabled = persisted.velocity and persisted.velocity.enabled or false,
	multiplier = persisted.velocity and persisted.velocity.multiplier or 1.0,
}
getgenv().AutoScoreConfig = getgenv().AutoScoreConfig or {
	enabled = persisted.autoScore and persisted.autoScore.enabled or false,
	autoEnemy = persisted.autoScore and persisted.autoScore.autoEnemy or false,
	antiAFK = persisted.autoScore and persisted.autoScore.antiAFK or false,
	targetGoal = persisted.autoScore and persisted.autoScore.targetGoal or nil,
}
getgenv().BallTimeConfig = getgenv().BallTimeConfig or {
	enabled = persisted.ballTime and persisted.ballTime.enabled or false,
	multiplier = persisted.ballTime and persisted.ballTime.multiplier or 0.5,
}
getgenv().PerformanceConfig = getgenv().PerformanceConfig or {
	maxFps = persisted.performance and persisted.performance.maxFps or 120,
	minFps = 60,
	boostFps = persisted.performance and persisted.performance.boostFps or true,
	reduceLatency = persisted.performance and persisted.performance.reduceLatency or false,
	disableShadows = persisted.performance and persisted.performance.disableShadows or false,
	disableParticles = persisted.performance and persisted.performance.disableParticles or false,
	lowerTextures = persisted.performance and persisted.performance.lowerTextures or false,
	clearTerrain = persisted.performance and persisted.performance.clearTerrain or false,
	reduceSound = persisted.performance and persisted.performance.reduceSound or false,
}
local perf = getgenv().PerformanceConfig

getgenv().AimbotConfig = getgenv().AimbotConfig or {
	enabled = persisted.aimbot and persisted.aimbot.enabled or false,
	autoDetect = true, antiPost = false, topCornerEnabled = true,
	selectedGoal = "Opposition", powerShot = persisted.aimbot and persisted.aimbot.powerShot or false,
}
local cfg = getgenv().AimbotConfig
getgenv().AimbotSync = function(state) cfg.enabled = state end

getgenv().AutoGKV2Config = getgenv().AutoGKV2Config or { enabled = false }
getgenv().AutoGroundSaveConfig = getgenv().AutoGroundSaveConfig or { enabled = false }
getgenv().AutoGKConfig = getgenv().AutoGKConfig or {
	enabled = persisted.autoGK and persisted.autoGK.enabled or false,
	diveSpeed = persisted.autoGK and persisted.autoGK.diveSpeed or 10,
}
getgenv().TouchReachConfig = getgenv().TouchReachConfig or {
	enabled = false, reach = 4.0, spoofTarget = 3.9,
	antiCancel = true, protectBall = true, instantSteal = true,
	naturalSpoof = true, blockDeny = true, visualizer = false,
}
local touchReach = getgenv().TouchReachConfig

local GoalPositions = { A = Vector3.new(-313.13, 10, 92.876), B = Vector3.new(-115.936, 10, 92.876) }
local GRAVITY_AB = 55
local GOAL_CENTER_Z, POST_LEFT_Z, POST_RIGHT_Z, POST_RADIUS = 92.876, 78.036, 107.715, 1.825
local CROSSBAR_Y, TOP_CORNER_Y, MAX_Y_VEL, SIM_DT, SIM_MAX_T, MIN_HSPEED_FRAC, MAX_KICK_POWER = 18, 15.0, 60, 0.020, 4.0, 0.40, 125

local function getMyTeamGoalKey()
	local char = player.Character; if not char then return nil end
	local label
	for _, v in ipairs(char:GetDescendants()) do if v:IsA("TextLabel") and v.Name == "Team" then label = v break end end
	if not label then return nil end
	local teamName = tostring(label.Text):lower():match("^%s*(.-)%s*$")
	local a = ReplicatedStorage:FindFirstChild("NameTeamA"); local b = ReplicatedStorage:FindFirstChild("NameTeamB")
	if not (a and b) then return nil end
	if teamName == tostring(a.Value):lower():match("^%s*(.-)%s*$") then return "A"
	elseif teamName == tostring(b.Value):lower():match("^%s*(.-)%s*$") then return "B" end
	return nil
end

local function detectEnemyGoal(ballPos, origVel)
	if origVel and math.abs(origVel.X) > 1.5 then return (origVel.X < 0) and "A" or "B" end
	local char = player.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then local lx = hrp.CFrame.LookVector.X; if math.abs(lx) > 0.05 then return (lx < 0) and "A" or "B" end end
	return (ballPos.X < -214) and "B" or "A"
end

local function getClosestGoalKey(ballPos)
	return (math.abs(ballPos.X - GoalPositions.A.X) < math.abs(ballPos.X - GoalPositions.B.X)) and "A" or "B"
end

local function simulateCrossing(ballPos, vx0, vy0, vz0, goalX)
	local px, py, pz = ballPos.X, ballPos.Y, ballPos.Z
	local vx, vz, vy = vx0, vz0, vy0
	local sign = (goalX >= ballPos.X) and 1 or -1
	local t, prevX, prevY, prevZ = 0, px, py, pz
	while t < SIM_MAX_T do
		prevX, prevY, prevZ = px, py, pz
		px, pz, py = px + vx * SIM_DT, pz + vz * SIM_DT, py + vy * SIM_DT - 0.5 * GRAVITY_AB * SIM_DT * SIM_DT
		vy = vy - GRAVITY_AB * SIM_DT
		if (sign > 0 and px >= goalX) or (sign < 0 and px <= goalX) then
			local denom = (px - prevX); local f = denom ~= 0 and (goalX - prevX) / denom or 0; f = math.clamp(f, 0, 1)
			return prevY + (py - prevY) * f, prevZ + (pz - prevZ) * f, (t + f * SIM_DT)
		end
		if py < 0 then return nil end
		t = t + SIM_DT
	end
	return nil
end

local function bestStraight(ballPos, goalX, targetZ, totalSpeed)
	local hMinSpeed = totalSpeed * MIN_HSPEED_FRAC
	local maxVy = math.min(MAX_Y_VEL, math.sqrt(math.max(totalSpeed^2 - hMinSpeed^2, 0)))
	local dx, dz = goalX - ballPos.X, targetZ - ballPos.Z
	local m = math.sqrt(dx*dx + dz*dz); if m < 1e-6 then return nil, math.huge end
	local ux, uz = dx/m, dz/m; local best, bestErr = nil, math.huge
	local targetY = cfg.topCornerEnabled and TOP_CORNER_Y or 2.0
	for i = 0, 60 do
		local vy = (i/60) * maxVy; local vh = math.sqrt(math.max(totalSpeed^2 - vy^2, 0))
		local cy, cz = simulateCrossing(ballPos, ux*vh, vy, uz*vh, goalX)
		if cy then
			local insideZ = (cz > POST_LEFT_Z + POST_RADIUS + 0.6) and (cz < POST_RIGHT_Z - POST_RADIUS - 0.6)
			local underBar = cy < (CROSSBAR_Y - POST_RADIUS - 0.6)
			local err = math.abs(cy - targetY) * 1.6 + math.abs(cz - targetZ)
			if not insideZ then err = err + 60 end; if not underBar then err = err + 60 end
			if cy < targetY then err = err + (targetY - cy) * 3.0 end
			if err < bestErr then bestErr, best = err, { vx=ux*vh, vy=vy, vz=uz*vh } end
		end
	end
	return best, bestErr
end

local function redirectVelocity(ballPos, origVel)
	local enemyGoal = detectEnemyGoal(ballPos, origVel); cfg.lastDetected = enemyGoal
	local goalKey = (cfg.selectedGoal == "Own Goals") and (getMyTeamGoalKey() or (enemyGoal == "A" and "B" or "A")) or (cfg.autoDetect and getClosestGoalKey(ballPos) or enemyGoal)
	local goalX = GoalPositions[goalKey].X
	local totalSpeed = cfg.powerShot and MAX_KICK_POWER or math.max(math.sqrt(origVel.X^2 + origVel.Y^2 + origVel.Z^2), 50)
	local farIsRight = math.abs(ballPos.Z - POST_RIGHT_Z) >= math.abs(ballPos.Z - POST_LEFT_Z)
	local straightTargetZ = farIsRight and (POST_RIGHT_Z - 3.5) or (POST_LEFT_Z + 3.5)
	local chosen = bestStraight(ballPos, goalX, straightTargetZ, totalSpeed) or bestStraight(ballPos, goalX, GOAL_CENTER_Z, totalSpeed)
	if not chosen then
		local dx, dz = goalX - ballPos.X, GOAL_CENTER_Z - ballPos.Z; local m = math.sqrt(dx*dx + dz*dz)
		local vy = math.min(MAX_Y_VEL, totalSpeed * 0.40); local vh = math.sqrt(math.max(totalSpeed^2 - vy^2, 0))
		return Vector3.new(dx/m*vh, vy, dz/m*vh), Vector3.new(0, 0, 0)
	end
	local vy = chosen.vy
	if (ballPos.Y > 13) and (math.abs(origVel.Y) > 8) then vy = math.min(vy, 30) end
	return Vector3.new(chosen.vx, vy, chosen.vz), Vector3.new(0, 0, 0)
end

local function juggleV2Override(part, realPos)
	if not juggleV2.enabled then return nil end
	local char = player.Character; if not char then return nil end
	local ball = workspace:FindFirstChild("SoccerBall", true); if not ball then return nil end
	local ballPos = ball.Position; local dist = (ballPos - realPos).Magnitude
	if dist > juggleV2.reach or dist <= 0.01 then return nil end
	return Vector3.new(ballPos.X, ballPos.Y - 1.5, ballPos.Z)
end

local GOAL_A_X, GOAL_B_X = -313.13, -115.936
local Z_MIN, Z_MAX = 78.036, 107.715
local GOAL_CENTER_Z_GK = (Z_MIN + Z_MAX) / 2
local GROUND_Y = 5.473
local BOUNCE_DAMP_Y = 0.55
local CROSSBAR_Y_GK = 18
local THREAT_WINDOW = 7.5
local GOAL_OFFSET = -0.5
local Z_SAVE_MIN = Z_MIN - 2.6; local Z_SAVE_MAX = Z_MAX + 2.6
local Y_SAVE_MAX = CROSSBAR_Y_GK + 0.6; local STAND_REACH_Y = GROUND_Y + 5.5
local smoothVelocity = Vector3.zero

getgenv().RawBallData = { pos = nil, vel = nil, time = 0 }
local function initBallRemoteHook()
	for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
		if r:IsA("RemoteEvent") and (r.Name == "BallPositionEvent" or r.Name == "MeasureLagEvent") then
			r.OnClientEvent:Connect(function(...)
				local args = {...}
				for _, arg in ipairs(args) do
					if typeof(arg) == "Vector3" then
						getgenv().RawBallData.pos = arg; getgenv().RawBallData.time = tick()
					elseif typeof(arg) == "table" then
						for _, v in pairs(arg) do if typeof(v) == "Vector3" then getgenv().RawBallData.pos = v; getgenv().RawBallData.time = tick() end end
					end
				end
			end)
		end
	end
end
task.spawn(initBallRemoteHook)

local function SimulateExactGamePhysics(ballPos, ballVel, ballRotVel, goalLineX)
	if math.abs(ballVel.X) < 0.2 then return nil end
	if (ballVel.X < 0) ~= (goalLineX < ballPos.X) then return nil end
	local ping = player:GetNetworkPing()
	local compPos = ballPos + (ballVel * ping)
	compPos = Vector3.new(compPos.X, compPos.Y - (0.5 * 55 * (ping^2)), compPos.Z)
	local totalTime, bounces, flightTime = 0, 0, 0
	local sPx, sPy, sPz = compPos.X, compPos.Y, compPos.Z
	local sVx, sVy, sVz = ballVel.X, ballVel.Y, ballVel.Z
	local curveFactor = ballRotVel.Y / -45
	local prevX, prevY, prevZ = sPx, sPy, sPz
	local trajectory = {}
	table.insert(trajectory, {x=sPx, y=sPy, z=sPz, t=0, vy=sVy, b=0})
	local crossedGoal = false
	for _ = 1, 2000 do
		flightTime = flightTime + 0.005; totalTime = totalTime + 0.005
		local angle = curveFactor * flightTime
		local curVx = sVx * math.cos(angle) - sVz * math.sin(angle)
		local curVz = sVx * math.sin(angle) + sVz * math.cos(angle)
		local npx = sPx + sVx * flightTime + 0.5 * (curVx - sVx) * flightTime
		local npy = sPy + sVy * flightTime - 0.5 * 55 * (flightTime^2)
		local npz = sPz + sVz * flightTime + 0.5 * (curVz - sVz) * flightTime
		local nvy = sVy - 55 * flightTime
		table.insert(trajectory, {x=npx, y=npy, z=npz, t=totalTime, vy=nvy, b=bounces})
		if (prevX <= goalLineX and npx >= goalLineX) or (prevX >= goalLineX and npx <= goalLineX) then crossedGoal = true; break end
		if npy < GROUND_Y then
			bounces = bounces + 1
			local dampXZ = math.abs(nvy) < 10 and 0.99 or 0.80
			sVx, sVz = curVx * dampXZ, curVz * dampXZ
			sVy = math.abs(nvy) * BOUNCE_DAMP_Y
			sPx, sPy, sPz = npx, GROUND_Y, npz
			local rotImpact = (Vector3.new(0,1,0)):Cross(Vector3.new(curVx,0,curVz).Unit).Unit * (math.sqrt(curVx^2+curVz^2)*0.8/1.5)
			curveFactor = (rotImpact.Y + (curveFactor * -45 * 0.8)) / -45
			flightTime = 0; npx, npy, npz = sPx, sPy, sPz
		end
		prevX, prevY, prevZ = npx, npy, npz
		if (curVx^2 + nvy^2 + curVz^2) < 0.09 or totalTime > THREAT_WINDOW then break end
	end
	return crossedGoal and trajectory or nil
end

local function GetStateAtX(trajectory, targetX)
	if not trajectory or #trajectory == 0 then return nil end
	local prev = trajectory[1]
	for i = 2, #trajectory do
		local cur = trajectory[i]
		if (prev.x <= targetX and cur.x >= targetX) or (prev.x >= targetX and cur.x <= targetX) then
			local frac = math.abs(targetX - prev.x) / math.max(math.abs(cur.x - prev.x), 0.0001)
			return {
				x = targetX,
				y = math.max(prev.y + (cur.y - prev.y) * frac, GROUND_Y),
				z = prev.z + (cur.z - prev.z) * frac,
				t = prev.t + (cur.t - prev.t) * frac,
				vy = prev.vy + (cur.vy - prev.vy) * frac,
				b = cur.b
			}
		end
		prev = cur
	end
	return nil
end

local cachedBall = nil
local function GetBall()
	if not cachedBall or not cachedBall:IsDescendantOf(workspace) then
		local f = workspace:FindFirstChild("FootballField")
		cachedBall = f and f:FindFirstChild("SoccerBall")
	end
	return cachedBall
end

RunService.Heartbeat:Connect(function()
	if not getgenv().AutoGKConfig.enabled and not getgenv().AutoGroundSaveConfig.enabled then return end
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChild("Humanoid")
	local ball = GetBall()
	if not hrp or not hum then
		if hrp and hrp:FindFirstChild("GK_V") then hrp.GK_V.Enabled = false; hrp.GK_R.Enabled = false; hum.AutoRotate = true end
		return
	end
	if not hrp:FindFirstChild("GK_V") then
		local att = Instance.new("Attachment", hrp); att.Name = "GK_A"
		local lvI = Instance.new("LinearVelocity", hrp); lvI.Name = "GK_V"; lvI.Attachment0 = att
		lvI.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector; lvI.ForceLimitMode = Enum.ForceLimitMode.PerAxis
		local aoI = Instance.new("AlignOrientation", hrp); aoI.Name = "GK_R"; aoI.Attachment0 = att
		aoI.Mode = Enum.OrientationAlignmentMode.OneAttachment; aoI.MaxTorque = math.huge; aoI.Responsiveness = 40
	end
	local lv, ao = hrp.GK_V, hrp.GK_R
	if not ball then lv.Enabled = false; ao.Enabled = false; hum.AutoRotate = true; return end
	local rawGoalX = (math.abs(hrp.Position.X - GOAL_A_X) < math.abs(hrp.Position.X - GOAL_B_X)) and GOAL_A_X or GOAL_B_X
	local dir = (rawGoalX < -200) and 1 or -1
	local goalX = rawGoalX + (GOAL_OFFSET * dir)
	local ballPos = ball.Position
	local vel = ball.AssemblyLinearVelocity; local rotVel = ball.AssemblyAngularVelocity
	if getgenv().RawBallData and getgenv().RawBallData.pos and (tick() - getgenv().RawBallData.time < 0.1) then
		ballPos = getgenv().RawBallData.pos
	end
	local isShotOnTarget, timeToGoal = false, 999
	local targetZ, predY = GOAL_CENTER_Z_GK, GROUND_Y
	local targetX = goalX + dir * 0.5
	local ballHeading = ((rawGoalX == GOAL_A_X) and vel.X < 0) or ((rawGoalX == GOAL_B_X) and vel.X > 0)
	local ballBehind = (dir == 1 and ballPos.X < hrp.Position.X) or (dir == -1 and ballPos.X > hrp.Position.X)
	local trajectory = nil
	if ballHeading and not ballBehind then trajectory = SimulateExactGamePhysics(ballPos, vel, rotVel, rawGoalX) end
	local goalState = trajectory and GetStateAtX(trajectory, rawGoalX) or nil
	if goalState and goalState.t < THREAT_WINDOW then
		timeToGoal = goalState.t
		if goalState.z >= Z_SAVE_MIN and goalState.z <= Z_SAVE_MAX and goalState.y <= Y_SAVE_MAX then
			isShotOnTarget = true; targetZ = goalState.z; predY = goalState.y
		end
	end
	local isActivelySaving = isShotOnTarget and timeToGoal <= 1.6
	if not isActivelySaving then lv.Enabled = false; ao.Enabled = false; hum.AutoRotate = true; smoothVelocity = Vector3.zero; return end
	local st = hum:GetState()
	local onGround = st ~= Enum.HumanoidStateType.Jumping and st ~= Enum.HumanoidStateType.Freefall
	if onGround and getgenv().AutoGKConfig.enabled and predY >= STAND_REACH_Y and timeToGoal <= 0.6 then
		hum.Jump = true; hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	local canGroundSave = getgenv().AutoGroundSaveConfig.enabled and onGround
	local canDive = getgenv().AutoGKConfig.enabled and not onGround
	if not canGroundSave and not canDive then lv.Enabled = false; ao.Enabled = false; hum.AutoRotate = true; smoothVelocity = Vector3.zero; return end
	if canGroundSave then hum.WalkSpeed = 23 end
	lv.Enabled = true; ao.Enabled = true; hum.AutoRotate = false
	lv.MaxAxesForce = Vector3.new(5000000, 0, 5000000)
	local lungeVec = Vector3.new(targetX, hrp.Position.Y, targetZ) - hrp.Position
	local desiredVel = Vector3.zero
	if lungeVec.Magnitude > 0.05 then
		desiredVel = lungeVec * 50
		if desiredVel.Magnitude > getgenv().AutoGKConfig.diveSpeed then desiredVel = desiredVel.Unit * getgenv().AutoGKConfig.diveSpeed end
	end
	smoothVelocity = smoothVelocity + (desiredVel - smoothVelocity) * 1.0
	lv.VectorVelocity = smoothVelocity
	local lookDir = Vector3.new(ballPos.X, hrp.Position.Y, ballPos.Z) - hrp.Position
	if lookDir.Magnitude > 0.1 then ao.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + lookDir.Unit * 10) end
end)

local cachedFieldForJuggle, cachedBallForJuggle, lastCacheCheckJuggle = nil, nil, 0
local function getBallDirect()
	local now = os.clock()
	if now - lastCacheCheckJuggle > 0.3 then
		lastCacheCheckJuggle = now
		cachedFieldForJuggle = workspace:FindFirstChild("FootballField")
		cachedBallForJuggle = cachedFieldForJuggle and cachedFieldForJuggle:FindFirstChild("SoccerBall")
		if not cachedBallForJuggle then cachedBallForJuggle = workspace:FindFirstChild("SoccerBall") end
	end
	return cachedBallForJuggle
end

local function isAirborne()
	local char = player.Character; if not char then return false end
	local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return false end
	if hum.FloorMaterial == Enum.Material.Air then return true end
	local s = hum:GetState()
	return s == Enum.HumanoidStateType.Freefall or s == Enum.HumanoidStateType.Jumping
end

local function LobShotComputeSpoof(realPos)
	LOB_STATE.active = false
	if not lobCfg.enabled then return realPos end
	local char = player.Character; if not char then return realPos end
	local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return realPos end
	local ball = getBallDirect(); if not ball or not ball:IsA("BasePart") then return realPos end
	local ballPos = ball.Position
	if ballPos.Y < BALL_FLOOR - 1 then return realPos end
	local dist = (ballPos - realPos).Magnitude
	if dist <= 0 or dist > lobCfg.reach then return realPos end
	local flat = Vector3.new(ballPos.X - realPos.X, 0, ballPos.Z - realPos.Z)
	local look = hrp.CFrame.LookVector; local flatLook = Vector3.new(look.X, 0, look.Z)
	local contactDir = flat.Magnitude > 0.05 and flat.Unit or (flatLook.Magnitude > 0.05 and flatLook.Unit or Vector3.new(0,0,1))
	if flatLook.Magnitude > 0.05 then flatLook = flatLook.Unit; if (contactDir.X*flatLook.X+contactDir.Z*flatLook.Z) < -0.1 then return realPos end end
	local dir = contactDir
	if flatLook.Magnitude > 0.05 then
		local bias = math.clamp(lobCfg.aimBias or 0.70, 0, 1)
		local mixed = Vector3.new((1-bias)*contactDir.X+bias*flatLook.X, 0, (1-bias)*contactDir.Z+bias*flatLook.Z)
		if mixed.Magnitude > 0.01 then dir = mixed.Unit end
	end
	local targetVy = math.clamp(lobVyForLevel(lobCfg.heightLevel), 0, 40)
	local U = flatLook.Magnitude < 0.5 and dir or flatLook
	local cosTheta = math.clamp(dir.X*U.X+dir.Z*U.Z, -1, 1)
	local merges = cosTheta >= 0.93969
	local bv = ball.Velocity; local horiz = math.sqrt(bv.X*bv.X+bv.Z*bv.Z)
	local needed = targetVy*(merges and 1.49 or 1.05)
	local baseWanted = math.clamp(needed-horiz, 40, 80)
	getgenv().LobShotKickWalkSpeed = 19+(baseWanted-40)/10
	local power = math.min(baseWanted+horiz, 85); if power < 1 then power = 1 end
	local q = math.clamp(targetVy/power, 0, 0.999); local s
	if merges then
		local lo, hi = 0.0, 0.999
		for _ = 1, 30 do local mid=(lo+hi)*0.5; local c_val=math.sqrt(math.max(1-mid*mid,0)); if (mid/math.sqrt(2+2*cosTheta*c_val))<q then lo=mid else hi=mid end end
		s = (lo+hi)*0.5
	else s = q end
	local cosP = math.sqrt(math.max(1-s*s,0))
	local launchDir = Vector3.new(dir.X*cosP, s, dir.Z*cosP)
	local k = 1.8; local spoofTorso = (ballPos - launchDir*k) - Vector3.new(0,1.3,0)
	if (ballPos-spoofTorso).Magnitude > 3.9 then spoofTorso = (ballPos-launchDir*1.2)-Vector3.new(0,1.3,0) end
	LOB_STATE.active = true
	return spoofTorso
end

local function SneakyComputeSpoof(realPos)
	STATE.reachActive = false
	if not c.enabled then return realPos end
	if c.airOnly and not isAirborne() then return realPos end
	local char = player.Character; if not char then return realPos end
	local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return realPos end
	local ball = getBallDirect(); if not ball or not ball:IsA("BasePart") then return realPos end
	local ballPos = ball.Position
	if ballPos.Y < BALL_FLOOR - 1 then return realPos end
	local dist = (ballPos - realPos).Magnitude
	if dist <= 0 or dist > c.reach then return realPos end
	local flat = Vector3.new(ballPos.X-realPos.X, 0, ballPos.Z-realPos.Z)
	local look = hrp.CFrame.LookVector; local flatLook = Vector3.new(look.X, 0, look.Z)
	local contactDir = flat.Magnitude > 0.05 and flat.Unit or (flatLook.Magnitude > 0.05 and flatLook.Unit or Vector3.new(0,0,1))
	if flatLook.Magnitude > 0.05 then flatLook = flatLook.Unit; if (contactDir.X*flatLook.X+contactDir.Z*flatLook.Z)<-0.1 then return realPos end end
	local dir = contactDir
	if flatLook.Magnitude > 0.05 then
		local bias = math.clamp(c.aimBias or 0.7, 0, 1)
		local mixed = Vector3.new((1-bias)*contactDir.X+bias*flatLook.X, 0, (1-bias)*contactDir.Z+bias*flatLook.Z)
		if mixed.Magnitude > 0.01 then dir = mixed.Unit end
	end
	local targetVy = math.clamp(vyForLevel(c.heightLevel), 0, 40)
	local U = flatLook.Magnitude < 0.5 and dir or flatLook
	local cosTheta = math.clamp(dir.X*U.X+dir.Z*U.Z, -1, 1)
	local merges = cosTheta >= 0.93969
	local bv = ball.Velocity; local horiz = math.sqrt(bv.X*bv.X+bv.Z*bv.Z)
	local needed = targetVy*(merges and 1.49 or 1.05)
	local baseWanted = math.clamp(needed-horiz, 40, 80)
	getgenv().SneakyKickWalkSpeed = 19+(baseWanted-40)/10
	local power = math.min(baseWanted+horiz, 85); if power < 1 then power = 1 end
	local q = math.clamp(targetVy/power, 0, 0.999); local s
	if merges then
		local lo, hi = 0.0, 0.999
		for _ = 1, 30 do local mid=(lo+hi)*0.5; local c_val=math.sqrt(math.max(1-mid*mid,0)); if (mid/math.sqrt(2+2*cosTheta*c_val))<q then lo=mid else hi=mid end end
		s = (lo+hi)*0.5
	else s = q end
	local cosP = math.sqrt(math.max(1-s*s,0))
	local launchDir = Vector3.new(dir.X*cosP, s, dir.Z*cosP)
	local k = 1.8; local spoofTorso = (ballPos-launchDir*k)-Vector3.new(0,1.3,0)
	if (ballPos-spoofTorso).Magnitude > 3.9 then spoofTorso = (ballPos-launchDir*1.2)-Vector3.new(0,1.3,0) end
	STATE.reachActive = true
	return spoofTorso
end

local function shouldSpoofPulse(part)
	if not part or not part:IsA("BasePart") then return false end
	local name = part.Name
	if name=="Torso" or name=="UpperTorso" or name=="LowerTorso" or name=="HumanoidRootPart" or name=="Head" then return true end
	if name:find("Leg") or name:find("Foot") or name:find("Hand") or name:find("Arm") then return true end
	return false
end

local function reachPositionOverride(part, realPos)
	local rc = getgenv().ReachConfig; if not rc.enabled then return nil end
	local ball = getBallDirect(); if not ball or not ball.Parent then return nil end
	local ok, ballPos = pcall(function() return ball.Position end); if not ok or not ballPos then return nil end
	local dx=ballPos.X-realPos.X; local dy=ballPos.Y-realPos.Y; local dz=ballPos.Z-realPos.Z
	local magnitude = math.sqrt(dx*dx+dy*dy+dz*dz)
	if magnitude > rc.range or magnitude <= 0.01 then return nil end
	local standoff = 0.55; local flatMag = math.sqrt(dx*dx+dz*dz)
	if flatMag <= standoff then return nil end
	local flatX, flatZ = dx/flatMag, dz/flatMag
	local excess = flatMag-standoff; local pullFrac = 0.45+(rc.cancelPower/10)*0.25
	local newFlat = flatMag-excess*pullFrac; if newFlat < standoff then newFlat = standoff end
	if newFlat >= flatMag-0.02 then return nil end
	local ballVel = ball.AssemblyLinearVelocity; local awaySpeed = ballVel.X*flatX+ballVel.Z*flatZ
	if awaySpeed > 3 then newFlat = math.min(flatMag, newFlat+awaySpeed*0.015) end
	local targetX = ballPos.X-flatX*newFlat; local targetZ = ballPos.Z-flatZ*newFlat
	local targetY = realPos.Y; if part.Name=="Head" then targetY = math.min(realPos.Y, ballPos.Y) end
	return Vector3.new(targetX, targetY, targetZ)
end

local function rainbowFlickOverride(part, realPos)
	local rf = getgenv().RainbowFlickConfig; if not rf.enabled then return nil end
	local ball = getBallDirect(); if not ball then return nil end
	local ok, ballPos = pcall(function() return ball.Position end); if not ok or not ballPos then return nil end
	local dx=ballPos.X-realPos.X; local dy=ballPos.Y-realPos.Y; local dz=ballPos.Z-realPos.Z
	local magnitude = math.sqrt(dx*dx+dy*dy+dz*dz)
	if magnitude > rf.reachScale*1.25 or magnitude <= 0.1 then return nil end
	return Vector3.new(ballPos.X, ballPos.Y-3, ballPos.Z)
end

local function groundShotsOverride(part, realPos)
	if not getgenv().JuvsReachConfig.Enabled then return nil end
	local ball = getBallDirect(); if not ball then return nil end
	local ballPos = ball.Position
	local dx=ballPos.X-realPos.X; local dy=ballPos.Y-realPos.Y; local dz=ballPos.Z-realPos.Z
	local magnitude = math.sqrt(dx*dx+dy*dy+dz*dz)
	if magnitude > getgenv().JuvsReachConfig.Range or magnitude <= 0.6 then return nil end
	local flatMag = math.sqrt(dx*dx+dz*dz); if flatMag <= 0.6 then return nil end
	local flatX, flatZ = dx/flatMag, dz/flatMag; local standoff = 0.55
	local newFlat = flatMag > standoff and flatMag-(flatMag-standoff)*0.45 or flatMag
	return Vector3.new(ballPos.X-flatX*newFlat, realPos.Y, ballPos.Z-flatZ*newFlat)
end

local function sneakyV2Override(part, realPos)
	if not sneakyV2.enabled then return nil end
	local charNode = player.Character; if not charNode then return nil end
	local ball = getBallDirect(); if not ball then return nil end
	local ballPos = ball.Position
	local dx=ballPos.X-realPos.X; local dy=ballPos.Y-realPos.Y; local dz=ballPos.Z-realPos.Z
	local magnitude = math.sqrt(dx*dx+dy*dy+dz*dz)
	if magnitude > sneakyV2.reach then return nil end
	local rootPart = charNode:FindFirstChild("HumanoidRootPart"); local hum = charNode:FindFirstChildOfClass("Humanoid")
	if not (rootPart and hum) then return nil end
	local rawMove = hum.MoveDirection; local moveDirection = Vector3.new(rawMove.X,0,rawMove.Z); local moveLen = moveDirection.Magnitude
	local isMoving = moveLen > 0.05; local lookVector = rootPart.CFrame.LookVector
	local lookDirX, lookDirZ = lookVector.X, lookVector.Z; local lookLen = math.sqrt(lookDirX*lookDirX+lookDirZ*lookDirZ)
	if lookLen > 0 then lookDirX, lookDirZ = lookDirX/lookLen, lookDirZ/lookLen else lookDirX, lookDirZ = 0, 1 end
	local alignment = isMoving and ((moveDirection.X/moveLen)*lookDirX+(moveDirection.Z/moveLen)*lookDirZ) or 0
	local speedFactor = isMoving and math.clamp(moveLen,1.2,2.5) or 1
	local dynamicModifier = 1.1+(alignment*0.45)*speedFactor
	local bx = lookDirX*(0.45*dynamicModifier); local bz = lookDirZ*(0.45*dynamicModifier)
	return Vector3.new(ballPos.X-bx, realPos.Y, ballPos.Z-bz)
end

local function juggleOverride(part, realPos)
	if not getgenv().AutoJuggleV1.enabled then return nil end
	local charNode = player.Character; if not charNode then return nil end
	local ball = getBallDirect(); if not ball then return nil end
	local ballPos = ball.Position
	local dx=ballPos.X-realPos.X; local dy=ballPos.Y-realPos.Y; local dz=ballPos.Z-realPos.Z
	local mag = math.sqrt(dx*dx+dy*dy+dz*dz)
	if mag > getgenv().AutoJuggleV1.reach or mag <= 0.01 then return nil end
	local rootPart = charNode:FindFirstChild("HumanoidRootPart"); local hum = charNode:FindFirstChildOfClass("Humanoid")
	if not (rootPart and hum) then return nil end
	local rawMove = hum.MoveDirection; local moveDirection = Vector3.new(rawMove.X,0,rawMove.Z); local moveLen = moveDirection.Magnitude
	local isMoving = moveLen > 0.05; local lookVector = rootPart.CFrame.LookVector
	local lookDirX, lookDirZ = lookVector.X, lookVector.Z; local lookLen = math.sqrt(lookDirX*lookDirX+lookDirZ*lookDirZ)
	if lookLen > 0 then lookDirX, lookDirZ = lookDirX/lookLen, lookDirZ/lookLen else lookDirX, lookDirZ = 0, 1 end
	local alignment = isMoving and ((moveDirection.X/moveLen)*lookDirX+(moveDirection.Z/moveLen)*lookDirZ) or 0
	local speedFactor = isMoving and math.clamp(moveLen,1.2,2.5) or 1
	local dynamicModifier = 1.1+(alignment*0.45)*speedFactor
	return Vector3.new(
		ballPos.X-(dx/math.max(mag,0.01))*(0.18*dynamicModifier),
		realPos.Y,
		ballPos.Z-(dz/math.max(mag,0.01))*(0.18*dynamicModifier)
	)
end

local noCollides = {}
local currentPokerBall = nil

local function clearNoclip()
	for _, nc in ipairs(noCollides) do if nc and nc.Parent then pcall(function() nc:Destroy() end) end end
	noCollides = {}
end

local function buildNoclip(chr, ball)
	clearNoclip()
	if not chr or not ball then return end
	for _, d in ipairs(chr:GetDescendants()) do
		if d:IsA("BasePart") then
			local ncc = Instance.new("NoCollisionConstraint"); ncc.Part0 = d; ncc.Part1 = ball; ncc.Parent = d
			table.insert(noCollides, ncc)
		end
	end
end

local function refreshNoclip()
	if not getgenv().PokersConfig.enabled then clearNoclip(); currentPokerBall = nil; return end
	local chr = player.Character; if not chr then return end
	local ball = getBallDirect(); if not ball then clearNoclip(); currentPokerBall = nil; return end
	if ball ~= currentPokerBall then currentPokerBall = ball; buildNoclip(chr, ball) end
end

RunService.Heartbeat:Connect(function()
	if getgenv().PokersConfig.enabled then
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum and hum.WalkSpeed ~= getgenv().PokersConfig.forceSpeed then hum.WalkSpeed = getgenv().PokersConfig.forceSpeed end
		if not currentPokerBall or not currentPokerBall.Parent then refreshNoclip() end
	else
		if #noCollides > 0 then clearNoclip() end
	end
end)

player.CharacterAdded:Connect(function(chr)
	clearNoclip(); currentPokerBall = nil
	chr.DescendantAdded:Connect(function(d)
		if d:IsA("BasePart") and getgenv().PokersConfig.enabled and currentPokerBall and currentPokerBall.Parent then
			local ncc = Instance.new("NoCollisionConstraint"); ncc.Part0 = d; ncc.Part1 = currentPokerBall; ncc.Parent = d
			table.insert(noCollides, ncc)
		end
	end)
end)

local oldIndex_main
local function installMainHook()
	oldIndex_main = hookmetamethod(game, "__index", function(self, key)
		if key ~= "Position" and key ~= "WalkSpeed" then return oldIndex_main(self, key) end
		if key == "WalkSpeed" then
			if juggleV2.enabled then
				local ok, isHum = pcall(function() return player.Character and self == player.Character:FindFirstChildOfClass("Humanoid") end)
				if ok and isHum then return juggleV2.forceSpeed end
			end
			if LOB_STATE.active then
				local ok, isHum = pcall(function() return player.Character and self == player.Character:FindFirstChildOfClass("Humanoid") end)
				if ok and isHum then return getgenv().LobShotKickWalkSpeed or 23 end
			end
			if STATE.reachActive then
				local ok, isHum = pcall(function() return player.Character and self == player.Character:FindFirstChildOfClass("Humanoid") end)
				if ok and isHum then return getgenv().SneakyKickWalkSpeed or 23 end
			end
			if getgenv().PokersConfig.enabled then
				local ok, isHum = pcall(function() return player.Character and self == player.Character:FindFirstChildOfClass("Humanoid") end)
				if ok and isHum then return getgenv().PokersConfig.forceSpeed end
			end
			return oldIndex_main(self, key)
		end
		local charNode = player.Character
		if not charNode or self.Parent ~= charNode then return oldIndex_main(self, key) end
		if not shouldSpoofPulse(self) then return oldIndex_main(self, key) end
		local name = self.Name
		local isTorso = (name=="UpperTorso" or name=="LowerTorso" or name=="HumanoidRootPart" or name=="Head")
		local realPos = oldIndex_main(self, key)
		local lastFeature = getgenv()._lastEnabledFeature

		if juggleV2.enabled and isTorso then
			local r = juggleV2Override(self, realPos); if r then return r end
		end
		if lastFeature == "juggle" and isTorso then
			local r = juggleOverride(self, realPos); if r then return r end
		elseif lastFeature == "sneakyV2" and isTorso then
			local r = sneakyV2Override(self, realPos); if r then return r end
		elseif lastFeature == "groundShots" and isTorso then
			local r = groundShotsOverride(self, realPos); if r then return r end
		elseif lastFeature == "rainbowFlick" then
			local r = rainbowFlickOverride(self, realPos); if r then return r end
		elseif lastFeature == "reach" then
			local r = reachPositionOverride(self, realPos); if r then return r end
		elseif lastFeature == "sneaky" and isTorso then
			local r = SneakyComputeSpoof(realPos); if r and r ~= realPos then return r end
		elseif lastFeature == "lobShot" and isTorso then
			local r = LobShotComputeSpoof(realPos); if r and r ~= realPos then return r end
		else
			if isTorso and lobCfg.enabled then local r = LobShotComputeSpoof(realPos); if r and r ~= realPos then return r end end
			if isTorso and c.enabled then local r = SneakyComputeSpoof(realPos); if r and r ~= realPos then return r end else STATE.reachActive = false end
			if isTorso and sneakyV2.enabled then local r = sneakyV2Override(self, realPos); if r then return r end end
			local r = rainbowFlickOverride(self, realPos); if r then return r end
			r = reachPositionOverride(self, realPos); if r then return r end
			if isTorso then r = groundShotsOverride(self, realPos); if r then return r end end
			if isTorso then r = juggleOverride(self, realPos); if r then return r end end
		end
		return realPos
	end)
end
task.spawn(function() task.wait(1); pcall(installMainHook) end)
player.CharacterAdded:Connect(function() task.wait(1.5); pcall(installMainHook) end)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
	local m = ""; pcall(function() m = getnamecallmethod() or "" end)
	if getgenv().MeasureLagEnabled and (m == "FireServer" or m == "InvokeServer") then
		local ok, n = pcall(function() return self.Name end)
		if ok and (n == "MeasureLagEvent" or n == "MeasureLag") then return end
	end
	if getgenv().JuggleV2Config.enabled and m == "FireServer" then
		local ok, n = pcall(function() return self.Name end)
		if ok and n == "KickBall" then
			local args = {...}
			if typeof(args[1]) == "Vector3" then
				args[2] = Vector3.new(args[2].X, math.max(args[2].Y, 45), args[2].Z)
				return oldNamecall(self, unpack(args))
			end
		end
	end
	return oldNamecall(self, ...)
end)

local humanoid_vel, root_vel
local baseWalkSpeed_vel = 16
local _weAreWriting_vel = false
local function setupVelCharacter(char)
	humanoid_vel = char:WaitForChild("Humanoid")
	root_vel = char:WaitForChild("HumanoidRootPart")
	baseWalkSpeed_vel = humanoid_vel.WalkSpeed
end
if player.Character then pcall(function() setupVelCharacter(player.Character) end) end
player.CharacterAdded:Connect(setupVelCharacter)
if not getgenv()._ScarletVelHooked then
	getgenv()._ScarletVelHooked = true
	local oldNewIndex
	oldNewIndex = hookmetamethod(game, "__newindex", newcclosure(function(self, key, value)
		if key == "WalkSpeed" and self == humanoid_vel then
			if _weAreWriting_vel then return oldNewIndex(self, key, value) end
			baseWalkSpeed_vel = value
			if getgenv().VelocityConfig.enabled then return oldNewIndex(self, key, value * getgenv().VelocityConfig.multiplier) end
			return oldNewIndex(self, key, value)
		end
		return oldNewIndex(self, key, value)
	end))
end
pcall(function() RunService:UnbindFromRenderStep("ScarletVelBypass") end)
RunService:BindToRenderStep("ScarletVelBypass", Enum.RenderPriority.Camera.Value + 1, function()
	if not getgenv().VelocityConfig.enabled or not humanoid_vel then return end
	_weAreWriting_vel = true
	local target = baseWalkSpeed_vel * getgenv().VelocityConfig.multiplier
	if math.abs(humanoid_vel.WalkSpeed - target) > 0.01 then humanoid_vel.WalkSpeed = target end
	_weAreWriting_vel = false
end)

do
	local asCfg = getgenv().AutoScoreConfig
	local KickRemote = ReplicatedStorage:FindFirstChild("KickBall")
	local GoalEvent = ReplicatedStorage:FindFirstChild("GoalEvent")
	local NearGoalEvent = ReplicatedStorage:FindFirstChild("NearGoalEvent")
	if KickRemote and GoalEvent and NearGoalEvent then
		local Goals = { ["A"] = Vector3.new(-320.417,6.306,92.020), ["B"] = Vector3.new(-111.136,6.306,92.689) }
		local lastKick = 0; local CachedTeamLabel = nil
		local function trim(text) return text:match("^%s*(.-)%s*$") end
		local function FindTeamLabel()
			local character = player.Character; if not character then return nil end
			for _, v in pairs(character:GetDescendants()) do if v:IsA("TextLabel") and v.Name == "Team" then return v end end
			return nil
		end
		local function GetEnemyGoal()
			if not CachedTeamLabel or not CachedTeamLabel.Parent then CachedTeamLabel = FindTeamLabel() end
			if not CachedTeamLabel then return nil end
			local myTeamName = trim(CachedTeamLabel.Text:lower())
			local a = ReplicatedStorage:FindFirstChild("NameTeamA"); local b = ReplicatedStorage:FindFirstChild("NameTeamB")
			if not (a and b) then return nil end
			if myTeamName == trim(a.Value:lower()) then return "B" elseif myTeamName == trim(b.Value:lower()) then return "A" end
			return nil
		end
		getgenv().ScoreGoal = function(goal)
			pcall(function()
				NearGoalEvent:FireServer(goal); task.wait(0.02)
				KickRemote:FireServer(Goals[goal], Vector3.new(0,30,0), Vector3.new(0,1,0), 3.8, "djhtelkds"); task.wait(0.02)
				GoalEvent:FireServer(goal)
			end)
		end
		task.spawn(function()
			while true do
				task.wait(0.1)
				if asCfg.enabled then
					local currentTime = tick()
					if currentTime - lastKick >= 0.6 then
						local target = asCfg.autoEnemy and GetEnemyGoal() or asCfg.targetGoal
						if target then lastKick = currentTime; getgenv().ScoreGoal(target) end
					end
				end
			end
		end)
		player.Idled:Connect(function()
			if asCfg.antiAFK then VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end
		end)
	end
end

do
	local asvCfg = getgenv().AutoSave
	local ballPos_as = Vector3.new(-311, 6, 92); local kickDir_as = Vector3.new(50, 5, 0)
	task.spawn(function()
		while true do
			if asvCfg.enabled then
				local KickBall = ReplicatedStorage:FindFirstChild("KickBall")
				if KickBall then
					local field = workspace:FindFirstChild("FootballField")
					local ball = field and field:FindFirstChild("SoccerBall")
					if ball then
						ball.CFrame = CFrame.new(ballPos_as)
						pcall(function() KickBall:FireServer(ballPos_as, kickDir_as, Vector3.new(0,0,0), 3, "djhtelkds") end)
					end
				end
			end
			task.wait()
		end
	end)
end

do
	local btCfg = getgenv().BallTimeConfig
	local timeOffset = 0; local realTick = tick; local lastReal = realTick()
	RunService.RenderStepped:Connect(function()
		local now = realTick(); local dt = now - lastReal; lastReal = now
		if btCfg.enabled then timeOffset = timeOffset + dt * (btCfg.multiplier - 1) end
	end)
	if not getgenv()._BallTimeHooked then
		getgenv()._BallTimeHooked = true
		local oldTick
		oldTick = hookfunction(tick, newcclosure(function(...)
			if timeOffset == 0 then return oldTick(...) end
			local env = getfenv(2)
			if env and env.script and env.script.Name == "BallHandler" then return oldTick(...) + timeOffset end
			env = getfenv(3)
			if env and env.script and env.script.Name == "BallHandler" then return oldTick(...) + timeOffset end
			return oldTick(...)
		end))
	end
end

do
	local trajFolder = workspace:FindFirstChild("ScarletTrajFolder") or Instance.new("Folder", workspace)
	trajFolder.Name = "ScarletTrajFolder"
	getgenv().TrajectoryEnabled = false
	local function updateTrajectory()
		trajFolder:ClearAllChildren()
		if not getgenv().TrajectoryEnabled then return end
		local ball = getBallDirect(); if not ball or not ball:IsA("BasePart") then return end
		local cur_vel = ball.AssemblyLinearVelocity; if not cur_vel or cur_vel.Magnitude < 3 then return end
		local cur_pos = ball.Position; local grav = workspace.Gravity
		local time_step = 0.07; local max_points = 25; local last_pos = cur_pos
		for i = 1, max_points do
			local next_pos = cur_pos + (cur_vel * time_step) + (0.5 * Vector3.new(0,-grav,0) * (time_step*time_step))
			local rp = RaycastParams.new(); rp.FilterDescendantsInstances = {ball, player.Character, trajFolder}; rp.FilterType = Enum.RaycastFilterType.Exclude
			local cast = workspace:Raycast(last_pos, next_pos - last_pos, rp)
			if cast then
				next_pos = cast.Position
				local dot = cur_vel:Dot(cast.Normal)
				cur_vel = (cur_vel - (2*dot*cast.Normal)) * 0.50
				cur_pos = next_pos
			else
				cur_vel = cur_vel + Vector3.new(0,-grav,0) * time_step
				cur_pos = next_pos
			end
			local dist = (next_pos - last_pos).Magnitude
			if dist > 0.05 then
				local p = Instance.new("Part"); p.Size = Vector3.new(0.60,0.60,dist)
				p.CFrame = CFrame.lookAt(last_pos:Lerp(next_pos,0.5), next_pos)
				p.Anchored = true; p.CanCollide = false; p.Color = Color3.fromRGB(160,0,220)
				p.Material = Enum.Material.Neon; p.Transparency = math.clamp(0.60+((i/max_points)*0.40),0,1); p.Parent = trajFolder
			end
			last_pos = next_pos
		end
	end
	RunService.Heartbeat:Connect(updateTrajectory)
end

local rainbowVisualDisc = Instance.new("Part")
rainbowVisualDisc.Shape = Enum.PartType.Cylinder; rainbowVisualDisc.Size = Vector3.new(0.15,7,7)
rainbowVisualDisc.Anchored = true; rainbowVisualDisc.CanCollide = false; rainbowVisualDisc.CanQuery = false; rainbowVisualDisc.CanTouch = false
rainbowVisualDisc.Material = Enum.Material.ForceField; rainbowVisualDisc.Transparency = 1; rainbowVisualDisc.CastShadow = false; rainbowVisualDisc.Parent = workspace
local rfHue = 0
RunService.Heartbeat:Connect(function(dt)
	local charNode = player.Character; local hrp = charNode and charNode:FindFirstChild("HumanoidRootPart")
	if getgenv().ShowRainbowFlickEnabled and hrp then
		local rf = getgenv().RainbowFlickConfig; local radius = rf.reachScale * 1.25
		rfHue = (rfHue + dt * 0.5) % 1
		rainbowVisualDisc.Size = Vector3.new(0.15, radius*2, radius*2)
		rainbowVisualDisc.CFrame = CFrame.new(Vector3.new(hrp.Position.X, hrp.Position.Y-2.5, hrp.Position.Z)) * CFrame.Angles(0,0,math.pi/2)
		rainbowVisualDisc.Color = Color3.fromHSV(rfHue, 0.9, 1); rainbowVisualDisc.Transparency = 0.75
	else rainbowVisualDisc.Transparency = 1 end
end)

local pitchTarget = workspace:FindFirstChild("Pitch", true) or workspace:FindFirstChild("Field", true) or workspace:FindFirstChild("Grass", true)
local rainbowConnection_pitch = nil; local originalPitchColors = {}
local function applyColorToPitch(color, revert)
	if not pitchTarget then return end
	local targets = {pitchTarget}
	for _, child in pairs(pitchTarget:GetDescendants()) do table.insert(targets, child) end
	for _, child in ipairs(targets) do
		if child:IsA("BasePart") then
			local lName = child.Name:lower()
			if not (lName:match("goal") or lName:match("net") or lName:match("post") or lName:match("line")) then
				if revert then if originalPitchColors[child] then child.Color = originalPitchColors[child] end
				else if not originalPitchColors[child] then originalPitchColors[child] = child.Color end; child.Color = color end
			end
		end
	end
end

local EQUIP_TAG = "ScarletHairEquipped"
local HAIR_ATTACHMENT_MAP = {
	HairBacon="HairAttachment",HairBlack="HairAttachment",HairBlackMask="FaceFrontAttachment",
	HairBlonde="HairAttachment",HairBrown="HairAttachment",HairCap="HatAttachment",
	HairCharmer="HairAttachment",HairCool="HairAttachment",HairDio="HairAttachment",
	HairEgg="HatAttachment",HairFloof="HairAttachment",HairFluffed="HairAttachment",
	HairGreen="HairAttachment",HairHalloween="FaceFrontAttachment",HairHat="HatAttachment",
	HairHockeyMask="FaceFrontAttachment",HairKnot="HairAttachment",HairLongPink="HairAttachment",
	HairMessy="HairAttachment",HairNerd="FaceFrontAttachment",HairBold="HairAttachment",
}
local HAIR_OFFSET_TWEAKS = {
	HairBlackMask=CFrame.new(0,0,-0.59),HairHockeyMask=CFrame.new(0,-0.01,-0.02),
	HairHalloween=CFrame.new(0,0.05,-0.04),HairBrown=CFrame.new(0,0.65,0),
	HairCap=CFrame.new(0,0.10,0.30),HairCharmer=CFrame.new(0,0.15,0.05),
	HairGreen=CFrame.new(0,0.20,-0.05),HairHat=CFrame.new(0,0.10,-0.25),
	HairKnot=CFrame.new(0,0.55,-0.05),HairNerd=CFrame.new(0,-0.65,-0.60),
}
local HAIR_ROTATION_TWEAKS = { HairHalloween = CFrame.Angles(math.rad(90),0,0) }
local hairRelativeMap = {}

local function hairNukeAll(char)
	for _, obj in ipairs(char:GetChildren()) do if obj:GetAttribute(EQUIP_TAG) then obj:Destroy() end end
	for _, obj in ipairs(char:GetChildren()) do
		if obj.Name and typeof(obj.Name)=="string" and obj.Name:sub(1,4)=="Hair" and not obj:IsA("Attachment") then obj:Destroy() end
	end
	local head = char:FindFirstChild("Head")
	if head then for _, child in ipairs(head:GetChildren()) do if child:IsA("Weld") and (child.Name=="HairWeld" or child.Name=="SubWeld") then child:Destroy() end end end
	for _, desc in ipairs(char:GetDescendants()) do if desc:GetAttribute(EQUIP_TAG) then pcall(function() desc:Destroy() end) end end
end
local function hairGetHandle(clone)
	if clone:IsA("BasePart") then return clone end
	local function search(p, name) if p.Name==name and p:IsA("BasePart") then return p end; for _, cc in ipairs(p:GetChildren()) do local f=search(cc,name); if f then return f end end end
	local h = search(clone, "Handle"); if h then return h end
	if clone:IsA("Accessory") then for _, cc in ipairs(clone:GetChildren()) do if cc:IsA("BasePart") then return cc end end end
	if clone:IsA("Model") and clone.PrimaryPart then return clone.PrimaryPart end
	for _, d in ipairs(clone:GetDescendants()) do if d:IsA("MeshPart") then return d end end
	for _, d in ipairs(clone:GetDescendants()) do if d:IsA("BasePart") then return d end end
end
local function hairGetAllParts(obj)
	local parts = {}; if obj:IsA("BasePart") then table.insert(parts, obj) end
	for _, d in ipairs(obj:GetDescendants()) do if d:IsA("BasePart") then table.insert(parts, d) end end
	return parts
end
local function hairFindAttachment(obj)
	for _, cc in ipairs(obj:GetChildren()) do if cc:IsA("Attachment") then return cc end end
	for _, d in ipairs(obj:GetDescendants()) do if d:IsA("Attachment") then return d end end
end
local function removeHair()
	local char = player.Character; if char then hairNukeAll(char) end; HairConfig.currentHairId = nil
end
local function equipHair(hairId)
	if hairId == "DEFAULT" or hairId == nil then removeHair(); return end
	local char = player.Character; if not char then return end
	local head = char:FindFirstChild("Head"); if not head then return end
	hairNukeAll(char)
	local src = ReplicatedStorage:FindFirstChild(hairId); if not src then return end
	local clone = src:Clone(); local handle = hairGetHandle(clone)
	if not handle then clone:Destroy(); return end
	local allParts = hairGetAllParts(clone); hairRelativeMap = {}
	for _, part in ipairs(allParts) do if part ~= handle then hairRelativeMap[part] = handle.CFrame:ToObjectSpace(part.CFrame) end end
	local att = hairFindAttachment(handle); local handleAttachCF = att and att.CFrame or CFrame.new()
	local headAttachName = HAIR_ATTACHMENT_MAP[hairId] or "HairAttachment"
	local headAttachment = head:FindFirstChild(headAttachName) or head:FindFirstChild("HairAttachment") or head:FindFirstChild("HatAttachment") or head:FindFirstChild("FaceFrontAttachment")
	if not headAttachment then clone:Destroy(); return end
	for _, part in ipairs(allParts) do part.Anchored=false; part.CanCollide=false; part.Massless=true end
	for _, desc in ipairs(clone:GetDescendants()) do if desc:IsA("Weld") or desc:IsA("WeldConstraint") or desc:IsA("Motor6D") then desc:Destroy() end end
	local extraOffset = HAIR_OFFSET_TWEAKS[hairId] or CFrame.new(); local extraRotation = HAIR_ROTATION_TWEAKS[hairId] or CFrame.new()
	local finalC1 = handleAttachCF * extraOffset * extraRotation
	handle.CFrame = head.CFrame * headAttachment.CFrame * finalC1:Inverse()
	for part, relCF in pairs(hairRelativeMap) do part.CFrame = handle.CFrame * relCF end
	local mw = Instance.new("Weld"); mw.Name="HairWeld"; mw.Part0=head; mw.Part1=handle; mw.C0=headAttachment.CFrame; mw.C1=finalC1; mw.Parent=head
	for part, relCF in pairs(hairRelativeMap) do local sw=Instance.new("Weld"); sw.Name="SubWeld"; sw.Part0=handle; sw.Part1=part; sw.C0=relCF; sw.C1=CFrame.new(); sw.Parent=handle end
	clone:SetAttribute(EQUIP_TAG, true); clone.Parent = char
	task.defer(function()
		for _, d in ipairs(clone:GetDescendants()) do if d:IsA("Weld") and d.Name=="AccessoryWeld" then d:Destroy() end end
		for _, part in ipairs(hairGetAllParts(clone)) do part.Anchored=false; part.CanCollide=false end
	end)
	HairConfig.currentHairId = hairId
end
getgenv()._HairCleanup = function() local char=player.Character; if char then hairNukeAll(char) end; HairConfig.currentHairId=nil end
player.CharacterAdded:Connect(function(char)
	if HairConfig.currentHairId then task.wait(1); equipHair(HairConfig.currentHairId) end
	if ShirtConfig.currentNumber then task.wait(1) end
end)

local function applyShirtNumber(num)
	local char = player.Character; if not char then return end
	for _, v in ipairs(char:GetDescendants()) do
		if (v:IsA("TextLabel") or v:IsA("TextBox")) and (tonumber(v.Text) or v.Name:lower():find("num")) then v.Text = tostring(num)
		elseif (v:IsA("StringValue") or v:IsA("IntValue")) and v.Name:lower():find("num") then v.Value = tostring(num) end
	end
	ShirtConfig.currentNumber = tostring(num)
end
local function applyShirtName(name)
	local char = player.Character; if not char then return end
	for _, v in ipairs(char:GetDescendants()) do
		if (v:IsA("TextLabel") or v:IsA("TextBox")) then local n=v.Name:lower(); if n:find("name") and not n:find("username") and not n:find("displayname") then v.Text=tostring(name) end
		elseif (v:IsA("StringValue") or v:IsA("IntValue")) and v.Name:lower():find("name") and not v.Name:lower():find("username") then v.Value=tostring(name) end
	end
	ShirtConfig.currentName = tostring(name)
end
local function applyShirtClan(clan)
	local char = player.Character; if not char then return end
	for _, v in ipairs(char:GetDescendants()) do
		if (v:IsA("TextLabel") or v:IsA("TextBox")) then local n=v.Name:lower(); if n:find("clan") or n:find("team") then v.Text=tostring(clan) end
		elseif (v:IsA("StringValue") or v:IsA("IntValue")) and (v.Name:lower():find("clan") or v.Name:lower():find("team")) then v.Value=tostring(clan) end
	end
	ShirtConfig.currentClan = tostring(clan)
end
player.CharacterAdded:Connect(function()
	task.wait(1)
	if ShirtConfig.currentNumber then applyShirtNumber(ShirtConfig.currentNumber) end
	if ShirtConfig.currentName then applyShirtName(ShirtConfig.currentName) end
	if ShirtConfig.currentClan then applyShirtClan(ShirtConfig.currentClan) end
end)

local NEVO_GRAVITY = 55; local NEVO_GROUND_Y = 5.473; local NEVO_FLOOR_BUF = 6.2
local NEVO_GOAL_X_A = -313.13; local NEVO_GOAL_X_B = -115.936
local NEVO_POST_L_Z = 78.036; local NEVO_POST_R_Z = 107.715; local NEVO_BAR_Y = 18; local NEVO_FRAME_R = 1.825; local NEVO_BALL_R = 1.0
local NEVO_CLEAR = NEVO_FRAME_R+NEVO_BALL_R+0.6; local NEVO_CENTER_Z = (NEVO_POST_L_Z+NEVO_POST_R_Z)/2
local NEVO_CHIP_APEX = 16; local NEVO_CHIP_VY_MAX = 34; local NEVO_CHIP_MIN = 52; local NEVO_CHIP_MAX = 62
local NEVO_WALL_DIST = 10; local NEVO_SHOT_FWD_MIN = 60; local NEVO_SHOT_FWD_MAX = 95
local NEVO_APEX_CAP = NEVO_BAR_Y-NEVO_CLEAR-0.2; local NEVO_OVERRIDE_TTL = 0.4
local neroState = false; local neroChipTime = 0; local neroOverrideArmed, neroOverrideVel, neroOverrideRot = false, nil, nil; local neroOverrideTime = 0
local function neroClearOverride() neroOverrideArmed, neroOverrideVel, neroOverrideRot = false, nil, nil end
local function neroArmOverride(vel, rot) neroOverrideVel, neroOverrideRot = vel, rot or Vector3.new(0,0,0); neroOverrideArmed, neroOverrideTime = true, tick() end
local function neroIsNearWall(pos)
	if pos.Y > 12 then return false end
	if math.abs(pos.Z-23.443)<NEVO_WALL_DIST or math.abs(pos.Z-161.748)<NEVO_WALL_DIST then return true end
	if (math.abs(pos.X-NEVO_GOAL_X_A)<NEVO_WALL_DIST or math.abs(pos.X-NEVO_GOAL_X_B)<NEVO_WALL_DIST) and not (pos.Z>=70 and pos.Z<=114) then return true end
	return false
end
local function neroChipVy(ballY) local rise=NEVO_CHIP_APEX-ballY; if rise<=1 then rise=1 end; return math.min(math.sqrt(2*NEVO_GRAVITY*rise),NEVO_CHIP_VY_MAX) end
local function neroSimGoal(pos, vel, goalX)
	local x0,y0,z0=pos.X,pos.Y,pos.Z; local vx,vy,vz=vel.X,vel.Y,vel.Z; local dt=0.004; local px=x0
	for i=1,700 do
		local t=i*dt; local x=x0+vx*t; local y=y0+vy*t-0.5*NEVO_GRAVITY*t*t; local z=z0+vz*t
		if t>0.06 and y<NEVO_FLOOR_BUF then return false end
		if math.abs(x-goalX)<4 and z>=NEVO_POST_L_Z-2 and z<=NEVO_POST_R_Z+2 then
			if math.sqrt((x-goalX)^2+(y-NEVO_BAR_Y)^2)<NEVO_FRAME_R+NEVO_BALL_R then return false end
		end
		if math.abs(x-goalX)<4 and y>=-1.5 and y<=19.5 then
			if math.sqrt((x-goalX)^2+(z-NEVO_POST_L_Z)^2)<NEVO_FRAME_R+NEVO_BALL_R or math.sqrt((x-goalX)^2+(z-NEVO_POST_R_Z)^2)<NEVO_FRAME_R+NEVO_BALL_R then return false end
		end
		local crossed=(goalX<-200 and x<=goalX and px>goalX) or (goalX>-200 and x>=goalX and px<goalX)
		if crossed then return (z>=NEVO_POST_L_Z+NEVO_CLEAR and z<=NEVO_POST_R_Z-NEVO_CLEAR and y>=NEVO_BALL_R and y<=NEVO_BAR_Y-NEVO_CLEAR) end
		px=x
	end
	return false
end
local function neroSolveShot(ballPos, targetX, targetZ, targetY, vy)
	local flat=Vector3.new(targetX-ballPos.X,0,targetZ-ballPos.Z); local flatDist=flat.Magnitude
	local flatDir = flatDist<1 and Vector3.new(targetX<-200 and -1 or 1,0,0) or flat.Unit; flatDist=math.max(flatDist,1)
	local a=-0.5*NEVO_GRAVITY; local disc=vy*vy-4*a*(ballPos.Y-targetY); if disc<0 then return nil end
	local sq=math.sqrt(disc); local t=math.max((-vy+sq)/(2*a),(-vy-sq)/(2*a)); if t<=0 then return nil end
	local fwd=flatDist/t; if fwd<NEVO_SHOT_FWD_MIN or fwd>NEVO_SHOT_FWD_MAX then return nil end
	return flatDir*fwd+Vector3.new(0,vy,0)
end
local function neroComputeShot(ballPos)
	local dA=math.abs(ballPos.X-NEVO_GOAL_X_A); local dB=math.abs(ballPos.X-NEVO_GOAL_X_B)
	local goalX = dA<dB and NEVO_GOAL_X_A or NEVO_GOAL_X_B; local aimX=goalX+(goalX<-200 and -3 or 3)
	local vyMax=math.min(math.sqrt(math.max(2*NEVO_GRAVITY*(NEVO_APEX_CAP-ballPos.Y),1)),33)
	for _, tY in ipairs({15,14,13,12,11,10,9}) do for vy=vyMax,22,-1.5 do for _, zOff in ipairs({0,5,-5,8,-8,3,-3}) do
		local tZ=math.clamp(NEVO_CENTER_Z+zOff,NEVO_POST_L_Z+NEVO_CLEAR+1,NEVO_POST_R_Z-NEVO_CLEAR-1)
		local vel=neroSolveShot(ballPos,aimX,tZ,tY,vy); if vel and neroSimGoal(ballPos,vel,goalX) then return vel,Vector3.new(0,0,0) end
	end end end
	for _, tY in ipairs({13,11,9}) do for vy=32,20,-1 do
		local flat=Vector3.new(aimX-ballPos.X,0,NEVO_CENTER_Z-ballPos.Z); local fdist=math.max(flat.Magnitude,1)
		local fdir=flat.Magnitude>0.01 and flat.Unit or Vector3.new(goalX<-200 and -1 or 1,0,0)
		local a=-0.5*NEVO_GRAVITY; local disc=vy*vy-4*a*(ballPos.Y-tY)
		if disc>=0 then local t=(-vy-math.sqrt(disc))/(2*a); if t>0 then local vel=fdir*(fdist/t)+Vector3.new(0,vy,0); if neroSimGoal(ballPos,vel,goalX) then return vel,Vector3.new(0,0,0) end end end
	end end
	local flat=Vector3.new(aimX-ballPos.X,0,NEVO_CENTER_Z-ballPos.Z)
	local fdir=flat.Magnitude>0.01 and flat.Unit or Vector3.new(goalX<-200 and -1 or 1,0,0)
	return fdir*math.clamp(math.max(flat.Magnitude,1)/0.9,NEVO_SHOT_FWD_MIN,NEVO_SHOT_FWD_MAX)+Vector3.new(0,30,0),Vector3.new(0,0,0)
end
RunService.Heartbeat:Connect(function()
	if neroState and (tick()-neroChipTime>0.5) then
		local ball=workspace:FindFirstChild("SoccerBall",true)
		if ball and ball:IsA("BasePart") and ball.Position.Y<=NEVO_GROUND_Y+0.4 then neroState=false end
	end
end)
local neroStartAnimation
for _, v in pairs(getgc()) do
	if type(v)=="function" and islclosure(v) then
		local ok, info = pcall(debug.getinfo, v)
		if ok and info and info.name=="startAnimation" then neroStartAnimation=v; break end
	end
end
local neroOldStartAnimation
if neroStartAnimation then
	neroOldStartAnimation = hookfunction(neroStartAnimation, function(p1,p2,p3,p4,p5)
		if neroOverrideArmed and (tick()-neroOverrideTime)<=NEVO_OVERRIDE_TTL then p2=neroOverrideVel; p3=neroOverrideRot or Vector3.new(0,0,0); neroClearOverride() elseif neroOverrideArmed then neroClearOverride() end
		return neroOldStartAnimation(p1,p2,p3,p4,p5)
	end)
end
local neroOldNamecall
neroOldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
	local method = getnamecallmethod()
	if getgenv().NeroConfig.enabled and neroStartAnimation and typeof(self)=="Instance" and self.Name=="KickBall" and method=="FireServer" then
		local args={...}; local ballPos,origVel=args[1],args[2]
		if typeof(ballPos)=="Vector3" and typeof(origVel)=="Vector3" then
			if neroIsNearWall(ballPos) and not neroState then
				local flatDir=Vector3.new(origVel.X,0,origVel.Z); local forwardSpeed=flatDir.Magnitude
				flatDir=forwardSpeed>0.01 and flatDir.Unit or Vector3.new(1,0,0)
				forwardSpeed=math.clamp(forwardSpeed,NEVO_CHIP_MIN,NEVO_CHIP_MAX)
				args[2]=flatDir*forwardSpeed+Vector3.new(0,neroChipVy(ballPos.Y),0); args[3]=Vector3.new(0,0,0)
				neroArmOverride(args[2],args[3]); neroState,neroChipTime=true,tick()
				task.delay(4, function() if neroState then neroState=false end end)
				return neroOldNamecall(self, unpack(args))
			elseif neroState then
				local shotVel,shotRot=neroComputeShot(ballPos); args[2],args[3]=shotVel,shotRot
				neroArmOverride(args[2],args[3]); neroState=false
				return neroOldNamecall(self, unpack(args))
			end
		end
	end
	return neroOldNamecall(self, ...)
end)

local function persistAll()
	local data = {
		_v = CONFIG_VERSION,
		juggleV2 = { enabled=juggleV2.enabled, reach=juggleV2.reach, forceSpeed=juggleV2.forceSpeed },
		sneaky = { enabled=c.enabled, reach=c.reach, heightLevel=c.heightLevel },
		sneakyV2 = { enabled=sneakyV2.enabled, reach=sneakyV2.reach },
		reach = { enabled=getgenv().ReachConfig.enabled, range=getgenv().ReachConfig.range },
		rainbowFlick = { enabled=getgenv().RainbowFlickConfig.enabled, reachScale=getgenv().RainbowFlickConfig.reachScale },
		groundShots = { Enabled=getgenv().JuvsReachConfig.Enabled, Range=getgenv().JuvsReachConfig.Range },
		juggle = { enabled=getgenv().AutoJuggleV1.enabled, reach=getgenv().AutoJuggleV1.reach },
		autoGK = { enabled=getgenv().AutoGKConfig.enabled, diveSpeed=getgenv().AutoGKConfig.diveSpeed },
		aimbot = { enabled=getgenv().AimbotConfig.enabled, powerShot=getgenv().AimbotConfig.powerShot },
		velocity = { enabled=getgenv().VelocityConfig.enabled, multiplier=getgenv().VelocityConfig.multiplier },
		autoScore = { enabled=getgenv().AutoScoreConfig.enabled, autoEnemy=getgenv().AutoScoreConfig.autoEnemy, antiAFK=getgenv().AutoScoreConfig.antiAFK, targetGoal=getgenv().AutoScoreConfig.targetGoal },
		saveFarm = { enabled=getgenv().AutoSave.enabled },
		ballTime = { enabled=getgenv().BallTimeConfig.enabled, multiplier=getgenv().BallTimeConfig.multiplier },
		performance = { maxFps=perf.maxFps, boostFps=perf.boostFps, reduceLatency=perf.reduceLatency, disableShadows=perf.disableShadows, disableParticles=perf.disableParticles, lowerTextures=perf.lowerTextures, clearTerrain=perf.clearTerrain, reduceSound=perf.reduceSound },
	}
	saveConfigToDisk(data)
end

local function setFeaturePriority(feature) getgenv()._lastEnabledFeature = feature end
local function clearFeaturePriority(feature) if getgenv()._lastEnabledFeature == feature then getgenv()._lastEnabledFeature = nil end end

local Window = Rayfield:CreateWindow({
	Name = "Scarlet V5",
	LoadingTitle = "Scarlet V5",
	LoadingSubtitle = "by you",
	Theme = "Custom",
	CustomTheme = {
		TextColor=Color3.fromRGB(240,230,255), Background=Color3.fromRGB(18,14,26), Topbar=Color3.fromRGB(24,18,34),
		Shadow=Color3.fromRGB(10,6,18), NotificationBackground=Color3.fromRGB(24,18,34), NotificationActionsBackground=Color3.fromRGB(30,22,42),
		TabBackground=Color3.fromRGB(22,16,32), TabStroke=Color3.fromRGB(90,0,120), TabBackgroundSelected=Color3.fromRGB(48,0,72),
		TabTextColor=Color3.fromRGB(180,140,220), SelectedTabTextColor=Color3.fromRGB(255,255,255),
		ElementBackground=Color3.fromRGB(28,20,40), ElementBackgroundHover=Color3.fromRGB(36,26,52),
		SecondaryElementBackground=Color3.fromRGB(22,16,32), ElementStroke=Color3.fromRGB(80,0,110), SecondaryElementStroke=Color3.fromRGB(60,0,90),
		SliderBackground=Color3.fromRGB(40,10,60), SliderProgress=Color3.fromRGB(160,0,220), SliderStroke=Color3.fromRGB(120,0,180),
		ToggleBackground=Color3.fromRGB(40,10,60), ToggleEnabled=Color3.fromRGB(180,0,80), ToggleDisabled=Color3.fromRGB(60,40,80),
		ToggleEnabledStroke=Color3.fromRGB(220,0,100), ToggleDisabledStroke=Color3.fromRGB(80,60,100),
		ToggleEnabledOuterStroke=Color3.fromRGB(160,0,60), ToggleDisabledOuterStroke=Color3.fromRGB(50,30,70),
		InputBackground=Color3.fromRGB(28,20,40), InputStroke=Color3.fromRGB(90,0,120), PlaceholderColor=Color3.fromRGB(120,90,150),
	},
	Discord = { Enabled=true, Invite="CbZr64enZ5", RememberJoins=true },
	ConfigurationSaving = { Enabled=true, FolderName="Scarlet", FileName="Config" },
	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,
})

local KineticsTab   = Window:CreateTab("⚡ Kinetics",     4483362458)
local BallisticsTab = Window:CreateTab("🎯 Ballistics",   4483362458)
local OverridesTab  = Window:CreateTab("🧠 Overrides",    4483362458)
local SpatialTab    = Window:CreateTab("🌐 Spatial",      4483362458)
local OptTab        = Window:CreateTab("📊 Optimization", 4483362458)
local UtilityTab    = Window:CreateTab("🔧 Utility",      4483362458)
local ScriptsTab    = Window:CreateTab("🖥 Scripts",      4483362458)
local MacrosTab     = Window:CreateTab("⌨️ Macros",       4483362458)
local ConfigTab     = Window:CreateTab("⚙️ Config",       4483362458)
local InfoTab       = Window:CreateTab("ℹ️ Info",         4483362458)

KineticsTab:CreateSection("Juggle V2")
KineticsTab:CreateToggle({ Name="Enable Juggle V2", CurrentValue=juggleV2.enabled, Flag="JuggleV2", Callback=function(v) juggleV2.enabled=v; if v then setFeaturePriority("juggleV2") else clearFeaturePriority("juggleV2") end; persistAll() end })
KineticsTab:CreateSlider({ Name="Juggle V2 Reach", Range={4.1,15}, Increment=0.1, CurrentValue=juggleV2.reach, Flag="JuggleV2Reach", Callback=function(v) juggleV2.reach=round01(v); persistAll() end })
KineticsTab:CreateSlider({ Name="Juggle V2 Speed", Range={16,50}, Increment=1, CurrentValue=juggleV2.forceSpeed, Flag="JuggleV2Speed", Callback=function(v) juggleV2.forceSpeed=v; persistAll() end })

KineticsTab:CreateSection("Sneaky")
KineticsTab:CreateToggle({ Name="Enable Sneaky", CurrentValue=c.enabled, Flag="Sneaky", Callback=function(v) c.enabled=v; if v then setFeaturePriority("sneaky") else clearFeaturePriority("sneaky") end; persistAll() end })
KineticsTab:CreateDropdown({ Name="Sneaky Height", Options={"Low","High","Extra High"}, CurrentOption={c.heightLevel}, Flag="SneakyHeight", Callback=function(opt) c.heightLevel=opt[1]; persistAll() end })
KineticsTab:CreateSlider({ Name="Sneaky Reach", Range={4.1,9}, Increment=0.1, CurrentValue=c.reach, Flag="SneakyReach", Callback=function(v) c.reach=round01(v); persistAll() end })

KineticsTab:CreateSection("Sneaky V2")
KineticsTab:CreateToggle({ Name="Enable Sneaky V2", CurrentValue=sneakyV2.enabled, Flag="SneakyV2", Callback=function(v) sneakyV2.enabled=v; if v then setFeaturePriority("sneakyV2") else clearFeaturePriority("sneakyV2") end; persistAll() end })
KineticsTab:CreateSlider({ Name="Sneaky V2 Reach", Range={4.1,8}, Increment=0.1, CurrentValue=sneakyV2.reach, Flag="SneakyV2Reach", Callback=function(v) sneakyV2.reach=round01(v); persistAll() end })

KineticsTab:CreateSection("Auto Juggle V1")
KineticsTab:CreateToggle({ Name="Enable Auto Juggle", CurrentValue=getgenv().AutoJuggleV1.enabled, Flag="JuggleV1", Callback=function(v) getgenv().AutoJuggleV1.enabled=v; if v then setFeaturePriority("juggle") else clearFeaturePriority("juggle") end; persistAll() end })
KineticsTab:CreateSlider({ Name="Juggle Reach", Range={4.1,9}, Increment=0.1, CurrentValue=getgenv().AutoJuggleV1.reach, Flag="JuggleV1Reach", Callback=function(v) getgenv().AutoJuggleV1.reach=round01(v); persistAll() end })

KineticsTab:CreateSection("Reach")
KineticsTab:CreateToggle({ Name="Enable Reach", CurrentValue=getgenv().ReachConfig.enabled, Flag="Reach", Callback=function(v) getgenv().ReachConfig.enabled=v; if v then setFeaturePriority("reach") else clearFeaturePriority("reach") end; persistAll() end })
KineticsTab:CreateSlider({ Name="Reach Range", Range={3.5,8.5}, Increment=0.1, CurrentValue=getgenv().ReachConfig.range, Flag="ReachRange", Callback=function(v) getgenv().ReachConfig.range=round01(v); persistAll() end })

BallisticsTab:CreateSection("Aimbot")
BallisticsTab:CreateToggle({ Name="Enable Aimbot", CurrentValue=cfg.enabled, Flag="Aimbot", Callback=function(v) cfg.enabled=v; if getgenv().AimbotSync then pcall(getgenv().AimbotSync,v) end; persistAll() end })
BallisticsTab:CreateToggle({ Name="Auto-Detect Goal", CurrentValue=true, Flag="AimbotAutoDetect", Callback=function(v) cfg.autoDetect=v end })
BallisticsTab:CreateDropdown({ Name="Target Goal", Options={"Opposition","Own Goals"}, CurrentOption={"Opposition"}, Flag="AimbotGoal", Callback=function(v) cfg.selectedGoal=v[1] end })
BallisticsTab:CreateToggle({ Name="Top Corner Bias", CurrentValue=true, Flag="TopCorner", Callback=function(v) cfg.topCornerEnabled=v end })
BallisticsTab:CreateToggle({ Name="Anti-Post Bypass", CurrentValue=false, Flag="AntiPost", Callback=function(v) cfg.antiPost=v end })
BallisticsTab:CreateToggle({ Name="Power Shot", CurrentValue=cfg.powerShot, Flag="PowerShot", Callback=function(v) cfg.powerShot=v; persistAll() end })

BallisticsTab:CreateSection("Lob Shot")
BallisticsTab:CreateToggle({ Name="Enable Lob Shot", CurrentValue=lobCfg.enabled, Flag="LobShot", Callback=function(v) lobCfg.enabled=v; if v then setFeaturePriority("lobShot") else clearFeaturePriority("lobShot") end; persistAll() end })
BallisticsTab:CreateDropdown({ Name="Lob Height", Options={"Low","Medium","High","Very High"}, CurrentOption={"High"}, Flag="LobHeight", Callback=function(v) lobCfg.heightLevel=v[1] end })
BallisticsTab:CreateSlider({ Name="Lob Power Boost", Range={0,30}, Increment=0.1, CurrentValue=0, Flag="LobPower", Callback=function(v) lobCfg.powerBoost=round01(v) end })

OverridesTab:CreateSection("Auto GK")
OverridesTab:CreateToggle({ Name="Enable Auto GK", CurrentValue=getgenv().AutoGKConfig.enabled, Flag="AutoGK", Callback=function(v) getgenv().AutoGKConfig.enabled=v; persistAll() end })
OverridesTab:CreateSlider({ Name="Dive Speed", Range={10,60}, Increment=1, CurrentValue=getgenv().AutoGKConfig.diveSpeed, Flag="DiveSpeed", Callback=function(v) getgenv().AutoGKConfig.diveSpeed=v; persistAll() end })
OverridesTab:CreateToggle({ Name="Auto Ground Save", CurrentValue=false, Flag="GroundSave", Callback=function(v) getgenv().AutoGroundSaveConfig.enabled=v end })

OverridesTab:CreateSection("Ground Shots")
OverridesTab:CreateToggle({ Name="Enable Ground Shots", CurrentValue=getgenv().JuvsReachConfig.Enabled, Flag="GroundShots", Callback=function(v) getgenv().JuvsReachConfig.Enabled=v; if v then setFeaturePriority("groundShots") else clearFeaturePriority("groundShots") end; persistAll() end })
OverridesTab:CreateSlider({ Name="Ground Shots Range", Range={3.5,8}, Increment=0.1, CurrentValue=getgenv().JuvsReachConfig.Range, Flag="GroundShotsRange", Callback=function(v) getgenv().JuvsReachConfig.Range=round01(v); persistAll() end })

OverridesTab:CreateSection("Auto Nero")
OverridesTab:CreateToggle({ Name="Enable Auto Nero", CurrentValue=false, Flag="Nero", Callback=function(v) getgenv().NeroConfig.enabled=v end })

OverridesTab:CreateSection("Pokers")
OverridesTab:CreateToggle({ Name="Enable Pokers", CurrentValue=false, Flag="PhaseShift", Callback=function(v) getgenv().PokersConfig.enabled=v; if v then refreshNoclip() else clearNoclip() end end })
OverridesTab:CreateSlider({ Name="Pokers Walk Speed", Range={12,32}, Increment=1, CurrentValue=16, Flag="PokersSpeed", Callback=function(v) getgenv().PokersConfig.forceSpeed=math.floor(v) end })

OverridesTab:CreateSection("Rainbow Flick")
OverridesTab:CreateToggle({ Name="Enable Rainbow Flick", CurrentValue=getgenv().RainbowFlickConfig.enabled, Flag="RainbowFlick", Callback=function(v) getgenv().RainbowFlickConfig.enabled=v; if v then setFeaturePriority("rainbowFlick") else clearFeaturePriority("rainbowFlick") end; persistAll() end })
OverridesTab:CreateSlider({ Name="Rainbow Scale", Range={3.5,10}, Increment=0.1, CurrentValue=getgenv().RainbowFlickConfig.reachScale, Flag="RainbowScale", Callback=function(v) getgenv().RainbowFlickConfig.reachScale=round01(v); persistAll() end })
OverridesTab:CreateToggle({ Name="Rainbow Flick Visualizer", CurrentValue=false, Flag="RFVisual", Callback=function(v) getgenv().ShowRainbowFlickEnabled=v end })

OverridesTab:CreateSection("Touch Reach")
OverridesTab:CreateToggle({ Name="Enable Touch Reach", CurrentValue=false, Flag="TouchReach", Callback=function(v) touchReach.enabled=v end })
OverridesTab:CreateSlider({ Name="Touch Reach Range", Range={4.0,10.0}, Increment=0.1, CurrentValue=4.0, Flag="TouchReachRange", Callback=function(v) touchReach.reach=round01(v) end })
OverridesTab:CreateToggle({ Name="Block Deny Events", CurrentValue=false, Flag="BlockDeny", Callback=function(v) touchReach.blockDeny=v end })

SpatialTab:CreateSection("Overlay Modifications")
SpatialTab:CreateToggle({ Name="Ball Trajectory Wireframe", CurrentValue=false, Flag="Trajectory", Callback=function(v) getgenv().TrajectoryEnabled=v end })
SpatialTab:CreateToggle({ Name="Time Dilation (Ball Timer)", CurrentValue=getgenv().BallTimeConfig.enabled, Flag="TimeDilation", Callback=function(v) getgenv().BallTimeConfig.enabled=v; persistAll() end })
SpatialTab:CreateSlider({ Name="Time Dilation Multiplier", Range={0.5,3.0}, Increment=0.1, CurrentValue=getgenv().BallTimeConfig.multiplier, Flag="TimeMult", Callback=function(v) getgenv().BallTimeConfig.multiplier=round01(v); persistAll() end })

SpatialTab:CreateSection("Character Modifications")
SpatialTab:CreateDropdown({
	Name="Hair Style Changer",
	Options={"Default Hair","Bacon","Black","Black Mask","Blonde","Bold","Brown","Cap","Charmer","Cool","Dio","Egg","Floof","Fluffed","Green","Halloween","Hat","Hockey Mask","Knot","Long Pink","Messy","Nerd"},
	CurrentOption={"Default Hair"}, Flag="HairStyle",
	Callback=function(opt)
		local idMap={["Default Hair"]="DEFAULT",["Bacon"]="HairBacon",["Black"]="HairBlack",["Black Mask"]="HairBlackMask",["Blonde"]="HairBlonde",["Bold"]="HairBold",["Brown"]="HairBrown",["Cap"]="HairCap",["Charmer"]="HairCharmer",["Cool"]="HairCool",["Dio"]="HairDio",["Egg"]="HairEgg",["Floof"]="HairFloof",["Fluffed"]="HairFluffed",["Green"]="HairGreen",["Halloween"]="HairHalloween",["Hat"]="HairHat",["Hockey Mask"]="HairHockeyMask",["Knot"]="HairKnot",["Long Pink"]="HairLongPink",["Messy"]="HairMessy",["Nerd"]="HairNerd"}
		local id=idMap[opt[1]]; if id=="DEFAULT" then removeHair() elseif id then equipHair(id) end
	end,
})
SpatialTab:CreateInput({ Name="Jersey Number", CurrentString="", PlaceholderText="10", Flag="JerseyNum", Callback=function(t) if t~="" then applyShirtNumber(t) end end })
SpatialTab:CreateInput({ Name="Player Name on Jersey", CurrentString="", PlaceholderText="Messi", Flag="JerseyName", Callback=function(t) if t~="" then applyShirtName(t) end end })
SpatialTab:CreateInput({ Name="Clan Tag", CurrentString="", PlaceholderText="GS", Flag="ClanTag", Callback=function(t) if t~="" then applyShirtClan(t) end end })

SpatialTab:CreateSection("World Environment")
SpatialTab:CreateInput({ Name="Time of Day", CurrentString="12", PlaceholderText="0-24", Flag="TimeOfDay", Callback=function(t) local n=tonumber(t); if n then Lighting.ClockTime=math.clamp(n,0,24) end end })
SpatialTab:CreateDropdown({
	Name="Pitch Turf Color",
	Options={"Default","Red","Orange","Yellow","Green","Blue","Purple","Pink","Rainbow"},
	CurrentOption={"Default"}, Flag="TurfColor",
	Callback=function(opt)
		if rainbowConnection_pitch then rainbowConnection_pitch:Disconnect(); rainbowConnection_pitch=nil end
		if opt[1]=="Default" then applyColorToPitch(nil,true)
		elseif opt[1]=="Rainbow" then
			local hue=0; rainbowConnection_pitch=RunService.RenderStepped:Connect(function(dt) hue=(hue+dt*0.1)%1; applyColorToPitch(Color3.fromHSV(hue,0.8,1),false) end)
		else
			local colors={Red=Color3.fromRGB(220,40,40),Orange=Color3.fromRGB(255,125,0),Yellow=Color3.fromRGB(255,230,50),Green=Color3.fromRGB(40,220,40),Blue=Color3.fromRGB(40,100,255),Purple=Color3.fromRGB(140,40,220),Pink=Color3.fromRGB(255,105,180)}
			if colors[opt[1]] then applyColorToPitch(colors[opt[1]],false) end
		end
	end,
})

OptTab:CreateSection("Framerate")
OptTab:CreateToggle({ Name="Unlock FPS Cap", CurrentValue=perf.boostFps, Flag="UnlockFPS", Callback=function(v) perf.boostFps=v; if setfpscap then pcall(function() setfpscap(v and perf.maxFps or 60) end) end; persistAll() end })
OptTab:CreateSlider({ Name="Maximum FPS", Range={60,360}, Increment=10, CurrentValue=perf.maxFps, Flag="MaxFPS", Callback=function(v) perf.maxFps=math.floor(v); if setfpscap and perf.boostFps then pcall(function() setfpscap(perf.maxFps) end) end; persistAll() end })
OptTab:CreateSection("Renderer Bypass")
OptTab:CreateToggle({ Name="Disable Global Shadows", CurrentValue=perf.disableShadows, Flag="NoShadows", Callback=function(v) perf.disableShadows=v; pcall(function() Lighting.GlobalShadows=not v end); persistAll() end })
OptTab:CreateToggle({ Name="Disable Particle Emitters", CurrentValue=perf.disableParticles, Flag="NoParticles", Callback=function(v) perf.disableParticles=v; persistAll() end })
OptTab:CreateToggle({ Name="Flatten Textures", CurrentValue=perf.lowerTextures, Flag="LowTex", Callback=function(v) perf.lowerTextures=v; persistAll() end })
OptTab:CreateToggle({ Name="Mute Ambient Sounds", CurrentValue=perf.reduceSound, Flag="MuteAmbient", Callback=function(v) perf.reduceSound=v; pcall(function() for _,s in pairs(game:GetService("SoundService"):GetDescendants()) do if s:IsA("Sound") then s.Volume=v and 0 or 0.5 end end end); persistAll() end })
OptTab:CreateToggle({ Name="Network Latency Reduction", CurrentValue=perf.reduceLatency, Flag="ReduceLatency", Callback=function(v) perf.reduceLatency=v; persistAll() end })
OptTab:CreateToggle({ Name="Clear Terrain Effects", CurrentValue=perf.clearTerrain, Flag="ClearTerrain", Callback=function(v) perf.clearTerrain=v; persistAll() end })
OptTab:CreateToggle({ Name="Ping Spoof (Measure Lag)", CurrentValue=false, Flag="PingSpoof", Callback=function(v) getgenv().MeasureLagEnabled=v end })

UtilityTab:CreateSection("Automation")
UtilityTab:CreateToggle({ Name="Auto-Save Farm", CurrentValue=getgenv().AutoSave.enabled, Flag="AutoSaveFarm", Callback=function(v) getgenv().AutoSave.enabled=v; persistAll() end })
UtilityTab:CreateToggle({ Name="Auto Score", CurrentValue=getgenv().AutoScoreConfig.enabled, Flag="AutoScore", Callback=function(v) getgenv().AutoScoreConfig.enabled=v; persistAll() end })
UtilityTab:CreateToggle({ Name="Auto Enemy Goal", CurrentValue=getgenv().AutoScoreConfig.autoEnemy, Flag="AutoEnemy", Callback=function(v) getgenv().AutoScoreConfig.autoEnemy=v; persistAll() end })
UtilityTab:CreateDropdown({ Name="Manual Target Goal", Options={"A","B"}, CurrentOption={getgenv().AutoScoreConfig.targetGoal or "A"}, Flag="TargetGoal", Callback=function(v) getgenv().AutoScoreConfig.targetGoal=v[1]; persistAll() end })
UtilityTab:CreateToggle({ Name="Anti-AFK", CurrentValue=getgenv().AutoScoreConfig.antiAFK, Flag="AntiAFK", Callback=function(v) getgenv().AutoScoreConfig.antiAFK=v; persistAll() end })
UtilityTab:CreateSection("Movement Physics")
UtilityTab:CreateToggle({ Name="Velocity Multiplier", CurrentValue=getgenv().VelocityConfig.enabled, Flag="VelMult", Callback=function(v) getgenv().VelocityConfig.enabled=v; persistAll() end })
UtilityTab:CreateSlider({ Name="Velocity Speed", Range={1.0,3.0}, Increment=0.1, CurrentValue=getgenv().VelocityConfig.multiplier, Flag="VelSpeed", Callback=function(v) getgenv().VelocityConfig.multiplier=round01(v); persistAll() end })
UtilityTab:CreateSection("Teleportation")
UtilityTab:CreateButton({ Name="Bring Ball", Callback=function()
	local char=player.Character or player.CharacterAdded:Wait()
	local hrp=char:FindFirstChild("HumanoidRootPart")
	local field=workspace:FindFirstChild("FootballField"); local soccerBall=field and field:FindFirstChild("SoccerBall")
	if hrp and soccerBall then soccerBall.CFrame=hrp.CFrame end
end })
UtilityTab:CreateSection("Goal Scoring")
UtilityTab:CreateButton({ Name="Score Goal A", Callback=function()
	local KickBall=game:GetService("ReplicatedStorage"):FindFirstChild("KickBall")
	local GoalEvent=game:GetService("ReplicatedStorage"):FindFirstChild("GoalEvent")
	if KickBall then KickBall:FireServer(Vector3.new(-213.62574768066406,6.241994857788086,117.22891235351562),Vector3.new(84.71153259277344,34,6.996870040893555),Vector3.new(0,-3.3757386207580566,0),3.379659414291382,"djhtelkds") end
	task.wait(0.5)
	if GoalEvent then GoalEvent:FireServer("A") end
end })
UtilityTab:CreateButton({ Name="Score Goal B", Callback=function()
	local KickBall=game:GetService("ReplicatedStorage"):FindFirstChild("KickBall")
	local GoalEvent=game:GetService("ReplicatedStorage"):FindFirstChild("GoalEvent")
	if KickBall then KickBall:FireServer(Vector3.new(-213.62574768066406,6.241994857788086,117.22891235351562),Vector3.new(84.71153259277344,34,6.996870040893555),Vector3.new(0,-3.3757386207580566,0),3.379659414291382,"djhtelkds") end
	task.wait(0.5)
	if GoalEvent then GoalEvent:FireServer("B") end
end })

getgenv().AutoKick = getgenv().AutoKick or { enabled = false, radius = 5 }
do
	local Debris = game:GetService("Debris")
	RunService.Heartbeat:Connect(function()
		if not getgenv().AutoKick.enabled then return end
		local char = player.Character; if not char then return end
		local head = char:FindFirstChild("Head")
		local lowerTorso = char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso")
		local hum = char:FindFirstChildOfClass("Humanoid"); if not (head and lowerTorso and hum) then return end
		local ball = workspace:FindFirstChild("SoccerBall", true); if not ball or not ball:IsA("BasePart") then return end
		local dist = (ball.Position - head.Position).Magnitude
		if dist > getgenv().AutoKick.radius then return end
		local forward = char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.CFrame.LookVector or Vector3.new(0,0,1)
		local feetPos = lowerTorso.Position - Vector3.new(0, 1.5, 0)
		local verticalAbove = ball.Position.Y - head.Position.Y
		if verticalAbove >= 0.4 then
			local controlPoint = head.Position + Vector3.new(0, 1.5, 0)
			local newPosition = ball.Position:Lerp(controlPoint, 0.84)
			ball.CFrame = CFrame.new(newPosition)
			ball.AssemblyLinearVelocity = ball.AssemblyLinearVelocity * 0.8
			return
		end
		local toBall = (ball.Position - feetPos)
		local dotFront = toBall.Unit:Dot(forward)
		if math.abs(dotFront) >= 0.85 and ball.Position.Y <= feetPos.Y + 0.1 then
			local dirVec = dotFront < 0 and -forward or forward
			ball.CFrame = CFrame.new(feetPos + dirVec)
			local bv = Instance.new("BodyVelocity")
			local mouse = player:GetMouse()
			local dir = (Vector3.new(mouse.Hit.X, mouse.Hit.Y, mouse.Hit.Z) - ball.Position)
			bv.Velocity = dir.Unit * 9.5
			bv.MaxForce = Vector3.new(3000, 3000, 3000)
			bv.Parent = ball
			Debris:AddItem(bv, 0.1)
			return
		end
		local controlPoint = lowerTorso.Position + forward * 1.5 + Vector3.new(0, -1, 0)
		local newPosition = ball.Position:Lerp(controlPoint, 0.84)
		ball.CFrame = CFrame.new(newPosition, newPosition + forward)
		ball.AssemblyLinearVelocity = ball.AssemblyLinearVelocity * 0.8
	end)
end

ScriptsTab:CreateSection("Special Shots")
ScriptsTab:CreateToggle({ Name="🔥 Auto Nero", CurrentValue=false, Flag="AutoNero", Callback=function(val) getgenv().NeroConfig.enabled=val end })
ScriptsTab:CreateSlider({ Name="Auto Nero Timeout (s)", Range={0.5,5}, Increment=0.1, Suffix="s", CurrentValue=1.5, Flag="AutoNeroTimeout", Callback=function(val) getgenv().NeroConfig.timeout=val end })
ScriptsTab:CreateToggle({ Name="⚽ Auto Header", CurrentValue=false, Flag="AutoHeader", Callback=function(val) getgenv().AutoKick.enabled=val end })
ScriptsTab:CreateSection("Manual Functions")
ScriptsTab:CreateToggle({ Name="Random Curve", CurrentValue=false, Flag="RandomCurve", Callback=function(val)
	if val then
		if not getgenv()._RandomCurveHook then
			getgenv()._RandomCurveHook = true
			local _rcOldNamecall
			_rcOldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
				local m = getnamecallmethod()
				if m == "FireServer" then
					local ok, n = pcall(function() return self.Name end)
					if ok and n == "KickBall" then
						local args = {...}
						if typeof(args[3]) == "Vector3" then
							local rx = (math.random()-0.5)*14
							local ry = (math.random()-0.5)*14
							local rz = (math.random()-0.5)*14
							args[3] = Vector3.new(rx, ry, rz)
							return _rcOldNamecall(self, unpack(args))
						end
					end
				end
				return _rcOldNamecall(self, ...)
			end)
		end
	else
		getgenv()._RandomCurveHook = nil
	end
end })
ScriptsTab:CreateSection("Ground Control")
ScriptsTab:CreateToggle({ Name="Enable Ground Shots", CurrentValue=getgenv().JuvsReachConfig.Enabled, Flag="GroundShotsScript", Callback=function(val) getgenv().JuvsReachConfig.Enabled=val; if val then setFeaturePriority("groundShots") else clearFeaturePriority("groundShots") end; persistAll() end })
ScriptsTab:CreateSection("Ball Control")
local deletingActive = false
local function runDeleteBall()
	if deletingActive then return end; deletingActive = true
	task.spawn(function()
		local Field=workspace:FindFirstChild("FootballField")
		if Field then local Ball=Field:FindFirstChild("SoccerBall"); if Ball then Ball:Destroy() end end
		local KickBall=game:GetService("ReplicatedStorage"):FindFirstChild("KickBall")
		if KickBall then KickBall:FireServer(Vector3.new(560.5654296875,600.84350585938,1582.9370117188),Vector3.new(560.5654296875,600.84350585938,1582.9370117188),Vector3.new(560.5654296875,600.84350585938,1582.9370117188),0,"djhtelkds") end
		deletingActive = false
	end)
end
ScriptsTab:CreateButton({ Name="🗑 Delete Ball", Callback=runDeleteBall })
ScriptsTab:CreateKeybind({ Name="Delete Ball Keybind", CurrentKeybind="X", HoldToInteract=false, Flag="DeleteBallKey", Callback=runDeleteBall })

MacrosTab:CreateSection("Keyboard Keybinds")
MacrosTab:CreateKeybind({ Name="Toggle Sneaky",        CurrentKeybind="Z", Flag="KB_Sneaky",    Callback=function() c.enabled=not c.enabled; if c.enabled then setFeaturePriority("sneaky") else clearFeaturePriority("sneaky") end; persistAll() end })
MacrosTab:CreateKeybind({ Name="Toggle Sneaky V2",     CurrentKeybind="B", Flag="KB_SneakyV2",  Callback=function() sneakyV2.enabled=not sneakyV2.enabled; if sneakyV2.enabled then setFeaturePriority("sneakyV2") else clearFeaturePriority("sneakyV2") end; persistAll() end })
MacrosTab:CreateKeybind({ Name="Toggle Auto Juggle",   CurrentKeybind="R", Flag="KB_Juggle",    Callback=function() getgenv().AutoJuggleV1.enabled=not getgenv().AutoJuggleV1.enabled; if getgenv().AutoJuggleV1.enabled then setFeaturePriority("juggle") else clearFeaturePriority("juggle") end; persistAll() end })
MacrosTab:CreateKeybind({ Name="Toggle Ground Shots",  CurrentKeybind="C", Flag="KB_Seismic",   Callback=function() getgenv().JuvsReachConfig.Enabled=not getgenv().JuvsReachConfig.Enabled; if getgenv().JuvsReachConfig.Enabled then setFeaturePriority("groundShots") else clearFeaturePriority("groundShots") end; persistAll() end })
MacrosTab:CreateKeybind({ Name="Toggle Pokers",        CurrentKeybind="V", Flag="KB_Phase",     Callback=function() getgenv().PokersConfig.enabled=not getgenv().PokersConfig.enabled; if getgenv().PokersConfig.enabled then refreshNoclip() else clearNoclip() end end })
MacrosTab:CreateKeybind({ Name="Toggle Auto GK",       CurrentKeybind="G", Flag="KB_AutoGK",    Callback=function() getgenv().AutoGKConfig.enabled=not getgenv().AutoGKConfig.enabled; persistAll() end })
MacrosTab:CreateKeybind({ Name="Toggle Reach",         CurrentKeybind="H", Flag="KB_Reach",     Callback=function() getgenv().ReachConfig.enabled=not getgenv().ReachConfig.enabled; if getgenv().ReachConfig.enabled then setFeaturePriority("reach") else clearFeaturePriority("reach") end; persistAll() end })
MacrosTab:CreateKeybind({ Name="Toggle Rainbow Flick", CurrentKeybind="F", Flag="KB_Rainbow",   Callback=function() getgenv().RainbowFlickConfig.enabled=not getgenv().RainbowFlickConfig.enabled; if getgenv().RainbowFlickConfig.enabled then setFeaturePriority("rainbowFlick") else clearFeaturePriority("rainbowFlick") end; persistAll() end })
MacrosTab:CreateKeybind({ Name="Toggle Auto Nero",     CurrentKeybind="N", Flag="KB_Nero",      Callback=function() getgenv().NeroConfig.enabled=not getgenv().NeroConfig.enabled end })
MacrosTab:CreateKeybind({ Name="Toggle Lob Shot",      CurrentKeybind="L", Flag="KB_Lob",       Callback=function() lobCfg.enabled=not lobCfg.enabled; if lobCfg.enabled then setFeaturePriority("lobShot") else clearFeaturePriority("lobShot") end; persistAll() end })
MacrosTab:CreateKeybind({ Name="Toggle Aimbot",        CurrentKeybind="Q", Flag="KB_Aimbot",    Callback=function() cfg.enabled=not cfg.enabled; if getgenv().AimbotSync then pcall(getgenv().AimbotSync,cfg.enabled) end; persistAll() end })
MacrosTab:CreateKeybind({ Name="Toggle Juggle V2",     CurrentKeybind="J", Flag="KB_Juggle2",   Callback=function() juggleV2.enabled=not juggleV2.enabled; if juggleV2.enabled then setFeaturePriority("juggleV2") else clearFeaturePriority("juggleV2") end; persistAll() end })

MacrosTab:CreateSection("Controller Keybinds")
local POKERS_CONTROLLER_BTN = Enum.KeyCode.ButtonL3
local POKERS_ALT_BTN        = Enum.KeyCode.DPadDown
local GK_CONTROLLER_BTN     = Enum.KeyCode.ButtonR3
local SNEAKY_CONTROLLER_BTN = Enum.KeyCode.ButtonX
local AIMBOT_CONTROLLER_BTN = Enum.KeyCode.ButtonY
MacrosTab:CreateKeybind({ Name="[Controller] Pokers",      CurrentKeybind="ButtonL3",  Flag="CKB_Phase",   Callback=function() getgenv().PokersConfig.enabled=not getgenv().PokersConfig.enabled; if getgenv().PokersConfig.enabled then refreshNoclip() else clearNoclip() end end })
MacrosTab:CreateKeybind({ Name="[Controller] Pokers Alt",  CurrentKeybind="DPadDown",  Flag="CKB_PhaseAlt",Callback=function() getgenv().PokersConfig.enabled=not getgenv().PokersConfig.enabled; if getgenv().PokersConfig.enabled then refreshNoclip() else clearNoclip() end end })
MacrosTab:CreateKeybind({ Name="[Controller] Auto GK",     CurrentKeybind="ButtonR3",  Flag="CKB_AutoGK",  Callback=function() getgenv().AutoGKConfig.enabled=not getgenv().AutoGKConfig.enabled; persistAll() end })
MacrosTab:CreateKeybind({ Name="[Controller] Sneaky",      CurrentKeybind="ButtonX",   Flag="CKB_Sneaky",  Callback=function() c.enabled=not c.enabled; if c.enabled then setFeaturePriority("sneaky") else clearFeaturePriority("sneaky") end; persistAll() end })
MacrosTab:CreateKeybind({ Name="[Controller] Aimbot",      CurrentKeybind="ButtonY",   Flag="CKB_Aimbot",  Callback=function() cfg.enabled=not cfg.enabled; if getgenv().AimbotSync then pcall(getgenv().AimbotSync,cfg.enabled) end; persistAll() end })

ConfigTab:CreateSection("Profile Management")
ConfigTab:CreateButton({ Name="💾 Save Config", Callback=function() Rayfield:SaveConfiguration(); persistAll(); Rayfield:Notify({Title="Scarlet V5",Content="Configuration saved.",Duration=3,Image=4483362458}) end })
ConfigTab:CreateButton({ Name="📂 Load Config", Callback=function() Rayfield:LoadConfiguration(); Rayfield:Notify({Title="Scarlet V5",Content="Configuration loaded.",Duration=3,Image=4483362458}) end })
ConfigTab:CreateButton({ Name="🗑 Reset Profile", Callback=function() if delfile and isfile and isfile(CONFIG_FILE) then pcall(function() delfile(CONFIG_FILE) end); Rayfield:Notify({Title="Scarlet",Content="Profile reset. Re-execute.",Duration=4,Image=4483362458}) end end })
ConfigTab:CreateKeybind({ Name="Toggle UI", CurrentKeybind="RightShift", HoldToInteract=false, Flag="ToggleUIKey", Callback=function() Window:Toggle() end })

InfoTab:CreateSection("About Scarlet V5")
InfoTab:CreateLabel("Scarlet V5 — Football utility script")
InfoTab:CreateLabel("Version: 5.0.0  |  Theme: Hollow Purple")
InfoTab:CreateSection("Community")
InfoTab:CreateButton({ Name="📨 Join Discord", Callback=function() Rayfield:Notify({Title="Discord",Content="discord.gg/CbZr64enZ5",Duration=6,Image=4483362458}) end })

task.spawn(function()
	if setfpscap and perf.boostFps then pcall(function() setfpscap(perf.maxFps) end) end
end)

task.spawn(function()
	if perf.disableShadows then pcall(function() Lighting.GlobalShadows=false end) end
	if perf.reduceSound then pcall(function() for _,s in pairs(game:GetService("SoundService"):GetDescendants()) do if s:IsA("Sound") then s.Volume=0 end end end) end
end)

task.spawn(function()
	while task.wait(0.5) do
		if perf.disableParticles then pcall(function() for _,v in pairs(workspace:GetDescendants()) do if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then v.Enabled=false end end end) end
		if perf.reduceLatency then pcall(function() local char=player.Character; if char then for _,v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CastShadow=false end end end end) end
		if perf.clearTerrain then pcall(function() workspace.Terrain.WaterWaveSize=0; workspace.Terrain.WaterWaveSpeed=0; workspace.Terrain.WaterReflectance=0; workspace.Terrain.WaterTransparency=1 end) end
	end
end)

Rayfield:LoadConfiguration()

Rayfield:Notify({
	Title    = "Scarlet V5",
	Content  = "Scarlet V5 Loaded. Join discord.gg/CbZr64enZ5",
	Duration = 5,
	Image    = 4483362458,
})
