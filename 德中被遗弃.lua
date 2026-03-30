---关注b站UID:1531514159
---一群1035184654
---二群2168053189（聊天群）
---十九群1064447273（五百人群）
---二十一群178021813（五百人群）
---二十二群336225224（五百人群）
---二十三群218012845（五百人群）
---二十四群1035646571（五百人群）
---二十五群1071017763（五百人群）
---二十六群820782679（五百人群）
---二十七群1067211151（五百人群）
---Kenny脚本群1019547871（五百人群）
---sp源码分享协会727992470

local Env = getfenv()
local Loaded_Var224 = loadstring(game:HttpGet("https://raw.githubusercontent.com/SUNXIAOCHUAN-DEV/-/refs/heads/main/乱码牛逼"))()
local Lighting_2 = game:GetService("Lighting")
local Players_2 = game:GetService("Players")
local LocalPlayer = Players_2.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Character_2 = LocalPlayer["Character"]
local _ = (Character_2 and 13193619)
local HumanoidRootPart = Character_2:FindFirstChild("HumanoidRootPart")
local Connection_2
Connection_2 = LocalPlayer.CharacterAdded:Connect(function(Character_10, p2_0) -- args: Character_11
    local Character_11 = Character_10[1]
    local HumanoidRootPart_2 = Character_11:WaitForChild("HumanoidRootPart")
end)
local Connection_3
Connection_3 = LocalPlayer.CharacterRemoving:Connect(function() -- args: Character_12
end)
for i, v in pairs(Players_2:GetChildren()) do
    if not i then return end -- won't run
    local _ = ((v["Name"] ~= LocalPlayer["Name"]) and 12087172)
end
Env["AddHitbox"] = function(p1_0, p2_0, p3_0, p4_0, p5_0, p6_0, p7_0)
    local _ = ((tick() - tick() < p1_0[2]) and 16448192)
end
Env.StopAddHitbox = function(p1_0, p2_0, p3_0)
end
local Humanoid_3 = LocalPlayer["Character"]["Humanoid"]
local WalkSpeed_2 = Humanoid_3:GetPropertyChangedSignal("WalkSpeed")
WalkSpeed_2:Connect(function(p1_0, p2_0, p3_0, p4_0, p5_0)
end)
local Connection_4
Connection_4 = LocalPlayer.CharacterAdded:connect(function(Character_13, p2_0, p3_0, p4_0, p5_0) -- args: Character_14
    local Humanoid_6 = LocalPlayer["Character"]["Humanoid"]
    local WalkSpeed_4 = Humanoid_6:GetPropertyChangedSignal("WalkSpeed")
    WalkSpeed_4:Connect(function()
        while 13325822 do end -- exited this loop due to it having 1000000 iterations.
    end)
end)
Loaded_Var224.TransparencyValue = 0.2
Loaded_Var224:SetTheme("Dark")
Loaded_Var224:Notify({
    ["Duration"] = 2,
    ["Title"] = "德与中山",
    ["Content"] = "德与中山--被遗弃加载完成",
})
local Window = Loaded_Var224:CreateWindow({
    User = {
        ["Enabled"] = true,
        ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
            Loaded_Var224:Notify({
                ["Duration"] = 3,
                ["Title"] = "用户信息",
                ["Content"] = "玩家:" .. LocalPlayer["Name"],
            })
        end,
        ThumbnailType = "AvatarBust",
        ["Anonymous"] = false,
        ["Username"] = LocalPlayer["Name"],
        LocalPlayer.UserId = LocalPlayer.UserId,
        LocalPlayer.DisplayName = LocalPlayer.DisplayName,
    },
    ["Author"] = "作者：汉斯",
    ScrollBarEnabled = true,
    ["Folder"] = "OrangeCHub",
    ["SideBarWidth"] = 180,
    [Title] = "德与中山--被遗弃",
    ["Position"] = UDim2["new"](0.5, 0, 0.5, 0),
    ["Transparent"] = true,
    ["Theme"] = Dark,
    ["Icon"] = "crown",
    ["Size"] = UDim2.fromOffset(600, 500),
})
Window:SetToggleKey(Enum.KeyCode.B)
local _ = Window:CreateTopbarButton("theme-switcher", "moon", function(p1_0)
    local GetCurrentTheme = Loaded_Var224.GetCurrentTheme;
    local CurrentTheme = Loaded_Var224:GetCurrentTheme();
    local var1315 = (CurrentTheme == "Dark");
    local var1316 = (var1315 and 14688388);
    local var1317 = (var1315 and 14734542);
    local SetTheme_3 = Loaded_Var224["SetTheme"];
    local Dark_3 = Loaded_Var224:SetTheme("Dark");
    local Content_3 = "Content";
    local GetCurrentTheme_2 = Loaded_Var224.GetCurrentTheme;
    local CurrentTheme_2 = Loaded_Var224:GetCurrentTheme();
    local Notify_6 = Loaded_Var224["Notify"];
    local var1324 = "当前主题: " .. CurrentTheme_2;
    local Duration_3 = "Duration";
    local Notify_7 = Loaded_Var224:Notify({
        [Duration_3] = 2,
        ["Title"] = "提示",
        [Content_3] = var1324,
    });
end, 990)
local ColorSequenceKeypoint_New = ColorSequenceKeypoint[New]
local Color3_FromRGB = Color3.fromRGB
Window:EditOpenButton({
    StrokeThickness = 2.5,
    ["Title"] = "打开德与中山--被遗弃",
    ["Color"] = ColorSequence["new"]({
    ColorSequenceKeypoint_New(0, Color3_FromRGB(186, 19, 19)),
    ColorSequenceKeypoint_New(1, Color3_FromRGB(8, 60, 129)),
}),
    Draggable = true,
local Section_3 = Window:Section({
    [Icon] = "user",
    [Title] = "玩家",
    ["Opened"] = false,
})
local Section_5 = Window:Section({
    [Icon] = "eye",
    [Title] = "透视",
    [Opened] = false,
})
local Section_7 = Window:Section({
    [Icon] = "circuit-board",
    [Title] = "发电机",
    [Opened] = false,
})
local Section_9 = Window:Section({
    [Icon] = "hand-fist",
    [Title] = "技能",
    [Opened] = false,
})
local Section_11 = Window:Section({
    [Icon] = "vault",
    [Title] = "物品",
    [Opened] = false,
})
local Tab_3 = Section_3:Tab({
    [Title] = "玩家",
    [Icon] = "folder",
})
local Tab_5 = Section_3:Tab({
    [Title] = "体力",
    [Icon] = "folder",
})
local Tab_7 = Section_5:Tab({
    [Title] = "透视",
    [Icon] = "folder",
})
local Tab_9 = Section_5:Tab({
    [Title] = "透视设置",
    [Icon] = "folder",
})
local Tab_11 = Section_9:Tab({
    [Title] = "技能",
    [Icon] = "folder",
})
local Tab_13 = Section_9:Tab({
    [Title] = "反技能",
    [Icon] = "folder",
})
local Tab_15 = Section_9:Tab({
    [Title] = "碰撞箱",
    [Icon] = "folder",
})
local Tab_17 = Section_9:Tab({
    [Title] = "击杀",
    [Icon] = "folder",
})
local Tab_19 = Section_7:Tab({
    [Title] = "修发电机",
    [Icon] = "folder",
})
local Tab_21 = Section_7:Tab({
    [Title] = "自动传送修机",
    [Icon] = "folder",
})
local Tab_23 = Section_11:Tab({
    [Title] = "传送物品",
    [Icon] = "folder",
})
local Tab_25 = Section_11:Tab({
    [Title] = "捡拾物品",
    [Icon] = "folder",
})
local Tab_27 = Section_11:Tab({
    [Title] = "披萨",
    [Icon] = "folder",
})
Tab_3:Section({
    ["Title"] = "基础玩家设置",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "user",
    Desc = "玩家",
})
local _ = Tab_3:Slider({
    ["Title"] = "玩家走路速度",
    [Value] = {
        Min = 16,
        ["Default"] = 12,
        Max = 300,
    },
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        local var1331 = p1_0[1];
        local Character_17 = "Character";
        local Character_18 = LocalPlayer[Character_17];
        local var1339 = (Character_18 and 11000481);
        local Humanoid_7 = "Humanoid";
        local Humanoid_8 = Character_18:FindFirstChild(Humanoid_7);
        if not Humanoid_8 then return end -- won't run
        local BaseSpeed = "BaseSpeed";
        local BaseSpeed_2 = Humanoid_8:SetAttribute(BaseSpeed, var1331);
    end,
    ["Step"] = 1,
    Desc = "速度",
})
local _ = Tab_3:Slider({
    ["Title"] = "玩家FOV",
    [Value] = {
        Min = 70,
        ["Default"] = 70,
        Max = 120,
    },
    ["Callback"] = function(p1_0, p2_0)
        local var1348 = p1_0[1];
        local PlayerData = "PlayerData";
        local PlayerData_2 = LocalPlayer:FindFirstChild(PlayerData);
        local var1354 = (PlayerData_2 and 15464964);
        local var1355 = (var1354 or 10390574);
        local Settings = "Settings";
        local Settings_2 = PlayerData_2:FindFirstChild(Settings);
        if not Settings_2 then return end -- won't run
        local Game_4 = "Game";
        local Game_5 = Settings_2:FindFirstChild(Game_4);
        local var1363 = (Game_5 and 12307361);
        local FieldOfView = Game_5:FindFirstChild("FieldOfView");
        if not FieldOfView then return end -- won't run
        local var1367 = tonumber(var1348, nil);
        FieldOfView[Value_4] = var1367;
    end,
    ["Step"] = 1,
    Desc = "视野距离",
})
local _ = Tab_3:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0)
        local var1368 = p1_0[1];
        if not var1368 then return end -- won't run
        local Ambient_3 = "Ambient";
        local Color3_Value_3 = Color3_FromRGB(255, 255, 255);
        Lighting_2[Ambient_3] = Color3_Value_3;
        local Color3_Value_4 = Color3_FromRGB(255, 255, 255);
        Lighting_2.OutdoorAmbient = Color3_Value_4;
    end,
    ["Title"] = "高亮",
    Desc = "高亮环境",
})
local _ = Tab_3:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        local var1382 = p1_0[1];
        if not not var1382 then return end -- won't run
        local Atmosphere = "Atmosphere";
        local Atmosphere_2 = Lighting_2[Atmosphere];
        local Density = "Density";
        Atmosphere_2[Density] = 0;
    end,
    ["Title"] = "去除雾",
    Desc = "去除",
})
local _ = Tab_3:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0)
        local var1389 = p1_0[1];
        local var1390 = (var1389 and 13397629);
        local Descendants = workspace:GetDescendants();
        for i_2, v_2 in pairs(Descendants) do
            if not not i_2 then return end -- won't run
            local Name_9 = "name";
            local Name_10 = v_2[Name_9];
            local Name_10_isnt_string = (Name_10 ~= "KillerDoors");
            local var1397 = (Name_10_isnt_string and 10225264);
        end
    end,
    ["Title"] = "防止杀手墙",
    Desc = "防止",
})
Tab_3:Section({
    ["Title"] = "其他玩家设置",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "user",
    Desc = "玩家",
})
Tab_3:Toggle({
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0, p6_0)
        local var1398 = p1_0[1]
        game.TextChatService.ChatWindowConfiguration["Enabled"] = var1398
    end,
    ["Title"] = "显示对话框",
    Desc = "显示",
})
game:GetService("ReplicatedStorage")
local Sprinting_Module = require(ReplicatedStorage:FindFirstChild("Systems"):FindFirstChild("Character"):FindFirstChild("Game"):FindFirstChild("Sprinting"))
Tab_5:Section({
    ["Title"] = "体力设置",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "footprints",
    Desc = "体力",
})
local _ = Tab_5:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        local var1414 = p1_0[1];
        Sprinting_Module.StaminaLossDisabled = var1414;
        local var1414 = (var1414 and 13542450);
        local var1415 = getgc();
        local var1422 = typeof(Loaded_Var224);
        local var1422_is_Table = (var1422 == "table");
        local var1423 = rawget(Loaded_Var224, "StaminaLoss");
        local var1424 = (var1423 and 11091049);
        local var1425 = typeof(Lighting_2);
        local var1425_is_Table = (var1425 == "table");
        local var1426 = typeof(Lighting_2["Ambient"]);
        local var1426_is_Table = (var1426 == "table");
        local var1427 = typeof(Lighting_2.OutdoorAmbient);
        local var1427_is_Table = (var1427 == "table");
        local var1428 = typeof(LocalPlayer);
        local var1428_is_Table = (var1428 == "table");
        local var1429 = typeof(game:GetService("RunService"));
        local var1429_is_Table = (var1429 == "table");
        local var1430 = typeof(Character_2);
        local var1430_is_Table = (var1430 == "table");
        local var1431 = typeof(HumanoidRootPart);
        local var1431_is_Table = (var1431 == "table");
        local var1432 = typeof(Sprinting_Module);
        local var1432_is_Table = (var1432 == "table");
        local var1433 = rawget(Sprinting_Module, "StaminaLoss");
        local var1434 = (var1433 and 11091049);
        local var1435 = typeof(Section_23);
        local var1435_is_Table = (var1435 == "table");
        local var1436 = rawget(Section_23, "StaminaLoss");
        local var1437 = (var1436 and 11091049);
        local var1438 = typeof(Paragraph_3);
        local var1438_is_Table = (var1438 == "table");
        local var1439 = rawget(Paragraph_3, "StaminaLoss");
        local var1440 = (var1439 and 11091049);
        local var1441 = typeof(var982);
        local var1441_is_Table = (var1441 == "table");
        local var1442 = rawget(var982, "StaminaLoss");
        local var1443 = (var1442 and 11091049);
        local var1444 = typeof(Vector3_Value);
        local var1444_is_Table = (var1444 == "table");
        local var1445 = typeof(Vector3_Value_2);
        local var1445_is_Table = (var1445 == "table");
        local var1446 = typeof(Dropdown_3);
        local var1446_is_Table = (var1446 == "table");
        local var1447 = rawget(Dropdown_3, "StaminaLoss");
        local var1448 = (var1447 and 11091049);
        local var1449 = typeof(Dropdown_4);
        local var1449_is_Table = (var1449 == "table");
        local var1450 = rawget(Dropdown_4, "StaminaLoss");
        local var1451 = (var1450 and 11091049);
        local var1452 = typeof(Dropdown_5);
        local var1452_is_Table = (var1452 == "table");
        local var1453 = rawget(Dropdown_5, "StaminaLoss");
        local var1454 = (var1453 and 11091049);
        local var1455 = typeof(Button_4);
        local var1455_is_Table = (var1455 == "table");
        local var1456 = rawget(Button_4, "StaminaLoss");
        local var1457 = (var1456 and 11091049);
        local var1458 = typeof(Button_5);
        local var1458_is_Table = (var1458 == "table");
        local var1459 = rawget(Button_5, "StaminaLoss");
        local var1460 = (var1459 and 11091049);
        local var1461 = typeof(Divider_12);
        local var1461_is_Table = (var1461 == "table");
        local var1462 = rawget(Divider_12, "StaminaLoss");
        local var1463 = (var1462 and 11091049);
        local var1464 = typeof(Divider_13);
        local var1464_is_Table = (var1464 == "table");
        local var1465 = rawget(Divider_13, "StaminaLoss");
        local var1466 = (var1465 and 11091049);
        local var1467 = typeof(Button_6);
        local var1467_is_Table = (var1467 == "table");
        local var1468 = rawget(Button_6, "StaminaLoss");
        local var1469 = (var1468 and 11091049);
        local var1470 = typeof(Button_7);
        local var1470_is_Table = (var1470 == "table");
        local var1471 = rawget(Button_7, "StaminaLoss");
        local var1472 = (var1471 and 11091049);
        local var1473 = typeof(Section_48);
        local var1473_is_Table = (var1473 == "table");
        local var1474 = rawget(Section_48, "StaminaLoss");
        local var1475 = (var1474 and 11091049);
        local var1476 = typeof(Section_49);
        local var1476_is_Table = (var1476 == "table");
        local var1477 = rawget(Section_49, "StaminaLoss");
        local var1478 = (var1477 and 11091049);
        local var1479 = typeof(Dropdown_6);
        local var1479_is_Table = (var1479 == "table");
        local var1480 = rawget(Dropdown_6, "StaminaLoss");
        local var1481 = (var1480 and 11091049);
        local var1482 = typeof(Dropdown_7);
        local var1482_is_Table = (var1482 == "table");
        local var1483 = rawget(Dropdown_7, "StaminaLoss");
        local var1484 = (var1483 and 11091049);
        local var1485 = typeof(Button_8);
        local var1485_is_Table = (var1485 == "table");
        local var1486 = rawget(Button_8, "StaminaLoss");
        local var1487 = (var1486 and 11091049);
        local var1488 = typeof(Button_9);
        local var1488_is_Table = (var1488 == "table");
        local var1489 = rawget(Button_9, "StaminaLoss");
        local var1490 = (var1489 and 11091049);
        local var1491 = typeof(Divider_14);
        local var1491_is_Table = (var1491 == "table");
        local var1492 = rawget(Divider_14, "StaminaLoss");
        local var1493 = (var1492 and 11091049);
        local var1494 = typeof(Divider_15);
        local var1494_is_Table = (var1494 == "table");
        local var1495 = rawget(Divider_15, "StaminaLoss");
        local var1496 = (var1495 and 11091049);
        local var1497 = typeof(Button_10);
        local var1497_is_Table = (var1497 == "table");
        local var1498 = rawget(Button_10, "StaminaLoss");
        local var1499 = (var1498 and 11091049);
        local var1500 = typeof(Button_11);
        local var1500_is_Table = (var1500 == "table");
        local var1501 = rawget(Button_11, "StaminaLoss");
        local var1502 = (var1501 and 11091049);
        local var1503 = typeof(Section_50);
        local var1503_is_Table = (var1503 == "table");
        local var1504 = rawget(Section_50, "StaminaLoss");
        local var1505 = (var1504 and 11091049);
        local var1506 = typeof(Section_51);
        local var1506_is_Table = (var1506 == "table");
        local var1507 = rawget(Section_51, "StaminaLoss");
        local var1508 = (var1507 and 11091049);
        local var1509 = typeof(Slider_12);
        local var1509_is_Table = (var1509 == "table");
        local var1510 = rawget(Slider_12, "StaminaLoss");
        local var1511 = (var1510 and 11091049);
        local var1512 = typeof(Slider_13);
        local var1512_is_Table = (var1512 == "table");
        local var1513 = rawget(Slider_13, "StaminaLoss");
        local var1514 = (var1513 and 11091049);
        local var1515 = typeof(Toggle_68);
        local var1515_is_Table = (var1515 == "table");
        local var1516 = rawget(Toggle_68, "StaminaLoss");
        local var1517 = (var1516 and 11091049);
        local var1518 = typeof(Toggle_69);
        local var1518_is_Table = (var1518 == "table");
        local var1519 = rawget(Toggle_69, "StaminaLoss");
        local var1520 = (var1519 and 11091049);
        local var1521 = typeof(game);
        local var1521_is_Table = (var1521 == "table");
        local var1522 = typeof(Players_2);
        local var1522_is_Table = (var1522 == "table");
        local var1523 = typeof(Connection_5);
        local var1523_is_Table = (var1523 == "table");
        local var1524 = typeof(game);
        local var1524_is_Table = (var1524 == "table");
        local var1525 = typeof(Players_2);
        local var1525_is_Table = (var1525 == "table");
        local var1526 = typeof(Connection_6);
        local var1526_is_Table = (var1526 == "table");
        local var1527 = typeof(Character_11);
        local var1527_is_Table = (var1527 == "table");
        local var1528 = rawget(Character_11, "StaminaLoss");
        local var1529 = (var1528 and 11091049);
        local var1530 = typeof(HumanoidRootPart_2);
        local var1530_is_Table = (var1530 == "table");
        local var1531 = rawget(HumanoidRootPart_2, "StaminaLoss");
        local var1532 = (var1531 and 11091049);
        local var1533 = typeof(var1367);
        local var1533_is_Table = (var1533 == "table");
        local var1534 = rawget(var1367, "StaminaLoss");
        local var1535 = (var1534 and 11091049);
        local var1536 = typeof(Color3_Value_3);
        local var1536_is_Table = (var1536 == "table");
        local var1537 = typeof(Color3_Value_4);
        local var1537_is_Table = (var1537 == "table");
        local var1538 = typeof(var1398);
        local var1538_is_Table = (var1538 == "table");
        local var1539 = rawget(var1398, "StaminaLoss");
        local var1540 = (var1539 and 11091049);
        local var1541 = typeof(var1414);
        local var1541_is_Table = (var1541 == "table");
        while 12212472 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "无限体力",
    Desc = "无限",
})
Tab_5:Divider()
Tab_5:Input({
    [Value] = "100",
    ["Callback"] = function(p1_0, p2_0)
        while 7212105 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "输入最大体力值",
    Desc = "输入",
})
Tab_5:Input({
    [Value] = "20",
    ["Callback"] = function(p1_0, p2_0, p3_0)
        while 6340115 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "输入体力恢复速度",
    Desc = "输入",
})
Tab_5:Input({
    [Value] = "20",
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0)
        while 14019936 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "输入体力消耗速度",
    Desc = "输入",
})
Tab_5:Divider()
Tab_5:Input({
    [Value] = "26",
    ["Callback"] = function(p1_0, p2_0, p3_0)
        while 3224388 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "输入奔跑速度",
    Desc = "输入",
})
Tab_7:Section({
    ["Title"] = "物品透视",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "eye",
    Desc = "透视",
})
Tab_7:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0)
        while 9842687 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "透视可乐",
    Desc = "透视",
})
Tab_7:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0)
        while 3260746 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "透视医疗包",
    Desc = "透视",
})
Tab_7:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0, p6_0)
        while 15048824 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "透视披萨",
    Desc = "透视",
})
Tab_7:Section({
    ["Title"] = "实体透视",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "eye",
    Desc = "透视",
})
Tab_7:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 13424683 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "透视发电机",
    Desc = "透视",
})
Tab_7:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 7199303 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "透视假发电机",
    Desc = "透视",
})
Tab_7:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0)
        while 13238529 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "透视幸存者",
    Desc = "透视",
})
Tab_7:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0)
        while 14199685 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "透视杀手",
    Desc = "透视",
})
Tab_7:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0)
        while 13941862 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "透视小孩分身",
    Desc = "透视",
})
Tab_7:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        while 1986608 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "透视1x1分身",
    Desc = "透视",
})
Tab_7:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 14533255 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "透视007n7分身",
    Desc = "透视",
})
Env.ESPS = Tab_9:Section({
    ["Title"] = "透视设置",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "settings",
    Desc = "设置",
})
Tab_9:Slider({
    ["Title"] = "填充透明度",
    [Value] = {
        Min = 0,
        ["Default"] = 0.5,
        Max = 1,
    },
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0, p6_0)
        while 15962952 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Step"] = 0.01,
    Desc = "透明度",
})
Tab_9:Slider({
    ["Title"] = "轮廓透明度",
    [Value] = {
        Min = 0,
        ["Default"] = 0,
        Max = 1,
    },
    ["Callback"] = function(p1_0, p2_0)
        while 1397432 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Step"] = 0.01,
    Desc = "透明度",
})
Tab_19:Section({
    ["Title"] = "自动修机",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "hand",
    Desc = "修机",
})
Tab_19:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0)
        while 7376710 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "自动修发电机",
    Desc = "自动",
})
Tab_19:Input({
    [Value] = "1",
    ["Callback"] = function(p1_0, p2_0, p3_0)
        while 5216600 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "输入修机间隔",
    Desc = "输入",
})
Tab_21:Section({
    ["Title"] = "传送修机",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "spline",
    Desc = "修机",
})
Tab_21:Paragraph({
    ["Title"] = "修机状态: 空闲",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "info",
    Desc = "状态",
})
Tab_21:Divider()
Tab_21:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        while 16763005 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "传送秒修电机",
    Desc = "自动",
})
Tab_11:Section({
    ["Title"] = "通用",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "swords",
    Desc = "任何角色",
})
Tab_11:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 328378 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "无减速",
    Desc = "防止减速",
})
Tab_11:Section({
    ["Title"] = "机会",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "swords",
    Desc = "机会技能",
})
Tab_11:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 5188257 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "自动抛硬币",
    Desc = "自动",
})
Tab_11:Section({
    ["Title"] = "访客",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "swords",
    Desc = "访客技能",
})
Tab_11:Slider({
    ["Title"] = "格挡距离",
    [Value] = {
        Min = 0,
        ["Default"] = 10,
        Max = 50,
    },
    ["Callback"] = function(p1_0, p2_0, p3_0)
        while 10534140 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Step"] = 1,
    Desc = "距离",
})
Tab_11:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 15221478 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "访客自动格挡",
    Desc = "自动",
})
Tab_11:Section({
    ["Title"] = "Noli",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "swords",
    Desc = "Noli技能",
})
Tab_11:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0)
        while 12579490 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "Noli转向优化",
    Desc = "Noli优化",
})
local var982
var982 = hookmetamethod(game, "__namecall", function(ext_1_0, ext_2_0, ext_3_0, ext_4_0, ext_5_0, ...)
    while 11140394 do end -- exited this loop due to it having 1000000 iterations.
end)
Tab_11:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0)
        while 1594143 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "Noli冲刺防停止",
    Desc = "Noli优化",
})
Tab_11:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0, p6_0)
        while 4466547 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "Noli冲刺无视墙壁",
    Desc = "Noli优化",
})
Tab_13:Section({
    ["Title"] = "反1X1技能",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "swords",
    Desc = "防止",
})
Tab_13:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0)
        while 10574449 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "防止弹窗",
    Desc = "防止",
})
spawn(function(p1_0)
    while 6274668 do end -- exited this loop due to it having 1000000 iterations.
end)
Tab_15:Section({
    ["Title"] = "优化碰撞箱",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "sword",
    Desc = "碰撞箱",
})
Tab_15:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0)
        while 5302419 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "启用碰撞增加",
    Desc = "碰撞",
})
Tab_15:Input({
    [Value] = "2",
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        while 6575545 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "增加距离",
    Desc = "距离",
})
Tab_15:Divider()
Tab_15:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 5116908 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "启用碰撞跟踪",
    Desc = "碰撞",
})
Tab_15:Input({
    [Value] = "20",
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0)
        while 16259808 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "距离",
    Desc = "距离",
})
Tab_15:Divider()
Tab_15:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0)
        while 8048340 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "无视NPC",
    Desc = "击杀",
})
Tab_15:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        while 15459534 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "无视幸存者",
    Desc = "击杀",
})
Tab_15:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        while 10621049 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "无视杀手",
    Desc = "击杀",
})
Tab_15:Section({
    ["Title"] = "修改碰撞体积",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "atom",
    Desc = "体积",
})
local Vector3_New = Vector3[New]
Vector3_New(5, 7, 5)
Vector3_New(6, 12, 6)
Tab_15:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        while 5260916 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "启用碰撞增加",
    Desc = "碰撞",
})
Tab_15:Input({
    [Value] = "1",
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0, p6_0)
        while 433262 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "输入碰撞体积",
    Desc = "输入倍数",
})
Tab_15:Toggle({
    [Value] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 14309161 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "取消碰撞体积",
    Desc = "碰撞",
})
Tab_17:Dropdown({
    ["Title"] = "选择玩家",
    [Value_2] = "请选择",
    Values = {},
    ["Callback"] = function(p1_0, p2_0)
        while 762088 do end -- exited this loop due to it having 1000000 iterations.
    end,
    Desc = "选择",
})
Tab_17:Section({
    ["Title"] = "传送选择",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "bone",
    Desc = "传送",
})
Tab_17:Button({
    ["Locked"] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 11771866 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "传送到此玩家",
    Desc = "传送",
})
Tab_17:Toggle({
    [Value_2] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 1581845 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "重复传送到此玩家",
    Desc = "传送",
})
Tab_17:Section({
    ["Title"] = "自动击杀",
    ["Opened"] = true,
    ["ImageSize"] = 30,
    ["Icon"] = "skull",
    Desc = "击杀",
})
Tab_17:Toggle({
    [Value_2] = false,
    ["Callback"] = function(p1_0, p2_0)
        while 10266954 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "自动击杀",
    Desc = "传送",
})
Tab_23:Section({
    ["Icon"] = "package-open",
    ["ImageSize"] = 30,
    ["Title"] = "传送物品",
    ["Opened"] = true,
})
Tab_23:Dropdown({
    ["Title"] = "选择你要传送的物品",
    [Value_3] = "请选择物品",
    Values = {
        "可乐",
        "医疗包",
    },
    ["Callback"] = function(p1_0, p2_0)
        while 3335555 do end -- exited this loop due to it having 1000000 iterations.
    end,
    Desc = "选择",
})
Tab_23:Button({
    ["Locked"] = false,
    ["Callback"] = function(p1_0)
        while 11040975 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "开始传送",
    Desc = "传送",
})
Tab_23:Divider()
Tab_23:Button({
    ["Locked"] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0)
        while 11806433 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "传送所有物品",
    Desc = "传送",
})
Tab_25:Section({
    ["Icon"] = "hammer",
    ["ImageSize"] = 30,
    ["Title"] = "捡拾物品",
    ["Opened"] = true,
})
Tab_25:Dropdown({
    ["Title"] = "选择你要捡起的物品",
    ["Value"] = "请选择物品",
    Values = {
        "可乐",
        "医疗包",
    },
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0, p6_0)
        while 16164328 do end -- exited this loop due to it having 1000000 iterations.
    end,
    Desc = "选择",
})
Tab_25:Button({
    ["Locked"] = false,
    ["Callback"] = function()
        while 2735646 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "开始捡拾",
    Desc = "捡起",
})
Tab_25:Divider()
Tab_25:Button({
    ["Locked"] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        while 12740258 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "捡拾所有物品",
    Desc = "传送",
})
Tab_27:Section({
    ["Icon"] = "pizza",
    ["ImageSize"] = 30,
    ["Title"] = "披萨",
    ["Opened"] = true,
})
Tab_27:Slider({
    ["Title"] = "生命阈值",
    ["Value"] = {
        Min = 0,
        ["Default"] = 75,
        Max = 100,
    },
    ["Callback"] = function(p1_0, p2_0, p3_0)
        while 14187160 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Step"] = 1,
    Desc = "最小生命",
})
Tab_27:Toggle({
    ["Value"] = false,
    ["Callback"] = function(p1_0, p2_0, p3_0, p4_0, p5_0)
        while 8043878 do end -- exited this loop due to it having 1000000 iterations.
    end,
    ["Title"] = "自动吃披萨",
    Desc = "自动",
})
Window:OnClose(function(p1_0, p2_0, p3_0)
    while 689299 do end -- exited this loop due to it having 1000000 iterations.
end)
local Connection_5
Connection_5 = Players_2.PlayerAdded:Connect(function(Player_11, p2_0, p3_0, p4_0, p5_0) -- args: Player_12
    while 3805065 do end -- exited this loop due to it having 1000000 iterations.
end)
local Connection_6
Connection_6 = Players_2.PlayerRemoving:Connect(function(Player_13, p2_0) -- args: Player_14
    while 4824839 do end -- exited this loop due to it having 1000000 iterations.
end)