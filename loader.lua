local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
 Name = "RUAJAD HUB V2.0 | Dragon Adventures",
 LoadingTitle = "Загрузка хаба...",
 LoadingSubtitle = "by custom",
 ConfigurationSaving = {
 Enabled = false,
 FolderName = "RuajadHub",
 FileName = "Config"
 },
 KeySystem = false,
})

local MainTab = Window:CreateTab("Main", 4483362458)
local FarmingTab = Window:CreateTab("Farming", 4483362458)
local TeleportTab = Window:CreateTab("Teleports", 4483362458)

MainTab:CreateSection("Фермка")

MainTab:CreateToggle({
 Name = "Auto-fly & Lock Position",
 CurrentValue = false,
 Callback = function(Value)
 -- сюда логику автофлая
 end,
})

FarmingTab:CreateSection("Ресурсы и мобы")

FarmingTab:CreateToggle({
 Name = "Auto Farm Resource Nodes",
 CurrentValue = false,
 Callback = function(Value)
 -- логика ресурсов
 end,
})

FarmingTab:CreateToggle({
 Name = "Auto Collect Eggs",
 CurrentValue = false,
 Callback = function(Value)
 -- логика яиц
 end,
})

-- Автофарм мобов
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getClosestMonster()
 local target = nil
 local shortestDist = math.huge
 
 for _, v in pairs(workspace:GetChildren()) do
 if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Name ~= "Player" then
 local dist = (LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
 if dist < shortestDist then
 shortestDist = dist
 target = v
 end
 end
 end
 
 return target
end

FarmingTab:CreateToggle({
 Name = "Auto Farm Monsters",
 CurrentValue = false,
 Callback = function(Value)
 _G.AutoMonster = Value
 task.spawn(function()
 while _G.AutoMonster do
 task.wait(0.5)
 local target = getClosestMonster()
 if target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
 local hrp = LocalPlayer.Character.HumanoidRootPart
 hrp.CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 15, 0)
 end
 end
 end)
 end,
})

TeleportTab:CreateSection("Миры")

TeleportTab:CreateButton({
 Name = "Origins",
 Callback = function()
 -- телепорт в ориджинс
 end,
})

TeleportTab:CreateButton({
 Name = "Grassland",
 Callback = function()
 -- телепорт в грассленд
 end,
})

Rayfield:LoadConfiguration()
