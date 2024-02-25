local flu = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local functions = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/hello-n-bye/starry/master/modules/miscellaneous.lua", true))()

local push = (http and http.request) or http_request or (fluxus and fluxus.request) or request
local queue = (fluxus and fluxus.queueteleport) or queue_on_teleport

local queueEnabled = true

local players = game.Players

local localPlayer = players.LocalPlayer

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local rootPart = character.HumanoidRootPart or character:WaitForChild("HumanoidRootPart")
local humanoid = character.Humanoid or character:WaitForChild("Humanoid")

local presets = {
    ['walkspeed'] = humanoid.WalkSpeed,
    ['jumppower'] = humanoid.JumpPower,
}

local window = flu:CreateWindow({
    Title = "Starry 💫",
    SubTitle = "github.com/hello-n-bye/Starry",
    TabWidth = 160,
    Size = UDim2.fromOffset(625, 460 / 1.5),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local tabs = {
    intro = window:AddTab({
        Title = " Main",
        Icon = ""
    }),
    general = window:AddTab({
        Title = " Pets",
        Icon = "bone"
    }),
    farming = window:AddTab({
        Title = " Farming",
        Icon = "carrot"
    }),
    trading = window:AddTab({
        Title = " Trading",
        Icon = "paperclip"
    }),
    player = window:AddTab({
        Title = " Player",
        Icon = "baby"
    }),
    minigames = window:AddTab({
        Title = " Minigames",
        Icon = "gamepad"
    }),
}

function notify(head, content)
    window:Dialog({
        Title = head,
        Content = content,
        Buttons = {
            {
                Title = "Okay",
                Callback = function()
                    print("Confirmed.")
                end
            }
        }
    })
end

function clip(string)
	local board = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

	if (board) then
		board(string)
    else
		notify("Failed", "Your executor doesn't support clipboarding.")
	end
end

local Options = flu.Options

flu:Notify({
    Title = "Star The Repo ⭐",
    Content = "Like our open-sourced project? Give it a star over on Github.",
    SubContent = "github.com/hello-n-bye/Starry",
    Duration = 5
})

-- main tab

tabs.intro:AddParagraph({
    Title = "Source-code",
    Content = "Find us @ github.com/hello-n-bye/Starry"
})

tabs.intro:AddButton({
    Title = "Join Community",
    Description = "Be apart my community for my main project.",
    Callback = function()
        if (clip) then
            clip("https://discord.gg/dshMH6Edeu")
            notify("Modulus", "Copied invite to your clipboard")
        else
            notify("Modulus", "discord.gg/dshMH6Edeu")
        end
    end
})

tabs.intro:AddButton({
    Title = "Rejoin",
    Description = "Join the server you are in again.",
    Callback = function()
        if (queueEnabled) then
            queue('loadstring(game:HttpGet("https://raw.githubusercontent.com/hello-n-bye/starry/master/main.lua"))()')
        end

        game:GetService("TeleportService"):Teleport(game.PlaceId, localPlayer)
    end
})

local launch = tabs.intro:AddToggle("Auto Launch", {
    Title = "Launch on Rejoin",
    Default = true
})

launch:OnChanged(function(value)
    queueEnabled = value
end)

-- player mods

local speed = tabs.player:AddSlider("Walking Speed", {
    Title = "Walkspeed",
    Description = "Changes how fast you walk.",
    Default = presets.walkspeed,
    Min = 1,
    Max = 250,
    Rounding = 1,
    Callback = function(value)
        humanoid.WalkSpeed = value
    end
})

tabs.player:AddButton({
    Title = "Clear Speed",
    Description = "Changes your speed back to normal.",
    Callback = function()
        speed:SetValue(presets.walkspeed)
        humanoid.WalkSpeed = presets.walkspeed

        notify("Walkspeed Changed", "Congrats, you're normal again.")
    end
})

local jumppower = tabs.player:AddSlider("Jumping Power", {
    Title = "Jump-power",
    Description = "Changes how high you can jump.",
    Default = presets.jumppower,
    Min = 1,
    Max = 781.25,
    Rounding = 1,
    Callback = function(value)
        humanoid.JumpPower = value
    end
})

tabs.player:AddButton({
    Title = "Clear Jump-power",
    Description = "Changes your jumping power back to normal.",
    Callback = function()
        jumppower:SetValue(presets.jumppower)
        humanoid.JumpPower = presets.jumppower
        
        notify("Jump-power Changed", "Congrats, you're normal again.")
    end
})

local listed = {}
local function getPlayersList()
    for _,v in ipairs(players:GetPlayers()) do
        if (v.Name) ~= (localPlayer.Name) then
            table.insert(listed, v.Name)
        end
    end
end

getPlayersList()

local gotoPlayer = tabs.player:AddDropdown("Player TP", {
    Title = "Goto Player",
    Values = listed,
    Multi = false,
    Default = "Select One"
})

local spectate = tabs.player:AddDropdown("Spectate", {
    Title = "Spectate Player",
    Values = listed,
    Multi = false,
    Default = "Select One"
})

--[[

local core = game:GetService("CoreGui")
for _,v in ipairs(core:GetDescendants()) do
	if (v.ClassName) == "TextLabel" then
		if (v.Text) == "Spectate Player" then
			local newLabel = v.Parent.Parent.TextButton.TextLabel
            print(newLabel.Text, newLabel.Parent)
			newLabel.Text = "Select One"
		end

        functions.yield(0.15)
        if (v.Text) == (v.Text) == "Goto Player" then
			local newLabel = v.Parent.Parent.TextButton.TextLabel
            print(newLabel.Text, newLabel.Parent)
			newLabel.Text = "Select One"
        end
	end
end

]]

players.PlayerAdded:Connect(function(player)
    table.insert(listed, player.Name)
    gotoPlayer:SetValues(listed)
    spectate:SetValues(listed)
end)

players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(listed) do
        if (name) == (player.Name) then
            table.remove(listed, i)
            break
        end
    end
    gotoPlayer:SetValues(listed)
    spectate:SetValues(listed)
end)

gotoPlayer:OnChanged(function(player)
    if (player) ~= "Select One" then
        local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local rootPart = character.HumanoidRootPart or character:WaitForChild("HumanoidRootPart")
        local succ, err = xpcall(function()
            local newChar = players[player].Character or players[player].CharacterAdded:Wait()
            rootPart.CFrame = newChar.HumanoidRootPart.CFrame
            gotoPlayer:SetValue("Select One")
        end, function(error)
            notify("Couldn't Teleport", tostring(error))
        end)
    end
end)

spectate:OnChanged(function(player)
    if (player) ~= "Select One" then
        local camera = workspace.CurrentCamera
        local succ, err = xpcall(function()
            local newChar = players[player].Character or players[player].CharacterAdded:Wait()
            camera.CameraSubject = newChar
        end, function(error)
            notify("Couldn't Spectate", tostring(error))
        end)
    end
end)

local unspectate = tabs.player:AddButton({
    Title = "Unspectate",
    Description = "Lock your camera back on yourself.",
    Callback = function()
        local camera = workspace.CurrentCamera
        local newChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local succ, err = xpcall(function()
            camera.CameraSubject = newChar
        end, function(error)
            notify("Couldn't Stop Spectating", tostring(error))
        end)
    end
})

window:SelectTab(1)