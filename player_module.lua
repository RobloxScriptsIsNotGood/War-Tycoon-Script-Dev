-- Player Module
local PlayerModule = {}

-- Services
local Players = game:GetService("Players")
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
function PlayerModule:Initialize(Rayfield, PlayerTab)
    -- Create Speed Section
    local SpeedSection = PlayerTab:CreateSection("Speed")
    
    -- WalkSpeed Toggle
    local WalkSpeedToggle = PlayerTab:CreateToggle({
        Name = "Enable WalkSpeed",
        CurrentValue = false,
        Flag = "WalkSpeedToggle",
        Callback = function(Value)
            Settings.WalkSpeedEnabled = Value
            if Value then
                if humanoid then
                    humanoid.WalkSpeed = Settings.WalkSpeedValue
                end
                Rayfield:Notify({
                    Title = "WalkSpeed",
                    Content = "Enabled",
                    Duration = 3,
                    Image = "zap"
                })
            else
                if humanoid then
                    humanoid.WalkSpeed = 16
                end
                Rayfield:Notify({
                    Title = "WalkSpeed",
                    Content = "Disabled",
                    Duration = 3,
                    Image = "zap-off"
                })
            end
        end,
    })
    
    -- WalkSpeed Slider
    local WalkSpeedSlider = PlayerTab:CreateSlider({
        Name = "WalkSpeed Value",
        Range = {0, 100},
        Increment = 1,
        Suffix = "",
        CurrentValue = 16,
        Flag = "WalkSpeedSlider",
        Callback = function(Value)
            Settings.WalkSpeedValue = Value
            if Settings.WalkSpeedEnabled and humanoid then
                humanoid.WalkSpeed = Value
            end
        end,
    })
    
    -- JumpHeight Toggle
    local JumpHeightToggle = PlayerTab:CreateToggle({
        Name = "Enable JumpHeight",
        CurrentValue = false,
        Flag = "JumpHeightToggle",
        Callback = function(Value)
            Settings.JumpHeightEnabled = Value
            if Value then
                if humanoid then
                    humanoid.JumpHeight = Settings.JumpHeightValue
                end
                Rayfield:Notify({
                    Title = "JumpHeight",
                    Content = "Enabled",
                    Duration = 3,
                    Image = "arrow-up"
                })
            else
                if humanoid then
                    humanoid.JumpHeight = 50
                end
                Rayfield:Notify({
                    Title = "JumpHeight",
                    Content = "Disabled",
                    Duration = 3,
                    Image = "arrow-down"
                })
            end
        end,
    })
    
    -- JumpHeight Slider
    local JumpHeightSlider = PlayerTab:CreateSlider({
        Name = "JumpHeight Value",
        Range = {0, 100},
        Increment = 1,
        Suffix = "",
        CurrentValue = 50,
        Flag = "JumpHeightSlider",
        Callback = function(Value)
            Settings.JumpHeightValue = Value
            if Settings.JumpHeightEnabled and humanoid then
                humanoid.JumpHeight = Value
            end
        end,
    })
end

return PlayerModule
