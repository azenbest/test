local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/NezukoX/UI-Library/master/source"))()

local player = game:GetService("Players").LocalPlayer
local exploit = identifyexecutor() or "Unknown"

local robloxId = 2932844883
local membershipType = "None"


local success, result = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/azenbest/test/refs/heads/main/main.lua"))()
end)

if not success then
    game.Players.LocalPlayer:Kick("Erreur : Impossible d'exécuter le script.")
    return
end


game:GetService("Players").LocalPlayer.Idled:Connect(function()
    local VirtualUser = game:GetService("VirtualUser")
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)


for _, portal in pairs(game:GetDescendants()) do
    if portal.Name == "RobloxForwardPortals" then
        portal:Destroy()
    end
end

game.DescendantAdded:Connect(function(descendant)
    if descendant.Name == "RobloxForwardPortals" then
        descendant:Destroy()
    end
end)


local Window = Rayfield:CreateWindow({
    Name = "BEST SCRIPT",
    LoadingTitle = "Private Script",
    LoadingSubtitle = "by Azen",
    KeySystem = false, 
})


if not Window then
    game.Players.LocalPlayer:Kick("Erreur de chargement de l'interface utilisateur")
    return
end


local Tabs = {
    Main = Window:CreateTab{ Title = "Main", Icon = "phosphor-house-bold" },
    AutoBuy = Window:CreateTab{ Title = "Auto Buy", Icon = "phosphor-shopping-cart-bold" },
    AutoStuff = Window:CreateTab{ Title = "Auto Stuff", Icon = "phosphor-robot-bold" },
    AutoFarm = Window:CreateTab{ Title = "Auto Farm", Icon = "phosphor-robot-bold" },
    Rebirth = Window:CreateTab{ Title = "Rebirth", Icon = "phosphor-arrows-clockwise-bold" },
    Killer = Window:CreateTab{ Title = "Killer", Icon = "phosphor-sword-bold" },
    Crystals = Window:CreateTab{ Title = "Crystals", Icon = "phosphor-diamond-bold" },
    Teleport = Window:CreateTab{ Title = "Teleport", Icon = "phosphor-map-pin-bold" },
    Stats = Window:CreateTab{ Title = "Stats", Icon = "phosphor-sparkle-bold" },
    Misc = Window:CreateTab{ Title = "Misc", Icon = "phosphor-map-pin-bold" },
    Settings = Window:CreateTab{ Title = "Settings", Icon = "phosphor-sliders-bold" }
}


local MainSection = Tabs.Main:CreateSection("Basic Controls")
local selectedSize = "2"

local Input = Tabs.Main:CreateInput("SizeChanger", {
    Title = "Size Changer",
    Description = "Enter Size",
    Default = "2",
    Placeholder = "Type here...",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        selectedSize = Value
        game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", tonumber(selectedSize))
    end
})
local Toggle = Tabs.Main:CreateToggle("AutoSize", {
	Title = "Auto Set Size",
	Description = "Auto Set ur Choosed Size",
	Default = false,
	Callback = function(Value)
		_G.AutoSize = Value
		while _G.AutoSize do
			game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", tonumber(selectedSize))
			task.wait(0.1)
		end
	end
})

local selectedSpeed = "125"
local Input = Tabs.Main:CreateInput("SpeedChanger", {
	Title = "Speed Changer",
	Description = "Enter Speed",
	Default = "125",
	Placeholder = "Enter Speed",
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		selectedSpeed = Value
		if _G.AutoSpeed then
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(selectedSpeed)
			end
		end
	end
})

local Toggle = Tabs.Main:CreateToggle("AutoSpeed", {
	Title = "Auto Set Speed",
	Description = "Auto Set ur Choosed Speed",
	Default = false,
	Callback = function(Value)
		_G.AutoSpeed = Value
		while _G.AutoSpeed do
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(selectedSpeed)
			end
			task.wait()
		end
	end
})

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
	if _G.AutoSpeed then
		local humanoid = char:WaitForChild("Humanoid")
		humanoid.WalkSpeed = tonumber(selectedSpeed)
	end
end)

Tabs.Main:CreateButton{
	Title = "Free AutoLift Gamepass",
	Callback = function()
		local gamepassFolder = game:GetService("ReplicatedStorage").gamepassIds
		local player = game:GetService("Players").LocalPlayer
		for _, gamepass in pairs(gamepassFolder:GetChildren()) do
			local value = Instance.new("IntValue")
			value.Name = gamepass.Name
			value.Value = gamepass.Value
			value.Parent = player.ownedGamepasses
		end
	end
}

local Toggle = Tabs.Main:CreateToggle("WalkOnWater", {
	Title = "Walk on Water",
	Description = "",
	Default = false,
	Callback = function(Value)
		if Value then
			createParts()
		else
			makePartsWalkthrough()
		end
	end
})

local function autoTool(toolName, varName)
	local Toggle = Tabs.AutoFarm:CreateToggle(toolName, {
		Title = "Auto " .. toolName,
		Description = "Auto Lift " .. toolName,
		Default = false,
		Callback = function(Value)
			_G[varName] = Value
			if Value then
				local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(toolName)
				if tool then
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
				end
			else
				local character = game.Players.LocalPlayer.Character
				local equipped = character:FindFirstChild(toolName)
				if equipped then
					equipped.Parent = game.Players.LocalPlayer.Backpack
				end
			end
			while _G[varName] do
				game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
				task.wait(0)
			end
		end
	})
end

autoTool("Weight", "AutoWeight")
autoTool("Pushups", "AutoPushups")
autoTool("Handstands", "AutoHandstands")
autoTool("Situps", "AutoSitups")

local Toggle = Tabs.AutoFarm:CreateToggle("Punch", {
	Title = "Auto Punch",
	Description = "Auto Punch",
	Default = false,
	Callback = function(Value)
		_G.fastHitActive = Value
		if Value then
			local function equipAndModifyPunch()
				while _G.fastHitActive do
					local player = game.Players.LocalPlayer
					local punch = player.Backpack:FindFirstChild("Punch")
					if punch then
						punch.Parent = player.Character
						if punch:FindFirstChild("attackTime") then
							punch.attackTime.Value = 0
						end
					end
					wait(0)
				end
			end
			local function rapidPunch()
				while _G.fastHitActive do
					local player = game.Players.LocalPlayer
					player.muscleEvent:FireServer("punch", "rightHand")
					player.muscleEvent:FireServer("punch", "leftHand")
					local character = player.Character
					if character then
						local punchTool = character:FindFirstChild("Punch")
						if punchTool then
							punchTool:Activate()
						end
					end
					wait(0)
				end
			end
			coroutine.wrap(equipAndModifyPunch)()
			coroutine.wrap(rapidPunch)()
		else
			local character = game.Players.LocalPlayer.Character
			local equipped = character:FindFirstChild("Punch")
			if equipped then
				equipped.Parent = game.Players.LocalPlayer.Backpack
			end
		end
	end
})
local Toggle = Tabs.AutoFarm:CreateToggle("ToolSpeed", {
    Title = "Fast Tools",
    Description = "Fast Tools..., What u didn't get.",
    Default = false,
    Callback = function(Value)
        _G.FastTools = Value
        local defaultSpeeds = {
            {"Punch", "attackTime", Value and 0 or 0.35},
            {"Ground Slam", "attackTime", Value and 0 or 6},
            {"Stomp", "attackTime", Value and 0 or 7},
            {"Handstands", "repTime", Value and 0 or 1},
            {"Pushups", "repTime", Value and 0 or 1},
            {"Weight", "repTime", Value and 0 or 1},
            {"Situps", "repTime", Value and 0 or 1}
        }
        local player = game.Players.LocalPlayer
        local backpack = player:WaitForChild("Backpack")
        for _, toolInfo in ipairs(defaultSpeeds) do
            local tool = backpack:FindFirstChild(toolInfo[1])
            if tool and tool:FindFirstChild(toolInfo[2]) then
                tool[toolInfo[2]].Value = toolInfo[3]
            end
            local equippedTool = player.Character and player.Character:FindFirstChild(toolInfo[1])
            if equippedTool and equippedTool:FindFirstChild(toolInfo[2]) then
                equippedTool[toolInfo[2]].Value = toolInfo[3]
            end
        end
    end
})

local RockSection = Tabs.AutoFarm:CreateSection("Rock Farm")
local selectrock = ""

local function createRockToggle(name, title, durability)
    return Tabs.AutoFarm:CreateToggle(name, {
        Title = title,
        Description = "Farm rocks at " .. title,
        Default = false,
        Callback = function(Value)
            selectrock = title
            getgenv().autoFarm = Value
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= durability then
                    for _, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == durability and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end
    })
end

createRockToggle("TinyIslandRock", "Tiny Island Rock", 0)
createRockToggle("StarterIslandRock", "Starter Island Rock", 100)
createRockToggle("LegendBeachRock", "Legend Beach Rock", 5000)
createRockToggle("FrostGymRock", "Frost Gym Rock", 150000)
createRockToggle("MythicalGymRock", "Mythical Gym Rock", 400000)
createRockToggle("EternalGymRock", "Eternal Gym Rock", 750000)
createRockToggle("LegendGymRock", "Legend Gym Rock", 1000000)

function gettool()
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end
local Toggle = Tabs.AutoFarm:CreateToggle("MuscleKingGymRock", {
    Title = "Farm Muscle King Gym Rock",
    Description = "Farm rocks at Muscle King Gym",
    Default = false,
    Callback = function(Value)
        selectrock = "Muscle King Gym Rock"
        getgenv().autoFarm = Value
        while getgenv().autoFarm do
            task.wait()
            if game:GetService("Players").LocalPlayer.Durability.Value >= 5000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 5000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                        firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                        gettool()
                    end
                end
            end
        end
    end
})

local Toggle = Tabs.Killer:CreateToggle("Kill v2 Player", {
    Title = "Start Killing",
    Default = false,
    Callback = function(v)
        getgenv().killallv2 = v
        task.spawn(function()
            while getgenv().killallv2 do
                for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") then
                                firetouchinterest(player.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.LeftHand, 0)
                                firetouchinterest(player.Character.HumanoidRootPart, game.Players.LocalPlayer.Character.LeftHand, 1)
                                gettool()
                            end
                        end
                    end
                end
                task.wait()
            end
        end)
    end
})
