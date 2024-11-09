
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
    autoShake = true
    if shakeConnection then
        shakeConnection:Disconnect()
    end
    autoShakeDelay = 0
    autoReel = true
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

-- UI Loading
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Variables
local selectedPlayer = ""
local currentPlayerList = {}
local Options = {}
local autoShake = true
local shakeConnection = nil
local autoShakeDelay = 0
local autoReel = true
local autoReelDelay = 0
local SpectatePlys = false
local SelectPly = false

-- Window Setup
local Window = Fluent:CreateWindow({
    Title = "[🐟]Fisch | 9 November 2024",
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
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Gifting = Window:AddTab({ Title = "Gifting", Icon = "gift" })
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

Tabs.Genaral:AddButton({
    Title = "Redeem All Code",
    Description = "",
    Callback = function()
        local args = {                
                [1] = "SorryForDowntime"
            }
            
            game:GetService("ReplicatedStorage").events.runcode:FireServer(unpack(args))

        local args = {
                [1] = "Scubaaaa"
            }
            
            game:GetService("ReplicatedStorage").events.runcode:FireServer(unpack(args))

        local args = {
                [1] = "FischFright2024"
            }

            game:GetService("ReplicatedStorage").events.runcode:FireServer(unpack(args))
    end
})

Options.PlayerSelect = Tabs.Player:AddDropdown("PlayerSelect", {
    Title = "Select Player",
    Values = {},
    Multi = false,
    Default = "",
    Callback = function(Value)
        selectedPlayer = Value
    end
})

Tabs.Player:AddButton({
    Title = "Teleport to Player",
    Description = "",
    Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[selectedPlayer].Character.HumanoidRootPart.CFrame
        end
    })

Tabs.Player:AddToggle("Spectate Player", {
    Title = "Spectate Player",
    Default = false,
    Callback = function(Value)
            SpectatePlys = Value
            local plr1 = game:GetService("Players").LocalPlayer.Character.Humanoid
            local plr2 = game:GetService("Players"):FindFirstChild(SelectPly)
            repeat wait(.1)
                game:GetService("Workspace").Camera.CameraSubject = game:GetService("Players"):FindFirstChild(SelectPly).Character.Humanoid
                until SpectatePlys == false
            game:GetService("Workspace").Camera.CameraSubject = game:GetService("Players").LocalPlayer.Character.Humanoid
        end

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
            Title = "Refresh Player",
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
                Title = "Equip Item",
                Content = "Hold an Item first!",
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
Options.PlayerSelect = Tabs.Gifting:AddDropdown("PlayerSelect", {
    Title = "Select Player",
    Values = {},
    Multi = false,
    Default = "",
    Callback = function(Value)
        selectedPlayer = Value
    end
})

Tabs.Gifting:AddButton({
    Title = "Refresh Player List",
    Callback = UpdatePlayerList
})

Tabs.Gifting:AddToggle("AutoGift", {
    Title = "Auto Gift All Items",
    Default = false,
    Callback = function(Value)
        getgenv().giftloop = Value
        if Value then
            spawn(GiftAll)
        end
    end
})

Tabs.Gifting:AddButton({
    Title = "Gift Equipped Fish",
    Callback = TradeEquipped
})

Tabs.Gifting:AddToggle("AutoConfirm", {
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
