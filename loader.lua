local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
 Name = "Shurumursky Hub | Dragon Adventures",
 LoadingTitle = "Загрузка хаба...",
 LoadingSubtitle = "by Shurumursky",
 ConfigurationSaving = {
 Enabled = false,
 FolderName = "ShurumurskyHub",
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
 _G.AutoFly = Value
 local LocalPlayer = game:GetService("Players").LocalPlayer
 task.spawn(function()
 while _G.AutoFly do
 task.wait()
 if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
 local hrp = LocalPlayer.Character.HumanoidRootPart
 hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
 if LocalPlayer.Character:FindFirstChild("Humanoid") then
 LocalPlayer.Character.Humanoid.PlatformStand = true
 end
 end
 end
 if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
 LocalPlayer.Character.Humanoid.PlatformStand = false
 end
 end)
 end,
})

FarmingTab:CreateSection("Ресурсы и мобы")

FarmingTab:CreateToggle({
 Name = "Auto Farm Resource Nodes",
 CurrentValue = false,
 Callback = function(Value)
 _G.AutoResources = Value
 task.spawn(function()
 while _G.AutoResources do
 for _, obj in pairs(workspace:GetDescendants()) do
 if not _G.AutoResources then break end
 if obj:IsA("Model") and (obj:FindFirstChild("Health") or obj.Name:lower():find("rock") or obj.Name:lower():find("tree") or obj.Name:lower():find("plant")) then
 local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
 local lp = game:GetService("Players").LocalPlayer
 if part and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
 lp.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 3, 0)
 task.wait(2)
 end
 end
 end
 task.wait(1)
 end
 end)
 end,
})

FarmingTab:CreateToggle({
 Name = "Auto Collect Eggs",
 CurrentValue = false,
 Callback = function(Value)
 _G.AutoEggs = Value
 task.spawn(function()
 while _G.AutoEggs do
 for _, egg in pairs(workspace:GetDescendants()) do
 if not _G.AutoEggs then break end
 if egg:IsA("Model") and egg.Name:lower():find("egg") then
 local part = egg.PrimaryPart or egg:FindFirstChildWhichIsA("BasePart")
 local lp = game:GetService("Players").LocalPlayer
 if part and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
 lp.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 2, 0)
 task.wait(2)
 end
 end
 end
 task.wait(1)
 end
 end)
 end,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getClosestMonster()
 local target = nil
 local shortestDist = math.huge
 
 for _, v in pairs(workspace:GetDescendants()) do
 if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
 local isPlayer = false
 for _, player in pairs(Players:GetPlayers()) do
 if player.Character == v then
 isPlayer = true
 break
 end
 end
 
 if not isPlayer and v ~= LocalPlayer.Character then
 local dist = (LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
 if dist < shortestDist then
 shortestDist = dist
 target = v
 end
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
 task.wait(1)
 local target = getClosestMonster()
 if target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
 local hrp = LocalPlayer.Character.HumanoidRootPart
 hrp.CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
 end
 end
 end)
 end,
})

TeleportTab:CreateSection("Миры")

TeleportTab:CreateButton({
 Name = "Origins",
 Callback = function()
 local lp = game:GetService("Players").LocalPlayer
 if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
 lp.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
 end
 end,
})

TeleportTab:CreateButton({
 Name = "Grassland",
 Callback = function()
 local lp = game:GetService("Players").LocalPlayer
 if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
 lp.Character.HumanoidRootPart.CFrame = CFrame.new(1000, 100, 1000)
 end
 end,
})

Rayfield:LoadConfiguration()
