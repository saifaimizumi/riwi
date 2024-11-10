local args = {
    [1] = "100M"
}

game:GetService("ReplicatedStorage").events.runcode:FireServer(unpack(args))

local args = {
    [1] = "200K"
}

game:GetService("ReplicatedStorage").events.runcode:FireServer(unpack(args))

local args = {
    [1] = "FischFright2024"
}

game:GetService("ReplicatedStorage").events.runcode:FireServer(unpack(args))

local args = {
    [1] = "SorryForDowntime"
}

game:GetService("ReplicatedStorage").events.runcode:FireServer(unpack(args))

local args = {
    [1] = "Scubaaaa"
}

game:GetService("ReplicatedStorage").events.runcode:FireServer(unpack(args))            
            

    
-- Initial Loading Checks
repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer.Character
repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

-- Destroy existing UI instances
if _G.UIDestroy then
    _G.UIDestroy()
end

-- Create cleanup function
_G.UIDestroy = function()
    if Window then
        Window:Destroy()
    end
    
    -- Reset all values
    selectedPlayer = ""
    currentPlayerList = {}
    Options = {}
    autoShake = false
    if shakeConnection then
        shakeConnection:Disconnect()
    end
    autoShakeDelay = 0
    autoReel = false
    autoReelDelay = 0
    getgenv().giftloop = false
    getgenv().autoconfirm = false
end

-- Core Services
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGUI = Player:WaitForChild("PlayerGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character
local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
-- UI Loading
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()


-- Variables
local selectedPlayer = ""
local currentPlayerList = {}
local Options = {}
local autoShake = false
local shakeConnection = nil
local autoShakeDelay = 0
local autoReel = false
local autoReelDelay = 0
local AntiDrown = false
local Cast = false


-- Window Setup
local Window = Fluent:CreateWindow({
    Title = "[🐟] Fisch | lyxme Hub 11 November 2024",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Amethyst",
    MinimizeConfig = {
        Side = "Left",
        Position = UDim2.new(0, 0, 0.5, 0)
    },
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tabs
local Tabs = {
    Genaral = Window:AddTab({ Title = "Genaral", Icon = "home" }),
    Merchant = Window:AddTab({ Title = "Merchant", Icon = "shopping-cart" }),
    Gift = Window:AddTab({ Title = "Gift", Icon = "gift" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Window:SelectTab(Tabs.Main)

-- Auto Shake Function
local function handleButtonClick(button)
    if not button.Visible then return end
    
    GuiService.SelectedObject = button
    task.wait(autoShakeDelay)
    
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
end
--Cast
function Pidoras()
    spawn(function()
        while AutoCast do
            local player = game.Players.LocalPlayer
            local character = player.Character

            if character then
                local tool = character:FindFirstChildOfClass("Tool")

                if tool then
                    local hasBobber = tool:FindFirstChild("bobber")

                    if not hasBobber then
                        local castEvent = tool:FindFirstChild("events") and tool.events:FindFirstChild("cast")

                        if castEvent then
                            local Random = math.random() * (99 - 90) + 90
                            local FRandom = string.format("%.4f", Random)
                            print(FRandom)
                            
                            local Random2 = math.random(90, 99)
                            castEvent:FireServer(Random2)

                            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                humanoidRootPart.Anchored = false
                            end
                        end
                    end
                end
                task.wait(1)
            end
        end
    end)
end
--Freez Player
local initialPosition

function rememberPosition()
    spawn(function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")
 
        local initialCFrame = rootPart.CFrame
 
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = rootPart
 
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.D = 100
        bodyGyro.P = 10000
        bodyGyro.CFrame = initialCFrame
        bodyGyro.Parent = rootPart
 
        while AutoFreeze do
            rootPart.CFrame = initialCFrame
            task.wait(0.01)
        end
 
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
        if bodyGyro then
            bodyGyro:Destroy()
        end
    end)
end
function AutoSellz()
    spawn(function()
        while AutoSell do
            SellFishAndReturnAll()
            task.wait(AutoSellDelay)
        end
    end)
end
function Appraise()
    spawn(function()
        while AutoAppraiser do
            workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Appraiser"):WaitForChild("appraiser"):WaitForChild("appraise"):InvokeServer()
            task.wait(0.1)
        end
    end)
end

function SellFishAndReturnAll()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local currentPosition = rootPart.CFrame
    local sellPosition = CFrame.new(464, 151, 232)
    local wasAutoFreezeActive = false
    if AutoFreeze then
        wasAutoFreezeActive = true
        AutoFreeze = false
    end
    rootPart.CFrame = sellPosition
    task.wait(0.5)
    workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sellall"):InvokeServer()
    task.wait(3)

    rootPart.CFrame = currentPosition

    if wasAutoFreezeActive then
        AutoFreeze = true
        rememberPosition()
    end
end
function SellFishAndReturnOne()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local currentPosition = rootPart.CFrame
    local sellPosition = CFrame.new(464, 151, 232)
    local wasAutoFreezeActive = false
    if AutoFreeze then
        wasAutoFreezeActive = true
        AutoFreeze = false
    end
    rootPart.CFrame = sellPosition
    task.wait(0.5)
    workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sell"):InvokeServer()
    task.wait(3)

    rootPart.CFrame = currentPosition

    if wasAutoFreezeActive then
        AutoFreeze = true
        rememberPosition()
    end
end

do
-- Main Tab Elements
local autoShakeToggle = Tabs.Genaral:AddToggle("AutoShake", {
    Title = "Auto Shake",
    Default = false,
    Callback = function(Value)
        autoShake = Value
        
        if Value then
            PlayerGUI.ChildAdded:Connect(function(GUI)
                if GUI:IsA("ScreenGui") and GUI.Name == "shakeui" then
                    local safezone = GUI:WaitForChild("safezone", 5)
                    if safezone then
                        safezone.ChildAdded:Connect(function(child)
                            if child:IsA("ImageButton") and child.Name == "button" then
                                task.spawn(function()
                                    if autoShake then
                                        handleButtonClick(child)
                                    end
                                end)
                            end
                        end)
                    end
                end
            end)
        end
    end
})

--ist jetzt nicht die beste lösung aber ich bin dran
task.spawn(function()
    task.wait(0.1)

    local value = true
    autoShakeToggle.SetValue(value) -- Toggle it on
    print("AutoShake set to " .. tostring(value))

    task.wait(0.05)

    value = false
    autoShakeToggle.SetValue(value) -- Toggle it off
    print("AutoShake set to " .. tostring(value))
end)



--ist jetzt nicht die beste lösung aber ich bin dran
task.spawn(function()
    task.wait(0.1)

    local value = true
    autoShakeToggle.SetValue(value) -- Toggle it on
    print("AutoShake set to " .. tostring(value))

    task.wait(0.05)

    value = false
    autoShakeToggle.SetValue(value) -- Toggle it off
    print("AutoShake set to " .. tostring(value))
end)

Tabs.Genaral:AddToggle("AutoReel", {
    Title = "Auto Reel",
    Default = false,
    Callback = function(Value)
        autoReel = Value
        
        if Value then
            PlayerGUI.ChildAdded:Connect(function(GUI)
                if GUI:IsA("ScreenGui") and GUI.Name == "reel" then
                    if autoReel then
                        local reelEvent = ReplicatedStorage:WaitForChild("events"):WaitForChild("reelfinished")
                        if reelEvent then
                            repeat
                                task.wait(autoReelDelay)
                                reelEvent:FireServer(100, false)
                            until GUI == nil or not autoReel
                        end
                    end
                end
            end)
        end
    end
})

local section = Tabs.Genaral:AddSection("Crab Cage")
local AutoFreezeT = Tabs.Genaral:AddToggle("MyFreeze", {
        Title = "Freeze Position",
        Description = "Freezes player position and rotation",
        Default = false
    })
    AutoFreezeT:OnChanged(function()
        AutoFreeze = AutoFreezeT.Value
        if AutoFreeze then
            rememberPosition()
        end
    end)

    local AutoSellF = Tabs.Genaral:AddToggle("AutoSellF", {Title = "Auto Sell Fish", Default = false })
    AutoSellF:OnChanged(function()
        AutoSell = AutoSellF.Value
        AutoSellz()
    end)
    Tabs.Genaral:AddButton({
        Title = "Sell one fish",
        Description = "Need to hold fish",
        Callback = function()
            SellFishAndReturnOne()
        end
    })
    Tabs.Genaral:AddButton({
        Title = "Sell All fishs",
        Description = "Selling all fish anywhere!",
        Callback = function()
            Window:Dialog({
                Title = "You sure want sell all fish?",
                Content = "",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            SellFishAndReturnAll()
                            print("Fish Sold.")
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Pidr.")
                        end
                    }
                }
            })
        end
    })
-- Functions
local function UpdatePlayerList()
    local newPlayerList = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player then
            table.insert(newPlayerList, player.Name)
        end
    end
    currentPlayerList = newPlayerList
    if Options.PlayerSelect then
        Options.PlayerSelect:SetValues(newPlayerList)
    end
end

local function TradeEquipped()
    if selectedPlayer == "" then
        Fluent:Notify({
            Title = "Error",
            Content = "Select a player first!",
            Duration = 3
        })
        return
    end

    local targetPlayer = Players:FindFirstChild(selectedPlayer)
    if targetPlayer then
        local equippedTool = Player.Character:FindFirstChildWhichIsA("Tool")
        if equippedTool and equippedTool:FindFirstChild("offer") then
            equippedTool.offer:FireServer(targetPlayer)
        else
            Fluent:Notify({
                Title = "Error",
                Content = "Hold an item first!",
                Duration = 3
            })
        end
    end
end

local function GiftAll()
    if selectedPlayer == "" then
        Fluent:Notify({
            Title = "Error",
            Content = "Select a player first!",
            Duration = 3
        })
        getgenv().giftloop = false
        return
    end

    local targetPlayer = Players:FindFirstChild(selectedPlayer)
    if targetPlayer then
        while getgenv().giftloop do
            for _, item in pairs(Player.Backpack:GetChildren()) do
                if not getgenv().giftloop then break end
                if item:FindFirstChild("offer") then
                    Player.PlayerGui.hud.safezone.backpack.events.equip:FireServer(item)
                    wait(0.1)
                    item.offer:FireServer(targetPlayer)
                    wait(0.2)
                end
            end
            wait(0.5)
        end
    end
end

local function startAutoConfirm()
    PlayerGUI.hud.safezone.bodyannouncements.ChildAdded:Connect(function(child)
        if getgenv().autoconfirm and child:IsA("Frame") and child.Name == "offer" then
            local confirmButton = child:FindFirstChild("confirm")
            local shouldStop = false
            
            child.AncestryChanged:Connect(function(_, parent)
                if not parent then shouldStop = true end
            end)
            
            if confirmButton then
                confirmButton.AncestryChanged:Connect(function(_, parent)
                    if not parent then shouldStop = true end
                end)
                
                while not shouldStop and getgenv().autoconfirm do
                    if confirmButton.Visible then
                        local pos = confirmButton.AbsolutePosition
                        local size = confirmButton.AbsoluteSize
                        local x = pos.X + size.X / 2
                        local y = pos.Y + size.Y / 2 + 58
                        
                        VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, Player, 0)
                        VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, Player, 0)
                    end
                    task.wait(0.01)
                end
            end
        end
    end)
end

-- Gifting Tab Elements
Options.PlayerSelect = Tabs.Gift:AddDropdown("PlayerSelect", {
    Title = "Select Player",
    Values = {},
    Multi = false,
    Default = "",
    Callback = function(Value)
        selectedPlayer = Value
    end
})

Tabs.Gift:AddButton({
    Title = "Refresh Player List",
    Callback = UpdatePlayerList
})

Tabs.Gift:AddToggle("AutoGift", {
    Title = "Auto Gift All Items",
    Default = false,
    Callback = function(Value)
        getgenv().giftloop = Value
        if Value then
            spawn(GiftAll)
        end
    end
})

Tabs.Gift:AddButton({
    Title = "Gift Equipped Fish",
    Callback = TradeEquipped
})

Tabs.Gift:AddToggle("AutoConfirm", {
    Title = "Auto Confirm Gifts",
    Default = false,
    Callback = function(Value)
        getgenv().autoconfirm = Value
        if Value then
            startAutoConfirm()
        end
    end
})

-- Player Events
Players.PlayerAdded:Connect(function(player)
    if player ~= Player then
        table.insert(currentPlayerList, player.Name)
        Options.PlayerSelect:SetValues(currentPlayerList)
        Fluent:Notify({
            Title = "Player Joined",
            Content = player.Name .. " joined!",
            Duration = 3
        })
    end
end)

Players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(currentPlayerList) do
        if name == player.Name then
            table.remove(currentPlayerList, i)
            Options.PlayerSelect:SetValues(currentPlayerList)
            Fluent:Notify({
                Title = "Player Left",
                Content = player.Name .. " left!",
                Duration = 3
            })
            break
        end
    end
end)

-- Initial Setup
UpdatePlayerList()

Tabs.Settings:AddButton({
        Title = "rejoin server",
        Description = "",
        Callback = function()
            local ts = game:GetService("TeleportService")
    
            local p = game:GetService("Players").LocalPlayer
            
             
            
            ts:Teleport(game.PlaceId, p)
        end
    })
    
    Tabs.Settings:AddButton({
        Title = "Hop server",
        Description = "",
        Callback = function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
               local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
               return Http:JSONDecode(Raw)
            end
            
            local Server, Next; repeat
               local Servers = ListServers(Next)
               Server = Servers.data[1]
               Next = Servers.nextPageCursor
            until Server
            
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end
    })
    
    
    

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Notification",
    Content = "The script has been loaded.",
    Duration = 5
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
