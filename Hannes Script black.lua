-- Create a new ScreenGui for the cheat menu
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HannesScript"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a modern and compact main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.2, 0, 0.4, 0)
mainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- Add a gradient to the background
local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
}
uiGradient.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0.15, 0)
titleBar.Text = "Hannes Script"
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 20
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local uiCornerTitle = Instance.new("UICorner")
uiCornerTitle.CornerRadius = UDim.new(0, 8)
uiCornerTitle.Parent = titleBar

-- Close button in the top-right corner
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.1, 0, 0.6, 0)
closeButton.Position = UDim2.new(0.9, -10, 0.2, 0)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar

local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0, 8)
closeButtonCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Make the GUI draggable
local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Scrollable area for cheat options
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 0.85, -10)
scrollFrame.Position = UDim2.new(0, 5, 0.15, 5)
scrollFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 4
scrollFrame.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = scrollFrame

-- Function to create modern cheat toggles
local function createToggle(name, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0.9, 0, 0.1, 0)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = scrollFrame

    local uiCornerToggle = Instance.new("UICorner")
    uiCornerToggle.CornerRadius = UDim.new(0, 8)
    uiCornerToggle.Parent = toggleFrame

    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
    toggleLabel.Position = UDim2.new(0.05, 0, 0, 0)
    toggleLabel.Text = name
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextSize = 16
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.Parent = toggleFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0.3, 0, 0.8, 0)
    toggleButton.Position = UDim2.new(0.65, 0, 0.1, 0)
    toggleButton.Text = "OFF"
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 14
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Parent = toggleFrame

    local uiCornerButton = Instance.new("UICorner")
    uiCornerButton.CornerRadius = UDim.new(0, 6)
    uiCornerButton.Parent = toggleButton

    toggleButton.MouseButton1Click:Connect(function()
        local isEnabled = toggleButton.Text == "OFF"
        toggleButton.Text = isEnabled and "ON" or "OFF"
        toggleButton.BackgroundColor3 = isEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        callback(isEnabled)
    end)
end

-- Function to create modern cheat buttons
local function createButton(name, callback)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(0.9, 0, 0.1, 0)
    buttonFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = scrollFrame

    local uiCornerButtonFrame = Instance.new("UICorner")
    uiCornerButtonFrame.CornerRadius = UDim.new(0, 8)
    uiCornerButtonFrame.Parent = buttonFrame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 1, -10)
    button.Position = UDim2.new(0, 5, 0, 5)
    button.Text = name
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = buttonFrame

    local uiCornerButton = Instance.new("UICorner")
    uiCornerButton.CornerRadius = UDim.new(0, 6)
    uiCornerButton.Parent = button

    button.MouseButton1Click:Connect(function()
        callback()
    end)
end

-- Cheat Features
createToggle("ESP", function(enabled)
    if enabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = player.Character
            end
        end
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                for _, child in pairs(player.Character:GetChildren()) do
                    if child:IsA("Highlight") then
                        child:Destroy()
                    end
                end
            end
        end
    end
end)

createToggle("Speed Hack", function(enabled)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    humanoid.WalkSpeed = enabled and 100 or 16
end)

createToggle("Noclip", function(enabled)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if enabled then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

createButton("Teleport to Random Player", function()
    local player = game.Players.LocalPlayer
    local otherPlayers = game.Players:GetPlayers()
    table.remove(otherPlayers, table.find(otherPlayers, player))

    if #otherPlayers > 0 then
        local targetPlayer = otherPlayers[math.random(1, #otherPlayers)]
        if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            player.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
        end
    end
end)