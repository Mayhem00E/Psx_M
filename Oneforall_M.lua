if not game:IsLoaded() then
    game.Loaded:Wait()
end

task.spawn(function()
    setfpscap(10)
    game:GetService("RunService"):Set3dRenderingEnabled(false)
end)

getgenv().DebugHook =
    "https://discord.com/api/webhooks/1101508002328105114/zFmIhMppmlQmj21EcIzs9Kv_S4evu7k4Em7k5G-Vy9SBEO-rNSrDR61kxP9n2xUFVlLN"
getgenv().MailHook =
    "https://discord.com/api/webhooks/1085929183487725588/phOL2IzRzkf7wwZI33Ng3bVG6JqBfuksEB0hah3VVqLRIzyNZIsz0R-1FekvevqS9SWy"
getgenv().MailUsername = "Mayhem00E"
getgenv().SellHook =
    "https://discord.com/api/webhooks/1087767388902133850/EPwgwO3ERE6Tivrw2S7YTU8XX5NAFc0cw12IcMusT1vbD0Mhm6zxAjODMn5pEWmQSz6U"
getgenv().SnipeHook =
    "https://discord.com/api/webhooks/1087767285688709163/ZYboDxOJV1jZVR-OHsdGQ4KqASjEgs1lXnrFvHcASabc6_dzkcMgsYCgvOTT_QdeVxuN"
getgenv().LoadedAll = false

local httpService = game:GetService("HttpService")
local promptOverlay = game.CoreGui.RobloxPromptGui.promptOverlay
local apiUrl = "https://functioning-install-isa-larry.trycloudflare.com/servers"

local function makeGetRequest(url)
    local response
    repeat
        response = game:HttpGetAsync(url)
    until response ~= ""
    return httpService:JSONDecode(response)["jobID"]
end

function Webhook(Url, Data)
    task.spawn(function()
        request {
            Url = Url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode(Data)
        }
    end)

end

sendError = function()
    local errorMessage = promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage.Text
    url = getgenv().DebugHook

    if string.match(errorMessage, "unexpected client behavior") or string.match(errorMessage, "Please rejoin%.") then
        Webhook(url, {
            ["content"] = "@everyone",
            ["embeds"] = {{
                ["title"] = game:GetService("Players").LocalPlayer.Name .. " has been disconnected!",
                ["description"] = errorMessage,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da)
            }}
        })

    elseif string.match(errorMessage, "[SAVING]") or string.match(errorMessage, "Saving failed") then
        Webhook(url, {
            ["embeds"] = {{
                ["title"] = game:GetService("Players").LocalPlayer.Name .. " has been disconnected!",
                ["description"] = errorMessage,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da)
            }}
        })
        task.wait(300)
        local getResponse = makeGetRequest(apiUrl)
        game:GetService("TeleportService"):TeleportToPlaceInstance(7722306047, getResponse, game.Players.LocalPlayer)
    elseif string.match(errorMessage, "Teleport failed") then
        Webhook(url, {
            ["embeds"] = {{
                ["title"] = game:GetService("Players").LocalPlayer.Name .. " has been disconnected!",
                ["description"] = errorMessage,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da)
            }}
        })
        promptOverlay:Destroy()
        local getResponse = makeGetRequest(apiUrl)
        game:GetService("TeleportService"):TeleportToPlaceInstance(7722306047, getResponse, game.Players.LocalPlayer)
    elseif string.match(errorMessage, "Reconnect was unsuccessful") then
        Webhook(url, {
            ["embeds"] = {{
                ["title"] = game:GetService("Players").LocalPlayer.Name .. " has been disconnected!",
                ["description"] = errorMessage,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da)
            }}
        })
        game:Shutdown()
    else
        Webhook(url, {
            ["embeds"] = {{
                ["title"] = game:GetService("Players").LocalPlayer.Name .. " has been disconnected!",
                ["description"] = errorMessage,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da)
            }}
        })
        if game.PlaceId ~= 7722306047 then
            local getResponse = makeGetRequest(apiUrl)
            game:GetService("TeleportService")
                :TeleportToPlaceInstance(7722306047, getResponse, game.Players.LocalPlayer)
        else
            game:GetService("TeleportService"):Teleport(6284583030)
        end

    end
end

task.spawn(function()
    promptOverlay.ChildAdded:connect(function(V)
        if V.Name == 'ErrorPrompt' then
            repeat
                Overlay = promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage.Text
                if Overlay ~= "Label" then
                    if Overlay:find("unexpected client behavior") or Overlay:find("Please rejoin%.") then
                        sendError()
                        game:Shutdown()
                    else
                        sendError()
                    end
                end
                task.wait(5)
            until false
        end
    end)
end)

task.spawn(function()
    repeat
        loadstring(game:HttpGet("https://raw.githubusercontent.com/miyuyumi/AutoConfig/main/Mobile/Scripts/All.lua"))()
        task.wait(60)
    until getgenv().LoadedAll == true
end)
