local success, library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/FengYu-ui/refs/heads/main/UI.lua"))()
end)

if not success then
    return
end

local localPlayer = game.Players.LocalPlayer
local gameMap = workspace.Map
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local lolz = {}
if getgenv().emergency_stop == nil then
    getgenv().emergency_stop = false
end

local function StudsIntoPower(studs)
    return (studs * 6)
end

function lolz:ExtendHitbox(studs, time)
    local distance = StudsIntoPower(studs)
    local start = tick()

    if getgenv().emergency_stop == true then
        getgenv().emergency_stop = false
    end

    repeat 
        game:GetService("RunService").Heartbeat:Wait()

        local player = game:GetService("Players").LocalPlayer
        local char = player.Character
        if not (char and char:FindFirstChild("HumanoidRootPart")) then
            continue
        end

        local hrp = char.HumanoidRootPart
        local velocity = hrp.Velocity

        hrp.Velocity = velocity * distance + (hrp.CFrame.LookVector * distance)

        game:GetService("RunService").RenderStepped:Wait()

        if char and char:FindFirstChild("HumanoidRootPart") then
            hrp.Velocity = velocity
        end
    until tick() - start > tonumber(time) or getgenv().emergency_stop == true

    if getgenv().emergency_stop == true then
        getgenv().emergency_stop = false
    end
end

function lolz:StopExtendingHitbox()
    getgenv().emergency_stop = true
end

local Network = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network")
local PathfindingService = game:GetService("PathfindingService")

local isKiller = false
local isSurvivor = true
local killerModel = nil
local playingState = "Playing"

task.spawn(function()
    while task.wait() do
        local _isKiller = false
        if workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers") then
            for _, v in pairs(workspace.Players.Killers:GetChildren()) do
                if v:GetAttribute("Username") and Players:FindFirstChild(v:GetAttribute("Username")) then
                    killerModel = v
                end
                if v:GetAttribute("Username") == localPlayer.Name then
                    killerModel = v
                    _isKiller = true
                end
            end
            isSurvivor = not _isKiller
            isKiller = _isKiller
        end
    end
end)

local FlipCooldown = false
function FortniteFlips()
    if FlipCooldown then
        return
    end

    FlipCooldown = true
    local character = localPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
    if not hrp or not humanoid then
        FlipCooldown = false
        return
    end

    local savedTracks = {}
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            savedTracks[#savedTracks + 1] = { track = track, time = track.TimePosition }
            track:Stop(0)
        end
    end

    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)

    local duration = 0.45
    local steps = 120
    local startCFrame = hrp.CFrame
    local forwardVector = startCFrame.LookVector
    local upVector = Vector3.new(0, 1, 0)
    
    task.spawn(function()
        local startTime = tick()
        for i = 1, steps do
            local t = i / steps
            local height = 4 * (t - t ^ 2) * 10
            local nextPos = startCFrame.Position + forwardVector * (35 * t) + upVector * height
            local rotation = startCFrame.Rotation * CFrame.Angles(-math.rad(i * (360 / steps)), 0, 0)

            hrp.CFrame = CFrame.new(nextPos) * rotation
            local elapsedTime = tick() - startTime
            local expectedTime = (duration / steps) * i
            local waitTime = expectedTime - elapsedTime
            if waitTime > 0 then
                task.wait(waitTime)
            end
        end

        hrp.CFrame = CFrame.new(startCFrame.Position + forwardVector * 35) * startCFrame.Rotation
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        humanoid:ChangeState(Enum.HumanoidStateType.Running)

        if animator then
            for _, data in ipairs(savedTracks) do
                local track = data.track
                track:Play()
                track.TimePosition = data.time
            end
        end
        task.wait(0.25)
        FlipCooldown = false
    end)
end

local originalValues = {}
local paths = {
    "HideKillerWins",
    "HidePlaytime",
    "HideSurvivorWins"
}

local function saveOriginals(player)
    if not originalValues[player.UserId] then
        originalValues[player.UserId] = {}
    end
    for _, key in ipairs(paths) do
        local value = player.PlayerData.Settings.Privacy:FindFirstChild(key)
        originalValues[player.UserId][key] = value.Value
    end
end

local function reveal(player)
    for _, key in ipairs(paths) do
        local value = player.PlayerData.Settings.Privacy:FindFirstChild(key)
        value.Value = false
    end
end

local function restore(player)
    if originalValues[player.UserId] then
        for key, val in pairs(originalValues[player.UserId]) do
            local value = player.PlayerData.Settings.Privacy:FindFirstChild(key)
            value.Value = val
        end
    end
end

local function hiddenStatsFunc(disable)
    for _, player in ipairs(Players:GetPlayers()) do
        if disable then
            saveOriginals(player)
            reveal(player)
        else
            restore(player)
        end
    end
end

local antiHiddenStatsEnabled = false
Players.PlayerAdded:Connect(function(player)
    if antiHiddenStatsEnabled then
        saveOriginals(player)
        reveal(player)
    end
end)

local Flip = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local button = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
local move = Instance.new("ImageLabel")

Flip.Name = "Flip"
Flip.Parent = gethui()
Flip.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Flip.DisplayOrder = 999999
Flip.OnTopOfCoreBlur = true
Flip.Enabled = false

Frame.Parent = Flip
Frame.AnchorPoint = Vector2.new(1, 1)
Frame.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(1, -30, 1, -30)
Frame.Size = UDim2.new(0, 98, 0, 44)

button.Name = "button"
button.Parent = Frame
button.AnchorPoint = Vector2.new(0, 0.5)
button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundTransparency = 1.000
button.BorderColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 0
button.Position = UDim2.new(0, 5, 0.5, 0)
button.Size = UDim2.new(0, 36, 0, 36)
button.Image = "rbxassetid://114905930912702"
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

UICorner.CornerRadius = UDim.new(0, 13)
UICorner.Parent = Frame

move.Name = "move"
move.Parent = Frame
move.AnchorPoint = Vector2.new(1, 0.5)
move.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
move.BackgroundTransparency = 1.000
move.BorderColor3 = Color3.fromRGB(0, 0, 0)
move.BorderSizePixel = 0
move.Position = UDim2.new(1, -5, 0.5, 0)
move.Size = UDim2.new(0, 36, 0, 36)
move.Image = "rbxassetid://107178621515925"

local UIS = game:GetService("UserInputService")
local function dragify(Frame, DragInp)
    local dragToggle = nil
    local dragInput = nil
    local dragStart = nil
    local Delta
    local Position
    local startPos
    local function updateInput(input)
        Delta = input.Position - dragStart
        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        Frame.Position = Position
    end
    DragInp.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
            dragToggle = true
            dragStart = input.Position
            startPos = Frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    DragInp.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            updateInput(input)
        end
    end)
end
dragify(Frame, move)
getgenv().FlipUI = Flip
button.MouseButton1Click:Connect(FortniteFlips)

local window = library:new("殺脚本┇被遗弃")

if isPlayerVIP() then
    local tag1 = window:AddTag("VIP用户", Color3.fromRGB(255, 215, 0))
end
local tag_normal = window:AddTag("正试版", Color3.fromRGB(100, 200, 255))

local FengYu = window:Tab("〖服务器】",'84830962019412')

local about = FengYu:section("〖服务器】",true)

about:Button("重新加入服务器", function()
    pcall(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end)
end)

about:Button("加入延迟低的服务器", function()
    local function findRandomServer()
        local success, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/" .. 
                game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
            )
        end)
        
        if success and data and data.data then
            local availableServers = {}
            for _, server in ipairs(data.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(availableServers, server)
                end
            end
            
            if #availableServers > 0 then
                local randomServer = availableServers[math.random(1, #availableServers)]
                return randomServer.id
            end
        end
        return nil
    end
    
    local serverId = findRandomServer()
    if serverId then
        pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverId, game.Players.LocalPlayer)
        end)
    end
end)

about:Button("加入新手服务器", function()
    local function findSmallerServer()
        local success, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/" .. 
                game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
            )
        end)
        
        if success and data and data.data then
            table.sort(data.data, function(a, b)
                return a.playing < b.playing
            end)
            
            local currentPlayers = #game.Players:GetPlayers()
            
            for _, server in ipairs(data.data) do
                if server.playing < currentPlayers and server.id ~= game.JobId and server.playing > 0 then
                    return server.id
                end
            end
            
            for _, server in ipairs(data.data) do
                if server.id ~= game.JobId and server.playing > 0 then
                    return server.id
                end
            end
        end
        return nil
    end
    
    local serverId = findSmallerServer()
    if serverId then
        pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverId, game.Players.LocalPlayer)
        end)
    end
end)

local FengYu = window:Tab("〖基础】",'16060333448')

local Feng = FengYu:section("〖设置】",true)

local vu2 = {
    noclip = false,
    infiniteJump = false,
    flying = false,
    killAllActive = false,
    killAllTeleport = false,
    autoRepairActive = false
}

local vu4 = {
    flySpeed = 50,
    teleportCooldown = 0.5,
    repairCheckInterval = 1.5,
    killAllSpeed = 50
}

local vu6 = {
    flightConn = nil,
    bodyGyro = nil,
    bodyVel = nil
}

Feng:Toggle("飞行", "Fly", false, function(value)
    vu2.flying = value
    if value then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            humanoid.AutoRotate = false
            vu6.bodyGyro = Instance.new("BodyGyro")
            vu6.bodyGyro.P = 90000
            vu6.bodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
            vu6.bodyGyro.CFrame = root.CFrame
            vu6.bodyGyro.Parent = root
            
            vu6.bodyVel = Instance.new("BodyVelocity")
            vu6.bodyVel.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
            vu6.bodyVel.Velocity = Vector3.zero
            vu6.bodyVel.Parent = root
            
            vu6.flightConn = game:GetService("RunService").Heartbeat:Connect(function()
                local cam = workspace.CurrentCamera
                local lookVector = cam.CFrame.LookVector
                local rightVector = cam.CFrame.RightVector
                local moveDir = humanoid.MoveDirection
                
                local forward = moveDir:Dot(Vector3.new(lookVector.X, 0, lookVector.Z).Unit)
                local right = moveDir:Dot(Vector3.new(rightVector.X, 0, rightVector.Z).Unit)
                local up = moveDir.Magnitude <= 0 and 0 or lookVector.Y * forward
                
                local velocity = lookVector * forward + rightVector * right
                local finalVelocity = Vector3.new(velocity.X, up, velocity.Z)
                
                if finalVelocity.Magnitude > 1 then
                    finalVelocity = finalVelocity.Unit
                end
                
                vu6.bodyVel.Velocity = finalVelocity * vu4.flySpeed
                vu6.bodyGyro.CFrame = CFrame.lookAt(root.Position, root.Position + lookVector, cam.CFrame.UpVector)
            end)
        end
    else
        if vu6.flightConn then
            vu6.flightConn:Disconnect()
            vu6.flightConn = nil
        end
        if vu6.bodyGyro then
            vu6.bodyGyro:Destroy()
            vu6.bodyGyro = nil
        end
        if vu6.bodyVel then
            vu6.bodyVel:Destroy()
            vu6.bodyVel = nil
        end
        
        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.AutoRotate = true
            end
        end
    end
end)

Feng:Slider("飞行速度", "FlySpeed", 5, 50, 150, true, function(value)
    vu4.flySpeed = value
end)

Feng:Toggle("穿墙", "NoclipToggle", false, function(bool)
    _G.noclipState = bool
end)

Feng:Toggle("允许跳跃", "AllowJump", false, function(bool)
    _G.allowJump = bool
    if bool then
        game.StarterGui:SetCore("SendNotification", { 
            Title = "ioio", 
            Text = "一直跳跃会踢你，因为幽灵会以为你是无敌少侠", 
            Duration = 9 
        })
    end
end)

Feng:Toggle("无限跳跃", "InfiniteJump", false, function(value)
    vu2.infiniteJump = value
    if value then
        _G.InfiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState("Jumping")
            end
        end)
    elseif _G.InfiniteJumpConnection then
        _G.InfiniteJumpConnection:Disconnect()
    end
end)

Feng:Toggle("隐身", "InvisToggle", false, function(bool)
    _G.invisEnabled = bool
end)

Feng:Button("自杀", function()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
end)

local FengYu = window:DualTab("〖幸存者】",'84830962019412')

local Feng = FengYu:section("〖机会部分】", "Left", true)

local function chanceAimbot(state)
    local CA = state
    if state then
        if game.Players.LocalPlayer.Character.Name ~= "Chance" then
            return
        end
        
        local RemoteEvent = game:GetService("ReplicatedStorage")
            :WaitForChild("Modules")
            :WaitForChild("Network")
            :WaitForChild("RemoteEvent")
            
        local CAbotConnection = RemoteEvent.OnClientEvent:Connect(function(...)
            local args = {...}
            if args[1] == "UseActorAbility" and args[2] == "Shoot" then 
                local killerContainer = game.Workspace.Players:FindFirstChild("Killers")
                if killerContainer then 
                    local killer = killerContainer:FindFirstChildOfClass("Model")
                    if killer and killer:FindFirstChild("HumanoidRootPart") then 
                        local killerHRP = killer.HumanoidRootPart
                        local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if playerHRP then 
                            local TMP = 0.35
                            local AMD = 2
                            local endTime = tick() + AMD
                            while tick() < endTime do
                                game:GetService("RunService").RenderStepped:Wait()
                                local predictedTarget = killerHRP.Position + (killerHRP.Velocity * TMP)
                                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = killerHRP.CFrame + Vector3.new(0, 0, -2)
                            end
                        end
                    end
                end
            end
        end)
        
        chanceAimbot.connection = CAbotConnection
    else
        if chanceAimbot.connection then
            chanceAimbot.connection:Disconnect()
            chanceAimbot.connection = nil
        end
    end
end

Feng:Toggle("机会自瞄", "FengYu", false, function(state)
    chanceAimbot(state)
end)

local function cleanup()
    if chanceAimbot.connection then
        chanceAimbot.connection:Disconnect()
        chanceAimbot.connection = nil
    end
end

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if chanceAimbot.connection then
        chanceAimbot(false)
    end
end)
local Feng = FengYu:section("〖Guest 1337功能】", "Right", true)

Feng:Toggle("动画检测", "AutoBlockAnimation", false, function(Value)
    autoBlockOn = Value
end)

Feng:Toggle("音效检测", "AutoBlockAudio", false, function(Value)
    autoBlockAudioOn = Value
end)
Feng:Label("建议全打开")
Feng:Toggle("自动肘击", "AutoPunch", false, function(Value)
    autoPunchOn = Value
end)
Feng:Label("只支持[斩首者，诺丽，1×4，约翰多]的格挡")
Feng:Label("我们拭目以待其他杀手")

local FengYu = window:Tab("〖发电机】",'84830962019412')

local Feng = FengYu:section("〖修复功能】", true)

Feng:Toggle("[总开关]自动修复发电机（推荐开启）", "AutoRepair", false, function(value)
    vu2.autoRepairActive = value
end)

local function findNearestGenerator()
    local character = game.Players.LocalPlayer.Character
    if not character then return nil end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local generators = {}
    if workspace:FindFirstChild("Map") then
        local ingame = workspace.Map:FindFirstChild("Ingame")
        if ingame then
            local map = ingame:FindFirstChild("Map")
            if map then
                for _, obj in pairs(map:GetChildren()) do
                    if obj.Name == "Generator" then
                        table.insert(generators, obj)
                    end
                end
            end
        end
    end
    
    local nearest = nil
    local nearestDist = math.huge
    
    for _, gen in pairs(generators) do
        local part = gen:FindFirstChildWhichIsA("BasePart")
        if part then
            local dist = (root.Position - part.Position).Magnitude
            if dist < nearestDist then
                nearest = gen
                nearestDist = dist
            end
        end
    end
    
    return nearest
end

local function repairGenerator(generator)
    if not generator then return false end
    
    local remotes = generator:FindFirstChild("Remotes")
    if remotes then
        local re = remotes:FindFirstChild("RE")
        if re and re:IsA("RemoteEvent") then
            re:FireServer()
            return true
        end
    end
    
    return false
end

spawn(function()
    while wait() do
        if vu2.autoRepairActive then
            local generator = findNearestGenerator()
            if generator then
                repairGenerator(generator)
                wait(vu4.repairCheckInterval)
            end
        end
        wait(0.1)
    end
end)

local function getValidGenerators()
    local validGenerators = {}
    local mapParent = workspace:FindFirstChild("Map")
    if mapParent then
        local ingame = mapParent:FindFirstChild("Ingame")
        if ingame then
            local generatorFolder = ingame:FindFirstChild("Map")
            if generatorFolder then
                for _, g in ipairs(generatorFolder:GetChildren()) do
                    if g.Name == "Generator" and g:FindFirstChild("Progress") and g.Progress.Value < 100 then
                        table.insert(validGenerators, g)
                    end
                end
            end
        end
    end
    return validGenerators
end

local function getNearestGenerator()
    local player = game.Players.LocalPlayer
    local validGenerators = getValidGenerators()
    local closest, shortest = nil, math.huge
    if player and player.Character and player.Character.PrimaryPart then
        local pos = player.Character.PrimaryPart.Position
        for _, g in ipairs(validGenerators) do
            local part = g.PrimaryPart or g:FindFirstChildWhichIsA("BasePart")
            if part then
                local dist = (part.Position - pos).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = g
                end
            end
        end
    end
    return closest
end

local function getGeneratorCFrame(generator)
    local TC = nil
    if generator:IsA("Model") then
        if generator.PrimaryPart then
            TC = generator.PrimaryPart.CFrame
        else
            for _, part in ipairs(generator:GetDescendants()) do
                if part:IsA("BasePart") then
                    TC = part.CFrame
                    break
                end
            end
        end
    elseif generator:IsA("BasePart") then
        TC = generator.CFrame
    end
    return TC and (TC * CFrame.new(0, 3, 0)) or nil
end

Feng:Button("单次传送", function()
    local player = game.Players.LocalPlayer
    local target = getNearestGenerator()
    
    if not target then
        return
    end
    
    local cf = getGeneratorCFrame(target)
    if cf and player.Character and player.Character.PrimaryPart then
        player.Character:SetPrimaryPartCFrame(cf)
    end
end)

Feng:Label("====================")
Feng:Toggle("[全自动]完成已知发电机", "FengYu", false, function(bool)
    _G.instantGenerator = bool

    task.spawn(function()
        while _G.instantGenerator and task.wait() do
            if workspace:FindFirstChild("Map") and gameMap:FindFirstChild("Ingame") and gameMap.Ingame:FindFirstChild("Map") then
                pcall(function()
                    for _, v in pairs(gameMap.Ingame.Map:GetChildren()) do
                        pcall(function()
                            if not generatorsDid[v] and v.Name == "Generator" and v:FindFirstChild("Scripts") and v.Scripts:FindFirstChild("Client") then
                                if not getsenv(v.Scripts.Client).toggleGeneratorState then return end
                                generatorsDid[v] = true
                                local old; old = hookfunction(getsenv(v.Scripts.Client).toggleGeneratorState, newcclosure(function(a)
                                    if checkcaller() then
                                        return old(a)
                                    end

                                    if not _G.instantGenerator then
                                        return old(a) 
                                    end

                                    if a ~= "enter" then 
                                        activelyAutoing = false
                                        return old("leave")
                                    end

                                    local result = v.Remotes.RF:InvokeServer("enter")
                                    if result ~= "fixing" then
                                        return
                                    end

                                    activelyAutoing = true

                                    for i = 1, 4 do
                                        if v.Progress.Value >= 100 then break end
                                        v.Remotes.RE:FireServer()
                                        setthreadidentity(8)
                                        Notify("发电机步骤", "完成谜题 " .. i, 4)
                                        generatorWait()
                                    end

                                    activelyAutoing = false
                                    return ""
                                end))
                            end
                        end)
                    end
                end)
            end
        end
    end)
end)

Feng:Toggle("[全自动]打开发电机", "FengYu", false, function(bool)
    _G.autoGen = bool
    task.spawn(function()
        while _G.autoGen and task.wait() do
            if gameMap:FindFirstChild("Ingame") and gameMap.Ingame:FindFirstChild("Map") then
                pcall(function()
                    for _, v in pairs(gameMap.Ingame.Map:GetChildren()) do
                        if v.Name == "Generator" then
                            pcall(function()
                                local function nextStep()
                                    if localPlayer.PlayerGui:FindFirstChild("PuzzleUI") then return end
                                    if activelyAutoing then return end

                                    if v.Main:FindFirstChild("Prompt") then
                                        fireproximityprompt(v.Main.Prompt)
                                    end
                                    task.wait(1)
                                end

                                local hello = v.Positions.Center.Position
                                local hello2 = v.Positions.Right.Position
                                local hello3 = v.Positions.Left.Position

                                if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return end

                                local pos = localPlayer.Character.HumanoidRootPart.Position
                                if (pos - hello).Magnitude <= 4 then
                                    nextStep()
                                elseif (pos - hello2).Magnitude <= 4 then
                                    nextStep()
                                elseif (pos - hello3).Magnitude <= 4 then
                                    nextStep()
                                end
                            end)
                        end
                    end
                end)
            end
        end
    end)
end)

Feng:Button("自动打开发电机", function()
    if activelyAutoing then return end
    pcall(function()
        if not (gameMap and gameMap.Ingame and gameMap.Ingame.Map) then return end
        for _, v in pairs(gameMap.Ingame.Map:GetChildren()) do
            if v.Name == "Generator" then
                pcall(function ()
                    if localPlayer.PlayerGui:FindFirstChild("PuzzleUI") then
                        local hello = v.Positions.Center.Position
                        if (localPlayer.Character.HumanoidRootPart.Position - hello).Magnitude <= 21 then
                            for i = 1, 4 do
                                if v.Progress.Value >= 100 then break end

                                if activelyAutoing then return end
                                if not localPlayer.PlayerGui:FindFirstChild("PuzzleUI") then break end

                                setthreadidentity(8)
                                Notify("发电机步骤", "完成谜题 " .. i, 4 )
                                v.Remotes.RE:FireServer()
                                generatorWait()
                            end
                        end
                    end
                end)
            end
        end
    end)
end)

local FengYu = window:Tab("〖ESP透视】",'84830962019412')

task.spawn(function()
    while task.wait(0.5) do
        if _G.generators then
            pcall(function()
                if workspace:FindFirstChild("Map") and gameMap:FindFirstChild("Ingame") and gameMap.Ingame:FindFirstChild("Map") then
                    for _, v in pairs(gameMap.Ingame.Map:GetChildren()) do
                        if v.Name == "Generator" then
                            if not v:FindFirstChild("gen_esp") then
                                local hl = Instance.new("Highlight", v)
                                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                hl.Name = "gen_esp"
                                hl.OutlineTransparency = 0
                                hl.FillTransparency = 0.3
                                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                hl.FillColor = Color3.fromRGB(255, 255, 51)
                            end
                            
                            if v:FindFirstChild("gen_esp") and v:FindFirstChild("Progress") then
                                local progressValue = math.floor(v.Progress.Value)
                                if progressValue >= 100 then
                                    v.gen_esp.FillColor = Color3.fromRGB(0, 255, 0)
                                else
                                    v.gen_esp.FillColor = Color3.fromRGB(255, 255, 51)
                                end
                                
                                if not v:FindFirstChild("nametag") then
                                    local bb = Instance.new("BillboardGui", v)
                                    bb.Size = UDim2.new(4, 0, 1, 0)
                                    bb.AlwaysOnTop = true
                                    bb.Name = "nametag"

                                    local text = Instance.new("TextLabel", bb)
                                    text.TextStrokeTransparency = 0
                                    text.Text = "发电机 (" .. progressValue .. "%)"
                                    text.TextSize = 15
                                    text.BackgroundTransparency = 1
                                    text.Size = UDim2.new(1, 0, 1, 0)
                                    text.TextColor3 = Color3.fromRGB(255, 255, 255)
                                else
                                    v.nametag.TextLabel.Text = "发电机 (" .. progressValue .. "%)"
                                end
                            end
                        end
                    end
                end
            end)
        else
            pcall(function()
                if workspace:FindFirstChild("Map") and gameMap:FindFirstChild("Ingame") and gameMap.Ingame:FindFirstChild("Map") then
                    for _, v in pairs(gameMap.Ingame.Map:GetChildren()) do
                        if v.Name == "Generator" then
                            if v:FindFirstChild("gen_esp") then
                                v.gen_esp:Destroy()
                            end
                            if v:FindFirstChild("nametag") then
                                v.nametag:Destroy()
                            end
                        end
                    end
                end
            end)
        end
    end
end)

local Feng = FengYu:section("〖内容】", true)

local killersESPToggle = false
local survivorsESPToggle = false
local itemESPEnabled = false

Feng:Toggle("发电机 ESP", "GeneratorsESP", false, function(bool)
    _G.generators = bool
end)

Feng:Toggle("杀手 ESP", "FengYu", false, function(Value)
    killersESPToggle = Value
end)

Feng:Toggle("幸存者 ESP", "FengYu", false, function(Value)
    survivorsESPToggle = Value
end)

local camera = workspace.CurrentCamera

local killersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")
local survivorsFolder = workspace:WaitForChild("Players"):WaitForChild("Survivors")

local function attachBillboard(model, color)
    if model:FindFirstChild("ESP_NameBillboard") then return end
    local head = model:FindFirstChild("Head") or model:FindFirstChildWhichIsA("BasePart")
    if not head then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_NameBillboard"
    billboard.Adornee = head
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.Parent = model

    local label = Instance.new("TextLabel")
    label.Name = "NameLabel"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = color
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextScaled = false
    label.TextWrapped = false
    label.ClipsDescendants = true
    label.TextTruncate = Enum.TextTruncate.None
    label.AutomaticSize = Enum.AutomaticSize.X
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextSize = 10
    label.Font = Enum.Font.GothamBold
    label.Text = "加载中..."
    label.Parent = billboard
end

local function updateBillboardText(model)
    local billboard = model:FindFirstChild("ESP_NameBillboard")
    if not billboard then return end

    local label = billboard:FindFirstChild("NameLabel")
    if not label then return end

    local actorText = model:GetAttribute("ActorDisplayName") or "???"
    local skinText = model:GetAttribute("SkinNameDisplay")
    local username = model:GetAttribute("Username") or "Unknown"

    if actorText == "Noli" and model:GetAttribute("IsFakeNoli") == true then
        actorText = actorText .. " (假的)"
    end

    local displayText = actorText
    if skinText and tostring(skinText) ~= "" then
        displayText = displayText .. " | " .. skinText
    end

    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local hp = math.floor(humanoid.Health)
        local maxhp = math.floor(humanoid.MaxHealth)
        displayText = string.format("%s (生命值: %d/%d)", displayText, hp, maxhp)
    end

    label.Text = displayText
end

local noliByUsername = {}

local function clearFakeTags()
    for _, killer in ipairs(killersFolder:GetChildren()) do
        if killer:GetAttribute("ActorDisplayName") == "Noli" then
            killer:SetAttribute("IsFakeNoli", false)
        end
    end
end

local function scanNolis()
    noliByUsername = {}

    for _, killer in ipairs(killersFolder:GetChildren()) do
        if killer:GetAttribute("ActorDisplayName") == "Noli" then
            local username = killer:GetAttribute("Username")
            if username then
                if not noliByUsername[username] then
                    noliByUsername[username] = {}
                end
                table.insert(noliByUsername[username], killer)
            end
        end
    end

    for username, models in pairs(noliByUsername) do
        if #models > 1 then
            for i = 2, #models do
                models[i]:SetAttribute("IsFakeNoli", true)
            end
            models[1]:SetAttribute("IsFakeNoli", false)
        else
            models[1]:SetAttribute("IsFakeNoli", false)
        end
    end
end

local function updateFakeNolis()
    clearFakeTags()
    scanNolis()
end

local function setupModel(model, isKiller)
    if not model:IsA("Model") or not model:FindFirstChildOfClass("Humanoid") then return end
    local color = isKiller and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 0)

    attachBillboard(model, color)
    updateBillboardText(model)

    if not model:FindFirstChild("ESP_Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillTransparency = 1
        highlight.OutlineTransparency = 0
        highlight.OutlineColor = color
        highlight.Adornee = model
        highlight.Parent = model
    end

    model:GetAttributeChangedSignal("ActorDisplayName"):Connect(function()
        updateBillboardText(model)
    end)
    model:GetAttributeChangedSignal("SkinNameDisplay"):Connect(function()
        updateBillboardText(model)
    end)

    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            updateBillboardText(model)
        end)
        humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
            updateBillboardText(model)
        end)
    end

    model.AncestryChanged:Connect(function(_, parent)
        if not parent then
            local bb = model:FindFirstChild("ESP_NameBillboard")
            if bb then bb:Destroy() end

            local hl = model:FindFirstChild("ESP_Highlight")
            if hl then hl:Destroy() end
        end
    end)
end

local function scanFolder(folder, isKiller)
    for _, model in ipairs(folder:GetChildren()) do
        setupModel(model, isKiller)
    end
end

task.spawn(function()
    while true do
        scanFolder(killersFolder, true)
        scanFolder(survivorsFolder, false)
        task.wait(5)
    end
end)

local function handleChildAdded(folder, isKiller)
    folder.ChildAdded:Connect(function(child)
        task.spawn(function()
            repeat task.wait() until child:IsDescendantOf(folder)
            local timeout = 3
            local timer = 0
            while (not child:FindFirstChild("Head") and not child:FindFirstChildWhichIsA("BasePart")) or not child:FindFirstChildOfClass("Humanoid") do
                task.wait(0.1)
                timer += 0.1
                if timer > timeout then return end
            end
            task.wait(0.2)
            setupModel(child, isKiller)
        end)
    end)
end

handleChildAdded(killersFolder, true)
handleChildAdded(survivorsFolder, false)
updateFakeNolis()

killersFolder.ChildRemoved:Connect(function(removed)
    if removed:GetAttribute("ActorDisplayName") == "Noli" then
        updateFakeNolis()
    end
end)

killersFolder.ChildAdded:Connect(function(added)
    if added:GetAttribute("ActorDisplayName") == "Noli" then
        task.defer(function()
            task.wait(0.2)
            updateFakeNolis()
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(10)
        updateFakeNolis()
    end
end)

RunService.RenderStepped:Connect(function()
    for _, folderData in pairs({
        {folder = killersFolder, toggle = killersESPToggle},
        {folder = survivorsFolder, toggle = survivorsESPToggle},
    }) do
        for _, model in ipairs(folderData.folder:GetChildren()) do
            local bb = model:FindFirstChild("ESP_NameBillboard")
            local hl = model:FindFirstChild("ESP_Highlight")

            if bb then bb.Enabled = folderData.toggle end
            if hl then hl.Enabled = folderData.toggle end

            if folderData.toggle and bb and bb.Adornee then
                local dist = (camera.CFrame.Position - bb.Adornee.Position).Magnitude
                local scale = math.clamp(1 / (dist / 20), 0.5, 2)

                local label = bb:FindFirstChild("NameLabel")
                if label then
                    label.TextSize = math.clamp(10 * scale, 12, 20)
                    bb.Size = UDim2.new(0, label.TextBounds.X + 20, 0, 50 * scale)
                end
            end
        end
    end
end)

local colorByName = {
    BloxyCola = Color3.fromRGB(255, 140, 0),
    Medkit = Color3.fromRGB(255, 100, 255),
}

local espParts = {}
local itemPartEspTrigger = nil

local function createNameTag(part, tagName, color)
    if part:FindFirstChild("ESP_Billboard") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Size = UDim2.new(0, 100, 0, 30)
    billboard.Adornee = part
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.Parent = part

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = color
    textLabel.TextStrokeTransparency = 0
    textLabel.Text = tagName
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextScaled = false
    textLabel.TextSize = 10
    textLabel.Parent = billboard
end

local function createBoxESP(part)
    if not part or not part:IsA("BasePart") then return end
    if part.Name ~= "ItemRoot" or not part.Parent then return end

    local tagName = part.Parent.Name
    local color = colorByName[tagName] or Color3.fromRGB(255, 255, 255)

    if part:FindFirstChild(tagName.."_PESP") then return end

    local box = Instance.new("BoxHandleAdornment")
    box.Name = tagName.."_PESP"
    box.Adornee = part
    box.Size = part.Size
    box.Transparency = 0.5
    box.Color3 = color
    box.ZIndex = 0
    box.AlwaysOnTop = true
    box.Parent = part

    createNameTag(part, tagName, color)
    table.insert(espParts, tagName)
end

function enableItemESP()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "ItemRoot" then
            createBoxESP(v)
        end
    end

    if not itemPartEspTrigger then
        itemPartEspTrigger = workspace.DescendantAdded:Connect(function(part)
            if part:IsA("BasePart") and part.Name == "ItemRoot" then
                createBoxESP(part)
            end
        end)
    end
end

function disableItemESP()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "ItemRoot" then
            if v:FindFirstChild("ESP_Billboard") then
                v:FindFirstChild("ESP_Billboard"):Destroy()
            end
            local tagName = v.Parent and v.Parent.Name
            if tagName and v:FindFirstChild(tagName.."_PESP") then
                v:FindFirstChild(tagName.."_PESP"):Destroy()
            end
        end
    end

    espParts = {}
    if itemPartEspTrigger then
        itemPartEspTrigger:Disconnect()
        itemPartEspTrigger = nil
    end
end

Feng:Toggle("物品 ESP", "FengYu", false, function(Value)
    itemESPEnabled = Value
    if itemESPEnabled then
        enableItemESP()
    else
        disableItemESP()
    end
end)

local FengYu = window:DualTab("〖※杂志】",'84830962019412')

local Feng = FengYu:section("〖其他】", "Left", true)

Feng:Button("变成药丸宝宝", function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

if character then
    repeat wait() until character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid")

    local limbs = {"Left Arm", "Right Arm", "Left Leg", "Right Leg"}
    for _, limb in ipairs(limbs) do
        local part = character:FindFirstChild(limb)
        if part then
            part:Destroy()
        end
    end

    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    if torso then
        local mesh = torso:FindFirstChildOfClass("SpecialMesh")
        if not mesh then
            mesh = Instance.new("SpecialMesh", torso)
        end
        mesh.MeshId = "rbxasset://fonts/head.mesh"
        mesh.Scale = Vector3.new(1.4, 1.8, 1.4)
    end
end
end)
Feng:Toggle("显示聊天", "FengYu", false, function(state)
    if state then
        _G.showChat = true
        task.spawn(function()
            while _G.showChat and task.wait() do
                game:GetService("TextChatService"):FindFirstChildOfClass("ChatWindowConfiguration").Enabled = true
            end
        end)
    else
        _G.showChat = false
        if playingState ~= "Spectating" then
            game:GetService("TextChatService"):FindFirstChildOfClass("ChatWindowConfiguration").Enabled = false
        end
    end
end)

Feng:Toggle("显示被隐藏的统计表", "AntiHiddenStats", false, function(state)
    antiHiddenStatsEnabled = state
    hiddenStatsFunc(state)
end)

Feng:Toggle("前空翻", "FrontFlip", false, function(state)
    if getgenv().FlipUI then
        getgenv().FlipUI.Enabled = state
    end
end)

local Feng = FengYu:section("〖👁️动作包整合】", "Right", false)

local animationControllers = {}
local animationStates = {}

local function createAnimationController(p740, p741, p742, toggleName)
    local controller = {
        active = false,
        connection = nil,
        characterConnection = nil,
        animations = {},
        animIds = {idle = p740, walk = p741, run = p742},
        toggleName = toggleName
    }
    
    local function setupAnimations(character)
        if not character or not controller.active then return end
        
        local humanoid = character:WaitForChild("Humanoid", 5)
        local rootPart = character:WaitForChild("HumanoidRootPart", 5)
        local animator = humanoid and humanoid:WaitForChild("Animator", 5)
        
        if not humanoid or not rootPart or not animator then return end
        
        for _, anim in pairs(controller.animations) do
            if anim then
                anim:Stop(0.2)
            end
        end
        controller.animations = {}
        
        local function loadAnimation(animId)
            local anim = Instance.new("Animation")
            anim.AnimationId = animId
            return animator:LoadAnimation(anim)
        end
        
        controller.animations.idle = loadAnimation(p740)
        controller.animations.walk = loadAnimation(p741)
        controller.animations.run = loadAnimation(p742)
        
        if controller.connection then
            controller.connection:Disconnect()
        end
        
        controller.connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not controller.active then return end
            if not controller.animations.idle or not controller.animations.walk or not controller.animations.run then return end
            
            local velocity = rootPart.Velocity.Magnitude
            if velocity < 1 then
                if not controller.animations.idle.IsPlaying then
                    controller.animations.idle:Play()
                    controller.animations.walk:Stop(0.2)
                    controller.animations.run:Stop(0.2)
                end
            elseif velocity >= 20 then
                if not controller.animations.run.IsPlaying then
                    controller.animations.run:Play()
                    controller.animations.idle:Stop(0.2)
                    controller.animations.walk:Stop(0.2)
                end
            elseif not controller.animations.walk.IsPlaying then
                controller.animations.walk:Play()
                controller.animations.idle:Stop(0.2)
                controller.animations.run:Stop(0.2)
            end
        end)
    end
    
    local function startAnimation()
        if controller.active then return end
        
        controller.active = true
        animationStates[controller.toggleName] = true
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        if controller.characterConnection then
            controller.characterConnection:Disconnect()
        end
        
        controller.characterConnection = player.CharacterAdded:Connect(function(newCharacter)
            if controller.active then
                wait(1)
                setupAnimations(newCharacter)
            end
        end)
        
        setupAnimations(character)
    end
    
    local function stopAnimation()
        if not controller.active then return end
        
        controller.active = false
        animationStates[controller.toggleName] = false
        
        if controller.connection then
            controller.connection:Disconnect()
            controller.connection = nil
        end
        
        if controller.characterConnection then
            controller.characterConnection:Disconnect()
            controller.characterConnection = nil
        end
        
        for _, anim in pairs(controller.animations) do
            if anim then
                anim:Stop(0.2)
            end
        end
        controller.animations = {}
    end
    
    return {
        start = startAnimation,
        stop = stopAnimation,
        isActive = function() return controller.active end,
        getToggleName = function() return controller.toggleName end
    }
end

local animationPacks = {
    ["2017动画包"] = {
        idle = "rbxassetid://124622205682529",
        walk = "rbxassetid://99127941563341",
        run = "rbxassetid://99159420513149"
    },
    ["狗王🐶动画包"] = {
        idle = "rbxassetid://135419935358802",
        walk = "rbxassetid://95469909855529",
        run = "rbxassetid://109671225388655"
    },
    ["放松动画包"] = {
        idle = "rbxassetid://132811450080149",
        walk = "rbxassetid://90163253241107",
        run = "rbxassetid://96194626828153"
    },
    ["约翰.多动画包"] = {
        idle = "rbxassetid://105880087711722",
        walk = "rbxassetid://81193817424328",
        run = "rbxassetid://132653655520682"
    },
    ["酷小孩动画包"] = {
        idle = "rbxassetid://18885903667",
        walk = "rbxassetid://18885906143",
        run = "rbxassetid://96571077893813"
    },
    ["诺利动画包"] = {
        idle = "rbxassetid://83465205704188",
        walk = "rbxassetid://116353529220765",
        run = "rbxassetid://117451341682452"
    },
    ["酷动画包"] = {
        idle = "rbxassetid://115268929362938",
        walk = "rbxassetid://123678890237669",
        run = "rbxassetid://132086389849889"
    },
    ["蓝小孩动画包"] = {
        idle = "rbxassetid://115268929362938I",
        walk = "rbxassetid://18885906143",
        run = "rbxassetid://96571077893813"
    }
}

for packName, animData in pairs(animationPacks) do
    animationControllers[packName] = createAnimationController(
        animData.idle,
        animData.walk,
        animData.run,
        packName
    )
    
    Feng:Toggle(packName, packName .. "Toggle", false, function(state)
        if state then
            animationControllers[packName]:start()
        else
            animationControllers[packName]:stop()
        end
    end)
end

local jeffController = {
    active = false,
    runningAnim = nil,
    idleAnim = nil,
    runningConnection = nil,
    characterConnection = nil
}

local function setupJeffAnimations(character)
    if not jeffController.active then return end
    
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end
    
    if jeffController.runningAnim then
        jeffController.runningAnim:Stop()
    end
    if jeffController.idleAnim then
        jeffController.idleAnim:Stop()
    end
    
    local runningAnim = Instance.new("Animation")
    runningAnim.AnimationId = "rbxassetid://252557606"
    local idleAnim = Instance.new("Animation")
    idleAnim.AnimationId = "rbxassetid://124622205682529"
    
    jeffController.runningAnim = humanoid:LoadAnimation(runningAnim)
    jeffController.idleAnim = humanoid:LoadAnimation(idleAnim)
    
    if jeffController.runningConnection then
        jeffController.runningConnection:Disconnect()
    end
    
    jeffController.runningConnection = humanoid.Running:Connect(function(speed)
        if not jeffController.active then return end
        if speed > 0 then
            if jeffController.idleAnim and jeffController.idleAnim.IsPlaying then
                jeffController.idleAnim:Stop()
            end
            if jeffController.runningAnim and not jeffController.runningAnim.IsPlaying then
                jeffController.runningAnim.Looped = true
                jeffController.runningAnim:Play()
            end
        else
            if jeffController.runningAnim and jeffController.runningAnim.IsPlaying then
                jeffController.runningAnim:Stop()
            end
            if jeffController.idleAnim and not jeffController.idleAnim.IsPlaying then
                jeffController.idleAnim.Looped = true
                jeffController.idleAnim:Play()
            end
        end
    end)
end

Feng:Toggle("Jeff the killer动画包", "JeffTheKillerToggle", false, function(state)
    if state then
        jeffController.active = true
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        if jeffController.characterConnection then
            jeffController.characterConnection:Disconnect()
        end
        
        jeffController.characterConnection = player.CharacterAdded:Connect(function(newCharacter)
            if jeffController.active then
                wait(1)
                setupJeffAnimations(newCharacter)
            end
        end)
        
        setupJeffAnimations(character)
    else
        jeffController.active = false
        
        if jeffController.characterConnection then
            jeffController.characterConnection:Disconnect()
            jeffController.characterConnection = nil
        end
        
        if jeffController.runningConnection then
            jeffController.runningConnection:Disconnect()
            jeffController.runningConnection = nil
        end
        
        if jeffController.runningAnim then
            jeffController.runningAnim:Stop()
            jeffController.runningAnim = nil
        end
        
        if jeffController.idleAnim then
            jeffController.idleAnim:Stop()
            jeffController.idleAnim = nil
        end
    end
end)

local Feng = FengYu:section("〖🔥FE动作】", "Right", false)

local vu710 = nil

Feng:Toggle("撸管", "MasterbaitToggle", false, function(p711)
    local v712 = game.Players.LocalPlayer
    local v713 = (v712.Character or v712.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")
    if v713 then
        if p711 then
            if not (vu710 and vu710.IsPlaying) then
                local v714 = Instance.new("Animation")
                v714.AnimationId = "rbxassetid://72042024"
                vu710 = v713:LoadAnimation(v714)
                vu710.Looped = true
                vu710:Play()
            end
        elseif vu710 and vu710.IsPlaying then
            vu710:Stop()
        end
    end
end)

Feng:Toggle("张开手臂旋转", "ArmsOutSpinToggle", false, function(p715)
    local v716 = game.Players.LocalPlayer
    local v717 = (v716.Character or v716.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")
    if v717 then
        if p715 then
            if not (vu710 and vu710.IsPlaying) then
                local v718 = Instance.new("Animation")
                v718.AnimationId = "rbxassetid://235542946"
                vu710 = v717:LoadAnimation(v718)
                vu710:Play()
            end
        elseif vu710 and vu710.IsPlaying then
            vu710:Stop()
        end
    end
end)

Feng:Toggle("旋转手", "SpinningHandsToggle", false, function(p719)
    local v720 = game.Players.LocalPlayer
    local v721 = (v720.Character or v720.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")
    if v721 then
        if p719 then
            if not (vu710 and vu710.IsPlaying) then
                local v722 = Instance.new("Animation")
                v722.AnimationId = "rbxassetid://259438880"
                vu710 = v721:LoadAnimation(v722)
                vu710.Looped = true
                vu710:Play()
            end
        elseif vu710 and vu710.IsPlaying then
            vu710:Stop()
        end
    end
end)

Feng:Toggle("跳跃", "JumpingJacksToggle", false, function(p723)
    local v724 = game.Players.LocalPlayer
    local v725 = (v724.Character or v724.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")
    if v725 then
        if p723 then
            if not (vu710 and vu710.IsPlaying) then
                local v726 = Instance.new("Animation")
                v726.AnimationId = "rbxassetid://429681631"
                vu710 = v725:LoadAnimation(v726)
                vu710.Looped = true
                vu710:Play()
            end
        elseif vu710 and vu710.IsPlaying then
            vu710:Stop()
        end
    end
end)

Feng:Button("滑铲按钮", function()
    local vu727 = game.Players.LocalPlayer
    local v728 = vu727:WaitForChild("PlayerGui")
    local v729 = v728:FindFirstChild("ScreenGui")
    if not v729 then
        v729 = Instance.new("ScreenGui")
        v729.Name = "ScreenGui"
        v729.Parent = v728
    end
    local v730 = Instance.new("TextButton")
    v730.Size = UDim2.new(0, 100, 0, 40)
    v730.Position = UDim2.new(0.5, -50, 0.5, -20)
    v730.Text = "滑铲"
    v730.BackgroundColor3 = Color3.fromRGB(0, 119, 255)
    v730.TextColor3 = Color3.fromRGB(255, 255, 255)
    v730.Font = Enum.Font.GothamBold
    v730.TextSize = 16
    v730.BorderSizePixel = 0
    v730.Parent = v729
    v730.Draggable = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = v730
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Parent = v730
    
    v730.MouseEnter:Connect(function()
        v730.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end)
    
    v730.MouseLeave:Connect(function()
        v730.BackgroundColor3 = Color3.fromRGB(0, 119, 255)
    end)
    
    v730.MouseButton1Click:Connect(function()
        local v731 = vu727.Character or vu727.CharacterAdded:Wait()
        local v732 = v731:WaitForChild("HumanoidRootPart")
        local v733 = v731:WaitForChild("Humanoid")
        local v734 = Instance.new("Animation")
        v734.AnimationId = "rbxassetid://182749109"
        local vu735 = v733:LoadAnimation(v734)
        local v736 = vu735
        vu735.Play(v736)
        local v737 = game:GetService("TweenService")
        local v738 = v732.CFrame * CFrame.new(0, 0, -20)
        local v739 = v737:Create(v732, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = v738
        })
        v739:Play()
        v739.Completed:Connect(function()
            vu735:Stop()
        end)
    end)
end)

local Feng = FengYu:section("〖⚠️表情动作区】", "Right", false)

Feng:Toggle("Silly Billy", "SillyBilly", false, function(state)
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    if state then
        humanoid.PlatformStand = true
        humanoid.JumpPower = 0
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = rootPart
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://107464355830477"
        local animationTrack = humanoid:LoadAnimation(animation)
        animationTrack:Play()
        
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://77601084987544"
        sound.Parent = rootPart
        sound.Volume = 0.5
        sound.Looped = false
        sound:Play()
        
        animationTrack.Stopped:Connect(function()
            humanoid.PlatformStand = false
            if bodyVelocity and bodyVelocity.Parent then
                bodyVelocity:Destroy()
            end
            
            for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
                local asset = char:FindFirstChild(assetName)
                if asset then asset:Destroy() end
            end
        end)
    else
        humanoid.PlatformStand = false
        humanoid.JumpPower = 0
        
        for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
            local asset = char:FindFirstChild(assetName)
            if asset then asset:Destroy() end
        end
        
        local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
        if bodyVelocity then bodyVelocity:Destroy() end
        
        local sound = rootPart:FindFirstChildOfClass("Sound")
        if sound then
            sound:Stop()
            sound:Destroy()
        end
        
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation.AnimationId == "rbxassetid://107464355830477" then
                track:Stop()
            end
        end
    end
end)

Feng:Toggle("Silly of it", "SillyOfIt", false, function(state)
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    if state then
        humanoid.PlatformStand = true
        humanoid.JumpPower = 0
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = rootPart
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://107464355830477"
        local animationTrack = humanoid:LoadAnimation(animation)
        animationTrack:Play()
        
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://120176009143091"
        sound.Parent = rootPart
        sound.Volume = 0.5
        sound.Looped = false
        sound:Play()
        
        animationTrack.Stopped:Connect(function()
            humanoid.PlatformStand = false
            if bodyVelocity and bodyVelocity.Parent then
                bodyVelocity:Destroy()
            end
            
            for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
                local asset = char:FindFirstChild(assetName)
                if asset then asset:Destroy() end
            end
        end)
    else
        humanoid.PlatformStand = false
        humanoid.JumpPower = 0
        
        for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
            local asset = char:FindFirstChild(assetName)
            if asset then asset:Destroy() end
        end
        
        local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
        if bodyVelocity then bodyVelocity:Destroy() end
        
        local sound = rootPart:FindFirstChildOfClass("Sound")
        if sound then
            sound:Stop()
            sound:Destroy()
        end
        
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation.AnimationId == "rbxassetid://107464355830477" then
                track:Stop()
            end
        end
    end
end)

Feng:Toggle("Subterfuge", "Subterfuge", false, function(state)
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    if state then
        humanoid.PlatformStand = true
        humanoid.JumpPower = 0
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = rootPart
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://87482480949358"
        local animationTrack = humanoid:LoadAnimation(animation)
        animationTrack:Play()
        
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://132297506693854"
        sound.Parent = rootPart
        sound.Volume = 2
        sound.Looped = false
        sound:Play()
        
        local args = {
            [1] = "PlayEmote",
            [2] = "Animations",
            [3] = "_Subterfuge"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        
        animationTrack.Stopped:Connect(function()
            humanoid.PlatformStand = false
            if bodyVelocity and bodyVelocity.Parent then
                bodyVelocity:Destroy()
            end
        end)
    else
        humanoid.PlatformStand = false
        humanoid.JumpPower = 0
        
        local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
        if bodyVelocity then bodyVelocity:Destroy() end
        
        local sound = rootPart:FindFirstChildOfClass("Sound")
        if sound then
            sound:Stop()
            sound:Destroy()
        end
        
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation.AnimationId == "rbxassetid://87482480949358" then
                track:Stop()
            end
        end
    end
end)

Feng:Toggle("Aw Shucks", "AwShucks", false, function(state)
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    if state then
        humanoid.PlatformStand = true
        humanoid.JumpPower = 0
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = rootPart
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://74238051754912"
        local animationTrack = humanoid:LoadAnimation(animation)
        animationTrack:Play()
        
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://123236721947419"
        sound.Parent = rootPart
        sound.Volume = 0.5
        sound.Looped = false
        sound:Play()
        
        local args = {
            [1] = "PlayEmote",
            [2] = "Animations",
            [3] = "Shucks"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        
        animationTrack.Stopped:Connect(function()
            humanoid.PlatformStand = false
            if bodyVelocity and bodyVelocity.Parent then
                bodyVelocity:Destroy()
            end
        end)
    else
        humanoid.PlatformStand = false
        humanoid.JumpPower = 0
        
        local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
        if bodyVelocity then bodyVelocity:Destroy() end
        
        local sound = rootPart:FindFirstChildOfClass("Sound")
        if sound then
            sound:Stop()
            sound:Destroy()
        end
        
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation.AnimationId == "rbxassetid://74238051754912" then
                track:Stop()
            end
        end
    end
end)

Feng:Toggle("Miss The Quiet", "MissTheQuiet", false, function(state)
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    if state then
        humanoid.PlatformStand = true
        humanoid.JumpPower = 0
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = rootPart
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://100986631322204"
        local animationTrack = humanoid:LoadAnimation(animation)
        animationTrack:Play()
        
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://131936418953291"
        sound.Parent = rootPart
        sound.Volume = 0.5
        sound.Looped = false
        sound:Play()
        
        animationTrack.Stopped:Connect(function()
            humanoid.PlatformStand = false
            if bodyVelocity and bodyVelocity.Parent then
                bodyVelocity:Destroy()
            end
            
            for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
                local asset = char:FindFirstChild(assetName)
                if asset then asset:Destroy() end
            end
        end)
    else
        humanoid.PlatformStand = false
        humanoid.JumpPower = 0
        
        for _, assetName in ipairs({"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}) do
            local asset = char:FindFirstChild(assetName)
            if asset then asset:Destroy() end
        end
        
        local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
        if bodyVelocity then bodyVelocity:Destroy() end
        
        local sound = rootPart:FindFirstChildOfClass("Sound")
        if sound then
            sound:Stop()
            sound:Destroy()
        end
        
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation.AnimationId == "rbxassetid://100986631322204" then
                track:Stop()
            end
        end
    end
end)

Feng:Toggle("VIP (新音频)", "VIPNew", false, function(state)
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    if state then
        humanoid.PlatformStand = true
        humanoid.JumpPower = 0
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = rootPart
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://138019937280193"
        local animationTrack = humanoid:LoadAnimation(animation)
        animationTrack:Play()
        
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://109474987384441"
        sound.Parent = rootPart
        sound.Volume = 0.5
        sound.Looped = true
        sound:Play()
        
        local effect = game:GetService("ReplicatedStorage").Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
        effect.Name = "PlayerEmoteVFX"
        effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
        effect.WeldConstraint.Part0 = char.PrimaryPart
        effect.WeldConstraint.Part1 = effect
        effect.Parent = char
        effect.CanCollide = false
        
        local args = {
            [1] = "PlayEmote",
            [2] = "Animations",
            [3] = "HakariDance"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        
        animationTrack.Stopped:Connect(function()
            humanoid.PlatformStand = false
            if bodyVelocity and bodyVelocity.Parent then
                bodyVelocity:Destroy()
            end
        end)
    else
        humanoid.PlatformStand = false
        humanoid.JumpPower = 0
        
        local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
        if bodyVelocity then bodyVelocity:Destroy() end
        
        local sound = rootPart:FindFirstChildOfClass("Sound")
        if sound then
            sound:Stop()
            sound:Destroy()
        end
        
        local effect = char:FindFirstChild("PlayerEmoteVFX")
        if effect then effect:Destroy() end
        
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                track:Stop()
            end
        end
    end
end)

Feng:Toggle("VIP (旧音频)", "VIPOld", false, function(state)
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local rootPart = char:WaitForChild("HumanoidRootPart")
    
    if state then
        humanoid.PlatformStand = true
        humanoid.JumpPower = 0
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = rootPart
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://138019937280193"
        local animationTrack = humanoid:LoadAnimation(animation)
        animationTrack:Play()
        
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://87166578676888"
        sound.Parent = rootPart
        sound.Volume = 0.5
        sound.Looped = true
        sound:Play()
        
        local effect = game:GetService("ReplicatedStorage").Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
        effect.Name = "PlayerEmoteVFX"
        effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
        effect.WeldConstraint.Part0 = char.PrimaryPart
        effect.WeldConstraint.Part1 = effect
        effect.Parent = char
        effect.CanCollide = false
        
        local args = {
            [1] = "PlayEmote",
            [2] = "Animations",
            [3] = "HakariDance"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        
        animationTrack.Stopped:Connect(function()
            humanoid.PlatformStand = false
            if bodyVelocity and bodyVelocity.Parent then
                bodyVelocity:Destroy()
            end
        end)
    else
        humanoid.PlatformStand = false
        humanoid.JumpPower = 0
        
        local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
        if bodyVelocity then bodyVelocity:Destroy() end
        
        local sound = rootPart:FindFirstChildOfClass("Sound")
        if sound then
            sound:Stop()
            sound:Destroy()
        end
        
        local effect = char:FindFirstChild("PlayerEmoteVFX")
        if effect then effect:Destroy() end
        
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                track:Stop()
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if autoBlockOn then
            local myChar = localPlayer.Character
            if myChar then
                local myRoot = myChar:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr ~= localPlayer and plr.Character then
                            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                            local animTracks = hum and hum:FindFirstChildOfClass("Animator") and hum:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()
                            if hrp and (hrp.Position - myRoot.Position).Magnitude <= detectionRange then
                                for _, track in ipairs(animTracks or {}) do
                                    local id = tostring(track.Animation.AnimationId):match("%d+")
                                    if table.find(autoBlockTriggerAnims, id) then
                                        if cachedCooldown and cachedCooldown.Text == "" then
                                            task.wait(blockdelay)
                                            fireGuiBlock()
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        if autoPunchOn then
            if cachedCharges and cachedCharges.Text == "1" then
                local myChar = localPlayer.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    for _, name in ipairs(killerNames) do
                        local killer = killersFolder:FindFirstChild(name)
                        if killer and killer:FindFirstChild("HumanoidRootPart") then
                            local root = killer.HumanoidRootPart
                            if (root.Position - myRoot.Position).Magnitude <= 10 then
                                fireGuiPunch()
                                if flingPunchOn then
                                    hiddenfling = true
                                    local targetHRP = root
                                    task.spawn(function()
                                        local start = tick()
                                        while tick() - start < 1 do
                                            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and targetHRP and targetHRP.Parent then
                                                local frontPos = targetHRP.Position + (targetHRP.CFrame.LookVector * 2)
                                                localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(frontPos, targetHRP.Position)
                                            end
                                            task.wait()
                                        end
                                        hiddenfling = false
                                    end)
                                end
                                break
                            end
                        end
                    end
                end
            end
        end
        
        if aimPunch then
            local myChar = localPlayer.Character
            if not myChar then return end
            local humanoid = myChar:FindFirstChild("Humanoid")
            local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
            if not animator then return end
            
            local myRoot = myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return end
            
            for _, name in ipairs(killerNames) do
                local killer = killersFolder:FindFirstChild(name)
                if killer and killer:FindFirstChild("HumanoidRootPart") then
                    local root = killer.HumanoidRootPart
                    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                        local animId = tostring(track.Animation.AnimationId):match("%d+")
                        if animId == "87259391926321" or animId == "140703210927645" then
                            local timePos = track.TimePosition or 0
                            if timePos <= 0.1 then
                                if humanoid then
                                    humanoid.AutoRotate = false
                                    local predictedPos = root.Position + (root.CFrame.LookVector * predictionValue)
                                    myRoot.CFrame = CFrame.lookAt(myRoot.Position, predictedPos)
                                    task.delay(0.5, function()
                                        if humanoid then
                                            humanoid.AutoRotate = true
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

local soundHooks = {}
local soundBlockedUntil = {}
local AUDIO_LOCAL_COOLDOWN = 0.35
local AUDIO_SOUND_THROTTLE = 1.0
local lastLocalBlockTime = 0

local function extractNumericSoundId(sound)
    if not sound then return nil end
    local sid = sound.SoundId
    if not sid then return nil end
    sid = tostring(sid)
    local num = string.match(sid, "rbxassetid://(%d+)") or string.match(sid, "://(%d+)") or string.match(sid, "^(%d+)$")
    return num
end

local function getSoundWorldPosition(sound)
    if not sound then return nil end
    local parent = sound.Parent
    if parent then
        if parent:IsA("BasePart") then
            return parent.Position, parent
        end
        if parent:IsA("Attachment") then
            local gp = parent.Parent
            if gp and gp:IsA("BasePart") then
                return gp.Position, gp
            end
        end
    end
    return nil, nil
end

local function attemptBlockForSound(sound, idParam)
    if not autoBlockAudioOn then return end
    if not sound or not sound:IsA("Sound") then return end
    if not sound.IsPlaying then return end
    
    local id = idParam or extractNumericSoundId(sound)
    if not id or not autoBlockTriggerSounds[id] then return end
    
    local now = tick()
    if soundBlockedUntil[sound] and now < soundBlockedUntil[sound] then return end
    if now - lastLocalBlockTime < AUDIO_LOCAL_COOLDOWN then return end
    
    refreshUIRefs()
    
    local myChar = localPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    
    local soundPos, soundPart = getSoundWorldPosition(sound)
    if not soundPart then return end
    
    task.wait(blockdelay)
    
    if cachedCooldown and cachedCooldown.Text == "" then
        fireGuiBlock()
        lastLocalBlockTime = now
        soundBlockedUntil[sound] = now + AUDIO_SOUND_THROTTLE
    end
end

local function hookSound(sound)
    if not sound or not sound:IsA("Sound") then return end
    if soundHooks[sound] then return end
    
    local preId = extractNumericSoundId(sound)
    soundHooks[sound] = { id = preId }
    
    local playedConn = sound.Played:Connect(function()
        attemptBlockForSound(sound, preId)
    end)
    
    local propConn = sound:GetPropertyChangedSignal("IsPlaying"):Connect(function()
        if sound.IsPlaying then
            attemptBlockForSound(sound, preId)
        end
    end)
    
    if sound.IsPlaying then
        attemptBlockForSound(sound, preId)
    end
end

task.spawn(function()
    for _, desc in ipairs(killersFolder:GetDescendants()) do
        if desc:IsA("Sound") then
            hookSound(desc)
        end
    end
    
    killersFolder.DescendantAdded:Connect(function(desc)
        if desc:IsA("Sound") then
            hookSound(desc)
        end
    end)
end)

refreshUIRefs()
localPlayer.CharacterAdded:Connect(function()
    task.delay(0.5, function()
        refreshUIRefs()
    end)
end)