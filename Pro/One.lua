if not game:IsLoaded() then
    game.Loaded:Wait()
end

task.spawn(function()
    setfpscap(10)
    game:GetService("RunService"):Set3dRenderingEnabled(false)
end)

getgenv().DebugHook =
    "https://discord.com/api/webhooks/1133045969517289552/zy2qQyFdT4OHwBmMRXvkVs5tAs6s1Quphn0FfhmY86ZZL5UlPXG9WZ9ojBxBBPGbh6yz"
getgenv().MailHook =
    "https://discord.com/api/webhooks/1133046237243908206/tEn2aHTCVwzAytixWdaIFgHVhFGjcfiUKw8nGq0ZC6qOpg3PbAJ4gI5gC4F8cWHiUfHm"
getgenv().MailUsername = "Mayhem00E"
getgenv().SellHook =
    "https://discord.com/api/webhooks/1133046431620542504/IrfydeMp0v5lW5-s3uqmVPNdDLioHMneejaBrPA5gnzrOJYlpfSGMxUaaizceRuuhKHr"
getgenv().SnipeHook =
    "https://discord.com/api/webhooks/1133046540680822795/fnOMpVn6gAGMDsQ784IfDEwMqw0jJDXqvA4FDgkELf_4oPG66R-pUWWDoPxzFQjF5Shr"
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
        loadstring(game:HttpGet("https://raw.githubusercontent.com/miyuyumi/AutoConfig/main/Mobile/Scripts/Pro.lua"))()
        task.wait(60)
    until getgenv().LoadedAll == true
end)
