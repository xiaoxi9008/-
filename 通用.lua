game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "因为你检测到通用",
  Text = "正在启动XIAOXI通用",
  Icon = "rbxassetid://123691280552142",
  Duration = 1,
  Callback = bindable,
  Button1 = "谢谢使用🤑",
  Button2 = "本脚本为工益",
})
wait(1.5)
game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "不打算付费",
  Text = "卡密进群获取🤔 ",
  Icon = "rbxassetid://123691280552142",
  Duration = 1,
  Callback = bindable,
  Button1 = "qq群：705378396",
  Button2 = "作者qq：3574769415",
})
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Potato5466794/Wind/refs/heads/main/Wind.luau"))()
local Window = WindUI:CreateWindow({
    Title = "<font color='#FFB6C1'>X</font><font color='#FFA0B5'>I</font><font color='#FF8AA9'>A</font><font color='#FF749D'>O</font><font color='#FF5E91'>X</font><font color='#FF4885'>I</font>",
    Icon = "rbxassetid://123691280552142",
    Author = "by小西制作",
    AuthorImage = 90840643379863,
    Folder = "CloudHub",
    Size = UDim2.fromOffset(200, 395),
        Transparent = true,
    Theme = "Dark",
    UserEnabled = true,
    SideBarWidth = 135,
    HasOutline = true,
    Transparent = true,
    Background = "video:https://raw.githubusercontent.com/xiaoxi9008/chesksks/refs/heads/main/Video_1773632365272_24.mp4",
    User = {
            Enabled = true,
            Callback = function()
                WindUI:Notify({
                    Title = "点击了自己",
                    Content = "没什么", 
                    Duration = 1,
                    Icon = "4483362748"
                })
            end,
            Anonymous = false
        },
})

Window:Tag({
    Title = "通用",
    Color = Color3.fromHex("FF69B4")
})

WindUI.Themes.Dark.Button = Color3.fromRGB(255, 255, 255)  
WindUI.Themes.Dark.ButtonBorder = Color3.fromRGB(255, 255, 255)  

local function addButtonBorderStyle()
    local mainFrame = Window.UIElements.Main
    if not mainFrame then return end
    
    local styleSheet = Instance.new("StyleSheet")
    styleSheet.Parent = mainFrame
    
    local rule = Instance.new("StyleRule")
    rule.Selector = "Button, ImageButton, TextButton"
    rule.Parent = styleSheet
    
    local borderProp = Instance.new("StyleProperty")
    borderProp.Name = "BorderSizePixel"
    borderProp.Value = 1
    borderProp.Parent = rule
    
    local colorProp = Instance.new("StyleProperty")
    colorProp.Name = "BorderColor3"
    colorProp.Value = Color3.fromRGB(255, 255, 255)
    colorProp.Parent = rule
end

Window:CreateTopbarButton("theme-switcher", "moon", function()
    local themes_list = {"Dark", "Light", "Mocha", "Aqua"}
    currentThemeIndex = (currentThemeIndex % #themes_list) + 1
    local newTheme = themes_list[currentThemeIndex]
    WindUI:SetTheme(newTheme)
    WindUI:Notify({
        Title = "主题已切换",
        Content = "当前主题: "..newTheme,
        Duration = 2
    })
end, 990)

WindUI.Themes.Dark.Toggle = Color3.fromHex("FF69B4")
WindUI.Themes.Dark.Checkbox = Color3.fromHex("FFB6C1")
WindUI.Themes.Dark.Button = Color3.fromHex("FF1493")
WindUI.Themes.Dark.Slider = Color3.fromHex("FF69B4")

local COLOR_SCHEMES = {
    ["彩虹颜色"] = {ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500")),
        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("EE82EE"))
    }), "palette"},
    
    ["樱花粉1"] = {ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("FF69B4")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("FF1493")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("FFB6C1"))
    }), "candy"},

    ["樱花粉2"] = {ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("FED0E0")),
        ColorSequenceKeypoint.new(0.2, Color3.fromHex("FDBAD2")),
        ColorSequenceKeypoint.new(0.4, Color3.fromHex("FCA5C5")),
        ColorSequenceKeypoint.new(0.6, Color3.fromHex("FB8FB7")),
        ColorSequenceKeypoint.new(0.8, Color3.fromHex("FA7AA9")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("F9649B"))
    }), "waves"},
}

Window:EditOpenButton(
    {
        Title = "<font color='#FFB6C1'>X</font><font color='#FFA0B5'>I</font><font color='#FF8AA9'>A</font><font color='#FF749D'>O</font><font color='#FF5E91'>X</font><font color='#FF4885'>I</font>",
        Icon = "rbxassetid://123691280552142",
        CornerRadius = UDim.new(0, 13),
        StrokeThickness = 4,
        Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(186, 19, 19)),ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 60, 129))}),
        Draggable = true
    }
)

local function createRainbowBorder(window, colorScheme, speed)
    local mainFrame = window.UIElements.Main
    if not mainFrame then return nil end
    
    local existingStroke = mainFrame:FindFirstChild("RainbowStroke")
    if existingStroke then
        existingStroke:Destroy()
    end
    
    if not mainFrame:FindFirstChildOfClass("UICorner") then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 16)
        corner.Parent = mainFrame
    end
    
    local rainbowStroke = Instance.new("UIStroke")
    rainbowStroke.Name = "RainbowStroke"
    rainbowStroke.Thickness = 2
    rainbowStroke.Color = Color3.new(1, 1, 1)
    rainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    rainbowStroke.LineJoinMode = Enum.LineJoinMode.Round
    rainbowStroke.Parent = mainFrame
    
    local glowEffect = Instance.new("UIGradient")
    glowEffect.Name = "GlowEffect"
    
    local schemeData = COLOR_SCHEMES[colorScheme or "樱花粉2"]
    if schemeData then
        glowEffect.Color = schemeData[1]
    else
        glowEffect.Color = COLOR_SCHEMES["樱花粉2"][1]
    end
    
    glowEffect.Rotation = 0
    glowEffect.Parent = rainbowStroke
    
    return rainbowStroke
end

local function startBorderAnimation(window, speed)
    local mainFrame = window.UIElements.Main
    if not mainFrame then return nil end
    
    local rainbowStroke = mainFrame:FindFirstChild("RainbowStroke")
    if not rainbowStroke then return nil end
    
    local glowEffect = rainbowStroke:FindFirstChild("GlowEffect")
    if not glowEffect then return nil end
    
    local animation = game:GetService("RunService").Heartbeat:Connect(function()
        if not rainbowStroke or rainbowStroke.Parent == nil then
            animation:Disconnect()
            return
        end
        
        local time = tick()
        glowEffect.Rotation = (time * speed * 60) % 360
    end)
    
    return animation
end

local borderAnimation
local borderEnabled = true
local currentColor = "樱花粉2"
local animationSpeed = 5

local rainbowStroke = createRainbowBorder(Window, currentColor, animationSpeed)
if rainbowStroke then
    borderAnimation = startBorderAnimation(Window, animationSpeed)
end


function Tab(a)
    return Window:Tab({Title = a, Icon = "eye"})
end

function Button(a, b, c)
    return a:Button({Title = b, Callback = c})
end

function Toggle(a, b, c, d)
    return a:Toggle({Title = b, Value = c, Callback = d})
end

function Slider(a, b, c, d, e, f)
    return a:Slider({Title = b, Step = 1, Value = {Min = c, Max = d, Default = e}, Callback = f})
end

function Dropdown(a, b, c, d, e)
    return a:Dropdown({Title = b, Values = c, Value = d, Callback = e})
end

function Input(a, b, c, d, e, f)
    return a:Input({
        Title = b,
        Desc = c or "",
        Value = d or "",
        Placeholder = e or "",
        Callback = f
    })
end

local Taba = Tab("首页")
local Tab1 = Tab("通用")
local TabFE = Tab("FE")
local Tab2 = Tab("ESP")
local Tab3 = Tab("自瞄")
local Tab4 = Tab("子追")
local Tabc = Tab("范围")
local Tabjb = Tab("网易云音乐")
local Tabd = Tab("催更地点")
local Tabb = Tab("设置")

local player = game.Players.LocalPlayer

Taba:Paragraph({
    Title = "欢迎使用XIAIXI脚本",
    Desc = "作者：小西｜ UI提供：鱼腥草｜\n版本：v4.0.0\n\n一个功能强大的脚本",
    ImageSize = 50,
    Thumbnail = "https://raw.githubusercontent.com/xiaoxi9008/chesksks/refs/heads/main/1357873301.jpg",
    ThumbnailSize = 170
})

Taba:Divider()

Taba:Button({
    Title = "显示欢迎通知",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "欢迎!",
            Content = "感谢使用XIAOXI",
            Icon = "heart",
            Duration = 3
        })
    end
})
Taba:Paragraph({
    Title = "此脚本为免费⭕钱和作者无关",
    Desc = [[ ]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#000000"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})
Taba:Paragraph({
    Title = "计划150个服务器😋😋",
    Desc = [[ ]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundTransparency = 1,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "复制QQ群[获取最新消息]", function()
    setclipboard("705378396")
end)

Tab1:Paragraph({
    Title = "以下是常用的",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundTransparency = 1,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Slider(Tab1, "移动速度", 1, 600, game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, function(a) 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = a
end)

local aimbotDemo = Tab1:Toggle({
    Title = "移速修改",
    Default = false,
    Callback = function(v)
        if v == true then
            sudu = game:GetService("RunService").Heartbeat:Connect(function()
                if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                    if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 10)
                    end
                end
            end)
        elseif not v and sudu then
            sudu:Disconnect()
            sudu = nil
        end
    end
})    
Tab1:Slider({
    Title = "速度设置",
    Value = {
        Min = 1,
        Max = 100,
        Default = 1,
    },
    Callback = function(Value)
        Speed = Value
    end
})

Slider(Tab1, "跳跃高度", 1, 600, game.Players.LocalPlayer.Character.Humanoid.JumpPower, function(a) 
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = a
end)

Slider(Tab1, "重力设置", 1, 500, workspace.Gravity, function(a) 
        workspace.Gravity = a
end)

Button(Tab1, "锁视角", function() 
    local ShiftlockStarterGui = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
ShiftlockStarterGui.Name = "Shiftlock (StarterGui)"
ShiftlockStarterGui.Parent = game.CoreGui
ShiftlockStarterGui.ZIndexBehavior =  Enum.ZIndexBehavior.Sibling
ShiftlockStarterGui.ResetOnSpawn = false

ImageButton.Parent = ShiftlockStarterGui
ImageButton.Active = true
ImageButton.Draggable = true
ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageButton.BackgroundTransparency = 1.000
ImageButton.Position = UDim2.new(0.921914339, 0, 0.552375436, 0)
ImageButton.Size = UDim2.new(0.0636147112, 0, 0.0661305636, 0)
ImageButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
ImageButton.Image = "http://www.roblox.com/asset/?id=182223762"
local function TLQOYN_fake_script()
    local script = Instance.new("LocalScript", ImageButton)

    local MobileCameraFramework = {}
    local Players = game.Players
    local runservice = game:GetService("RunService")
    local CAS = game:GetService("ContextActionService")
    local Player = Players.LocalPlayer
    local character = Player.Character or Player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    local humanoid = character.Humanoid
    local camera = workspace.CurrentCamera
    local button = script.Parent
    uis = game:GetService("UserInputService")
    ismobile = uis.TouchEnabled
    button.Visible = ismobile
    
    local states = {
        OFF = "rbxasset://textures/ui/mouseLock_off@2x.png",
        ON = "rbxasset://textures/ui/mouseLock_on@2x.png"
    }
    local MAX_LENGTH = 900000
    local active = false
    local ENABLED_OFFSET = CFrame.new(1.7, 0, 0)
    local DISABLED_OFFSET = CFrame.new(-1.7, 0, 0)
local rootPos = Vector3.new(0,0,0)
local function UpdatePos()
if Player.Character and Player.Character:FindFirstChildOfClass"Humanoid" and Player.Character:FindFirstChildOfClass"Humanoid".RootPart then
rootPos = Player.Character:FindFirstChildOfClass"Humanoid".RootPart.Position
end
end
    local function UpdateImage(STATE)
        button.Image = states[STATE]
    end
    local function UpdateAutoRotate(BOOL)
if Player.Character and Player.Character:FindFirstChildOfClass"Humanoid" then
Player.Character:FindFirstChildOfClass"Humanoid".AutoRotate = BOOL
end
end
    local function GetUpdatedCameraCFrame()
if game:GetService"Workspace".CurrentCamera then
return CFrame.new(rootPos, Vector3.new(game:GetService"Workspace".CurrentCamera.CFrame.LookVector.X * MAX_LENGTH, rootPos.Y, game:GetService"Workspace".CurrentCamera.CFrame.LookVector.Z * MAX_LENGTH))
end
end
    local function EnableShiftlock()
UpdatePos()
        UpdateAutoRotate(false)
        UpdateImage("ON")
if Player.Character and Player.Character:FindFirstChildOfClass"Humanoid" and Player.Character:FindFirstChildOfClass"Humanoid".RootPart then
Player.Character:FindFirstChildOfClass"Humanoid".RootPart.CFrame = GetUpdatedCameraCFrame()
end
if game:GetService"Workspace".CurrentCamera then
game:GetService"Workspace".CurrentCamera.CFrame = camera.CFrame * ENABLED_OFFSET
end
    end
    local function DisableShiftlock()
UpdatePos()
        UpdateAutoRotate(true)
        UpdateImage("OFF")
        if game:GetService"Workspace".CurrentCamera then
game:GetService"Workspace".CurrentCamera.CFrame = camera.CFrame * DISABLED_OFFSET
end
        pcall(function()
            active:Disconnect()
            active = nil
        end)
    end
    UpdateImage("OFF")
    active = false
    function ShiftLock()
        if not active then
            active = runservice.RenderStepped:Connect(function()
                EnableShiftlock()
            end)
        else
            DisableShiftlock()
        end
    end
    local ShiftLockButton = CAS:BindAction("ShiftLOCK", ShiftLock, false, "On")
    CAS:SetPosition("ShiftLOCK", UDim2.new(0.8, 0, 0.8, 0))
    button.MouseButton1Click:Connect(function()
        if not active then
            active = runservice.RenderStepped:Connect(function()
                EnableShiftlock()
            end)
        else
            DisableShiftlock()
        end
    end)
    return MobileCameraFramework
    
end
coroutine.wrap(TLQOYN_fake_script)()
local function OMQRQRC_fake_script()
    local script = Instance.new("LocalScript", ShiftlockStarterGui)

    local Players = game.Players
    local UserInputService = game:GetService("UserInputService")
    local Settings = UserSettings()
    local GameSettings = Settings.GameSettings
    local ShiftLockController = {}
    while not Players.LocalPlayer do
        wait()
    end
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local ScreenGui, ShiftLockIcon, InputCn
    local IsShiftLockMode = true
    local IsShiftLocked = true
    local IsActionBound = false
    local IsInFirstPerson = false
    ShiftLockController.OnShiftLockToggled = Instance.new("BindableEvent")
    local function isShiftLockMode()
        return LocalPlayer.DevEnableMouseLock and GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove and LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
    end
    if not UserInputService.TouchEnabled then
        IsShiftLockMode = isShiftLockMode()
    end
    local function onShiftLockToggled()
        IsShiftLocked = not IsShiftLocked
        ShiftLockController.OnShiftLockToggled:Fire()
    end
    local initialize = function()
        print("enabled")
    end
    function ShiftLockController:IsShiftLocked()
        return IsShiftLockMode and IsShiftLocked
    end
    function ShiftLockController:SetIsInFirstPerson(isInFirstPerson)
        IsInFirstPerson = isInFirstPerson
    end
    local function mouseLockSwitchFunc(actionName, inputState, inputObject)
        if IsShiftLockMode then
            onShiftLockToggled()
        end
    end
    local function disableShiftLock()
        if ScreenGui then
            ScreenGui.Parent = nil
        end
        IsShiftLockMode = false
        Mouse.Icon = ""
        if InputCn then
            InputCn:disconnect()
            InputCn = nil
        end
        IsActionBound = false
        ShiftLockController.OnShiftLockToggled:Fire()
    end
    local onShiftInputBegan = function(inputObject, isProcessed)
        if isProcessed then
            return
        end
        if inputObject.UserInputType ~= Enum.UserInputType.Keyboard or inputObject.KeyCode == Enum.KeyCode.LeftShift or inputObject.KeyCode == Enum.KeyCode.RightShift then
        end
    end
    local function enableShiftLock()
        IsShiftLockMode = isShiftLockMode()
        if IsShiftLockMode then
            if ScreenGui then
                ScreenGui.Parent = PlayerGui
            end
            if IsShiftLocked then
                ShiftLockController.OnShiftLockToggled:Fire()
            end
            if not IsActionBound then
                InputCn = UserInputService.InputBegan:connect(onShiftInputBegan)
                IsActionBound = true
            end
        end
    end
    GameSettings.Changed:connect(function(property)
        if property == "ControlMode" then
            if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
                enableShiftLock()
            else
                disableShiftLock()
            end
        elseif property == "ComputerMovementMode" then
            if GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
                disableShiftLock()
            else
                enableShiftLock()
            end
        end
    end)
    LocalPlayer.Changed:connect(function(property)
        if property == "DevEnableMouseLock" then
            if LocalPlayer.DevEnableMouseLock then
                enableShiftLock()
            else
                disableShiftLock()
            end
        elseif property == "DevComputerMovementMode" then
            if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
                disableShiftLock()
            else
                enableShiftLock()
            end
        end
    end)
    LocalPlayer.CharacterAdded:connect(function(character)
        if not UserInputService.TouchEnabled then
            initialize()
        end
    end)
    if not UserInputService.TouchEnabled then
        initialize()
        if isShiftLockMode() then
            InputCn = UserInputService.InputBegan:connect(onShiftInputBegan)
            IsActionBound = true
        end
    end
    enableShiftLock()
    return ShiftLockController
    
end
coroutine.wrap(OMQRQRC_fake_script)()
end)

Tab1:Paragraph({
    Title = "以下是飞行区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "XIAOXI飞行", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoxi9008/XIAOXIBUXINB/refs/heads/main/NOL%E9%A3%9E%E8%A1%8C.lua"))()
end) 

Button(Tab1, "飞行v4", function() 
        loadstring(game:HttpGet("https://dpaste.org/PE88V/raw"))()
end)

Button(Tab1, "无敌少侠r15", function() 
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
end)

Button(Tab1, "无敌少侠r6", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%97%A0%E6%95%8C%E5%B0%91%E4%BE%A0%E9%A3%9E%E8%A1%8Cr6.txt"))()
end)

Toggle(Tab1, "无限跳", false, function(Value)
    Jump = Value
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if Jump then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        end
    end)
end)

Button(Tab1, "爬墙", function() 
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

Tab1:Paragraph({
    Title = "以下是黑洞区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "双环控制黑洞", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%8F%8C%E7%8E%AF%E6%8E%A7%E5%88%B6%E9%BB%91%E6%B4%9E.txt"))()
end)

Button(Tab1, "可爱黑洞[英文]", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hellohellohell012321/KAWAII-AURA/main/kawaii_aura.lua"))()
end)

Button(Tab1, "哥特风黑洞", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%93%A5%E7%89%B9%E9%A3%8E%E9%BB%91%E6%B4%9E.txt"))()
end)

Button(Tab1, "磁铁黑洞", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E7%A3%81%E9%93%81%E9%BB%91%E6%B4%9EV2.txt"))()
end)

Tab1:Paragraph({
    Title = "以下是fps区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "fpsBooster(很猛的提升fps)", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/JoshzzAlteregooo/JoshzzFpsBoosterVersion3/refs/heads/main/JoshzzNewFpsBooster"))()
end)

Button(Tab1, "fps显示", function() 
    loadstring(game:HttpGet("https://pastefy.app/d9j82YJr/raw",true))()
end)

Tab1:Paragraph({
    Title = "以下是回溯区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})
Button(Tab1, "回溯", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MSTTOPPER/Scripts/refs/heads/main/FlashBack"))()
end)

Tab1:Paragraph({
    Title = "以下是甩飞区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "甩飞所有人", function() 
        loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
end)

Button(Tab1, "甩飞", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3LD4D0/Crazy-Man-R6/36ec60d16bf8d208c40807aa0fd2662af76a5385/Crazy%20Man%20R6"))()
end)

Button(Tab1, "触碰既甩飞", function() 
        loadstring(game:HttpGet("http://rawscripts.net/raw/Universal-Script-Touch-fling-script-22447"))()
end)

Tab1:Paragraph({
    Title = "以下是防坠落区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "防坠落 by西班牙", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/5twh2hsf9j-byte/BowenPrime67/refs/heads/main/Python"))()
end)

Button(Tab1, "踏空行走", function() 
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
end)

Tab1:Paragraph({
    Title = "以下是传送区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "点击传送工具", function() 
    mouse = game.Players.LocalPlayer:GetMouse()
                tool = Instance.new("Tool")
                tool.RequiresHandle = false
                tool.Name = "Click Teleport"
                tool.Activated:connect(function()
                local pos = mouse.Hit+Vector3.new(0,2.5,0)
                pos = CFrame.new(pos.X,pos.Y,pos.Z)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
                end)
                tool.Parent = game.Players.LocalPlayer.Backpack
end)

Tab1:Paragraph({
    Title = "以下是穿墙区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Toggle(Tab1, "穿墙", false, function(a)
    pcall(function()
        for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") then
                v.CanCollide = not a
            end
        end
    end)
end)

Tab1:Paragraph({
    Title = "以下是旋转区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "旋转[1]", function() 
        loadstring(game:HttpGet('https://pastebin.com/raw/r97d7dS0', true))()
end)

Button(Tab1, "旋转[2]", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/TUIXUI_qun-809771141/refs/heads/TUIXUI/fling"))()
end)

Button(Tab1, "在别人身上旋转", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ShutUpJamesTheLoserAlt/hatspin/refs/heads/main/hat"))()
end)

Tab1:Paragraph({
    Title = "以下是客户端区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "无头加短腿美化", function() 
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Permanent-Headless-And-korblox-Script-4140"))()
end)

Tab1:Paragraph({
    Title = "以下是视觉区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "动态模糊", function() 
     	local camera = workspace.CurrentCamera
local blurAmount = 10
local blurAmplifier = 5
local lastVector = camera.CFrame.LookVector

local motionBlur = Instance.new("BlurEffect", camera)

local runService = game:GetService("RunService")

workspace.Changed:Connect(function(property)
 if property == "CurrentCamera" then
  print("Changed")
  local camera = workspace.CurrentCamera
  if motionBlur and motionBlur.Parent then
   motionBlur.Parent = camera
  else
   motionBlur = Instance.new("BlurEffect", camera)
  end
 end
end)

runService.Heartbeat:Connect(function()
 if not motionBlur or motionBlur.Parent == nil then
  motionBlur = Instance.new("BlurEffect", camera)
 end
 
 local magnitude = (camera.CFrame.LookVector - lastVector).magnitude
 motionBlur.Size = math.abs(magnitude)*blurAmount*blurAmplifier/2
 lastVector = camera.CFrame.LookVector
end)
end)

local deleteShadowsEnabled = false

Toggle(Tab1, "删除阴影", deleteShadowsEnabled, function(state)
    deleteShadowsEnabled = state
    
    if deleteShadowsEnabled then
        if game:GetService("Lighting").GlobalShadows then
            game:GetService("Lighting").GlobalShadows = false
        end
        if game:GetService("Lighting").ShadowSoftness then
            game:GetService("Lighting").ShadowSoftness = 0
        end
        
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                obj.CastShadow = false
            end
        end
        print("删除阴影已开启")
    else
        if game:GetService("Lighting").GlobalShadows then
            game:GetService("Lighting").GlobalShadows = true
        end
        if game:GetService("Lighting").ShadowSoftness then
            game:GetService("Lighting").ShadowSoftness = 1
        end
        print("删除阴影已关闭")
    end
end)
Toggle(Tab1, "夜视", false, function(a)
        if a then
            game.Lighting.Ambient = Color3.new(1, 1, 1)
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
end)

Button(Tab1, "最大视野缩放", function() 
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = 200000
end)

Button(Tab1, "视野缩放128", function() 
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = 128
end)

Slider(Tab1, "视野缩放距离", 1, 1500, game:GetService("Players").LocalPlayer.CameraMaxZoomDistance, function(a) 
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = a
end)

Button(Tab1, "广角", function() 
    Workspace.CurrentCamera.FieldOfView = 120
end)

Button(Tab1, "恢复视野", function() 
    Workspace.CurrentCamera.FieldOfView = 70
end)

Tab1:Paragraph({
    Title = "以下是控制区",
    Desc = [[ 👇👇👇]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#000000"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tab1, "控制NPC", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/fe-source/refs/heads/main/NPC/source/main.Luau"))()
end)

Button(TabFE, "超多动作but英文", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/smalldesikon/vv/main/%E8%80%81%E5%A4%96%E5%8A%A8%E4%BD%9C100%E4%B8%87%E4%B8%AA"))()
end)

Button(TabFE, "动作", function() 
        loadstring(game:HttpGet("https://yarhm.mhi.im/scr?channel=afemmax"))()
end)

Button(TabFE, "隐身", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/smalldesikon/vv/main/%E9%9A%90%E8%BA%ABfe"))()
end)

local espEnabled = false
local espObjects = {}
local refreshConnection = nil

local espSettings = {
    showName = false,
    showDistance = false,
    showHealth = false,
    showBox = false
}

local camera = game:GetService("Workspace").CurrentCamera

function getHeadScreenSize(character)
    if not character then return 50 end
    
    local head = character:FindFirstChild("Head")
    if not head then return 50 end
    
    local headPos, headVisible = camera:WorldToViewportPoint(head.Position)
    if not headVisible then return 50 end
    
    local distance = (head.Position - camera.CFrame.Position).Magnitude
    local headSize = head.Size.Y * 100 / distance
    
    return math.max(headSize, 10)
end

function updateHealthDisplay(player)
    if not espObjects[player] or not espObjects[player].health then return end
    
    local character = player.Character
    if not character or not character:FindFirstChild("Humanoid") then return end
    
    local humanoid = character.Humanoid
    local healthPercent = humanoid.Health / humanoid.MaxHealth
    local healthBar = espObjects[player].healthBar
    local healthText = espObjects[player].healthText
    
    if healthBar and healthText then
        healthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
        
        if healthPercent > 0.7 then
            healthBar.BackgroundColor3 = Color3.new(0, 1, 0)
        elseif healthPercent > 0.3 then
            healthBar.BackgroundColor3 = Color3.new(1, 1, 0)
        else
            healthBar.BackgroundColor3 = Color3.new(1, 0, 0)
        end
        
        healthText.Text = string.format("%d/%d", 
            math.floor(humanoid.Health), 
            math.floor(humanoid.MaxHealth))
    end
end

function createESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local character = player.Character
    local humanoidRootPart = character.HumanoidRootPart
    
    if espObjects[player] then
        clearESP(player)
    end
    
    espObjects[player] = {}
    
    if espSettings.showName then
        local nameBillboard = Instance.new("BillboardGui")
        local nameText = Instance.new("TextLabel")
        
        nameBillboard.Name = "ESP_Name"
        nameBillboard.Adornee = humanoidRootPart
        nameBillboard.Size = UDim2.new(0, 200, 0, 30)
        nameBillboard.StudsOffset = Vector3.new(0, 3.5, 0)
        nameBillboard.AlwaysOnTop = true
        nameBillboard.Parent = humanoidRootPart
        
        nameText.Size = UDim2.new(1, 0, 1, 0)
        nameText.BackgroundTransparency = 1
        nameText.Text = player.Name
        nameText.TextColor3 = Color3.new(1, 1, 1)
        nameText.TextSize = 14
        nameText.Font = Enum.Font.GothamBold
        nameText.Parent = nameBillboard
        
        espObjects[player].name = nameBillboard
        espObjects[player].nameText = nameText
    end
    
    if espSettings.showBox then
        local boxGui = Instance.new("BillboardGui")
        boxGui.Name = "ESP_Box2D"
        boxGui.Adornee = humanoidRootPart
        boxGui.Size = UDim2.new(0, 80, 0, 120)
        boxGui.StudsOffset = Vector3.new(0, 0, 0)
        boxGui.AlwaysOnTop = true
        boxGui.Parent = humanoidRootPart
        
        local boxFrame = Instance.new("Frame")
        boxFrame.Name = "BoxFrame"
        boxFrame.Size = UDim2.new(1, 0, 1, 0)
        boxFrame.BackgroundTransparency = 1
        boxFrame.BorderSizePixel = 2
        boxFrame.BorderColor3 = Color3.new(1, 0, 0)
        boxFrame.Parent = boxGui
        
        local boxFill = Instance.new("Frame")
        boxFill.Name = "BoxFill"
        boxFill.Size = UDim2.new(1, 0, 1, 0)
        boxFill.BackgroundColor3 = Color3.new(1, 0, 0)
        boxFill.BackgroundTransparency = 0.8
        boxFill.BorderSizePixel = 0
        boxFill.Parent = boxGui
        
        espObjects[player].box = boxGui
    end
    
    if espSettings.showDistance then
        local distanceBillboard = Instance.new("BillboardGui")
        local distanceText = Instance.new("TextLabel")
        
        distanceBillboard.Name = "ESP_Distance"
        distanceBillboard.Adornee = humanoidRootPart
        distanceBillboard.Size = UDim2.new(0, 120, 0, 25)
        distanceBillboard.StudsOffset = Vector3.new(0, -3, 0)
        distanceBillboard.AlwaysOnTop = true
        distanceBillboard.Parent = humanoidRootPart
        
        distanceText.Size = UDim2.new(1, 0, 1, 0)
        distanceText.BackgroundTransparency = 1
        distanceText.TextColor3 = Color3.new(0, 1, 1)
        distanceText.TextSize = 12
        distanceText.Font = Enum.Font.GothamBold
        distanceText.Text = "距离: 0"
        distanceText.Parent = distanceBillboard
        
        espObjects[player].distance = distanceBillboard
        espObjects[player].distanceText = distanceText
    end
    
    if espSettings.showHealth and character:FindFirstChild("Humanoid") then
        local healthBillboard = Instance.new("BillboardGui")
        local healthFrame = Instance.new("Frame")
        local healthBar = Instance.new("Frame")
        local healthText = Instance.new("TextLabel")
        
        healthBillboard.Name = "ESP_Health"
        healthBillboard.Adornee = humanoidRootPart
        healthBillboard.Size = UDim2.new(0, 70, 0, 25)
        healthBillboard.StudsOffset = Vector3.new(0, 2.5, 0)
        healthBillboard.AlwaysOnTop = true
        healthBillboard.Parent = humanoidRootPart
        
        healthFrame.Name = "HealthFrame"
        healthFrame.Size = UDim2.new(0.9, 0, 0.5, 0)
        healthFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
        healthFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        healthFrame.BorderSizePixel = 1
        healthFrame.BorderColor3 = Color3.new(1, 1, 1)
        healthFrame.Parent = healthBillboard
        
        healthBar.Name = "HealthBar"
        healthBar.Size = UDim2.new(1, 0, 1, 0)
        healthBar.BackgroundColor3 = Color3.new(0, 1, 0)
        healthBar.BorderSizePixel = 0
        healthBar.Parent = healthFrame
        
        healthText.Name = "HealthText"
        healthText.Size = UDim2.new(1, 0, 0.5, 0)
        healthText.Position = UDim2.new(0, 0, 0.5, 0)
        healthText.BackgroundTransparency = 1
        healthText.TextColor3 = Color3.new(1, 1, 1)
        healthText.TextSize = 10
        healthText.Font = Enum.Font.GothamBold
        healthText.Text = "100/100"
        healthText.Parent = healthBillboard
        
        espObjects[player].health = healthBillboard
        espObjects[player].healthBar = healthBar
        espObjects[player].healthText = healthText
    end
end

function updateESPSize(player)
    local character = player.Character
    if not character then return end
    
    local headSize = getHeadScreenSize(character)
    local scale = headSize / 50
    
    scale = math.clamp(scale, 0.5, 3.0)
    
    if espObjects[player].name then
        local baseSize = Vector2.new(200, 30)
        espObjects[player].name.Size = UDim2.new(0, baseSize.X * scale, 0, baseSize.Y * scale)
        if espObjects[player].nameText then
            espObjects[player].nameText.TextSize = 14 * scale
        end
    end
    
    if espObjects[player].box then
        local baseSize = Vector2.new(80, 120)
        espObjects[player].box.Size = UDim2.new(0, baseSize.X * scale, 0, baseSize.Y * scale)
    end
    
    if espObjects[player].distance then
        local baseSize = Vector2.new(120, 25)
        espObjects[player].distance.Size = UDim2.new(0, baseSize.X * scale, 0, baseSize.Y * scale)
        if espObjects[player].distanceText then
            espObjects[player].distanceText.TextSize = 12 * scale
        end
    end
    
    if espObjects[player].health then
        local baseSize = Vector2.new(70, 25)
        espObjects[player].health.Size = UDim2.new(0, baseSize.X * scale, 0, baseSize.Y * scale)
        if espObjects[player].healthText then
            espObjects[player].healthText.TextSize = 10 * scale
        end
    end
end

function clearESP(player)
    if espObjects[player] then
        for _, obj in pairs(espObjects[player]) do
            if obj and obj.Parent then
                obj:Destroy()
            end
        end
        espObjects[player] = nil
    end
end

function clearAllESP()
    for player, objects in pairs(espObjects) do
        clearESP(player)
    end
    espObjects = {}
end

function updateESPInfo()
    if not espEnabled then return end
    
    local localPlayer = game.Players.LocalPlayer
    local localCharacter = localPlayer.Character
    local localRootPart = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
    
    if not localRootPart then return end
    
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= localPlayer then
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            
            if not rootPart then
                clearESP(player)
                continue
            end
            
            if not espObjects[player] then
                createESP(player)
            end
            
            updateESPSize(player)
            
            if espSettings.showHealth then
                updateHealthDisplay(player)
            end
            
            if espSettings.showDistance and espObjects[player].distance then
                local distance = (rootPart.Position - localRootPart.Position).Magnitude
                local distanceText = espObjects[player].distanceText
                if distanceText then
                    distanceText.Text = string.format("距离: %d", math.floor(distance))
                end
            end
            
            continue
        end
    end
end

function updateAllESP()
    clearAllESP()
    
    if not espEnabled then
        return
    end
    
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            createESP(player)
        end
    end
end

function startAutoRefresh()
    if refreshConnection then
        refreshConnection:Disconnect()
    end
    
    refreshConnection = game:GetService("RunService").Heartbeat:Connect(function()
        updateESPInfo()
    end)
end

function stopAutoRefresh()
    if refreshConnection then
        refreshConnection:Disconnect()
        refreshConnection = nil
    end
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
    
    player.CharacterRemoving:Connect(function()
        clearESP(player)
    end)
end)

game.Players.PlayerRemoving:Connect(function(player)
    clearESP(player)
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if espEnabled then
        wait(2)
        updateAllESP()
    end
end)

Toggle(Tab2, "启用ESP总开关", false, function(value)
    espEnabled = value
    
    if value then
        updateAllESP()
        startAutoRefresh()
    else
        clearAllESP()
        stopAutoRefresh()
    end
end)

Toggle(Tab2, "显示玩家名称", false, function(value)
    espSettings.showName = value
    if espEnabled then
        updateAllESP()
    end
end)

Toggle(Tab2, "显示玩家距离", false, function(value)
    espSettings.showDistance = value
    if espEnabled then
        updateAllESP()
    end
end)

Toggle(Tab2, "显示玩家血量", false, function(value)
    espSettings.showHealth = value
    if espEnabled then
        updateAllESP()
    end
end)

Toggle(Tab2, "显示玩家方框", false, function(value)
    espSettings.showBox = value
    if espEnabled then
        updateAllESP()
    end
end)

Button(Tab3, "陌自瞄（死亡消失）", function() 
    loadstring(game:HttpGet("https://pastefy.app/ZYMlyhhz/raw",true))()
end)

Button(Tab3, "宙斯自瞄", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20Aimbot.lua"))()
end)

Button(Tab3, "英文自瞄", function() 
    loadstring(game:HttpGet("https://rentry.co/n55gmtpi/raw", true))()
end)

Button(Tab3, "自瞄50", function() 
    loadstring(game:HttpGet("https://pastefy.app/b3uXjRF6/raw",true))()
end)

Button(Tab3, "自瞄100", function() 
    loadstring(game:HttpGet("https://pastefy.app/tQrd2r0L/raw",true))()
end)

Button(Tab3, "自瞄150", function() 
    loadstring(game:HttpGet("https://pastefy.app/UOQWFvGp/raw",true))()
end)

Button(Tab3, "自瞄200", function() 
    loadstring(game:HttpGet("https://pastefy.app/b5CuDuer/raw",true))()
end)

Button(Tab3, "自瞄250", function() 
    loadstring(game:HttpGet("https://pastefy.app/p2huH7eF/raw",true))()
end)

Button(Tab3, "自瞄300", function() 
    loadstring(game:HttpGet("https://pastefy.app/niyVhrvV/raw",true))()
end)

Button(Tab3, "自瞄350", function() 
    loadstring(game:HttpGet("https://pastefy.app/pnjKHMvV/raw",true))()
end)

Button(Tab3, "自瞄400", function() 
    loadstring(game:HttpGet("https://pastefy.app/LQuP7sjj/raw",true))()
end)

Button(Tab3, "自瞄600", function() 
    loadstring(game:HttpGet("https://pastefy.app/WmcEe2HB/raw",true))()
end)

Button(Tab3, "自瞄全屏", function() 
    loadstring(game:HttpGet("https://pastefy.app/n5LhGGgf/raw",true))()
end)

Button(Tab3, "神青高级自瞄", function() 
    shin_qine="作者神青" 
shin__qine="高级自瞄" 
loadstring(game:HttpGet("https://raw.githubusercontent.com/gycgchgyfytdttr/QQ-9-2-8-9-50173/refs/heads/main/cure.lua"))()
end)

Button(Tab3, "自瞄", function()
    pcall(function()
        local fov = 100 
        local smoothness = 10 
        local crosshairDistance = 5 
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local Players = game:GetService("Players")
        local Cam = game.Workspace.CurrentCamera
        
        local FOVring = Drawing.new("Circle")
        FOVring.Visible = true
        FOVring.Thickness = 2
        FOVring.Color = Color3.fromRGB(0, 255, 0)
        FOVring.Filled = false
        FOVring.Radius = fov
        FOVring.Position = Cam.ViewportSize / 2
        
        local Player = Players.LocalPlayer
        local PlayerGui = Player:WaitForChild("PlayerGui")
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "FovAdjustGui"
        ScreenGui.Parent = PlayerGui
        
        local Frame = Instance.new("Frame")
        Frame.Name = "MainFrame"
        Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Frame.BorderColor3 = Color3.fromRGB(128, 0, 128)
        Frame.BorderSizePixel = 2
        Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
        Frame.Size = UDim2.new(0.4, 0, 0.4, 0)
        Frame.Active = true
        Frame.Draggable = true
        Frame.Parent = ScreenGui
        
        local MinimizeButton = Instance.new("TextButton")
        MinimizeButton.Name = "MinimizeButton"
        MinimizeButton.Text = "-"
        MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        MinimizeButton.Position = UDim2.new(0.9, 0, 0, 0)
        MinimizeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
        MinimizeButton.Parent = Frame
        
        local isMinimized = false
        MinimizeButton.MouseButton1Click:Connect(function()
            isMinimized = not isMinimized
            if isMinimized then
                Frame:TweenSize(UDim2.new(0.1, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
                MinimizeButton.Text = "+"
            else
                Frame:TweenSize(UDim2.new(0.4, 0, 0.4, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
                MinimizeButton.Text = "-"
            end
        end)
        
        local FovLabel = Instance.new("TextLabel")
        FovLabel.Name = "FovLabel"
        FovLabel.Text = "自瞄范围"
        FovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        FovLabel.BackgroundTransparency = 1
        FovLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
        FovLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
        FovLabel.Parent = Frame
        
        local FovSlider = Instance.new("TextBox")
        FovSlider.Name = "FovSlider"
        FovSlider.Text = tostring(fov)
        FovSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
        FovSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        FovSlider.Position = UDim2.new(0.1, 0, 0.3, 0)
        FovSlider.Size = UDim2.new(0.8, 0, 0.2, 0)
        FovSlider.Parent = Frame
        
        local SmoothnessLabel = Instance.new("TextLabel")
        SmoothnessLabel.Name = "SmoothnessLabel"
        SmoothnessLabel.Text = "自瞄平滑度"
        SmoothnessLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        SmoothnessLabel.BackgroundTransparency = 1
        SmoothnessLabel.Position = UDim2.new(0.1, 0, 0.5, 0)
        SmoothnessLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
        SmoothnessLabel.Parent = Frame
        
        local SmoothnessSlider = Instance.new("TextBox")
        SmoothnessSlider.Name = "SmoothnessSlider"
        SmoothnessSlider.Text = tostring(smoothness)
        SmoothnessSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
        SmoothnessSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        SmoothnessSlider.Position = UDim2.new(0.1, 0, 0.7, 0)
        SmoothnessSlider.Size = UDim2.new(0.8, 0, 0.2, 0)
        SmoothnessSlider.Parent = Frame
        
        local CrosshairDistanceLabel = Instance.new("TextLabel")
        CrosshairDistanceLabel.Name = "CrosshairDistanceLabel"
        CrosshairDistanceLabel.Text = "自瞄预判距离"
        CrosshairDistanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        CrosshairDistanceLabel.BackgroundTransparency = 1
        CrosshairDistanceLabel.Position = UDim2.new(0.1, 0, 0.9, 0)
        CrosshairDistanceLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
        CrosshairDistanceLabel.Parent = Frame
        
        local CrosshairDistanceSlider = Instance.new("TextBox")
        CrosshairDistanceSlider.Name = "CrosshairDistanceSlider"
        CrosshairDistanceSlider.Text = tostring(crosshairDistance)
        CrosshairDistanceSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
        CrosshairDistanceSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        CrosshairDistanceSlider.Position = UDim2.new(0.1, 0, 1.1, 0)
        CrosshairDistanceSlider.Size = UDim2.new(0.8, 0, 0.2, 0)
        CrosshairDistanceSlider.Parent = Frame
        
        local targetCFrame = Cam.CFrame
        
        local function updateDrawings()
            local camViewportSize = Cam.ViewportSize
            FOVring.Position = camViewportSize / 2
            FOVring.Radius = fov
        end
        
        local function onKeyDown(input)
            if input.KeyCode == Enum.KeyCode.Delete then
                RunService:UnbindFromRenderStep("FOVUpdate")
                FOVring:Remove()
            end
        end
        
        UserInputService.InputBegan:Connect(onKeyDown)
        
        local function getClosestPlayerInFOV(trg_part)
            local nearest = nil
            local last = math.huge
            local playerMousePos = Cam.ViewportSize / 2
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    local part = player.Character and player.Character:FindFirstChild(trg_part)
                    if part then
                        local ePos, isVisible = Cam:WorldToViewportPoint(part.Position)
                        local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude
                        if distance < last and isVisible and distance < fov then
                            last = distance
                            nearest = player
                        end
                    end
                end
            end
            return nearest
        end
        
        RunService.RenderStepped:Connect(function()
            updateDrawings()
            local closest = getClosestPlayerInFOV("Head")
            if closest and closest.Character:FindFirstChild("Head") then
                local targetCharacter = closest.Character
                local targetHead = targetCharacter.Head
                local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
                local isMoving = targetRootPart and targetRootPart.Velocity.Magnitude > 0.1
                local targetPosition
                
                if isMoving then
                    targetPosition = targetHead.Position + (targetHead.CFrame.LookVector * crosshairDistance)
                else
                    targetPosition = targetHead.Position
                end
                targetCFrame = CFrame.new(Cam.CFrame.Position, targetPosition)
            else
                targetCFrame = Cam.CFrame
            end
            Cam.CFrame = Cam.CFrame:Lerp(targetCFrame, 1 / smoothness)
        end)
        
        FovSlider.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local newFov = tonumber(FovSlider.Text)
                if newFov then
                    fov = newFov
                else
                    FovSlider.Text = tostring(fov)
                end
            end
        end)
        
        SmoothnessSlider.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local newSmoothness = tonumber(SmoothnessSlider.Text)
                if newSmoothness then
                    smoothness = newSmoothness
                else
                    SmoothnessSlider.Text = tostring(smoothness)
                end
            end
        end)
        
        CrosshairDistanceSlider.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local newCrosshairDistance = tonumber(CrosshairDistanceSlider.Text)
                if newCrosshairDistance then
                    crosshairDistance = newCrosshairDistance
                else
                    CrosshairDistanceSlider.Text = tostring(crosshairDistance)
                end
            end
        end)
    end)
end)

_G.HitboxEnabled = false
_G.HeadSize = 10
_G.HitboxLoop = nil

Input(Tabc, "自定义范围", "输入HitBox大小", "10", "例如: 20", function(Value)
    local numValue = tonumber(Value)
    if numValue then
        _G.HeadSize = numValue
        print("HitBox大小已设置为: " .. _G.HeadSize)
    else
        warn("请输入有效的数字")
    end
end)

Toggle(Tabc, "启用自定义范围", false, function(Value)
    _G.HitboxEnabled = Value
    
    if Value then
        if _G.HitboxLoop then
            _G.HitboxLoop:Disconnect()
            _G.HitboxLoop = nil
        end
        
        _G.HitboxLoop = game:GetService('RunService').RenderStepped:Connect(function()
            if _G.HitboxEnabled then
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character then
                        pcall(function()
                            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                humanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                                humanoidRootPart.Transparency = 0.7
                                humanoidRootPart.BrickColor = BrickColor.new("Really red")
                                humanoidRootPart.Material = "Neon"
                                humanoidRootPart.CanCollide = false
                            end
                        end)
                    end
                end
            end
        end)
        print("自定义范围已开启，大小: " .. _G.HeadSize)
    else
        if _G.HitboxLoop then
            _G.HitboxLoop:Disconnect()
            _G.HitboxLoop = nil
        end
        
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                pcall(function()
                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        humanoidRootPart.Size = Vector3.new(2, 2, 1)
                        humanoidRootPart.Transparency = 0
                        humanoidRootPart.BrickColor = BrickColor.new("Medium stone grey")
                        humanoidRootPart.Material = "Plastic"
                    end
                end)
            end
        end
        print("自定义范围已关闭")
    end
end)

Button(Tab4, "HB 子追", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/HB-ksdb/-4/main/%E5%AD%90%E8%BF%BD%E8%84%9A%E6%9C%AC%E7%A9%BF%E5%A2%99.lua"))()
end)

Button(Tab4, "阿尔子追", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/sgbs/main/%E4%B8%81%E4%B8%81%20%E6%B1%89%E5%8C%96%E8%87%AA%E7%9E%84.txt"))()
end)

Button(Tab4, "俄州子追", function() 
    loadstring(game:HttpGet("https://gist.githubusercontent.com/ClasiniZukov/e7547e7b48fa90d10eb7f85bd3569147/raw/f95cd3561a3bb3ac6172a14eb74233625b52e757/gistfile1.txt"))()
end)

--=======姥爷司空别翻过头了===========
--=======姥爷司空别翻过头了===========
--=======姥爷司空别翻过头了===========
--=======姥爷司空别翻过头了===========
Button(Tabjb, "XIAOXI网易云", function() 
        FengYu_HUB = "网易云音乐"
loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoxi9008/XIAOXIBUXINB/refs/heads/main/%E7%BD%91%E6%98%93%E4%BA%91.lua"))()
end)
--=======姥爷司空别翻过头了===========
--=======姥爷司空别翻过头了===========
--=======姥爷司空别翻过头了===========
--=======姥爷司空别翻过头了===========

Button(Tabb, "折叠UI", function()
    Window:Close()
end)

Button(Tabb, "重置人物", function() 
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

Button(Tabb, "重进服务器", function() 
    game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId,
            game.JobId,
            game:GetService("Players").LocalPlayer
        )
end)

Tabd:Paragraph({
    Title = "小西不更新怎么办",
    Desc = [[直接加q群😎]],
    Image = "eye",
    ImageSize = 24,
    Color = Color3.fromHex("#FFFFFF"),
    BackgroundColor3 = Color3.fromHex("#000000"),
    BackgroundTransparency = 0.2,
    OutlineColor = Color3.fromHex("#FFFFFF"),
    OutlineThickness = 1,
    Padding = UDim.new(0, 1)
})

Button(Tabd, "XIAOXI脚本qq主群[点我复制]", function()
    setclipboard("705378396")
end)

Button(Tabb, "离开服务器", function() 
    game:Shutdown()
end)