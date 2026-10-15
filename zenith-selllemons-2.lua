if game.GameId == 7395930870 then
    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")

    local Tycoon = require(ReplicatedStorage.Modules.Tycoon.Tycoon)
    local TycoonAnalyzer = require(ReplicatedStorage.Modules.Tycoon.Component.TycoonAnalyzer)
    local Balance = require(ReplicatedStorage.Balance)
    local ClientTycoonEvolution = require(ReplicatedStorage.Modules.Tycoon.Component.Client.ClientTycoonEvolution)
    local ClientTycoonAscension = require(ReplicatedStorage.Modules.Tycoon.Component.Client.ClientTycoonAscension)
    local TycoonBalances = require(ReplicatedStorage.Modules.Tycoon.Component.TycoonBalances)
    local ClientTycoonRebirth = require(ReplicatedStorage.Modules.Tycoon.Component.Client.ClientTycoonRebirth)
    local Huge = require(ReplicatedStorage.Modules.Huge)
    local ClientTycoonPowers = require(ReplicatedStorage.Modules.Tycoon.Component.Client.ClientTycoonPowers)
    local ClientTycoonBalances = require(ReplicatedStorage.Modules.Tycoon.Component.Client.ClientTycoonBalances)
    local Config = require(ReplicatedStorage.Config)

    local introPurchased = false

    local function GetTycoon(player)
        for _, v in ipairs(workspace:GetChildren()) do
            if v.Name:find("Tycoon") then
                local owner = v:FindFirstChild("Owner")
                if owner and owner.Value == player then
                    return v
                end
            end
        end
    end

    local tycoonNum = GetTycoon(plr)

    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = "Zenith Hub â Sell Lemons",
        Icon = 0,
        LoadingTitle = "Zenith Hub",
        LoadingSubtitle = "by marcus | discord.gg/zenithhub",
        Theme = "Dark",
        CustomTheme = {
            TextColor = Color3.fromRGB(255, 234, 234),
            Background = Color3.fromRGB(14, 6, 6),
            Topbar = Color3.fromRGB(20, 8, 8),
            Shadow = Color3.fromRGB(8, 3, 3),
            NotificationBackground = Color3.fromRGB(20, 8, 8),
            NotificationActionsBackground = Color3.fromRGB(26, 10, 10),
            TabBackground = Color3.fromRGB(18, 7, 7),
            TabStroke = Color3.fromRGB(60, 20, 20),
            TabBackgroundSelected = Color3.fromRGB(210, 38, 38),
            TabTextColor = Color3.fromRGB(178, 120, 120),
            SelectedTabTextColor = Color3.fromRGB(255, 234, 234),
            ElementBackground = Color3.fromRGB(26, 10, 10),
            ElementBackgroundHover = Color3.fromRGB(36, 14, 14),
            SecondaryElementBackground = Color3.fromRGB(32, 12, 12),
            ElementStroke = Color3.fromRGB(60, 20, 20),
            SecondaryElementStroke = Color3.fromRGB(50, 18, 18),
            SliderBackground = Color3.fromRGB(50, 16, 16),
            SliderProgress = Color3.fromRGB(210, 38, 38),
            SliderStroke = Color3.fromRGB(80, 28, 28),
            ToggleBackground = Color3.fromRGB(50, 16, 16),
            ToggleEnabled = Color3.fromRGB(210, 38, 38),
            ToggleDisabled = Color3.fromRGB(60, 20, 20),
            ToggleEnabledStroke = Color3.fromRGB(180, 40, 40),
            ToggleDisabledStroke = Color3.fromRGB(70, 25, 25),
            ToggleEnabledOuterStroke = Color3.fromRGB(150, 35, 35),
            ToggleDisabledOuterStroke = Color3.fromRGB(50, 18, 18),
            DropdownSelected = Color3.fromRGB(210, 38, 38),
            DropdownUnselected = Color3.fromRGB(50, 16, 16),
            InputBackground = Color3.fromRGB(26, 10, 10),
            InputStroke = Color3.fromRGB(60, 20, 20),
            PlaceholderColor = Color3.fromRGB(120, 60, 60),
        },
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
    })

    local Tabs = {
        Farm = Window:CreateTab("Farm", "sprout"),
        Stats = Window:CreateTab("Players Stats", "bar-chart-2"),
        Settings = Window:CreateTab("Settings", "settings"),
    }

    local UIActive = true

    Rayfield:Notify({
        Title = "Zenith Hub",
        Content = "Sell Lemons loaded. discord.gg/zenithhub",
        Duration = 5,
        Image = 4483362458,
    })

    local selectedPlayer = plr
    local selectedTycoon = GetTycoon(plr)
    local statConnections = {}

    local function updatePlayerList()
        local playerList = {}
        for _, player in ipairs(Players:GetPlayers()) do
            table.insert(playerList, player.Name)
        end
        return playerList
    end

    local PlayersDropdown = Tabs.Stats:CreateDropdown({
        Name = "Choose Player",
        Options = updatePlayerList(),
        CurrentOption = {plr.Name},
        MultipleOptions = false,
        Flag = "Players",
        Callback = function(value)
            local player = Players:FindFirstChild(value[1])
            if player then ConnectPlayer(player) end
        end,
    })

    local function UpdateStats()
        if not selectedTycoon then return end
        local values = selectedTycoon.Values.Values
        Rayfield:Notify({
            Title = "Stats Updated",
            Content = "Rebirths: " .. tostring(values:GetAttribute("TotalRebirths") or 0) ..
                      " | Evolves: " .. tostring(values:GetAttribute("TotalEvolves") or 0) ..
                      " | Ascension: " .. tostring(values:GetAttribute("Ascension") or 0),
            Duration = 3,
        })
    end

    function ConnectPlayer(player)
        for _, connection in ipairs(statConnections) do connection:Disconnect() end
        table.clear(statConnections)
        selectedPlayer = player
        selectedTycoon = GetTycoon(player)
        if not selectedTycoon then return end
        local values = selectedTycoon.Values.Values
        UpdateStats()
        table.insert(statConnections, values:GetAttributeChangedSignal("TotalRebirths"):Connect(UpdateStats))
        table.insert(statConnections, values:GetAttributeChangedSignal("TotalEvolves"):Connect(UpdateStats))
        table.insert(statConnections, values:GetAttributeChangedSignal("Ascension"):Connect(UpdateStats))
    end

    Players.PlayerAdded:Connect(function() PlayersDropdown:Set(updatePlayerList()) end)
    Players.PlayerRemoving:Connect(function() PlayersDropdown:Set(updatePlayerList()) end)
    ConnectPlayer(plr)

    local Options = {}

    local function GetNextPurchase()
        local tycoon = Tycoon.getLocal()
        if not tycoon then return nil end
        local analyzer = tycoon:GetComponent(TycoonAnalyzer)
        if not analyzer then return nil end
        local purchases = analyzer:GetPurchases()
        for _, purchaseName in ipairs(Balance.PurchaseOrder) do
            local purchase = purchases[purchaseName]
            if purchase and purchase:IsEnabled() and not purchase:IsPurchased() then
                return purchase
            end
        end
        return nil
    end

    local function RestoreSettings(settings)
        if Options.Power then Options.Power = settings.power end
        if Options.Upgrade then Options.Upgrade = settings.upgrade end
        if Options.Rebirth then Options.Rebirth = settings.rebirth end
        if Options.Evolution then Options.Evolution = settings.evolution end
    end

    local function startAutoUpgrade()
        task.spawn(function()
            local tycoon
            repeat task.wait(0.5) tycoon = Tycoon.getLocal() until tycoon
            local analyzer = tycoon:GetComponent(TycoonAnalyzer)
            local balances = tycoon:GetComponent(ClientTycoonBalances)
            if not analyzer or not balances then return end
            while UIActive do
                if Options.Upgrade then
                    local earners = analyzer:GetEarners()
                    for name, earner in pairs(earners) do
                        if earner:IsEnabled() then
                            local info = earner:GetNextUpgradeInfo()
                            if info and not info.Max then
                                local cash = balances:GetCash()
                                if info.Price <= cash then
                                    pcall(function() earner:Upgrade(info.Count, true) end)
                                    task.wait(0.005)
                                end
                            end
                        end
                    end
                end
                task.wait(0.005)
            end
        end)
    end

    local function startAutoRebirth()
        task.spawn(function()
            while UIActive do
                if Options.Rebirth then
                    pcall(function()
                        local tycoon = Tycoon.getLocal()
                        if not tycoon then return end
                        local balances = tycoon:GetComponent(TycoonBalances)
                        local rebirth = tycoon:GetComponent(ClientTycoonRebirth)
                        if not balances or not rebirth then return end
                        local currentInvestors = balances:GetInvestors()
                        local potentialInvestors = rebirth:GetPotentialInvestors()
                        local multiplier = Huge.divide(potentialInvestors, Huge.max(currentInvestors, Huge.toHuge(100)))
                        if multiplier >= Huge.toHuge(tonumber(Options.RebirthMultiplier) or 100) then
                            rebirth:RebirthAsync()
                            if Options.Power then
                                local powers = tycoon:GetComponent(ClientTycoonPowers)
                                local balance = tycoon:GetComponent(ClientTycoonBalances)
                                local ci = balance:GetInvestors()
                                local safeAmount = Huge.multiply(ci, Huge.toHuge(0.5))
                                for powerName, _ in Config.Powers do
                                    local upgradePrice = powers:GetUpgradePrice(powerName)
                                    if upgradePrice and upgradePrice <= safeAmount then
                                        pcall(function() powers:UpgradeAsync(powerName) end)
                                    end
                                end
                            end
                        end
                    end)
                end
                task.wait(1)
            end
        end)
    end

    local function startAutoEvolution()
        task.spawn(function()
            while UIActive do
                if Options.Evolution then
                    pcall(function()
                        local tycoon = Tycoon.getLocal()
                        if not tycoon then return end
                        local evolution = tycoon:GetComponent(ClientTycoonEvolution)
                        if not evolution then return end
                        local progress, _ = evolution:GetEvolutionProgress()
                        if progress >= 1 then evolution:EvolveAsync() end
                    end)
                end
                task.wait(1)
            end
        end)
    end

    local function startIntroPurchase(tycoon)
        local analyzer = tycoon:GetComponent(TycoonAnalyzer)
        local balances = tycoon:GetComponent(ClientTycoonBalances)
        if not analyzer or not balances then return end
        local purchases = analyzer:GetPurchases()
        local introPurchase = purchases["StaircaseIntro"]
        if not introPurchase then return end
        if introPurchase:IsPurchased() then introPurchased = true return end
        local introPrice = introPurchase:GetPrice()
        local cash = balances:GetCash()
        if cash >= introPrice then
            local orig = { power=Options.Power, upgrade=Options.Upgrade, rebirth=Options.Rebirth, evolution=Options.Evolution }
            Options.Power=false Options.Upgrade=false Options.Rebirth=false Options.Evolution=false
            task.wait(1.5)
            introPrice = introPurchase:GetPrice() cash = balances:GetCash()
            if cash >= introPrice then
                local timeout = tick() + 15
                repeat
                    task.wait(0.1)
                    pcall(function() introPurchase:TryPurchaseAsync() end)
                    purchases = analyzer:GetPurchases()
                    introPurchase = purchases["StaircaseIntro"]
                until not introPurchase or introPurchase:IsPurchased() or tick() > timeout
            end
            RestoreSettings(orig)
        end
    end

    local function startAutoPurchase()
        task.spawn(function()
            while UIActive do
                if Options.Purchase then
                    pcall(function()
                        local tycoon = Tycoon.getLocal()
                        if not tycoon then return end
                        if not introPurchased then startIntroPurchase(tycoon) end
                        local balances = tycoon:GetComponent(ClientTycoonBalances)
                        local purchase = GetNextPurchase()
                        if not purchase then return end
                        if purchase.DisplayName == "Cup Stand" or purchase.DisplayName == "Juicer" then
                            tycoonNum.Remotes.WakeIncomeStream:InvokeServer("LemonStand")
                        end
                        local cash = balances:GetCash()
                        local price = purchase:GetPrice()
                        if cash >= price then purchase:TryPurchaseAsync() end
                    end)
                end
                task.wait(0.005)
            end
        end)
    end

    local function startAutoAscend()
        task.spawn(function()
            while UIActive do
                if Options.Ascend then
                    pcall(function()
                        local tycoon = Tycoon.getLocal()
                        if not tycoon then return end
                        local analyzer = tycoon:GetComponent(TycoonAnalyzer)
                        local balance = tycoon:GetComponent(ClientTycoonBalances)
                        local ascension = tycoon:GetComponent(ClientTycoonAscension)
                        if not analyzer or not balance or not ascension then return end
                        local purchases = analyzer:GetPurchases()
                        local finalPurchase = purchases["StaircaseStepFinal"]
                        if not finalPurchase then return end
                        local price = finalPurchase:GetPrice()
                        local cash = balance:GetCash()
                        if cash >= price then
                            local orig = { power=Options.Power, upgrade=Options.Upgrade, rebirth=Options.Rebirth, evolution=Options.Evolution }
                            Options.Purchase=true Options.Power=false Options.Upgrade=false Options.Rebirth=false Options.Evolution=false
                            local broke = false
                            repeat
                                task.wait(0.2)
                                price = finalPurchase:GetPrice() cash = balance:GetCash()
                                if cash >= price then
                                    purchases = analyzer:GetPurchases()
                                    finalPurchase = purchases["StaircaseStepFinal"]
                                else
                                    RestoreSettings(orig) broke = true
                                end
                            until finalPurchase:IsPurchased() or broke
                            local oldAscension = ascension:GetAscension()
                            ascension:AscendAsync()
                            local x = 0
                            repeat
                                task.wait(0.5) x = x + 1
                                if x % 5 == 0 then oldAscension = ascension:GetAscension() ascension:AscendAsync() end
                            until ascension:GetAscension() > oldAscension or x == 26
                            introPurchased = false
                            RestoreSettings(orig)
                        end
                    end)
                end
                task.wait(0.05)
            end
        end)
    end

    Tabs.Farm:CreateToggle({
        Name = "Auto Purchase",
        CurrentValue = false,
        Flag = "Purchase",
        Callback = function(v) Options.Purchase = v startAutoPurchase() end,
    })

    Tabs.Farm:CreateToggle({
        Name = "Auto Power",
        CurrentValue = false,
        Flag = "Power",
        Callback = function(v) Options.Power = v end,
    })

    Tabs.Farm:CreateToggle({
        Name = "Auto Upgrade",
        CurrentValue = false,
        Flag = "Upgrade",
        Callback = function(v) Options.Upgrade = v startAutoUpgrade() end,
    })

    Tabs.Farm:CreateToggle({
        Name = "Auto Rebirth",
        CurrentValue = false,
        Flag = "Rebirth",
        Callback = function(v) Options.Rebirth = v startAutoRebirth() end,
    })

    Tabs.Farm:CreateInput({
        Name = "Rebirth Multiplier",
        CurrentValue = "100",
        PlaceholderText = "100",
        RemoveTextAfterFocusLost = false,
        Flag = "RebirthMultiplier",
        Callback = function(v) Options.RebirthMultiplier = tonumber(v) or 100 end,
    })

    Tabs.Farm:CreateToggle({
        Name = "Auto Evolution",
        CurrentValue = false,
        Flag = "Evolution",
        Callback = function(v) Options.Evolution = v startAutoEvolution() end,
    })

    Tabs.Farm:CreateToggle({
        Name = "Auto Ascend",
        CurrentValue = false,
        Flag = "Ascend",
        Callback = function(v) Options.Ascend = v startAutoAscend() end,
    })

    Tabs.Settings:CreateToggle({
        Name = "Disable 3D Rendering",
        CurrentValue = false,
        Flag = "Render",
        Callback = function(v)
            game:GetService("RunService"):Set3dRenderingEnabled(not v)
        end,
    })

    Tabs.Settings:CreateToggle({
        Name = "Anti AFK",
        CurrentValue = true,
        Flag = "AntiAFK",
        Callback = function(v) end,
    })

    Tabs.Settings:CreateButton({
        Name = "Server Hop",
        Callback = function()
            local success, response = pcall(function()
                return game:HttpGet(("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"):format(game.PlaceId))
            end)
            if not success then return end
            local servers = HttpService:JSONDecode(response)
            for _, server in ipairs(servers.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, game.Players.LocalPlayer)
                    break
                end
            end
        end,
    })

    Rayfield:LoadConfiguration()
else
    warn("[Zenith] Wrong game. Expected GameId: 7395930870")
end
