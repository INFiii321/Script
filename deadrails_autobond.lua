-- Dead Rails Auto Bond Collector (Teleport to Each Bond, Fullscreen GUI)

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.3
frame.Parent = gui

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 0.1, 0)
statusText.Position = UDim2.new(0, 0, 0.1, 0)
statusText.BackgroundTransparency = 1
statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
statusText.Font = Enum.Font.GothamBold
statusText.TextScaled = true
statusText.Text = "Script Starting..."
statusText.Parent = frame

local bondCounter = Instance.new("TextLabel")
bondCounter.Size = UDim2.new(1, 0, 0.1, 0)
bondCounter.Position = UDim2.new(0, 0, 0.2, 0)
bondCounter.BackgroundTransparency = 1
bondCounter.TextColor3 = Color3.fromRGB(0, 255, 127)
bondCounter.Font = Enum.Font.Gotham
bondCounter.TextScaled = true
bondCounter.Text = "Bonds Collected: 0"
bondCounter.Parent = frame

local collected = 0
statusText.Text = "Collecting Bonds..."

function getBondParts()
    local bonds = {}
    for _, bond in pairs(workspace:GetDescendants()) do
        if bond:IsA("Part") and bond.Name:lower():find("bond") then
            table.insert(bonds, bond)
        end
    end
    return bonds
end

function collectBonds()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    for _, bond in ipairs(getBondParts()) do
        if bond and bond.Parent then
            statusText.Text = "Collecting Bond at: " .. tostring(bond.Position)
            hrp.CFrame = CFrame.new(bond.Position + Vector3.new(0, 3, 0))
            task.wait(0.4)
            collected += 1
            bondCounter.Text = "Bonds Collected: " .. collected
        end
    end
end

while true do
    local bondsLeft = #getBondParts()
    if bondsLeft > 0 then
        collectBonds()
    else
        statusText.Text = "All Bonds Collected! Script Finished."
        break
    end
    task.wait(1)
end
