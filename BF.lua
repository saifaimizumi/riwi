--lyxme Hub
function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

spawn(function()
while wait() do
if AutoEquiped then
pcall(function()
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Weapon))
end)
end
end
end)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "lyxme Hub | BloxFruit ",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(510, 390),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "rbxassetid://11433532654" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "pluscircle" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "Notification",
        Content = "lyxme Hub running script",
        SubContent = "", -- Optional
        Duration = 10 -- Set to nil to make the notification not disappear
    })

end

local DropdownSelectWeapon = Tabs.Main:AddDropdown("DropdownSelectWeapon", {
        Title = "Select Weapon",
        Values = {'Melee','Sword','Blox Fruit'},
        Multi = false,
        Default = 1,
    })
    DropdownSelectWeapon:SetValue('Melee')
    DropdownSelectWeapon:OnChanged(function(Value)
        ChooseWeapon = Value
    end)
    task.spawn(function()
        while wait() do
            pcall(function()
                    if ChooseWeapon == "Melee" then
                        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ToolTip == "Melee" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                    SelectWeapon = v.Name
                                end
                            end
                        end
                    elseif ChooseWeapon == "Sword" then
                        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ToolTip == "Sword" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                    SelectWeapon = v.Name
                                end
                            end
                        end
                    elseif ChooseWeapon == "Blox Fruit" then
                        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ToolTip == "Blox Fruit" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                    SelectWeapon = v.Name
                                end
                            end
                        end
                    for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ToolTip == "Melee" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                    SelectWeapon = v.Name
                                end
                            end
                        end
                    end
                end)
        end
    end)
            
                                 

local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Auto Collect Playtime Rewards", Default = false })

Toggle:OnChanged(function(Value)
_G.Rewards = Value
if _G.Rewards then
     while _G.Rewards do wait()
          local args = {
               [1] = 1
           }
           
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayRewards"):FireServer(unpack(args))
          
          local args = {
               [1] = 2
           }
          
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayRewards"):FireServer(unpack(args))
          
          local args = {
               [1] = 3
           }
           
           game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayRewards"):FireServer(unpack(args))
           
          
           local args = {
               [1] = 4
           }
           
           game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayRewards"):FireServer(unpack(args))
           

           local args = {
               [1] = 5
           }
           
           game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayRewards"):FireServer(unpack(args))
           

           local args = {
               [1] = 6
           }
           
           game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayRewards"):FireServer(unpack(args))
          

           local args = {
               [1] = 7
           }
           
           game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayRewards"):FireServer(unpack(args))

     end
end
end)

Options.MyToggle:SetValue(false)




local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "AntiAFK", Default = false })

    Toggle:OnChanged(function(Value)
        _G.antiAFK = Value

        while _G.antiAFK do wait(20)
    
        game:GetService'VirtualUser':Button1Down(Vector2.new(788, 547))
        
    end
    end)

    Options.MyToggle:SetValue(false)





    Tabs.Settings:AddButton({
        Title = "Rejoin Server",
        Description = "",
        Callback = function()
            local ts = game:GetService("TeleportService")
    
            local p = game:GetService("Players").LocalPlayer
            
             
            
            ts:Teleport(game.PlaceId, p)
        end
    })
    
    Tabs.Settings:AddButton({
        Title = "Hop Server",
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
    Content = "The script has been loading",
    Duration = 5
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()

