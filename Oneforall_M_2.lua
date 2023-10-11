local LogService = game:GetService("LogService")
local teleportCount = 0
local function onMessageOut(message, messageType)
    if message:find("IsTeleporting") then
        teleportCount = teleportCount + 1
        if teleportCount == 5 then
            game:Shutdown()
        end
    end
end

LogService.MessageOut:Connect(onMessageOut)

task.spawn(function()
    task.wait(30)
    local license = false
    local client = false
    local history = LogService:GetLogHistory()
    for i, v in pairs(history) do
        if v.message:find("CoreGui.RobloxGui.Modules.LuaApp.Components.More.Licensing.useLicenseData:10") then
            license = true
        end
        if v.message:find("CLIENT | _L") then
            client = true
        end
    end
    if license and not client then
        game:Shutdown()
    end
end)

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
    "https://discord.com/api/webhooks/1144652210962190458/CkLRWpdlH_cfwJa4iScrx7tGSA0O-IIeQi-yZ2bOxaJllBxGxetUU_EdSycJCtvDFXZ9"
getgenv().SnipeHook =
    "https://discord.com/api/webhooks/1144652035539619972/Ne3IpQfe-gy2nD0a-psy-HjZe2qaGliG6UVH_rL8fV5Tj9CS5KUae3lcHnT7jmcDOy2e"
getgenv().LoadedAll = false
getgenv().Titanic =
    "https://discord.com/api/webhooks/1157148880123744306/Hjwv4eoUVEDV-yYoI_4DEXBFyKuBb3dB0y2lrEgRoRlW4qd4rViOxKh-9yg4VtTUg4pd"
getgenv().SendMail = true

local httpService = game:GetService("HttpService")
local promptOverlay = game.CoreGui.RobloxPromptGui.promptOverlay
local apiUrl = "https://meat-paris-jackson-damage.trycloudflare.com"

local function makeGetRequest(url)
    local response
    repeat
        local success, error = pcall(function()
            response = game:HttpGetAsync(url .. "1")
            response = httpService:JSONDecode(response)["jobID"]
        end)
        task.wait(10)
    until response ~= "" and success
    return response
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
        -- Webhook(url, {
        --     ["embeds"] = {{
        --         ["title"] = game:GetService("Players").LocalPlayer.Name .. " has been disconnected!",
        --         ["description"] = errorMessage,
        --         ["type"] = "rich",
        --         ["color"] = tonumber(0x7269da)
        --     }}
        -- })
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
        -- Webhook(url, {
        --     ["embeds"] = {{
        --         ["title"] = game:GetService("Players").LocalPlayer.Name .. " has been disconnected!",
        --         ["description"] = errorMessage,
        --         ["type"] = "rich",
        --         ["color"] = tonumber(0x7269da)
        --     }}
        -- })
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
        loadstring(game:HttpGet("https://raw.githubusercontent.com/miyuyumi/AutoConfig/main/Mobile/Scripts/All.lua"))()
        task.wait(60)
    until getgenv().LoadedAll == true
end)
