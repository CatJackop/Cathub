-- CAT HUB | Fluent Red GUI-only
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "CAT HUB",
    SubTitle = "catjack.gg",
    TabWidth = 150,
    Size = UDim2.fromOffset(600, 470),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Discord = Window:AddTab({Title="Discord", Icon="message-circle"}),
    Player = Window:AddTab({Title="Player", Icon="user"}),
    Combat = Window:AddTab({Title="Combat", Icon="swords"}),
    ESP = Window:AddTab({Title="ESP", Icon="eye"}),
    Settings = Window:AddTab({Title="Settings", Icon="settings"})
}

Tabs.Discord:AddParagraph({Title="CAT HUB", Content="Discord: https://discord.gg/yuaWVkXFQH\nCredit: catjack.gg"})

Tabs.Player:AddToggle("AutoV3",{Title="Auto V3",Default=false})
Tabs.Player:AddToggle("AutoV4",{Title="Auto V4",Default=false})
Tabs.Player:AddSlider("WalkSpeed",{Title="Walking Speed",Default=16,Min=0,Max=100,Rounding=0})
Tabs.Player:AddSlider("JumpHeight",{Title="Jumping Height",Default=50,Min=0,Max=150,Rounding=0})
Tabs.Player:AddToggle("WalkOnWater",{Title="Walk on Water",Default=false})
Tabs.Player:AddToggle("Ragdoll",{Title="Ragdoll",Default=false})

Tabs.Combat:AddToggle("FastAttack",{Title="Fast Attack",Default=false})
Tabs.Combat:AddToggle("Aimbot",{Title="Aimbot",Default=false})
Tabs.Combat:AddToggle("CameraLock",{Title="Camera Lock",Default=false})
Tabs.Combat:AddToggle("FlashStepAimbot",{Title="Flash Step + Aimbot",Default=false})
Tabs.Combat:AddButton({Title="Tween to Player",Callback=function() end})
Tabs.Combat:AddButton({Title="Tween to Aimbot Target",Callback=function() end})

Tabs.ESP:AddToggle("PlayerName",{Title="Player Name",Default=false})
Tabs.ESP:AddToggle("Health",{Title="Health",Default=false})
Tabs.ESP:AddToggle("GreenHealthBar",{Title="Green Health Bar",Default=false})
Tabs.ESP:AddToggle("Distance",{Title="Distance",Default=false})
Tabs.ESP:AddToggle("GreenPlayerHighlight",{Title="Green Player Highlight",Default=false})
Tabs.ESP:AddToggle("RedTracer",{Title="Red Tracer",Default=false})
Tabs.ESP:AddSlider("TracerThickness",{Title="Tracer Thickness",Default=3,Min=1,Max=10,Rounding=0})
Tabs.ESP:AddToggle("PvPStatus",{Title="PvP Status",Default=false})

-- Settings: V3/V4 intentionally removed.
Tabs.Settings:AddSlider("UITransparency",{Title="UI Transparency",Default=0,Min=0,Max=1,Rounding=2})

Fluent:Notify({Title="CAT HUB",Content="Red Fluent GUI loaded.",Duration=4})


-- CAT HUB movable hide/show logo
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local LogoGui = Instance.new("ScreenGui")
LogoGui.Name = "CATHUB_HideShowLogo"
LogoGui.ResetOnSpawn = false
LogoGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    LogoGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
end)
if not LogoGui.Parent then
    LogoGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local LogoButton = Instance.new("ImageButton")
LogoButton.Name = "CAT_HUB_Logo"
LogoButton.Size = UDim2.fromOffset(58, 58)
LogoButton.Position = UDim2.new(0, 20, 0.5, -29)
LogoButton.BackgroundTransparency = 1
LogoButton.Image = "rbxassetid://126031329785796"
LogoButton.ScaleType = Enum.ScaleType.Fit
LogoButton.Active = true
LogoButton.ZIndex = 100
LogoButton.Parent = LogoGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(1, 0)
Corner.Parent = LogoButton

-- Make the logo movable on mouse/touch.
local dragging = false
local dragStart
local startPos
local moved = false

LogoButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        moved = false
        dragStart = input.Position
        startPos = LogoButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then return end

    local delta = input.Position - dragStart
    if math.abs(delta.X) > 4 or math.abs(delta.Y) > 4 then
        moved = true
    end

    LogoButton.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end)

LogoButton.Activated:Connect(function()
    if moved then
        moved = false
        return
    end

    -- Fluent's window has a minimize/toggle function in supported builds.
    local ok = pcall(function()
        Window:Minimize()
    end)

    -- Fallback for builds exposing the root GUI directly.
    if not ok then
        local root = Window.Root or Window.Main or Window.GUI
        if typeof(root) == "Instance" and root:IsA("GuiObject") then
            root.Visible = not root.Visible
        end
    end
end)
