local Starlight = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/starlight"))()  

local NebulaIcons = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/nebula-icon-library-loader"))()

local Window = Starlight:CreateWindow({
    Name = "verikoolhub",
    Subtitle = "v1.1",
    Icon = 123456789,

    LoadingSettings = {
        Title = "VeriKoolHub",
        Subtitle = "Welcome to VeriKoolHub",
    },

    FileSettings = {
        ConfigFolder = "KoolScript"
    },
})



local Starlight = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/starlight"))()  

local NebulaIcons = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/nebula-icon-library-loader"))()

local Window = Starlight:CreateWindow({
    Name = "verikoolhub",
    Subtitle = "v1.0",
    Icon = 123456789,

    LoadingSettings = {
        Title = "VeriKoolHub",
        Subtitle = "Welcome to VeriKoolHub",
    },

    FileSettings = {
        ConfigFolder = "KoolScript"
    },
})

local TabSection = Window:CreateTabSection("Tab Section")

local Tab = TabSection:CreateTab({
    Name = "Games",
    Icon = NebulaIcons:GetIcon('view_in_ar', 'Material'),
    Columns = 2,
}, "INDEX")

local Groupbox = Tab:CreateGroupbox({
    Name = "Groupbox",
    Column = 1,
}, "INDEX")

local Button = Groupbox:CreateButton({
    Name = "insane elevator",
    Icon = NebulaIcons:GetIcon('check', 'Material'),
    Tooltip = "This is A Tooltip!",
    Style = 1,
    Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/verikoolguy2/kool-script/refs/heads/main/insaneelevator.lua"))()
    end,
}, "INDEX")

local Button = Groupbox:CreateButton({
    Name = "Regular Button",
    Icon = NebulaIcons:GetIcon('check', 'Material'),
    Tooltip = "This is A Tooltip!",
    Style = 2,
    Callback = function()
         print("hi from Regular Button!")
    end,
}, "INDEX")

local Toggle = Groupbox:CreateToggle({
    Name = "Toggle",
    CurrentValue = false,
    Style = 1,
    Callback = function(Value)
        print("ToggleValue =", Value)
    end,
}, "INDEX")

local Checkbox = Groupbox:CreateToggle({
    Name = "Checkbox",
    CurrentValue = false,
    Style = 2,
    Callback = function(Value)
        print("Checkbox =", Value)
    end,
}, "INDEX")

local Slider = Groupbox:CreateSlider({
    Name = "Slider",
    Icon = NebulaIcons:GetIcon('bar-chart', 'Lucide'),
    Range = {0, 100},
    Increment = 1,
    Callback = function(v)
        print("Slider Val =", v)
    end,
}, "INDEX")


local Input = Groupbox:CreateInput({
    Name = "Dynamic Input",
    Icon = NebulaIcons:GetIcon('text-cursor-input', 'Lucide'),
    CurrentValue = "",
    PlaceholderText = "Placeholder Text",
    Callback = function(Text)
            print("Current Text =", Text)
    end,
}, "INDEX")


local Label = Groupbox:CreateButton({
    Name = "Label"
}, "INDEX")

local Paragraph = Groupbox:CreateParagraph({
    Name = "Paragraph",
    Content = [[Content of your paragraph goes here. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem. Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. 

    Also Supports Multi Lining
    ]]

}, "INDEX")

local KeyLabel = Groupbox:CreateButton({
    Name = "Keybind"
}, "INDEX")
local Bind = KeyLabel:AddBind({
    HoldToInteract = false,
    CurrentValue = "Q",
    Callback = function(v)
    print("Keybind =", v)
    end,
}, "INDEX")


local DLabel = Groupbox:CreateButton({
    Name = "Regular Dropdown"
}, "INDEX")
local Dropdown = DLabel:AddDropdown({
    Options = {"Option 1", "Option 2"},
    CurrentOptions = {"Option 1"},
    Callback = function(Options)
        print("Option =", Options)
    end,
}, "INDEX")


local PLabel = Groupbox:CreateButton({
    Name = "Player Dropdown"
}, "INDEX")

local PlayersDropdown = PLabel:CreateDropdown({
    Options = {},
    CurrentOptions = {},
    Special = 1, -- Optional flag if supported by the UI library
    Callback = function(Selected)
        print("Selected Player:", Selected)
    end,
}, "INDEX")


local TLabel = Groupbox:CreateButton({
    Name = "Team Dropdown"
}, "INDEX")

local Dropdown = TLabel:AddDropdown({
    Options = {},
    CurrentOptions = {},
    Callback = function(v)
        print("Team Selected:", v)
    end,
}, "INDEX")

TabSection:CreateCustomTab({
Name = "FE Scripts",
Icon = NebulaIcons:GetIcon('view_in_ar', 'Material'),
Page = object,
}, "INDEX")

local Groupbox = Tab:CreateGroupbox({
Name = "Groupbox 2",
Column = 1,
}, "INDEX")
local Button = Groupbox:CreateButton({
    Name = "FE Ragdoll R15 R6 [not in all games]",
    Icon = NebulaIcons:GetIcon('check', 'Material'),
    Tooltip = "This is A Tooltip!",
    Style = 1,
    Callback = function() loadstring(game:HttpGet(('https://raw.githubusercontent.com/verikoolguy2/kool-script/refs/heads/main/ragdoll.lua'),true))()
    end,
}, "INDEX")

Window:CreateHomeTab({
    -- Logic is done this way to not immediately rule out unknown executors.
    -- For example, if Delta is confirmed to break with your script, it can go in Unsupported.
    -- If users use Trigon but you don't have it/unsure whether it works, it can be left out and marked as a maybe

    SupportedExecutors = {}, 
    UnsupportedExecutors = {},

    DiscordInvite = "1234", -- The Discord Invite Link. Do Not Include discord.gg/ | Only Include the code.
    Backdrop = nil, -- A Custom Image to use for the backdrop. Set to 0 to use the Game's Thumbnail. Defaults To A Roblox Void. Set to a blank image to not use.  

    IconStyle = 1, -- 1 for solid, 2 for outline

    Changelog = {
        -- Pass Tables For Each Update
        
        {
            Title = "Example Update",
            Date = "25th october twentyfive",
            Description = "blablblablajana \n blabakjakd",
        },
        {
            Title = "Second Update!!",
            Date = "sometime after example update",
            Description = "",
        }  
    }
})

local TabSection = Window:CreateTabSection("Tab Section")

local Tab = TabSection:CreateTab({
    Name = "Games",
    Icon = NebulaIcons:GetIcon('view_in_ar', 'Material'),
    Columns = 2,
}, "INDEX")

local Groupbox = Tab:CreateGroupbox({
    Name = "Groupbox",
    Column = 1,
}, "INDEX")

local Button = Groupbox:CreateButton({
    Name = "insane elevator",
    Icon = NebulaIcons:GetIcon('check', 'Material'),
    Tooltip = "This is A Tooltip!",
    Style = 1,
    Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/verikoolguy2/kool-script/refs/heads/main/insaneelevator.lua"))()
    end,
}, "INDEX")

local Button = Groupbox:CreateButton({
    Name = "Regular Button",
    Icon = NebulaIcons:GetIcon('check', 'Material'),
    Tooltip = "This is A Tooltip!",
    Style = 2,
    Callback = function()
         print("hi from Regular Button!")
    end,
}, "INDEX")

local Toggle = Groupbox:CreateToggle({
    Name = "Toggle",
    CurrentValue = false,
    Style = 1,
    Callback = function(Value)
        print("ToggleValue =", Value)
    end,
}, "INDEX")

local Checkbox = Groupbox:CreateToggle({
    Name = "Checkbox",
    CurrentValue = false,
    Style = 2,
    Callback = function(Value)
        print("Checkbox =", Value)
    end,
}, "INDEX")

local Slider = Groupbox:CreateSlider({
    Name = "Slider",
    Icon = NebulaIcons:GetIcon('bar-chart', 'Lucide'),
    Range = {0, 100},
    Increment = 1,
    Callback = function(v)
        print("Slider Val =", v)
    end,
}, "INDEX")


local Input = Groupbox:CreateInput({
    Name = "Dynamic Input",
    Icon = NebulaIcons:GetIcon('text-cursor-input', 'Lucide'),
    CurrentValue = "",
    PlaceholderText = "Placeholder Text",
    Callback = function(Text)
            print("Current Text =", Text)
    end,
}, "INDEX")


local Label = Groupbox:CreateButton({
    Name = "Label"
}, "INDEX")

local Paragraph = Groupbox:CreateParagraph({
    Name = "Paragraph",
    Content = [[Content of your paragraph goes here. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem. Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. 

    Also Supports Multi Lining
    ]]

}, "INDEX")

local KeyLabel = Groupbox:CreateButton({
    Name = "Keybind"
}, "INDEX")
local Bind = KeyLabel:AddBind({
    HoldToInteract = false,
    CurrentValue = "Q",
    Callback = function(v)
    print("Keybind =", v)
    end,
}, "INDEX")


local DLabel = Groupbox:CreateButton({
    Name = "Regular Dropdown"
}, "INDEX")
local Dropdown = DLabel:AddDropdown({
    Options = {"Option 1", "Option 2"},
    CurrentOptions = {"Option 1"},
    Callback = function(Options)
        print("Option =", Options)
    end,
}, "INDEX")


local PLabel = Groupbox:CreateButton({
    Name = "Player Dropdown"
}, "INDEX")

local PlayersDropdown = PLabel:CreateDropdown({
    Options = {},
    CurrentOptions = {},
    Special = 1, -- Optional flag if supported by the UI library
    Callback = function(Selected)
        print("Selected Player:", Selected)
    end,
}, "INDEX")


local TLabel = Groupbox:CreateButton({
    Name = "Team Dropdown"
}, "INDEX")

local Dropdown = TLabel:AddDropdown({
    Options = {},
    CurrentOptions = {},
    Callback = function(v)
        print("Team Selected:", v)
    end,
}, "INDEX")

local TabSection = Window:CreateTabSection("Tab Section")

local Tab = TabSection:CreateTab({
    Name = "Tab",
    Icon = NebulaIcons:GetIcon('view_in_ar', 'Material'),
    Columns = 2,
}, "INDEX")

local Groupbox = Tab:CreateGroupbox({
    Name = "Groupbox",
    Column = 1,
}, "INDEX")

local Dialog = Window:PromptDialog({
    Name = "Header",
    Content = "Description",
    Type = 1,
    Actions = { 
        Primary = {
            Name = "Okay!",
            Icon = NebulaIcons:GetIcon("check", "Material"),
            Callback = function()

            end
        }, 
        {
            Name = "Cancel",
            Callback = function()

            end
        },
    }
})
