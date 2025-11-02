-- Player Module
local PlayerModule = {}

-- Services
local Players = game:GetServices("Players")
local RunService = game:GetService("RunService")

-- Local Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Settings
local Settings = {
    WalkSpeedEnabled = false,
    WalkSpeedValue = 16,
    JumpHeightEnabled = false,
    JumpHeightValue = 50
}

-- Update character reference on respawn
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
end)

-- Apply WalkSpeed
local function ApplyWalkSpeed()
    if Settings.WalkSpeedEnabled and humanoid then
        humanoid.WalkSpeed = Settings.WalkSpeedValue
    end
end

-- Apply JumpHeight
local function ApplyJumpHeight()
    if Settings.JumpHeightEnabled and humanoid then
        humanoid.JumpHeight = Settings.JumpHeightValue
    end
end

-- Continuous update loop
RunService.Heartbeat:Connect(function()
    if humanoid then
        if Settings.WalkSpeedEnabled then
            humanoid.WalkSpeed = Settings.WalkSpeedValue
        end
        if Settings.JumpHeightEnabled then
            humanoid.JumpHeight = Settings.JumpHeightValue
        end
    end
end)

-- Initialize UI
function PlayerModule:Initialize(venyx, playerPage)
    local speedSection = playerPage:addSection("Speed")
    
    -- WalkSpeed Toggle
    speedSection:addToggle("Enable WalkSpeed", nil, function(value)
        Settings.WalkSpeedEnabled = value
        if value then
            ApplyWalkSpeed()
            venyx:Notify("WalkSpeed", "Enabled")
        else
            if humanoid then
                humanoid.WalkSpeed = 16 -- Reset to default
            end
            venyx:Notify("WalkSpeed", "Disabled")
        end
    end)
    
    -- WalkSpeed Slider
    speedSection:addSlider("WalkSpeed Value", 16, 0, 100, function(value)
        Settings.WalkSpeedValue = value
        if Settings.WalkSpeedEnabled then
            ApplyWalkSpeed()
        end
    end)
    
    -- JumpHeight Toggle
    speedSection:addToggle("Enable JumpHeight", nil, function(value)
        Settings.JumpHeightEnabled = value
        if value then
            ApplyJumpHeight()
            venyx:Notify("JumpHeight", "Enabled")
        else
            if humanoid then
                humanoid.JumpHeight = 50 -- Reset to default
            end
            venyx:Notify("JumpHeight", "Disabled")
        end
    end)
    
    -- JumpHeight Slider
    speedSection:addSlider("JumpHeight Value", 50, 0, 100, function(value)
        Settings.JumpHeightValue = value
        if Settings.JumpHeightEnabled then
            ApplyJumpHeight()
        end
    end)
end

return PlayerModule
