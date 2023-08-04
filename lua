local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/cnzins1/Fluent.gg/main/FluentThemes'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

		getgenv()._Cameras = {
			Toggle = false,
			Pos = nil,
			X_Offset = 0,
			Y_Offset = 0
		}
		
		getgenv().SilentSettings = {
			AimType = "To Cursor",
			AimPart = "Head",
			AimDis = 200,
            hitChance = 100,
			AimSleepers = false,
			TeamCheck = true,
			VisibleCheck = true,
			Prediction = true,
			Snaplines = true,
			SnaplinesColor = Color3.fromRGB(206,250,5)
		}

local _Camera = getrenv()._G.modules.Camera
local _Character = getrenv()._G.modules.Character
local _Network = getrenv()._G.modules.Network
local _SendCodes = getrenv()._G.modules.Network.SendCodes
local Camera = game:GetService("Workspace").Camera
local CameraPred = game:GetService("Workspace").CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local CharcaterMiddle = game:GetService("Workspace").Ignore.LocalCharacter.Middle

local Esp = {Settings={
    Boxes=true,BoxesOutline=true,BoxesColor=Color3.fromRGB(255,255,255),BoxesOutlineColor=Color3.fromRGB(0,0,0),
    Sleeping=false,SleepingColor=Color3.fromRGB(255,255,255),
    Distances=false,DistanceColor=Color3.fromRGB(255,255,255),
    Armour=false,ArmourColor=Color3.fromRGB(255,255,255),
    Tool=false,ToolColor=Color3.fromRGB(255,255,255),
    Tracer=false,TracerColor=Color3.fromRGB(255,255,255),TracerThickness=1,TracerTransparrency=1,TracerFrom="Bottom",
    ViewAngle=false,ViewAngleColor=Color3.fromRGB(255,255,255),ViewAngleThickness=1,ViewAngleTransparrency=1,
    HighlightVisible=true,
    Rainbow=false,
    TextFont=2,TextOutline=true,TextSize=15,RenderDistance=1500,TeamCheck=false,TargetSleepers=false,MinTextSize=8
},Drawings={},Connections={},Players={},Ores={},StorageThings={}}
local Fonts = {["UI"]=0,["System"]=1,["Plex"]=2,["Monospace"]=3}

local Fov = {Settings={
    FovEnabled=false,FovColor=Color3.fromRGB(255,255,255),FovSize=90,FovTransparency=1,Dynamic=true,RealFovSize=90,FovPosition="Mouse",
}}

local Functions = {}
local NoSway = false
local triggerBot = false
local Arrow = game.ReplicatedStorage:WaitForChild("Arrow")
local Bullet = game.ReplicatedStorage:WaitForChild("Bullet")

local gun = workspace.Ignore.FPSArms:FindFirstChild("HandModel")
local arms = workspace.Ignore:FindFirstChild("FPSArms")
local terrain = workspace.Terrain

local dropslist = {
    ["0"] = {
        ["Bow"] = 5,
        ["M4A1"] = 1,
        ["SCAR"] = 1,
        ["PipeSMG"] = 1,
    },
    ["10"] = {
        ["Bow"] = 5,
        ["M4A1"] = 1,
        ["SCAR"] = 1,
        ["PipeSMG"] = 1,
    },
    ["20"] = {
        ["Bow"] = 0,
        ["M4A1"] = 1,
        ["SCAR"] = 1,
        ["PipeSMG"] = 1,
    },
    ["30"] = {
        ["Bow"] = 1,
        ["M4A1"] = 1,
        ["SCAR"] = 1,
        ["PipeSMG"] = 1,
    },
    ["40"] = {
        ["Bow"] = 5,
        ["M4A1"] = 1,
        ["SCAR"] = 1,
        ["PipeSMG"] = 1,
    },
    ["50"] = {
        ["Bow"] = 4,
        ["M4A1"] = 1,
        ["SCAR"] = 1,
        ["PipeSMG"] = 1,
    },
    ["60"] = {
        ["Bow"] = 7,
        ["M4A1"] = 1,
        ["SCAR"] = 1,
        ["PipeSMG"] = 1,
    },
    ["70"] = {
        ["Bow"] = 7,
        ["M4A1"] = 1,
        ["SCAR"] = 1,
        ["PipeSMG"] = 2,
    },
    ["80"] = {
        ["Bow"] = 7,
        ["M4A1"] = 1,
        ["SCAR"] = 1,
        ["PipeSMG"] = 2,
    },
    ["90"] = {
        ["Bow"] = 7,
        ["M4A1"] = 1,
        ["SCAR"] = 1,
        ["PipeSMG"] = 2,
    },
    ["100"] = {
        ["Bow"] = 9,
        ["M4A1"] = 10,
        ["SCAR"] = 1,
        ["PipeSMG"] = 3,
        ["USP9"] = 2,
    },
    ["110"] = {
        ["Bow"] = 9,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 3,
    },
    ["120"] = {
        ["Bow"] = 10,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 3,
    },
    ["130"] = {
        ["Bow"] = 11,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 3,
    },
    ["140"] = {
        ["Bow"] = 13,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 3,
    },
    ["150"] = {
        ["Bow"] = 14,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 4,
        ["USP9"] = 4,
    },
    ["160"] = {
        ["Bow"] = 16,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 4,
    },
    ["170"] = {
        ["Bow"] = 17,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 4,
    },
    ["180"] = {
        ["Bow"] = 19,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 5,
    },
    ["190"] = {
        ["Bow"] = 22,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 5,
    },
    ["200"] = {
        ["Bow"] = 24,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 5,
    },
    ["210"] = {
        ["Bow"] = 27,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 5,
    },
    ["220"] = {
        ["Bow"] = 29,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 6,
    },
    ["230"] = {
        ["Bow"] = 33,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 6,
    },
    ["240"] = {
        ["Bow"] = 38,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 6,
    },
    ["250"] = {
        ["Bow"] = 38,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 6,
    },
    ["260"] = {
        ["Bow"] = 38,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 7,
    },
    ["270"] = {
        ["Bow"] = 38,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 7,
    },
    ["280"] = {
        ["Bow"] = 38,
        ["M4A1"] = 10,
        ["SCAR"] = 9,
        ["PipeSMG"] = 7,
    },
    ["290"] = {
        ["Bow"] = 38,
        ["M4A1"] = 10,
        ["SCAR"] = 10,
        ["PipeSMG"] = 8,
    },
    ["300"] = {
        ["Bow"] = 38,
        ["M4A1"] = 10,
        ["SCAR"] = 10,
        ["PipeSMG"] = 8,
    },
    ["310"] = {
        ["Bow"] = 38,
        ["M4A1"] = 11,
        ["SCAR"] = 10,
        ["PipeSMG"] = 8,
    },
    ["320"] = {
        ["Bow"] = 38,
        ["M4A1"] = 11,
        ["SCAR"] = 10,
        ["PipeSMG"] = 9,
    },
    ["330"] = {
        ["Bow"] = 38,
        ["M4A1"] = 11,
        ["SCAR"] = 11,
        ["PipeSMG"] = 9,
    },
    ["340"] = {
        ["Bow"] = 38,
        ["M4A1"] = 11,
        ["SCAR"] = 11,
        ["PipeSMG"] = 9,
    },
    ["350"] = {
        ["Bow"] = 38,
        ["M4A1"] = 12,
        ["SCAR"] = 12,
        ["PipeSMG"] = 10,
    },
    ["360"] = {
        ["Bow"] = 38,
        ["M4A1"] = 12,
        ["SCAR"] = 12,
        ["PipeSMG"] = 10,
    },
    ["370"] = {
        ["Bow"] = 38,
        ["M4A1"] = 12,
        ["SCAR"] = 12,
        ["PipeSMG"] = 11,
    },
    ["380"] = {
        ["Bow"] = 38,
        ["M4A1"] = 13,
        ["SCAR"] = 13,
        ["PipeSMG"] = 11,
    },
    ["390"] = {
        ["Bow"] = 38,
        ["M4A1"] = 13,
        ["SCAR"] = 12,
        ["PipeSMG"] = 11,
    },
    ["400"] = {
        ["Bow"] = 38,
        ["M4A1"] = 13,
        ["SCAR"] = 12,
        ["PipeSMG"] = 12,
    },
    ["410"] = {
        ["Bow"] = 38,
        ["M4A1"] = 13,
        ["SCAR"] = 12,
        ["PipeSMG"] = 12,
    },
    ["420"] = {
        ["Bow"] = 38,
        ["M4A1"] = 15,
        ["SCAR"] = 12,
        ["PipeSMG"] = 13,
    },
    ["430"] = {
        ["Bow"] = 38,
        ["M4A1"] = 16,
        ["SCAR"] = 12,
        ["PipeSMG"] = 13,
    },
    ["440"] = {
        ["Bow"] = 38,
        ["M4A1"] = 16,
        ["SCAR"] = 12,
        ["PipeSMG"] = 14,
    },
    ["450"] = {
        ["Bow"] = 38,
        ["M4A1"] = 16,
        ["SCAR"] = 12,
        ["PipeSMG"] = 14,
    },
    ["460"] = {
        ["Bow"] = 38,
        ["M4A1"] = 17,
        ["SCAR"] = 12,
        ["PipeSMG"] = 15,
    },
    ["470"] = {
        ["Bow"] = 38,
        ["M4A1"] = 18,
        ["SCAR"] = 12,
        ["PipeSMG"] = 16,
    },
    ["480"] = {
        ["Bow"] = 38,
        ["M4A1"] = 19,
        ["SCAR"] = 12,
        ["PipeSMG"] = 16,
    },
    ["490"] = {
        ["Bow"] = 38,
        ["M4A1"] = 19,
        ["SCAR"] = 12,
        ["PipeSMG"] = 17,
    },
    ["500"] = {
        ["Bow"] = 38,
        ["M4A1"] = 20,
        ["SCAR"] = 18,
        ["PipeSMG"] = 17,
    },
    ["510"] = {
        ["Bow"] = 38,
        ["M4A1"] = 20,
        ["SCAR"] = 18,
        ["PipeSMG"] = 18,
    },
    ["520"] = {
        ["Bow"] = 38,
        ["M4A1"] = 21,
        ["SCAR"] = 21,
        ["PipeSMG"] = 19,
    },
    ["530"] = {
        ["Bow"] = 38,
        ["M4A1"] = 21,
        ["SCAR"] = 21.5,
        ["PipeSMG"] = 20,
    },
    ["540"] = {
        ["Bow"] = 38,
        ["M4A1"] = 21,
        ["SCAR"] = 22,
        ["PipeSMG"] = 21,
    },
    ["550"] = {
        ["Bow"] = 38,
        ["M4A1"] = 22,
        ["SCAR"] = 22,
        ["PipeSMG"] = 22,
    },
    ["560"] = {
        ["Bow"] = 38,
        ["M4A1"] = 23,
        ["SCAR"] = 23,
        ["PipeSMG"] = 23,
    },
    ["570"] = {
        ["Bow"] = 38,
        ["M4A1"] = 23,
        ["SCAR"] = 23,
        ["PipeSMG"] = 24,
    },
    ["580"] = {
        ["Bow"] = 38,
        ["M4A1"] = 24,
        ["SCAR"] = 24,
        ["PipeSMG"] = 25,
    },
    ["590"] = {
        ["Bow"] = 38,
        ["M4A1"] = 25,
        ["SCAR"] = 24,
    },
    ["600"] = {
        ["Bow"] = 38,
        ["M4A1"] = 26,
        ["SCAR"] = 26,
    },
    ["610"] = {
        ["Bow"] = 38,
        ["M4A1"] = 27,
        ["SCAR"] = 27,
    },
    ["620"] = {
        ["Bow"] = 38,
        ["M4A1"] = 27,
        ["SCAR"] = 27,
    },
    ["630"] = {
        ["Bow"] = 38,
        ["M4A1"] = 28,
        ["SCAR"] = 28,
    },
    ["640"] = {
        ["Bow"] = 38,
        ["M4A1"] = 28,
        ["SCAR"] = 28,
    },
    ["650"] = {
        ["Bow"] = 38,
        ["M4A1"] = 29,
        ["SCAR"] = 29,
    },
    ["660"] = {
        ["Bow"] = 38,
        ["M4A1"] = 30,
        ["SCAR"] = 30,
    },
    ["670"] = {
        ["Bow"] = 38,
        ["M4A1"] = 31,
        ["SCAR"] = 31,
    },
    ["680"] = {
        ["Bow"] = 38,
        ["M4A1"] = 32,
        ["SCAR"] = 32,
    },
    ["690"] = {
        ["Bow"] = 38,
        ["M4A1"] = 33,
        ["SCAR"] = 33,
    },
    ["700"] = {
        ["Bow"] = 38,
        ["M4A1"] = 34,
        ["SCAR"] = 34,
    },
    ["710"] = {
        ["Bow"] = 38,
        ["M4A1"] = 35,
        ["SCAR"] = 35,
    },
    ["720"] = {
        ["Bow"] = 38,
        ["M4A1"] = 36,
        ["SCAR"] = 36,
    },
    ["730"] = {
        ["Bow"] = 38,
        ["M4A1"] = 38,
        ["SCAR"] = 38,
    },
    ["740"] = {
        ["Bow"] = 38,
        ["M4A1"] = 39,
        ["SCAR"] = 39,
    },
    ["750"] = {
        ["Bow"] = 38,
        ["M4A1"] = 40,
        ["SCAR"] = 40,
    },
    ["760"] = {
        ["Bow"] = 38,
        ["M4A1"] = 41,
        ["SCAR"] = 41,
    },
    ["770"] = {
        ["Bow"] = 38,
        ["M4A1"] = 43,
        ["SCAR"] = 43,
    },
    ["780"] = {
        ["Bow"] = 38,
        ["M4A1"] = 45,
        ["SCAR"] = 45,
    },
    ["790"] = {
        ["Bow"] = 38,
        ["M4A1"] = 46,
        ["SCAR"] = 46,
    },
    ["800"] = {
        ["Bow"] = 38,
        ["M4A1"] = 47,
        ["SCAR"] = 47,
    }
}
--Func
function Functions:DropDist(distance)
    if distance <= 10 then
        return "10"
    elseif distance <= 20 then
        return "20"
    elseif distance <= 30 then
        return "30"
    elseif distance <= 40 then
        return "40"
    elseif distance <= 50 then
        return "50"
    elseif distance <= 60 then
        return "60"
    elseif distance <= 70 then
        return "70"
    elseif distance <= 80 then
        return "80"
    elseif distance <= 90 then
        return "90"
    elseif distance <= 100 then
        return "100"
    elseif distance <= 110 then
        return "110"
    elseif distance <= 120 then
        return "120"
    elseif distance <= 130 then
        return "130"
    elseif distance <= 140 then
        return "140"
    elseif distance <= 150 then
        return "150"
    elseif distance <= 160 then
        return "160"
    elseif distance <= 170 then
        return "170"
    elseif distance <= 180 then
        return "180"
    elseif distance <= 190 then
        return "190"
    elseif distance <= 200 then
        return "200"
    elseif distance <= 210 then
        return "210"
    elseif distance <= 220 then
        return "220"
    elseif distance <= 230 then
        return "230"
    elseif distance <= 240 then
        return "240"
    elseif distance <= 250 then
        return "250"
    elseif distance <= 260 then
        return "260"
    elseif distance <= 270 then
        return "270"
    elseif distance <= 280 then
        return "280"
    elseif distance <= 290 then
        return "290"
    elseif distance <= 300 then
        return "300"
    elseif distance <= 310 then
        return "310"
    elseif distance <= 320 then
        return "320"
    elseif distance <= 330 then
        return "330"
    elseif distance <= 340 then
        return "340"
    elseif distance <= 350 then
        return "350"
    elseif distance <= 360 then
        return "360"
    elseif distance <= 370 then
        return "370"
    elseif distance <= 380 then
        return "380"
    elseif distance <= 390 then
        return "390"
    elseif distance <= 400 then
        return "400"
    elseif distance <= 410 then
        return "410"
    elseif distance <= 420 then
        return "420"
    elseif distance <= 430 then
        return "430"
    elseif distance <= 440 then
        return "440"
    elseif distance <= 450 then
        return "450"
    elseif distance <= 460 then
        return "460"
    elseif distance <= 470 then
        return "470"
    elseif distance <= 480 then
        return "480"
    elseif distance <= 490 then
        return "490"
    elseif distance <= 500 then
        return "500"
    elseif distance <= 510 then
        return "510"
    elseif distance <= 520 then
        return "520"
    elseif distance <= 530 then
        return "530"
    elseif distance <= 540 then
        return "540"
    elseif distance <= 550 then
        return "550"
    elseif distance <= 560 then
        return "560"
    elseif distance <= 570 then
        return "570"
    elseif distance <= 580 then
        return "580"
    elseif distance <= 590 then
        return "590"
    elseif distance <= 600 then
        return "600"
    elseif distance <= 610 then
        return "610"
    elseif distance <= 620 then
        return "620"
    elseif distance <= 630 then
        return "630"
    elseif distance <= 640 then
        return "640"
    elseif distance <= 650 then
        return "650"
    elseif distance <= 660 then
        return "660"
    elseif distance <= 670 then
        return "670"
    elseif distance <= 680 then
        return "680"
    elseif distance <= 690 then
        return "690"
    elseif distance <= 700 then
        return "700"
    elseif distance <= 710 then
        return "710"
    elseif distance <= 720 then
        return "720"
    elseif distance <= 730 then
        return "730"
    elseif distance <= 740 then
        return "740"
    elseif distance <= 750 then
        return "750"
    elseif distance <= 760 then
        return "760"
    elseif distance <= 770 then
        return "770"
    elseif distance <= 780 then
        return "780"
    elseif distance <= 790 then
        return "790"
    elseif distance <= 800 then
        return "800"
    else 
        return "800"
    end
end

local function inlos(p, ...)
  return #workspace.CurrentCamera:GetPartsObscuringTarget({p}, {workspace.CurrentCamera, workspace.Ignore.LocalCharacter.Middle, arms, gun, ...}) == 0
end

-- Sleeper Check
		local function IsSleeping(head)
			return (head.Rotation == Vector3.new(0, 0, -75) or head.Rotation == Vector3.new(0, 0, 45)) -- Jank
		end
		
-- Visible Check
		function isPartVisible(part)
			local ignore = workspace.Ignore:GetDescendants();
			local castPoints = { part.Position }
			return Camera:GetPartsObscuringTarget(castPoints, ignore)
		end

-- Closest to cursor
function getClosestPlayerToCursor()
			local closestPlayer = nil;
			local shortestDistance = SilentSettings["AimDis"]
			for i, v in pairs(workspace:GetChildren()) do
				if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= "Player" then
					if v.PrimaryPart ~= nil and v:FindFirstChild("Head") then
						if (not isPartVisible(v.PrimaryPart) and not SilentSettings["VisibleCheck"]) or (IsSleeping(v.Head) and not SilentSettings["AimSleepers"]) then
							return nil
						end
						local pos = Camera.WorldToViewportPoint(Camera, v.PrimaryPart.Position)
						local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
						local MouseMagnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
						if MouseMagnitude < Fov.Settings.RealFovSize then
							closestPlayer = v
							shortestDistance = magnitude
						end
					end
				end
			end
			return closestPlayer
		end

-- Closest to player
function getClosestPlayerToPlayer()
			local closestPlayer = nil
			local shortestDistance = SilentSettings["AimDis"]
			for i, v in pairs(workspace:GetChildren()) do
				if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= "Player" then
					if v.PrimaryPart ~= nil and v:FindFirstChild("Head") then
						if (not isPartVisible(v.PrimaryPart) and not SilentSettings["VisibleCheck"]) or (IsSleeping(v.Head) and not SilentSettings["AimSleepers"]) then
							return nil
						end
						local magnitude = (_Character.character.Middle.Position - v.PrimaryPart.Position).magnitude
						local MouseMagnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
						if magnitude < shortestDistance then
							closestPlayer = v
							shortestDistance = magnitude
						end
					end
				end
			end
			return closestPlayer
		end

-- Closest (prediction)
function Functions:GetClosest()
    local closest,PlayerDistance,playerTable = nil,SilentSettings["AimDis"],nil
    for i,v in pairs(getupvalues(getrenv()._G.modules.Player.GetPlayerModel)[1]) do
        if v.model:FindFirstChild("HumanoidRootPart") then
            local MousePred = game.Players.LocalPlayer:GetMouse()
            local pos,OnScreen = Camera.WorldToViewportPoint(CameraPred, v.model:GetPivot().Position)
            local MouseMagnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(MousePred.X, MousePred.Y)).Magnitude
            local PlayerDistance = (CharcaterMiddle:GetPivot().Position-v.model:GetPivot().Position).Magnitude
            local PlayerID = v.id
            if PlayerDistance <= SilentSettings["AimDis"] and OnScreen == true then
                closest = v.model;PlayerDistance = PlayerDistance;playerTable=v;playerId = PlayerID
            end
        end
    end
    return closest,playerTable,playerId
end


-- Weapon info
function Functions:GetProjectileInfo()
    if getrenv()._G.modules.FPS.GetEquippedItem() == nil then return 0,0 end
    local mod = require(game:GetService("ReplicatedStorage").ItemConfigs[getrenv()._G.modules.FPS.GetEquippedItem().id])
    for i,v in pairs(mod) do
        if i == "ProjectileSpeed" or i == "ProjectileDrop" then
            return mod.ProjectileSpeed,mod.ProjectileDrop
        end
    end
    return 0,0
end

-- Prediction
function Functions:Predict()
    local Prediction = Vector3.new(0,0,0)
    local Drop = 0
    if Functions:GetClosest() ~= nil then
        local ps,pd = Functions:GetProjectileInfo()
        Player,PlayerTable = Functions:GetClosest()
		local Velocity = PlayerTable.velocityVector
        local Distance = (CharcaterMiddle.Position - Player[SilentSettings["AimPart"]].Position).Magnitude
        local DropDistance = (CharcaterMiddle.Position - Player["Torso"].Position).Magnitude
        if ps == 0 then
            ps = 500
        end
        if pd == 0 then
            pd = 1
        end
        local TimeOfFlight = Distance / ps
        local DropTimeOfFlight = DropDistance / ps
        newps = ps - 13 * ps ^ 2 * TimeOfFlight ^ 2
        TimeOfFlight += (Distance / newps)

        if getrenv()._G.modules.FPS.GetEquippedItem() then
            local ids = tostring(getrenv()._G.modules.FPS.GetEquippedItem().id)
            local distances = Functions:DropDist(DropDistance)

            local find = false

            if ids then
                for v,i in pairs(dropslist[distances]) do
                    if v == ids then
                        find = true
                    end
                end
                if find then
                    Drop = (DropTimeOfFlight*dropslist[distances][ids])
                end
            end
        end
        if Velocity and TimeOfFlight then
            Prediction = (Velocity * (TimeOfFlight*10)) * .5
        end
    end
    return Prediction + Vector3.new(0,Drop,0)
end

-- Drawing esp
function Functions:Draw(Type,Propities)
    if not Type and not Propities then return end
    local drawing = Drawing.new(Type)
    for i,v in pairs(Propities) do
        drawing[i] = v
    end
    table.insert(Esp.Drawings,drawing)
    return drawing
end

-- Tool names
function Functions:GetToolNames()
    tbl = {}
    for i,v in pairs(game:GetService("ReplicatedStorage").HandModels:GetChildren()) do
        if not table.find(tbl,v.Name) then table.insert(tbl,v.Name) end
    end
    return tbl
end

-- Check tools
function Esp:CheckTools(PlayerTable)
    if not PlayerTable then return end
    if PlayerTable.equippedItem and table.find(Functions:GetToolNames(),PlayerTable["equippedItem"].id) then
        return tostring(PlayerTable["equippedItem"].id)
    elseif PlayerTable.handModel and PlayerTable.handModel.Name and string.find(PlayerTable.handModel.Name,"Hammer") then
        return PlayerTable["handModel"].Name
    else
        return "Empty"
    end
end

-- Create esp
function Esp:CreateEsp(PlayerTable)
    if not PlayerTable then return end
    local drawings = {}
    drawings.BoxOutline = Functions:Draw("Square",{Thickness=2,Filled=false,Transparency=1,Color=Esp.Settings.BoxesOutlineColor,Visible=false,ZIndex = -1,Visible=false});
    drawings.Box = Functions:Draw("Square",{Thickness=1,Filled=false,Transparency=1,Color=Esp.Settings.BoxesColor,Visible=false,ZIndex = 2,Visible=false});
    drawings.Sleeping = Functions:Draw("Text",{Text = "Nil",Font=Esp.Settings.TextFont,Size=Esp.Settings.TextSize,Center=true,Outline=Esp.Settings.TextOutline,Color = Esp.Settings.SleepingColor,ZIndex = 2,Visible=false})
    drawings.Armour = Functions:Draw("Text",{Text = "Naked",Font=Esp.Settings.TextFont,Size=Esp.Settings.TextSize,Center=false,Outline=Esp.Settings.TextOutline,Color = Esp.Settings.ArmourColor,ZIndex = 2,Visible=false})
    drawings.Tool = Functions:Draw("Text",{Text = "Nothing",Font=Esp.Settings.TextFont,Size=Esp.Settings.TextSize,Center=false,Outline=Esp.Settings.TextOutline,Color = Esp.Settings.ToolColor,ZIndex = 2,Visible=false})
    drawings.ViewAngle = Functions:Draw("Line",{Thickness=Esp.Settings.ViewAngleThickness,Transparency=Esp.Settings.ViewAngleTransparrency,Color=Esp.Settings.ViewAngleColor,ZIndex=2,Visible=false})
    drawings.Tracer = Functions:Draw("Line",{Thickness=Esp.Settings.TracerThickness,Transparency=1,Color=Esp.Settings.TracerColor,ZIndex=2,Visible=false})
    drawings.PlayerTable = PlayerTable
    Esp.Players[PlayerTable.model] = drawings
end

-- Remove esp
function Esp:RemoveEsp(PlayerTable)
    if not PlayerTable and PlayerTable.model ~= nil then return end
    esp = Esp.Players[PlayerTable.model];
    if not esp then return end
    for i, v in pairs(esp) do
        if not type(v) == "table" then
            v:Remove();
        end
    end
    Esp.Players[PlayerTable.model] = nil;
end

-- Update esp
function Esp:UpdateEsp()
	if Esp.Settings.Rainbow == true then
		for i,v in pairs(Esp.Players) do
        local Character = i
        local Position,OnScreen = Camera:WorldToViewportPoint(Character:GetPivot().Position);
        local scale = 1 / (Position.Z * math.tan(math.rad(Camera.FieldOfView * 0.5)) * 2) * 100;
        local w,h = math.floor(40 / 2), math.floor(55 / 2);
        local x,y = math.floor(Position.X), math.floor(Position.Y);
        local Distance = (CharcaterMiddle:GetPivot().Position-Character:GetPivot().Position).Magnitude
        local BoxPosX,BoxPosY = math.floor(x - w * 0.5),math.floor(y - h * 0.5)
        local offsetCFrame = CFrame.new(0, 0, -4)
        if Character and Character:FindFirstChild("HumanoidRootPart") and Character:FindFirstChild("Head") then
            local TeamTag = Character.Head.Teamtag.Enabled
            if OnScreen == true and Esp.Settings.Boxes == true and Distance <= Esp.Settings.RenderDistance then
                if Esp.Settings.TeamCheck == true and TeamTag == false then 
                    v.BoxOutline.Visible = Esp.Settings.BoxesOutline;v.Box.Visible = true
                elseif Esp.Settings.TeamCheck == true and TeamTag == true then
                    v.BoxOutline.Visible = false;v.Box.Visible = false
                else
                    v.BoxOutline.Visible = Esp.Settings.BoxesOutline;v.Box.Visible = true
                end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then
                    v.BoxOutline.Visible = false;v.Box.Visible = false
                end
                v.BoxOutline.Position = Vector2.new(BoxPosX,BoxPosY);v.BoxOutline.Size = Vector2.new(w,h)
                v.Box.Position = Vector2.new(BoxPosX,BoxPosY);v.Box.Size = Vector2.new(w,h)
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Box.Color = Color3.fromRGB(0,255,0);v.BoxOutline.Color = Esp.Settings.BoxesOutlineColor
                else
                v.Box.Color = Color3.fromHSV(tick() * 128 % 255/255, 1, 1);v.BoxOutline.Color = Esp.Settings.BoxesOutlineColor
                end
            else
                v.BoxOutline.Visible = false;v.Box.Visible = false
            end
            if OnScreen == true and Esp.Settings.Sleeping == true and Distance <= Esp.Settings.RenderDistance then
                if v.PlayerTable.sleeping == true then v.Sleeping.Text = "Sleeping" else v.Sleeping.Text = "Awake" end
                if Esp.Settings.TeamCheck == true and TeamTag == false then  v.Sleeping.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.Sleeping.Visible = false else v.Sleeping.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.Sleeping.Visible = false end
                v.Sleeping.Outline=Esp.Settings.TextOutline;v.Sleeping.Size=math.max(math.min(math.abs(Esp.Settings.TextSize),Esp.Settings.TextSize),Esp.Settings.MinTextSize);v.Sleeping.Color = Esp.Settings.SleepingColor;v.Sleeping.Font=Esp.Settings.TextFont;v.Sleeping.Position = Vector2.new(x,math.floor(y-h*0.5-v.Sleeping.TextBounds.Y))
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Sleeping.Color = Color3.fromRGB(0,255,0)
                else
                v.Sleeping.Color = Color3.fromHSV(tick() * 128 % 255/255, 1, 1)
                end
            else
                v.Sleeping.Visible=false
            end
            if OnScreen == true and Esp.Settings.Distances == true and Distance <= Esp.Settings.RenderDistance then
                if Esp.Settings.TeamCheck == true and TeamTag == false then  v.Sleeping.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.Sleeping.Visible = false else v.Sleeping.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.Sleeping.Visible = false end

                if Esp.Settings.Sleeping == false then
                    v.Sleeping.Text = math.floor(Distance).."m"
                else
                    v.Sleeping.Text = v.Sleeping.Text.." | "..math.floor(Distance).."m"
                end
                v.Sleeping.Outline=Esp.Settings.TextOutline;v.Sleeping.Size=math.max(math.min(math.abs(Esp.Settings.TextSize),Esp.Settings.TextSize),Esp.Settings.MinTextSize);v.Sleeping.Font=Esp.Settings.TextFont;v.Sleeping.Position = Vector2.new(x,math.floor(y-h*0.5-v.Sleeping.TextBounds.Y))
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Sleeping.Color = Color3.fromRGB(0,255,0)
                else
                v.Sleeping.Color = Color3.fromHSV(tick() * 128 % 255/255, 1, 1)
                end
            else
                v.Sleeping.Visible = false
            end
            if OnScreen == true and Esp.Settings.Tool == true and Distance <= Esp.Settings.RenderDistance then
                if Esp.Settings.TeamCheck == true and TeamTag == false then v.Tool.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.Tool.Visible = false else v.Tool.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.Tool.Visible = false end
                v.Tool.Position = Vector2.new(math.floor((BoxPosX+w)+v.Tool.TextBounds.X/10),BoxPosY+v.Tool.TextBounds.Y*1.55*0.5-((v.Tool.TextBounds.Y*2)*0.5)+v.Tool.TextBounds.Y)
                v.Tool.Text=Esp:CheckTools(v.PlayerTable);v.Tool.Outline=Esp.Settings.TextOutline;v.Tool.Size=math.max(math.min(math.abs(Esp.Settings.TextSize),Esp.Settings.TextSize),Esp.Settings.MinTextSize);v.Tool.Font=Esp.Settings.TextFont
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Tool.Color = Color3.fromRGB(0,255,0)
                else
                v.Tool.Color = Color3.fromHSV(tick() * 128 % 255/255, 1, 1)
                end
            else
                v.Tool.Visible = false
            end
            if OnScreen == true and Esp.Settings.Armour == true and Distance <= Esp.Settings.RenderDistance then
                if Character.Armor:FindFirstChildOfClass("Folder") then v.Armour.Text = "Armoured" else v.Armour.Text = "Naked" end
                if Esp.Settings.TeamCheck == true and TeamTag == false then v.Armour.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.Armour.Visible = false else v.Armour.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.Armour.Visible = false end
                v.Armour.Outline=Esp.Settings.TextOutline;v.Armour.Size = math.max(math.min(math.abs(Esp.Settings.TextSize),Esp.Settings.TextSize),Esp.Settings.MinTextSize);
                v.Armour.Position=Vector2.new(math.floor((BoxPosX+w)+v.Armour.TextBounds.X/10),BoxPosY+v.Armour.TextBounds.Y*1.55*0.5-((v.Armour.TextBounds.Y*2)*0.5));v.Armour.Font=Esp.Settings.TextFont
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Armour.Color = Color3.fromRGB(0,255,0)
                else
                v.Armour.Color = Color3.fromHSV(tick() * 128 % 255/255, 1, 1)
                end
            else
                v.Armour.Visible = false
            end
            if OnScreen == true and Esp.Settings.Tracer == true and Distance <= Esp.Settings.RenderDistance then
                if Esp.Settings.TeamCheck == true and TeamTag == false then v.Tracer.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.Tracer.Visible = false else v.Tracer.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.Tracer.Visible = false end
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Tracer.Color = Color3.fromRGB(0,255,0)
                else
                v.Tracer.Color = Color3.fromHSV(tick() * 128 % 255/255, 1, 1)
                end
                v.Tracer.Thickness=Esp.Settings.TracerThickness;v.Transparency=Esp.Settings.TracerTransparrency;
                if Esp.Settings.TracerFrom == "Bottom" then
                    v.Tracer.From = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y)
                    v.Tracer.To = Vector2.new(x,y+h*0.5)
                elseif Esp.Settings.TracerFrom == "Middle" then
                    v.Tracer.From = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
                    v.Tracer.To = Vector2.new(x,y)
                else
                    v.Tracer.From = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/Camera.ViewportSize.Y)
                    if Esp.Settings.Sleeping == true then
                        v.Tracer.To = Vector2.new(x,(y-h)-v.Sleeping.TextBounds.Y*0.5)
                    else
                        v.Tracer.To = Vector2.new(x,y-h*0.5)
                    end
                end
            else
                v.Tracer.Visible = false
            end
            if OnScreen == true and Esp.Settings.ViewAngle == true and Distance <= Esp.Settings.RenderDistance then
                if Esp.Settings.TeamCheck == true and TeamTag == false then v.ViewAngle.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.ViewAngle.Visible = false else v.ViewAngle.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.ViewAngle.Visible = false end
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.ViewAngle.Color = Color3.fromRGB(0,255,0)
                else
                v.ViewAngle.Color=Esp.Settings.ViewAngleColor
                end
                v.ViewAngle.Thickness=Esp.Settings.ViewAngleThickness;v.Transparency=Esp.Settings.ViewAngleTransparrency;
                local headpos = Camera:WorldToViewportPoint(Character.Head.Position)
                local offsetCFrame = CFrame.new(0, 0, -4)
                v.ViewAngle.From = Vector2.new(headpos.X, headpos.Y)
                local value = math.clamp(1/Distance*100, 0.1, 1)
                local dir = Character.Head.CFrame:ToWorldSpace(offsetCFrame)
                offsetCFrame = offsetCFrame * CFrame.new(0, 0, 0.4)
                local dirpos = Camera:WorldToViewportPoint(Vector3.new(dir.X, dir.Y, dir.Z))
                if OnScreen == true then
                    v.ViewAngle.To = Vector2.new(dirpos.X, dirpos.Y)
                    offsetCFrame = CFrame.new(0, 0, -4)
                end
            else
                v.ViewAngle.Visible = false
            end
        else
            v.Box.Visible=false;v.BoxOutline.Visible=false;v.Tool.Visible=false;v.Armour.Visible=false;v.Sleeping.Visible=false;v.ViewAngle.Visible=false;v.Tracer.Visible=false;
        end
    end
		else
    		for i,v in pairs(Esp.Players) do
        local Character = i
        local Position,OnScreen = Camera:WorldToViewportPoint(Character:GetPivot().Position);
        local scale = 1 / (Position.Z * math.tan(math.rad(Camera.FieldOfView * 0.5)) * 2) * 100;
        local w,h = math.floor(40 / 2), math.floor(55 / 2 	);
        local x,y = math.floor(Position.X), math.floor(Position.Y);
        local Distance = (CharcaterMiddle:GetPivot().Position-Character:GetPivot().Position).Magnitude
        local BoxPosX,BoxPosY = math.floor(x - w * 0.5),math.floor(y - h * 0.5)
        local offsetCFrame = CFrame.new(0, 0, -4)
        if Character and Character:FindFirstChild("HumanoidRootPart") and Character:FindFirstChild("Head") then
            local TeamTag = Character.Head.Teamtag.Enabled
            if OnScreen == true and Esp.Settings.Boxes == true and Distance <= Esp.Settings.RenderDistance then
                if Esp.Settings.TeamCheck == true and TeamTag == false then 
                    v.BoxOutline.Visible = Esp.Settings.BoxesOutline;v.Box.Visible = true
                elseif Esp.Settings.TeamCheck == true and TeamTag == true then
                    v.BoxOutline.Visible = false;v.Box.Visible = false
                else
                    v.BoxOutline.Visible = Esp.Settings.BoxesOutline;v.Box.Visible = true
                end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then
                    v.BoxOutline.Visible = false;v.Box.Visible = false
                end
                v.BoxOutline.Position = Vector2.new(BoxPosX,BoxPosY);v.BoxOutline.Size = Vector2.new(w,h)
                v.Box.Position = Vector2.new(BoxPosX,BoxPosY);v.Box.Size = Vector2.new(w,h)
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Box.Color = Color3.fromRGB(0,255,0);v.BoxOutline.Color = Esp.Settings.BoxesOutlineColor
                else
                v.Box.Color=Esp.Settings.BoxesColor;v.BoxOutline.Color = Esp.Settings.BoxesOutlineColor
                end
            else
                v.BoxOutline.Visible = false;v.Box.Visible = false
            end
            if OnScreen == true and Esp.Settings.Sleeping == true and Distance <= Esp.Settings.RenderDistance then
                if v.PlayerTable.sleeping == true then v.Sleeping.Text = "Sleeping" else v.Sleeping.Text = "Awake" end
                if Esp.Settings.TeamCheck == true and TeamTag == false then  v.Sleeping.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.Sleeping.Visible = false else v.Sleeping.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.Sleeping.Visible = false end
                v.Sleeping.Outline=Esp.Settings.TextOutline;v.Sleeping.Size=math.max(math.min(math.abs(Esp.Settings.TextSize),Esp.Settings.TextSize),Esp.Settings.MinTextSize);v.Sleeping.Color = Esp.Settings.SleepingColor;v.Sleeping.Font=Esp.Settings.TextFont;v.Sleeping.Position = Vector2.new(x,math.floor(y-h*0.5-v.Sleeping.TextBounds.Y))
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Sleeping.Color = Color3.fromRGB(0,255,0)
                else
                v.Sleeping.Color=Esp.Settings.SleepingColor
                end
            else
                v.Sleeping.Visible=false
            end
            if OnScreen == true and Esp.Settings.Distances == true and Distance <= Esp.Settings.RenderDistance then
                if Esp.Settings.TeamCheck == true and TeamTag == false then  v.Sleeping.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.Sleeping.Visible = false else v.Sleeping.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.Sleeping.Visible = false end

                if Esp.Settings.Sleeping == false then
                    v.Sleeping.Text = math.floor(Distance).."m"
                else
                    v.Sleeping.Text = v.Sleeping.Text.." | "..math.floor(Distance).."m"
                end
                v.Sleeping.Outline=Esp.Settings.TextOutline;v.Sleeping.Size=math.max(math.min(math.abs(Esp.Settings.TextSize),Esp.Settings.TextSize),Esp.Settings.MinTextSize);v.Sleeping.Color = Esp.Settings.SleepingColor;v.Sleeping.Font=Esp.Settings.TextFont;v.Sleeping.Position = Vector2.new(x,math.floor(y-h*0.5-v.Sleeping.TextBounds.Y))
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Sleeping.Color = Color3.fromRGB(0,255,0)
                else
                v.Sleeping.Color=Esp.Settings.SleepingColor
                end
            else
                v.Sleeping.Visible = false
            end
            if OnScreen == true and Esp.Settings.Tool == true and Distance <= Esp.Settings.RenderDistance then
                if Esp.Settings.TeamCheck == true and TeamTag == false then v.Tool.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.Tool.Visible = false else v.Tool.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.Tool.Visible = false end
                v.Tool.Position = Vector2.new(math.floor((BoxPosX+w)+v.Tool.TextBounds.X/10),BoxPosY+v.Tool.TextBounds.Y*1.55*0.5-((v.Tool.TextBounds.Y*2)*0.5)+v.Tool.TextBounds.Y)
                v.Tool.Text=Esp:CheckTools(v.PlayerTable);v.Tool.Outline=Esp.Settings.TextOutline;v.Tool.Size=math.max(math.min(math.abs(Esp.Settings.TextSize),Esp.Settings.TextSize),Esp.Settings.MinTextSize);v.Tool.Font=Esp.Settings.TextFont
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Tool.Color = Color3.fromRGB(0,255,0)
                else
                v.Tool.Color=Esp.Settings.ToolColor
                end
            else
                v.Tool.Visible = false
            end
            if OnScreen == true and Esp.Settings.Armour == true and Distance <= Esp.Settings.RenderDistance then
                if Character.Armor:FindFirstChildOfClass("Folder") then v.Armour.Text = "Armoured" else v.Armour.Text = "Naked" end
                if Esp.Settings.TeamCheck == true and TeamTag == false then v.Armour.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.Armour.Visible = false else v.Armour.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.Armour.Visible = false end
                v.Armour.Outline=Esp.Settings.TextOutline;v.Armour.Size = math.max(math.min(math.abs(Esp.Settings.TextSize),Esp.Settings.TextSize),Esp.Settings.MinTextSize);
                v.Armour.Position=Vector2.new(math.floor((BoxPosX+w)+v.Armour.TextBounds.X/10),BoxPosY+v.Armour.TextBounds.Y*1.55*0.5-((v.Armour.TextBounds.Y*2)*0.5));v.Armour.Font=Esp.Settings.TextFont
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Armour.Color = Color3.fromRGB(0,255,0)
                else
                v.Armour.Color=Esp.Settings.ArmourColor
                end
            else
                v.Armour.Visible = false
            end
            if OnScreen == true and Esp.Settings.Tracer == true and Distance <= Esp.Settings.RenderDistance then
                if Esp.Settings.TeamCheck == true and TeamTag == false then v.Tracer.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.Tracer.Visible = false else v.Tracer.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.Tracer.Visible = false end
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.Tracer.Color = Color3.fromRGB(0,255,0)
                else
                v.Tracer.Color=Esp.Settings.TracerColor
                end
                ;v.Tracer.Thickness=Esp.Settings.TracerThickness;v.Transparency=Esp.Settings.TracerTransparrency;
                if Esp.Settings.TracerFrom == "Bottom" then
                    v.Tracer.From = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y)
                    v.Tracer.To = Vector2.new(x,y+h*0.5)
                elseif Esp.Settings.TracerFrom == "Middle" then
                    v.Tracer.From = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
                    v.Tracer.To = Vector2.new(x,y)
                else
                    v.Tracer.From = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/Camera.ViewportSize.Y)
                    if Esp.Settings.Sleeping == true then
                        v.Tracer.To = Vector2.new(x,(y-h)-v.Sleeping.TextBounds.Y*0.5)
                    else
                        v.Tracer.To = Vector2.new(x,y-h*0.5)
                    end
                end
            else
                v.Tracer.Visible = false
            end
            if OnScreen == true and Esp.Settings.ViewAngle == true and Distance <= Esp.Settings.RenderDistance then
                if Esp.Settings.TeamCheck == true and TeamTag == false then v.ViewAngle.Visible = true elseif Esp.Settings.TeamCheck == true and TeamTag == true then v.ViewAngle.Visible = false else v.ViewAngle.Visible = true end
                if Esp.Settings.TargetSleepers == true and v.PlayerTable.sleeping == true then v.ViewAngle.Visible = false end
                if inlos(Character.HumanoidRootPart.Position, Character) and Esp.Settings.HighlightVisible then
                v.ViewAngle.Color = Color3.fromRGB(0,255,0)
                else
                v.ViewAngle.Color=Esp.Settings.ViewAngleColor
                end
                v.ViewAngle.Thickness=Esp.Settings.ViewAngleThickness;v.Transparency=Esp.Settings.ViewAngleTransparrency;
                local headpos = Camera:WorldToViewportPoint(Character.Head.Position)
                local offsetCFrame = CFrame.new(0, 0, -4)
                v.ViewAngle.From = Vector2.new(headpos.X, headpos.Y)
                local value = math.clamp(1/Distance*100, 0.1, 1)
                local dir = Character.Head.CFrame:ToWorldSpace(offsetCFrame)
                offsetCFrame = offsetCFrame * CFrame.new(0, 0, 0.4)
                local dirpos = Camera:WorldToViewportPoint(Vector3.new(dir.X, dir.Y, dir.Z))
                if OnScreen == true then
                    v.ViewAngle.To = Vector2.new(dirpos.X, dirpos.Y)
                    offsetCFrame = CFrame.new(0, 0, -4)
                end
            else
                v.ViewAngle.Visible = false
            end
        else
            v.Box.Visible=false;v.BoxOutline.Visible=false;v.Tool.Visible=false;v.Armour.Visible=false;v.Sleeping.Visible=false;v.ViewAngle.Visible=false;v.Tracer.Visible=false;
        end
    end
end
end

-- Esp updater
local PlayerUpdater = game:GetService("RunService").RenderStepped
local PlayerConnection = PlayerUpdater:Connect(function()
    Esp:UpdateEsp()
end)

--Init Functions
for i, v in pairs(getupvalues(getrenv()._G.modules.Player.GetPlayerModel)[1]) do
    if not table.find(cache,v) then
        table.insert(cache,v)
        Esp:CreateEsp(v)
    end
end

-- Esp adder
game:GetService("Workspace").ChildAdded:Connect(function(child)
    if child:FindFirstChild("HumanoidRootPart") then
        for i, v in pairs(getupvalues(getrenv()._G.modules.Player.GetPlayerModel)[1]) do
            if not table.find(cache,v) then
                Esp:CreateEsp(v)
                table.insert(cache,v)
            end
        end
    end
end)

local FovSnapline = Functions:Draw("Line",{Transparency=1,Thickness=1,Visible=false,Color = SilentSettings["SnaplinesColor"]})
local FovCircle = Functions:Draw("Circle",{Color=Fov.Settings.FovColor,Radius=Fov.Settings.FovSize,NumSides=90,Thickness=1,Transparency=Fov.Settings.FovTransparency,ZIndex=2,Visible=false})

local Window = Library:CreateWindow({

    Title = 'Fluent.gg | Public',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

		local CombatTab = Window:AddTab('Combat')

		local SilentAimSector = CombatTab:AddLeftGroupbox('Combat')
		local miscCombat = CombatTab:AddRightTabbox()
		local miscCombatTab = miscCombat:AddTab('Misc')
		local GunModsTabbox = CombatTab:AddRightTabbox()
		local GunModsTab = GunModsTabbox:AddTab('Modifications')
		local HitBoxSector = CombatTab:AddLeftGroupbox('HitBox')

		SilentAimSector:AddToggle('SilentAim_Enabled', { Text = 'Enable SilentAim', Default = false, Tooltip = nil, })
		Toggles.SilentAim_Enabled:OnChanged(function()
			_Cameras["Toggle"] = Toggles.SilentAim_Enabled.Value
			print(_Cameras["Toggle"])
		end)
		SilentAimSector:AddLabel('SilentAim Keybind'):AddKeyPicker('SilentAimbot_Bind',
		{ Default = 'MB2', Text = 'SilentAim Keybind', Tooltip = nil, NoUI = false, Mode = 'Hold', })
		local OrginalGetCFrame = _Camera.GetCFrame;
		_Camera.GetCFrame = function()
			if _Cameras["Toggle"] and _Cameras["Pos"] then
				return CFrame.new(OrginalGetCFrame().p,
					_Cameras["Pos"].Position + Vector3.new((_Cameras["X_Offset"]), (_Cameras["Y_Offset"]), 0.001));
			else
				return OrginalGetCFrame();
			end
	end
		task.spawn(function()
			while task.wait() do
				if Options.SilentAimbot_Bind:GetState() and _Cameras["Toggle"] and math.random(0,100) <= SilentSettings["hitChance"] then
					local Target;
					if SilentSettings["AimType"] == "To Cursor" then
						Target = getClosestPlayerToCursor();
					else
						Target = getClosestPlayerToPlayer();
					end
					if Target then
						local Head = Target:FindFirstChild("Head");
						if Head then
							local oldx = Head.Position.X;
							local oldy = Head.Position.Y;
							if SilentSettings.TeamCheck == true and Head.Teamtag.Enabled == false then
							if SilentSettings["Prediction"] == true then
								if Functions:GetClosest() ~= nil then
								_Network.Send(_SendCodes.ENT_LOOK_AT, playerId)
								_Cameras["Pos"] = CFrame.new(Head.CFrame.Position+Functions:Predict());
                                wait(0.01)
                                _Cameras["Pos"] = nil;
							else
								if Functions:GetClosest() ~= nil then
								_Network.Send(_SendCodes.ENT_LOOK_AT, playerId)
								_Cameras["Pos"] = CFrame.new(Head.CFrame.Position)
                                wait(0.01)
                                _Cameras["Pos"] = nil;
                                	end
                                end
							end
						end
					end
				else
					_Cameras["Pos"] = nil;
					end
				end
			end
		end)
		
		SilentAimSector:AddDropdown('AimTypeDrop',
			{ Values = { "To Cursor", "To Player" }, Default = 1, Multi = false, Text = 'Target', Tooltip = nil, })
		Options.AimTypeDrop:OnChanged(function()
			SilentSettings["AimType"] = Options.AimTypeDrop.Value;
		end)
		SilentAimSector:AddSlider('Aim_Distance',
			{ Text = 'Max Distance', Default = 500, Min = 0, Max = 1000, Rounding = 0, Compact = false, })
		Options.Aim_Distance:OnChanged(function()
			SilentSettings["AimDis"] = Options.Aim_Distance.Value;
		end)
        SilentAimSector:AddSlider('HitChance', {Text='Hit Chance',Default=100,Min=0,Max=100,Rounding=0,Compact=false,Suffix="%"}):OnChanged(function(Value)
    SilentSettings["hitChance"] = Value
end)
SilentAimSector:AddToggle('Team_Check', { Text = 'Team Check', Default = true, Tooltip = nil, })
		Toggles.Team_Check:OnChanged(function()
			SilentSettings["TeamCheck"] = Toggles.Team_Check.Value;
		end)
SilentAimSector:AddToggle('snapLine', { Text = 'Snaplines', Default = false, Tooltip = nil, })
		Toggles.snapLine:OnChanged(function()
			SilentSettings["Snaplines"] = Toggles.snapLine.Value;
		end)
SilentAimSector:AddToggle('Pred', { Text = 'Prediction', Default = true, Tooltip = nil, })
		Toggles.Pred:OnChanged(function()
			SilentSettings["Prediction"] = Toggles.Pred.Value;
		end)

game:GetService("RunService").RenderStepped:Connect(function()
    if getClosestPlayerToCursor() ~= nil and SilentSettings["Snaplines"] == true and _Cameras["Toggle"] then
        local p,t = getClosestPlayerToCursor()
        FovSnapline.Visible = true
        local Position,OnScreen = Camera:WorldToViewportPoint(getClosestPlayerToCursor()[SilentSettings["AimPart"]]:GetPivot().p+Functions:Predict());
        if SilentSettings["TeamCheck"] == true and getClosestPlayerToCursor().Head.Teamtag.Enabled == false and OnScreen == true then
            FovSnapline.To = Position
        elseif OnScreen == true then
            FovSnapline.To = Position
        end
    else
        FovSnapline.Visible = false
    end
    if Fov.Settings["Position"] == "Screen" then
        FovSnapline.From=FovCircle.Position
    else
        local MousePos = Camera.WorldToViewportPoint(Camera,game.Players.LocalPlayer:GetMouse().Hit.p)
        FovCircle.Position = Vector2.new(MousePos.X,MousePos.Y)
        FovSnapline.From=FovCircle.Position
    end
end)

		local HitBX = 4
		local HitBY = 5
		local HitBZ = 2.5

		HitBoxSector:AddToggle('EnabledHB', { Text = 'Enabled', Default = false, Tooltip = nil, })
		Toggles.EnabledHB:OnChanged(function(EnabledHBB)
			if EnabledHBB == true then
				for v, i in pairs(workspace:GetChildren()) do
					if i:FindFirstChild("HumanoidRootPart") then
						i.Head.Size = Vector3.new(HitBX, HitBY, HitBZ)
					end
				end
				game.ReplicatedStorage.Player.Head.Size = Vector3.new(HitBX, HitBY, HitBZ)
			elseif EnabledHBB == false then
				for v, i in pairs(workspace:GetChildren()) do
					if i:FindFirstChild("HumanoidRootPart") then
						i.Head.Size = Vector3.new(1.9362, 0.9681, 0.9681)
					end
				end
				game.ReplicatedStorage.Player.Head.Size = Vector3.new(1.9362, 0.9681, 0.9681)
			end
		end)
		HitBoxSector:AddSlider('hitbox_sizeX',
			{ Text = 'Hitbox X', Default = 4, Min = 2, Max = 6, Rounding = 1, Compact = false, })
		Options.hitbox_sizeX:OnChanged(function()
			HitBX = Options.hitbox_sizeX.Value
		end)
		HitBoxSector:AddSlider('hitbox_sizeY',
			{ Text = 'Hitbox Y', Default = 5, Min = 1, Max = 6, Rounding = 1, Compact = false, })
		Options.hitbox_sizeY:OnChanged(function()
			HitBY = Options.hitbox_sizeY.Value
		end)
		HitBoxSector:AddSlider('hitbox_sizeZ',
			{ Text = 'Hitbox Z', Default = 4.5, Min = 1, Max = 6, Rounding = 1, Compact = false, })
		Options.hitbox_sizeZ:OnChanged(function()
			HitBZ = Options.hitbox_sizeZ.Value
			print(HitBZ)
		end)
		
		
miscCombatTab:AddToggle('AutoReload',{Text='Auto Reload (risky)',Default=false}):OnChanged(function(Value)
    task.spawn(function()
        while Value do task.wait()
            if getrenv()._G.modules.FPS.GetEquippedItem() ~= nil and getrenv()._G.modules.FPS.GetEquippedItem().id ~= nil and getrenv()._G.modules.FPS.GetEquippedItem().ammo and getrenv()._G.modules.FPS.GetEquippedItem().ammo < math.round(require(game:GetService("ReplicatedStorage").ItemConfigs[getrenv()._G.modules.FPS.GetEquippedItem().id]).MaxAmmo/1.5) then
                game.Players.LocalPlayer:FindFirstChild("RemoteEvent"):FireServer(10, "Reload")
                print("auto re-loaded!")
                wait(0.1)
            end
        end
    end)
end)
miscCombatTab:AddToggle('Triggerbot',{Text='Triggerbot',Default=false}):OnChanged(function(Value)
	triggerBot = Value
end)

miscCombatTab:AddLabel('Triggerbot Keybind'):AddKeyPicker('TriggerBot_Bind',
{ Default = 'X', Text = 'Triggerbot Keybind', Tooltip = nil, NoUI = false, Mode = 'Toggle', })
task.spawn(function()
	while task.wait() do
		if Options.TriggerBot_Bind:GetState() and triggerBot then
			if getrenv()._G.modules.FPS.GetEquippedItem() ~= nil and getrenv()._G.modules.FPS.GetEquippedItem().id ~= nil and getrenv()._G.modules.FPS.GetEquippedItem().ammo and getrenv()._G.modules.FPS.GetEquippedItem().ammo > 0 then
				local Target
				Target = getClosestPlayerToCursor()
				if Target then
					local Head = Target:FindFirstChild("Head")
					if Head and Head.Teamtag.Enabled == false then
						if inlos(Head.Position, Target) then
						mouse1press()
						task.wait(0.01)
						mouse1release()
						end
					end
				end	
			end
		end
	end
end)

miscCombatTab:AddToggle("LootAll", { Text = "Loot All", Default = false }):AddKeyPicker("LootAllKeyBind",{ Default = "V", SyncToggleState = true, Mode = "Toggle", Text = "Loot All", NoUI = false }); 
Toggles.LootAll:OnChanged(function()
    for G = 1, 20 do 
        game:GetService("Players").LocalPlayer.RemoteEvent:FireServer(12, G, true)
    end
end)

local alwaysGroundedToggle = false
miscCombatTab:AddToggle('jumpShoot',{Text='Air Shoot',Default=false}):OnChanged(function(Value)
	alwaysGroundedToggle = Value
end)
local jumpShoot; jumpShoot = hookfunction(getrenv()._G.modules.Character.IsGrounded, function(...)
    args = {...}
    if alwaysGroundedToggle == true then
        return true
    else
        return jumpShoot(unpack(args))
    end
end)

miscCombatTab:AddToggle('', {Text = "Jump Crouch",Default = false,}):AddKeyPicker('JumpCrouchKey', {Default='Q',SyncToggleState=true,Mode='Toggle',Text='Auto-walk',NoUI=false})
  local stoprun = false
  task.spawn(function()
  while true do
    local state = Options.JumpCrouchKey:GetState()
    if state then
      keypress(0x57)
      keypress(0x10)
      wait(0.05)
      keypress(0x43)
      keypress(0x20)
      keyrelease(0x20)
      wait(0.5)
      keyrelease(0x43)
      wait(1)
    end
    if Library.Unloaded then break end
    wait()
  end
  end)
  task.spawn(function()
  while task.wait() do
    local state = Options.JumpCrouchKey:GetState()
    if not state then
      if stoprun then
        keyrelease(0x57)
        keyrelease(0x10)
        stoprun = false
      end
    else
      stoprun = true
    end
  end
  end)

local GunModsEnabled = false

local noSwayTog = false
local noAimOffsetTog = false
local noZoomTog = false
local firerateMultiTog = false
local autoFireTypeTog = false
local instaEquipTog = false
local noSpreadTog = false
local instaReloadTog = false

local firerateMulti = 1
local autoFireType = 'auto'
local equipTime = 0
local reloadTime = 0


GunModsTab:AddToggle('noSwayT',{Text='No Sway',Default=false}):OnChanged(function(Value)
	noSwayTog = Value
end)
GunModsTab:AddToggle('noAimOffsetT',{Text='No Aiming-offset',Default=false}):OnChanged(function(Value)
	noAimOffsetTog = Value
end)
GunModsTab:AddToggle('firerateMultiT',{Text='Fire-rate Multiplier',Default=false}):OnChanged(function(Value)
	firerateMultiTog = Value
end)
GunModsTab:AddToggle('autoFireTypeT',{Text='Change Firing Type',Default=false}):OnChanged(function(Value)
	autoFireTypeTog = Value
end)
GunModsTab:AddToggle('instaEquipT',{Text='No Equip Delay',Default=false}):OnChanged(function(Value)
	instaEquipTog = Value
end)
GunModsTab:AddToggle('noSpreadT',{Text='No Spread',Default=false}):OnChanged(function(Value)
	noSpreadTog = Value
end)
GunModsTab:AddToggle('instaReloadT',{Text='Instant Reload',Default=false}):OnChanged(function(Value)
	instaReloadTog = Value
end)

local GunModsSettingTab = GunModsTabbox:AddTab('Settings')

GunModsSettingTab:AddToggle('GunModsEnabledT',{Text='Enabled',Default=false}):OnChanged(function(Value)
	GunModsEnabled = Value
end)
GunModsSettingTab:AddDropdown('autoFireTypeD',{Values={"auto","semi-auto","manual"},Default=1,Multi=false,Text='Firing Type'}):OnChanged(function(Value)
    autoFireType = Value
end)
GunModsSettingTab:AddSlider('equipTimeS', {Text='Equip Time',Default=1,Min=0,Max=1,Rounding=1,Compact=false}):OnChanged(function(Value)
    equipTime = Value
end)
GunModsSettingTab:AddSlider('reloadTimeS', {Text='Reload Time',Default=3,Min=0,Max=3,Rounding=1,Compact=false}):OnChanged(function(Value)
    reloadTime = Value
end)

local spinbotTabbox = CombatTab:AddLeftTabbox()
local spinbotTab = spinbotTabbox:AddTab('Spinbot')
local spinbotToggle = false
local spinbotSpeed = 15

spinbotTab:AddToggle('spinbotEnabledT',{Text='Enabled',Default=false}):OnChanged(function(Value)
	spinbotToggle = Value
end)
spinbotTab:AddSlider('speedS', {Text='Spinbot Speed',Default=15,Min=1,Max=20,Rounding=0,Compact=false}):OnChanged(function(Value)
    spinbotSpeed = Value
end)

local event = game.Players.LocalPlayer:FindFirstChild("RemoteEvent").FireServer
local spinHookSpeed = 1

    local Spon
    Spon= hookfunction(event, function(self, ...)
        local args = {...}
        if args[1] and args[2] and args[1] == 1 and typeof(args[2]) == "Vector3" and args[4] and spinbotToggle then
            args[4] = spinHookSpeed
            spinHookSpeed = spinHookSpeed - spinbotSpeed
        end
        return Spon(self, unpack(args))
    end)

    local Spon1
    Spon1= hookfunction(event, function(self, ...)
        local args = {...}
        if args[1] and args[2] and args[1] == 1 and typeof(args[2]) == "Vector3" and args[4] and spinbotToggle then
            args[3] = math.random(-1.5000001192092896, 1.5000001192092896)
        end
        return Spon1(self, unpack(args))
    end)

local FOVTabbox = CombatTab:AddRightTabbox()
local FovTab = FOVTabbox:AddTab('FOV')

FovTab:AddToggle('Fov',{Text='Enabled',Default=false}):AddColorPicker('FovColor',{Default=Color3.fromRGB(206,250,5),Title='Color'})
--FovTab:AddToggle('Dynamic',{Text='Dynamic',Default=true})
FovTab:AddDropdown('FovPosition', {Values = {"Screen","Mouse"},Default = 2,Multi = false,Text = 'Position'}):OnChanged(function(Value)
    Fov.Settings.FovPosition = Value
end)
FovTab:AddSlider('FovSize', {Text='Size',Default=90,Min=30,Max=350,Rounding=0,Compact=false}):OnChanged(function(Value)
    Fov.Settings.FovSize = Value;FovCircle.Radius = Value
end)


game:GetService("RunService").RenderStepped:Connect(function()
    Fov.Settings.RealFovSize=FovCircle.Radius
    if Fov.Settings.Dynamic == true then
        local set = Fov.Settings.FovSize * ((Fov.Settings.FovSize-Camera.FieldOfView)/100 + 1) + 5
        FovCircle.Radius = set
    else
        FovCircle.Radius=Fov.Settings.FovSize
    end
    if Fov.Settings.FovPosition == "Screen" then
        FovCircle.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
    else
        local MousePos = Camera.WorldToViewportPoint(Camera,game.Players.LocalPlayer:GetMouse().Hit.p)
        FovCircle.Position = Vector2.new(MousePos.X,MousePos.Y)
    end
end)

Toggles.Fov:OnChanged(function(Value)
    Fov.Settings.FovEnabled = Value
    FovCircle.Visible = Value
end)
Options.FovColor:OnChanged(function(Value)
    Fov.Settings.FovColor = Value
    FovCircle.Color = Value
end)

local Visual = Window:AddTab('Visuals')
local PlayerVisualTabbox = Visual:AddLeftTabbox()
local PlayerVisualTab = PlayerVisualTabbox:AddTab('ESP')
local PlayerSettingsVisualTab = PlayerVisualTabbox:AddTab('Settings')

PlayerVisualTab:AddToggle('Boxes',{Text='Box',Default=false}):AddColorPicker('BoxesColor',{Default=Color3.fromRGB(206,250,5),Title='Color'})
PlayerVisualTab:AddToggle('Sleeping',{Text='Sleeping or awake',Default=false}):AddColorPicker('SleepingColor',{Default=Color3.fromRGB(206,250,5),Title='Color'})
PlayerVisualTab:AddToggle('Distances',{Text='Length',Default=false}):AddColorPicker('DistancesColor',{Default=Color3.fromRGB(206,250,5),Title='Color'})
PlayerVisualTab:AddToggle('Armour',{Text='Armour',Default=false}):AddColorPicker('ArmourColor',{Default=Color3.fromRGB(206,250,5),Title='Color'})
PlayerVisualTab:AddToggle('Tool',{Text='Weapon',Default=false}):AddColorPicker('ToolColor',{Default=Color3.fromRGB(206,250,5),Title='Color'})
--PlayerVisualTab:AddToggle('ViewAngle',{Text='View Angle',Default=false}):AddColorPicker('ViewAngleColor',{Default=Color3.fromRGB(206,250,5),Title='Color'})
--PlayerVisualTab:AddToggle('Tracer',{Text='Tracer',Default=false}):AddColorPicker('TracerColor',{Default=Color3.fromRGB(206,250,5),Title='Color'})

--Esp Switches
Toggles.Armour:OnChanged(function(Value)
    Esp.Settings.Armour = Value
end)
Options.ToolColor:OnChanged(function(Value)
    Esp.Settings.ToolColor = Value
end)
Toggles.Tool:OnChanged(function(Value)
    Esp.Settings.Tool = Value
end)
Options.ArmourColor:OnChanged(function(Value)
    Esp.Settings.ArmourColor = Value
end)
Toggles.Armour:OnChanged(function(Value)
    Esp.Settings.Armour = Value
end)
Toggles.Distances:OnChanged(function(Value)
    Esp.Settings.Distances = Value
end)
Options.DistancesColor:OnChanged(function(Value)
    Esp.Settings.DistanceColor = Value
end)
Options.SleepingColor:OnChanged(function(Value)
    Esp.Settings.SleepingColor = Value
end)
Toggles.Sleeping:OnChanged(function(Value)
    Esp.Settings.Sleeping = Value
end)
Options.BoxesColor:OnChanged(function(Value)
    Esp.Settings.BoxesColor = Value
end)
Toggles.Boxes:OnChanged(function(Value)
    Esp.Settings.Boxes = Value
end)
PlayerSettingsVisualTab:AddSlider('RenderDistance', {Text='Render Distance',Default=1500,Min=1,Max=1500,Rounding=0,Compact=false,Suffix="m"}):OnChanged(function(Value)
    Esp.Settings.RenderDistance = Value
end)
PlayerSettingsVisualTab:AddSlider('TextSize', {Text='Text Size',Default=15,Min=8,Max=50,Rounding=0,Compact=false}):OnChanged(function(Value)
    Esp.Settings.TextSize = Value
end)
PlayerSettingsVisualTab:AddToggle('TargetSleepers',{Text='Dont Show Sleepers',Default=true}):OnChanged(function(Value)
    Esp.Settings.TargetSleepers = Value
end)
PlayerSettingsVisualTab:AddToggle('TeamCheck',{Text='Team Check',Default=true}):OnChanged(function(Value)
    Esp.Settings.TeamCheck = Value
end)
PlayerSettingsVisualTab:AddToggle('HighlightVis',{Text='Highlight Visible Players',Default=true}):OnChanged(function(Value)
    Esp.Settings.HighlightVisible = Value
end)
PlayerSettingsVisualTab:AddToggle('Rainbow',{Text='Rainbow',Default=false}):OnChanged(function(Value)
    Esp.Settings.Rainbow = Value
end)
PlayerSettingsVisualTab:AddDropdown('TracerPosition',{Values={"Bottom","Middle","Top"},Default=1,Multi=false,Text='Tracer Position'}):OnChanged(function(Value)
    Esp.Settings.TracerFrom = Value
end)

local CrosshairVisualTabbox = Visual:AddLeftTabbox()
local CrosshairVisualTab = CrosshairVisualTabbox:AddTab('Crosshair')

getgenv().CrosshairSettings = {
			Color = Color3.fromRGB(206,250,5),
			Opacity = 1,
			Length = 10,
			Thickness = 1,
			Offset = 3,
			Dot = false,
			FollowCursor = false,
			HideMouseIcon = false,
			HideGameCrosshair = false,
			VisibleHS = false
		}
		loadstring(game:HttpGet("https://github.com/ZXCSt1vaha/Main/raw/main/CrossHairLOL"))()
		CrosshairVisualTab:AddToggle('VisibleCH', { Text = 'Visible', Default = false, Tooltip = nil, })
		Toggles.VisibleCH:OnChanged(function(chtv)
			getgenv().CrosshairSettings.VisibleHS = chtv
		end)
		CrosshairVisualTab:AddLabel('Color'):AddColorPicker('CHJColor', { Default = Color3.fromRGB(206,250,5), Title = 'Color', })
		Options.CHJColor:OnChanged(function(chc)
			getgenv().CrosshairSettings.Color = chc
		end)
		CrosshairVisualTab:AddToggle('HideMouseIconT', { Text = 'Hide Mouse', Default = false, Tooltip = nil, })
		Toggles.HideMouseIconT:OnChanged(function(hmich)
			getgenv().CrosshairSettings.HideMouseIcon = hmich
		end)
		CrosshairVisualTab:AddSlider('ThicknessS', {
			Text = 'Thickness',
			Default = 1,
			Min = 0,
			Max = 5,
			Rounding = 1,
			Compact = false,
		})
		Options.ThicknessS:OnChanged(function(tck)
			getgenv().CrosshairSettings.Thickness = tck
		end)

_G.SettingsOre = {
    iron = {
      enabled = true,
      colour = Color3.fromRGB(199, 172, 120),
    },
    nitrate = {
      enabled = true,
      colour = Color3.fromRGB(248, 248, 248),
    },
    stone = {
      enabled = true,
      colour = Color3.fromRGB(205, 205, 205),
    },
    oreDistance = 500,
  }
local char = game:GetService("Workspace").Ignore.LocalCharacter:WaitForChild("Top")
local settings1 = _G.SettingsOre
  if settings1 == nil then
    return
  end

local OreVisualTabbox = Visual:AddRightTabbox()
local OreVisualTab = OreVisualTabbox:AddTab('Ore ESP')
local OreSettingsVisualTab = OreVisualTabbox:AddTab('Settings')
OreVisualTab:AddLabel('Iron Color'):AddColorPicker('IronColor', { Default = Color3.fromRGB(199, 172, 120), Title = 'Color', })
Options.IronColor:OnChanged(function(Value)
	settings1.iron.colour = Value
    if settings1.iron.enabled then
    settings1.iron.enabled = false
    task.wait(0.01)
    settings1.iron.enabled = true
    end
end)
OreVisualTab:AddLabel('Nitrate Color'):AddColorPicker('NitrateColor', { Default = Color3.fromRGB(248, 248, 248), Title = 'Color', })
Options.NitrateColor:OnChanged(function(Value)
	settings1.nitrate.colour = Value
    if settings1.nitrate.enabled then
    settings1.nitrate.enabled = false
    task.wait(0.01)
    settings1.nitrate.enabled = true
    end
end)
OreVisualTab:AddLabel('Stone Color'):AddColorPicker('StoneColor', { Default = Color3.fromRGB(205, 205, 205), Title = 'Color', })
Options.StoneColor:OnChanged(function(Value)
	settings1.stone.colour = Value
if settings1.stone.enabled then
    settings1.stone.enabled = false
    task.wait(0.01)
    settings1.stone.enabled = true
    end
end)
OreSettingsVisualTab:AddToggle('iron_Toggle',{Text='Iron Toggle',Default=false}):OnChanged(function(Value)
    settings1.iron.enabled = Value
end)
OreSettingsVisualTab:AddToggle('nitrate_Toggle',{Text='Nitrate Toggle',Default=false}):OnChanged(function(Value)
    settings1.nitrate.enabled = Value
end)
OreSettingsVisualTab:AddToggle('stone_Toggle',{Text='Stone Toggle',Default=false}):OnChanged(function(Value)
    settings1.stone.enabled = Value
end)
OreSettingsVisualTab:AddSlider('OreRenderDistance', {Text='Render Distance',Default=500,Min=1,Max=1500,Rounding=0,Compact=false,Suffix="m"}):OnChanged(function(Value)
    settings1.oreDistance = Value
end)

  local function get_text(text, position)
    local distance = math.floor((position - workspace.Ignore.LocalCharacter.Middle.Position).Magnitude)
    local final_text = tostring(text) .. "\n[" .. tostring(distance) .. "] studs"
    return tostring(final_text)
  end
  local function worldtoviewport(position)
    local a, b = workspace.CurrentCamera:WorldToViewportPoint(position)
    return Vector2.new(a.X, a.Y), b
  end
  local function add_esp(part, text, colour, toggle)
    local drawing_text = Drawing.new("Text")
    drawing_text.Outline = true
    drawing_text.Center = true
    drawing_text.Visible = false
    drawing_text.Font = 2
    drawing_text.Size = 11
    drawing_text.Color = colour
    local rendersteploop = game:GetService("RunService").Stepped:connect(function()pcall(function()
    if not part:IsDescendantOf(workspace) or not settings1 then
      drawing_text.Visible = false
      drawing_text:Remove()
      rendersteploop:Disconnect()
    end
    local part_pos = part.Position
    local screen_pos, on_screen = worldtoviewport(part_pos)
    if not on_screen then
      drawing_text.Visible = false
      rendersteploop:Disconnect()
    end
    local oreDis = (char:GetPivot().Position-part_pos).Magnitude
    if oreDis >= settings1.oreDistance then
      drawing_text.Visible = false
      rendersteploop:Disconnect()
    end
    if text == 'Iron' and not settings1.iron.enabled then
      drawing_text.Visible = false
      drawing_text.Color = settings1.iron.colour
      rendersteploop:Disconnect()
      else if text == 'Nitrate' and not settings1.nitrate.enabled then
      drawing_text.Visible = false
      drawing_text.Color = settings1.nitrate.colour
      rendersteploop:Disconnect()
      else if text == 'Stone' and not settings1.stone.enabled then
      drawing_text.Visible = false
      drawing_text.Color = settings1.stone.colour
      rendersteploop:Disconnect()
         end
      end
    end
    drawing_text.Visible = true
    drawing_text.Text = get_text(text, part_pos)
    drawing_text.Position = screen_pos
    rendersteploop:Disconnect()
    end)
    end)
    end
  local function filter_models(v)
    if (not v:IsA("Model")) then
      return
    end
    local is_part = v:FindFirstChild("Part")
    local children = v:GetChildren()
    local child_amount = #children
    if is_part then
      if child_amount == 1 then
        add_esp(is_part, "Stone", settings1.stone.colour, settings1.stone.enabled)
      elseif child_amount == 2 then
        for _, v in pairs(children) do
          local brickcolor = v.BrickColor
          local is_ore = v.ClassName == "MeshPart" and v.Name == "Part"
          if is_ore then
            if brickcolor == BrickColor.new("Institutional white") then
              add_esp(v, "Nitrate", settings1.nitrate.colour, settings1.nitrate.enabled)
            elseif brickcolor == BrickColor.new("Burlap") then
              add_esp(v, "Iron", settings1.iron.colour, settings1.iron.enabled)
            end
          end
        end
      end
    end
  end
  for index, model in pairs(workspace:GetChildren()) do
filter_models(model)
end
workspace.ChildAdded:Connect(function(model)
filter_models(model)
end)

local MiscVisualTabbox = Visual:AddRightTabbox()
local MiscVisualTab = MiscVisualTabbox:AddTab('Misc')
local arrowToggle = false
local bulletToggle = false
Arrow.Trail.Lifetime = 20

local arrowLight = Instance.new("PointLight")
arrowLight.Parent = Arrow
arrowLight.Brightness = 0.2
arrowLight.Range = 50

MiscVisualTab:AddToggle('Arrow_trail',{Text='Arrow trail color',Default=false}):AddColorPicker('Arrow_trail_color',{Default=Color3.fromRGB(206,250,5),Title='Color'})
MiscVisualTab:AddToggle('Bullet_trail',{Text='Bullet trail color',Default=false}):AddColorPicker('Bullet_trail_color',{Default=Color3.fromRGB(206,250,5),Title='Color'})

Toggles.Arrow_trail:OnChanged(function(Value)
    arrowToggle = Value
end)
Options.Arrow_trail_color:OnChanged(function(Value)
if arrowToggle then
    local colorSequenceArrow = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Value),
    ColorSequenceKeypoint.new(1, Value),
}
Arrow.Trail.Color = colorSequenceArrow
Arrow.Material = "Neon"
Arrow.Color = Value
arrowLight.Color = Value
else return end
end)

Toggles.Bullet_trail:OnChanged(function(Value)
    bulletToggle = Value
end)
Options.Bullet_trail_color:OnChanged(function(Value)
if bulletToggle then
Bullet.PointLight.Color = Value
Bullet.Color = Value
else return end
end)

task.spawn(function()
	while task.wait() do
sethiddenproperty(game:GetService("Lighting"),"ClockTime",12)
sethiddenproperty(game:GetService("Lighting"),"Ambient",Color3.fromRGB(200,200,200))
    end
end)

local MiscTab = Window:AddTab('Misc')

local Xray = MiscTab:AddLeftGroupbox('Xray')

local XRAY22 = false
Xray:AddToggle("XRAY", { Text = "XRAY", Default = false })
	:AddKeyPicker("XRAYKey", { Default = "T", SyncToggleState = true, Mode = "Toggle", Text = "XRAY", NoUI = false })
	:OnChanged(function()
		XRAY22 = Toggles.XRAY.Value
		if XRAY22 then
			for i, v in pairs(game:GetDescendants()) do
				if v:FindFirstChild("Hitbox") then
					v.Hitbox.Transparency = 0.6
				end
			end
		else
			for i, v in pairs(game:GetDescendants()) do
				if v:FindFirstChild("Hitbox") then
					v.Hitbox.Transparency = 0
				end
			end
		end
	end)





local CustomHitsoundsTabBox = MiscTab:AddLeftTabbox("Custom Hitsounds")
local PlayerHitsoundsTab = CustomHitsoundsTabBox:AddTab("Player Hitsounds")
local NatureHitsoundsTab = CustomHitsoundsTabBox:AddTab("Nature Hitsounds")

local sounds = {
	["Defualt Headshot Hit"] = "rbxassetid://9119561046",
	["Defualt Body Hit"] = "rbxassetid://9114487369",
	["Defualt Wood Hit"] = "rbxassetid://9125573608",
	["Defualt Rock Hit"] = "rbxassetid://9118630389",
	Neverlose = "rbxassetid://8726881116",
	Gamesense = "rbxassetid://4817809188",
	One = "rbxassetid://7380502345",
	Bell = "rbxassetid://6534947240",
	Rust = "rbxassetid://1255040462",
	TF2 = "rbxassetid://2868331684",
	Slime = "rbxassetid://6916371803",
	["Among Us"] = "rbxassetid://5700183626",
	Minecraft = "rbxassetid://4018616850",
	["CS:GO"] = "rbxassetid://6937353691",
	Saber = "rbxassetid://8415678813",
	Baimware = "rbxassetid://3124331820",
	Osu = "rbxassetid://7149255551",
	["TF2 Critical"] = "rbxassetid://296102734",
	Bat = "rbxassetid://3333907347",
	["Call of Duty"] = "rbxassetid://5952120301",
	Bubble = "rbxassetid://6534947588",
	Pick = "rbxassetid://1347140027",
	Pop = "rbxassetid://198598793",
	Bruh = "rbxassetid://4275842574",
	Bamboo = "rbxassetid://3769434519",
	Crowbar = "rbxassetid://546410481",
	Weeb = "rbxassetid://6442965016",
	Beep = "rbxassetid://8177256015",
	Bambi = "rbxassetid://8437203821",
	Stone = "rbxassetid://3581383408",
	["Old Fatality"] = "rbxassetid://6607142036",
	Click = "rbxassetid://8053704437",
	Ding = "rbxassetid://7149516994",
	Snow = "rbxassetid://6455527632",
	Laser = "rbxassetid://7837461331",
	Mario = "rbxassetid://2815207981",
	Steve = "rbxassetid://4965083997",
	Snowdrake = "rbxassetid://7834724809",
}

local SoundService = game:GetService("SoundService")

SoundService.PlayerHitHeadshot.Volume = 5
SoundService.PlayerHitHeadshot.Pitch = 1
SoundService.PlayerHitHeadshot.EqualizerSoundEffect.HighGain = -2

-- GAME
PlayerHitsoundsTab:AddToggle("Enabled_Toggle1", { Text = "Enabled", Default = false })

PlayerHitsoundsTab:AddDropdown(
	"HeadshotHit",
	{
		Values = {
			"Defualt Headshot Hit",
			"Neverlose",
			"Gamesense",
			"One",
			"Bell",
			"Rust",
			"TF2",
			"Slime",
			"Among Us",
			"Minecraft",
			"CS:GO",
			"Saber",
			"Baimware",
			"Osu",
			"TF2 Critical",
			"Bat",
			"Call of Duty",
			"Bubble",
			"Pick",
			"Pop",
			"Bruh",
			"Bamboo",
			"Crowbar",
			"Weeb",
			"Beep",
			"Bambi",
			"Stone",
			"Old Fatality",
			"Click",
			"Ding",
			"Snow",
			"Laser",
			"Mario",
			"Steve",
			"Snowdrake",
		},
		Default = 1,
		Multi = false,
		Text = "Head Hitsound:",
	}
)
Options.HeadshotHit:OnChanged(function()
	local soundId = sounds[Options.HeadshotHit.Value]
	game:GetService("SoundService").PlayerHitHeadshot.SoundId = soundId
end)

PlayerHitsoundsTab
	:AddSlider("Volume_Slider", { Text = "Volume", Default = 5, Min = 0, Max = 10, Rounding = 0, Compact = true })
	:OnChanged(function(vol)
		SoundService.PlayerHitHeadshot.Volume = vol
	end)

PlayerHitsoundsTab
	:AddSlider("Pitch_Slider", { Text = "Pitch", Default = 1, Min = 0, Max = 2, Rounding = 1, Compact = true })
	:OnChanged(function(pich)
		SoundService.PlayerHitHeadshot.Pitch = pich
	end)
--
PlayerHitsoundsTab:AddToggle("Enabled_Toggle2", { Text = "Enabled", Default = false })

PlayerHitsoundsTab:AddDropdown(
	"Hit",
	{
		Values = {
			"Defualt Body Hit",
			"Neverlose",
			"Gamesense",
			"One",
			"Bell",
			"Rust",
			"TF2",
			"Slime",
			"Among Us",
			"Minecraft",
			"CS:GO",
			"Saber",
			"Baimware",
			"Osu",
			"TF2 Critical",
			"Bat",
			"Call of Duty",
			"Bubble",
			"Pick",
			"Pop",
			"Bruh",
			"Bamboo",
			"Crowbar",
			"Weeb",
			"Beep",
			"Bambi",
			"Stone",
			"Old Fatality",
			"Click",
			"Ding",
			"Snow",
			"Laser",
			"Mario",
			"Steve",
			"Snowdrake",
		},
		Default = 1,
		Multi = false,
		Text = "Body Hitsound:",
	}
)
Options.Hit:OnChanged(function()
	local soundId = sounds[Options.Hit.Value]
	game:GetService("SoundService").PlayerHit2.SoundId = soundId
end)

PlayerHitsoundsTab
	:AddSlider("Volume_Slider", { Text = "Volume", Default = 5, Min = 0, Max = 10, Rounding = 0, Compact = true })
	:OnChanged(function(vole)
		SoundService.PlayerHit2.Volume = vole
	end)

PlayerHitsoundsTab
	:AddSlider("Pitch_Slider", { Text = "Pitch", Default = 1, Min = 0, Max = 2, Rounding = 1, Compact = true })
	:OnChanged(function(piche)
		SoundService.PlayerHit2.Pitch = piche
	end)

--* Nature Hitsounds *--

NatureHitsoundsTab:AddToggle("Enabled_Toggle2", { Text = "Enabled", Default = false })

NatureHitsoundsTab:AddDropdown(
	"WoodHit",
	{
		Values = {
			"Defualt Wood Hit",
			"Neverlose",
			"Gamesense",
			"One",
			"Bell",
			"Rust",
			"TF2",
			"Slime",
			"Among Us",
			"Minecraft",
			"CS:GO",
			"Saber",
			"Baimware",
			"Osu",
			"TF2 Critical",
			"Bat",
			"Call of Duty",
			"Bubble",
			"Pick",
			"Pop",
			"Bruh",
			"Bamboo",
			"Crowbar",
			"Weeb",
			"Beep",
			"Bambi",
			"Stone",
			"Old Fatality",
			"Click",
			"Ding",
			"Snow",
			"Laser",
			"Mario",
			"Steve",
			"Snowdrake",
		},
		Default = 1,
		Multi = false,
		Text = "Wood Hitsound:",
	}
)
Options.WoodHit:OnChanged(function()
	local soundId = sounds[Options.WoodHit.Value]
	game:GetService("SoundService").WoodHit.SoundId = soundId
end)

NatureHitsoundsTab
	:AddSlider("Volume_Slider", { Text = "Volume", Default = 5, Min = 0, Max = 10, Rounding = 0, Compact = true })
	:OnChanged(function(vole)
		SoundService.WoodHit.Volume = vole
	end)

NatureHitsoundsTab
	:AddSlider("Pitch_Slider", { Text = "Pitch", Default = 1, Min = 0, Max = 2, Rounding = 1, Compact = true })
	:OnChanged(function(piche)
		SoundService.WoodHit.Pitch = piche
	end)
--
NatureHitsoundsTab:AddToggle("Enabled_Toggle1", { Text = "Enabled", Default = false })

NatureHitsoundsTab:AddDropdown(
	"RockHit",
	{
		Values = {
			"Defualt Rock Hit",
			"Neverlose",
			"Gamesense",
			"One",
			"Bell",
			"Rust",
			"TF2",
			"Slime",
			"Among Us",
			"Minecraft",
			"CS:GO",
			"Saber",
			"Baimware",
			"Osu",
			"TF2 Critical",
			"Bat",
			"Call of Duty",
			"Bubble",
			"Pick",
			"Pop",
			"Bruh",
			"Bamboo",
			"Crowbar",
			"Weeb",
			"Beep",
			"Bambi",
			"Stone",
			"Old Fatality",
			"Click",
			"Ding",
			"Snow",
			"Laser",
			"Mario",
			"Steve",
			"Snowdrake",
		},
		Default = 1,
		Multi = false,
		Text = "Rock Hitsound:",
	}
)
Options.RockHit:OnChanged(function()
	local soundId = sounds[Options.RockHit.Value]
	game:GetService("SoundService").RockHit.SoundId = soundId
end)

NatureHitsoundsTab
	:AddSlider("Volume_Slider", { Text = "Volume", Default = 5, Min = 0, Max = 10, Rounding = 0, Compact = true })
	:OnChanged(function(vol)
		SoundService.RockHit.Volume = vol
	end)

NatureHitsoundsTab
	:AddSlider("Pitch_Slider", { Text = "Pitch", Default = 1, Min = 0, Max = 2, Rounding = 1, Compact = true })
	:OnChanged(function(pich)
		SoundService.RockHit.Pitch = pich
	end)




local chatSpammerTab = MiscTab:AddLeftGroupbox('Chat Spammer')

local spammerToggle = false
local spammerMsg = 'Fluent.gg | Public'
local spammerTime = 3

chatSpammerTab:AddToggle('spammer_Toggle',{Text='Enabled',Default=false}):OnChanged(function(Value)
spammerToggle = Value
    task.spawn(function()
        while spammerToggle do task.wait(spammerTime)
        _Network.Send(_SendCodes.SEND_CHAT_MESSAGE, spammerMsg, "Global")
	end
end)
end)
chatSpammerTab:AddInput('spammer_Text',{Text='Spammer text',Default='Fluent.gg | Public',Finished = true}):OnChanged(function(Value)
    spammerMsg = Value
end)
chatSpammerTab:AddSlider('spammer_Delay', {Text='Spammer delay',Default=3,Min=1,Max=10,Rounding=0,Compact=false,Suffix="s"}):OnChanged(function(Value)
    spammerTime = Value
end)

local beforeNameText = 'get rekt'
local beforeDistanceText = 'i just got you from'
local afterDisText = 'Fluent.gg | Public'
local trashTalkToggle = false
local trashRNG = false
local userOrDisplay = 'Username'

local Chats = {
    ["Trash Talk"] = {"please uninstall this game or go to adopt me bro", "nice one bud", "maybe i should teach you how to actually play the game", "sit down dog", "soooo bad kid pls stop playing", "ur mom probably better than u lol"};
    ["Kid"] = {"my mommy said i can pway for five more minutes guys", "STOP ITTTT IM TELLING MY MOMMY", "pwease stop ur hurting muh feewings...", "my dad owns dis gaem, he'll ban u!!"};
    ["Noob"] = {"um guys, how do i play this game", "which button is it to shoot now", "please go easy on me guys, im new to this", "if u do not go easy on me, i will report u"};
    ["British"] = {"oh good day to u fam!", "splendid day we having bruv?", "fancy a cuppa?", "i'm chuffed to bits!", "britain: the land of embarrassment and breakfast.", "lets sip our tea shall we mate!", "OI BRUV LOOK AT WHAT YOU DID", "oh my days!"};
}

local trashTalkTabbox = MiscTab:AddRightTabbox()
local trashTalkTab = trashTalkTabbox:AddTab('Trash Talk')
local trashTalkSettingsTab = trashTalkTabbox:AddTab('Settings')
trashTalkTab:AddInput('b4_name_Text',{Text='Before Name Text',Default='get rekt',Finished = true}):OnChanged(function(Value)
    beforeNameText = Value
end)
trashTalkTab:AddInput('b4_distance_Text',{Text='Before Distance Text',Default='i just got you from',Finished = true}):OnChanged(function(Value)
    beforeDistanceText = Value
end)
trashTalkTab:AddInput('after_distance_Text',{Text='After Distance Text',Default='Fluent.gg | Public',Finished = true}):OnChanged(function(Value)
    afterDisText = Value
end)
trashTalkSettingsTab:AddToggle('talk_Toggle',{Text='Enabled',Default=false}):OnChanged(function(Value)
    trashTalkToggle = Value
end)
trashTalkSettingsTab:AddDropdown('nameOrDisplayName',
	{ Values = { "Username", "Displayname" }, Default = 1, Multi = false, Text = 'Type', Tooltip = nil, })
Options.AimTypeDrop:OnChanged(function()
	userOrDisplay = Options.nameOrDisplayName.Value
end)
trashTalkSettingsTab:AddButton({Text = 'Preview Trash Talk Text',
    Func = function()
        print(beforeNameText..' '..'NAME'..' '..beforeDistanceText..' '..'100m'..' '..afterDisText)
    end,
    DoubleClick = false,
    Tooltip = 'Open F9 to preview the text!'
})

game:GetService("LogService").MessageOut:Connect(function(message)
    local extractedName = message:match("->([%w_]+)")
    local initialHealth, finalHealth = message:match("(%-?%d+%.?%d*)%D*->(%-?%d+%.?%d*)hp")
    local studsValue = message:match("(%d+%.?%d*)s")

    if extractedName and initialHealth and finalHealth and studsValue and extractedName ~= game.Players.LocalPlayer.Name then
        local studsTaken = tonumber(studsValue)
        local displayName = game.Players[extractedName].DisplayName
        if tonumber(finalHealth) <= 0 and trashTalkToggle then
            if userOrDisplay == 'Username' then
            _Network.Send(_SendCodes.SEND_CHAT_MESSAGE, beforeNameText.." "..extractedName.." "..beforeDistanceText.." "..tonumber(studsValue).."m"..' '..afterDisText, "Global")
            else
            _Network.Send(_SendCodes.SEND_CHAT_MESSAGE, beforeNameText.." "..displayName.." "..beforeDistanceText.." "..tonumber(studsValue).."m"..' '..afterDisText, "Global")
            end
        end
    end
end)

function Functions:ToggleLeaves(Trans)
    for i,v in pairs(getrenv()._G.modules.Entity.List) do
        if v.typ == "Tree1" or v.typ == "Tree2" then
            v.model.Leaves.Transparency = Trans
        end
    end
end

game:GetService("Workspace").ChildAdded:Connect(function(child)
    if child:FindFirstChild("Leaves") then
		Functions:ToggleLeaves(1)
    end
end)

sethiddenproperty(game:GetService("Workspace").Terrain,"Decoration",false)
Functions:ToggleLeaves(1)

local noSway; noSway = hookfunction(getupvalues(getrenv()._G.modules.FPS.ToolControllers.RangedWeapon.PlayerFire)[1], function(...)
    arg = {...}
    if GunModsEnabled and noSwayTog == true then
    arg[2]['AimRecoil']['push'] = 0
    arg[2]['AimRecoil']['cameraX'] = 0
    arg[2]['AimRecoil']['cameraY'] = 0
    arg[2]['AimRecoil']['cameraXShake'] = 0
    --
    arg[2]['HipRecoil']['push'] = 0
    arg[2]['HipRecoil']['cameraX'] = 0
    arg[2]['HipRecoil']['cameraY'] = 0
    arg[2]['HipRecoil']['cameraXShake'] = 0
    return noSway(unpack(arg))
    else
    return noSway(...)
    end
end)
local noOffset; noOffset = hookfunction(getrenv()._G.modules.Camera.SetVMAimingOffset, function(...)
    arg = {...}
    if GunModsEnabled and noAimOffsetTog == true then
    return
    else
    return noOffset(...)
    end
end)
local HighFireRate; HighFireRate = hookfunction(getupvalues(getrenv()._G.modules.FPS.ToolControllers.RangedWeapon.PlayerFire)[1], function(...)
    arg = {...}
    if GunModsEnabled and firerateMultiTog == true then
	arg[2]['AttackCooldown'] = 0.11
    return HighFireRate(unpack(arg))
    else
    return HighFireRate(...)
    end
end)
local autoFire; autoFire = hookfunction(getupvalues(getrenv()._G.modules.FPS.ToolControllers.RangedWeapon.PlayerFire)[1], function(...)
    arg = {...}
    if GunModsEnabled and autoFireTypeTog == true then
    arg[2]['FireAction'] = autoFireType
    return autoFire(unpack(arg))
    else
    return autoFire(...)
    end
end)
local noEquipDelay; noEquipDelay = hookfunction(getupvalues(getrenv()._G.modules.FPS.ToolControllers.RangedWeapon.PlayerFire)[1], function(...)
    arg = {...}
    if GunModsEnabled and instaEquipTog == true then
    arg[2]['EquipTime'] = equipTime
    return noEquipDelay(unpack(arg))
    else
    return noEquipDelay(...)
    end
end)
local reloadDuringShoot; reloadDuringShoot = hookfunction(getupvalues(getrenv()._G.modules.FPS.ToolControllers.RangedWeapon.PlayerFire)[1], function(...)
    arg = {...}
    if GunModsEnabled and instaReloadTog == true then
    arg[2]['ReloadTime'] = reloadTime
    return reloadDuringShoot(unpack(arg))
    else
    return reloadDuringShoot(...)
    end
end)
local noSpread; noSpread = hookfunction(getupvalues(getrenv()._G.modules.FPS.ToolControllers.RangedWeapon.PlayerFire)[1], function(...)
    arg = {...}
    if GunModsEnabled and noSpreadTog == true then
    arg[2]['Accuracy'] = math.huge
    return noSpread(unpack(arg))
    else
    return noSpread(...)
    end
end)

local Tabs = {
    ['UI Settings'] = Window:AddTab('UI Settings')
}

playerNum = tonumber(#game.Players:GetPlayers())

game.Players.PlayerAdded:Connect(function()
    playerNum = tonumber(#game.Players:GetPlayers())
end)
game.Players.PlayerRemoving:Connect(function()
    playerNum = tonumber(#game.Players:GetPlayers())
end)

Library:SetWatermark('Fluent.gg | Public | '.. playerNum .. ' players')

Library.KeybindFrame.Visible = true;

Library:OnUnload(function()
    print('Unloaded!')
    for i,v in pairs(Toggles) do
    v:SetValue(false)
    Library:SetWatermarkVisibility(false)
    Library.Unloaded = true
    end
end)

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'LeftControl', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings() 
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
ThemeManager:SetFolder('Fluentgg')
SaveManager:SetFolder('Fluentgg/Configs')
SaveManager:BuildConfigSection(Tabs['UI Settings']) 
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()
