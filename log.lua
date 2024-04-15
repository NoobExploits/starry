-- log the person's username and send it over to my webhook
-- for obvious reasons, the webhook is hidden!

-- for safety, and privacy reasons, you're free to look through and analyze my logging code

local logger = {}

local req = (fluxus and fluxus.request) or request

local deviceType = game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows and "💻" or "📱"
local exe = identifyexecutor() 
local player = game.Players.LocalPlayer
local job = tostring(game.JobId)
local gameId = game.PlaceId
local plyID = player.UserId
local teleportStatement = "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. gameId .. ", '" .. job .. "', player)"
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local players = game:GetService("Players")
local http = game:GetService("HttpService")

if executor == nil then
    executor = "Unknown"
end

local localPlayer = players.LocalPlayer

local metadata = {
    ["username"] = localPlayer.Name,
    ["colors"] = {
        ["white"] = 0xFFFFF,
        ["green"] = 0x00FF00,
        ["blue"] = 0x1555E3,
        ["indigo"] = 0x2E2B5F,
        ["orange"] = 0xFF7F00,
        ["red"] = 0xFF0000,
        ["pink"] = 0xE325C7
    }
}

local function randomize()
    local colors = metadata.colors
    local names = {}

    for name,_ in pairs(colors) do
        table.insert(names, name)
    end

    local random = names[math.random(1, #names)]
    return colors[random]
end

logger.post = function(url)
    xpcall(function()
        req({
           Url = Webhook,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
            Body = game:GetService("HttpService"):JSONEncode({
        content = "",
        embeds = {
            {
                title = Title,
                description = "",
                type = "rich",
                color = Color,
                thumbnail = {
                    url = ThumbnailUrl
                },
                fields = {              
                    {
                        name = "𝐈𝐧𝐟𝐨𝐫𝐦𝐚𝐭𝐢𝐨𝐧:",
                        value = " 𝐏𝐥𝐚𝐲𝐞𝐫:\n〘👤〙**Username**: [" .. player.Name .. "](https://www.roblox.com/users/" .. player.UserId .. "/profile)\n〘🎲〙**Player ID:** " .. plyID .. "\n\n𝐆𝐚𝐦𝐞𝐬:\n〘🎮〙**Game**: [" .. gameName .. "](https://www.roblox.com/games/" .. gameId .. ")\n〘🎲〙Game ID: " .. gameId .. "\n\n 𝐌𝐢𝐬𝐜:\n〘🔧〙**Executor**: " .. exe .. "\n **〘❓〙Platform**: " .. deviceType .."\n\n 𝐄𝐱𝐞𝐜𝐮𝐭𝐢𝐨𝐧 𝐓𝐢𝐦𝐞 🕧\n ".. currentTime,
                        inline = true
                    },
                    {
                        name = FieldTitle,
                        value = FieldText,
                        inline = true
                    },
                    {
                        name = "𝐒𝐧𝐢𝐩𝐞 𝐏𝐥𝐚𝐲𝐞𝐫",
                        value = "```lua\n" .. teleportStatement .. "```",
                        inline = true
                    }
                },
                footer = {
                    text = FooterText,
                    icon_url = FooterUrl
                }
            }
        }
    })
})
    end, function(err)
        warn("💫 Starry Debugger: " .. err)
    end)
end

return logger
