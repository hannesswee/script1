-- Cheat Menu with Enhanced GUI and Features
-- Colors: Dark Purple, Black, Gray, White

-- Create a new ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CheatMenu"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.25, 0, 0.35, 0)
mainFrame.Position = UDim2.new(0.2, 0, 0.7, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Dark Gray
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui

local mainFrameCorner = Instance.new("UICorner")
mainFrameCorner.CornerRadius = UDim.new(0, 12)
mainFrameCorner.Parent = mainFrame

-- Password Input
local passwordFrame = Instance.new("Frame")
passwordFrame.Size = UDim2.new(0.15, 0, 0.15, 0) -- Smaller size
passwordFrame.Position = UDim2.new(0.1, 0, 0.5, 0)
passwordFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
passwordFrame.BorderSizePixel = 0
passwordFrame.AnchorPoint = Vector2.new(0.5, 0.5)
passwordFrame.Parent = screenGui

local passwordFrameCorner = Instance.new("UICorner")
passwordFrameCorner.CornerRadius = UDim.new(0, 12)
passwordFrameCorner.Parent = passwordFrame

local passwordLabel = Instance.new("TextLabel")
passwordLabel.Size = UDim2.new(1, -20, 0.4, 0)
passwordLabel.Position = UDim2.new(0.5, 0, 0.2, 0)
passwordLabel.AnchorPoint = Vector2.new(0.5, 0.5)
passwordLabel.Text = "Enter Password"
passwordLabel.Font = Enum.Font.GothamBold
passwordLabel.TextSize = 20
passwordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
passwordLabel.BackgroundTransparency = 1
passwordLabel.Parent = passwordFrame

local passwordBox = Instance.new("TextBox")
passwordBox.Size = UDim2.new(1, -20, 0.4, 0)
passwordBox.Position = UDim2.new(0.5, 0, 0.7, 0)
passwordBox.AnchorPoint = Vector2.new(0.5, 0.5)
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextSize = 18
passwordBox.PlaceholderText = "Password"
passwordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
passwordBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
passwordBox.BorderSizePixel = 0
passwordBox.Parent = passwordFrame

local passwordBoxCorner = Instance.new("UICorner")
passwordBoxCorner.CornerRadius = UDim.new(0, 8)
passwordBoxCorner.Parent = passwordBox

-- Dragging functionality
local dragging, dragStart, startPos

passwordFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = passwordFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

passwordFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
		local delta = input.Position - dragStart
		passwordFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Password Validation
local correctPassword = "GOMORRON" -- Set your password here

passwordBox.FocusLost:Connect(function(enterPressed)
	if enterPressed and passwordBox.Text == correctPassword then
		passwordFrame:Destroy() -- Remove password frame upon success
		mainFrame.Visible = true -- Show the cheat menu
	else
		passwordBox.Text = "" -- Clear text for retry
		passwordLabel.Text = "Incorrect Password"
		passwordLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red text
		wait(1)
		passwordLabel.Text = "Enter Password"
		passwordLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Reset color
	end
end)

mainFrame.Visible = false -- Hide main frame initially

-- Title Bar
local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0.1, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Slightly lighter gray
titleBar.Text = "Hannes Cheat Menu"
titleBar.Font = Enum.Font.GothamBold
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255) -- White
titleBar.TextSize = 22
titleBar.Parent = mainFrame

local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 8)
titleBarCorner.Parent = titleBar

local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local isVisible = true -- Tracks if the GUI is visible

-- Function to fade in all elements of the GUI
local function fadeIn()
	mainFrame.Visible = true
	for _, element in pairs(mainFrame:GetDescendants()) do
		if element:IsA("GuiObject") then
			element.Visible = true
			local targetTransparency = element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") and 0 or 0
			local fadeTween = tweenService:Create(element, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				BackgroundTransparency = targetTransparency,
			})
			fadeTween:Play()

			-- Fade in text (TextTransparency) if applicable
			if element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") then
				local textFade = tweenService:Create(element, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					TextTransparency = 0,
				})
				textFade:Play()
			end
		end
	end

	-- Fade in the main frame
	local mainFrameFade = tweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0,
	})
	mainFrameFade:Play()
end

-- Function to fade out all elements of the GUI
local function fadeOut()
	for _, element in pairs(mainFrame:GetDescendants()) do
		if element:IsA("GuiObject") then
			local targetTransparency = element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") and 1 or 1
			local fadeTween = tweenService:Create(element, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				BackgroundTransparency = targetTransparency,
			})
			fadeTween:Play()

			-- Fade out text (TextTransparency) if applicable
			if element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") then
				local textFade = tweenService:Create(element, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					TextTransparency = 1,
				})
				textFade:Play()
			end
		end
	end

	-- Fade out the main frame
	local mainFrameFade = tweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 1,
	})
	mainFrameFade:Play()

	-- Set visibility to false after fade-out completes
	mainFrameFade.Completed:Connect(function()
		mainFrame.Visible = false
	end)
end

-- Toggle the GUI with the Insert key
userInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
		isVisible = not isVisible
		if isVisible then
			fadeIn()
		else
			fadeOut()
		end
	end
end)

-- Ensure the GUI starts with the correct visibility state
if not isVisible then
	for _, element in pairs(mainFrame:GetDescendants()) do
		if element:IsA("GuiObject") then
			element.Visible = false
			element.BackgroundTransparency = 1
			if element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") then
				element.TextTransparency = 1
			end
		end
	end
	mainFrame.BackgroundTransparency = 1
	mainFrame.Visible = false
end

-- Draggable GUI
local dragging, dragStart, startPos

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

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, -10, 0, 5)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- Dark Purple
closeButton.Parent = mainFrame

local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0, 8)
closeButtonCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Scroll Frame
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 0.85, -10)
scrollFrame.Position = UDim2.new(0, 10, 0.15, 10)
scrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark Gray
scrollFrame.BorderSizePixel = 0
scrollFrame.Parent = mainFrame

local scrollFrameCorner = Instance.new("UICorner")
scrollFrameCorner.CornerRadius = UDim.new(0, 8)
scrollFrameCorner.Parent = scrollFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = scrollFrame

-- Function to Create Toggles
local function createToggle(name, callback)
	local toggleFrame = Instance.new("Frame")
	toggleFrame.Size = UDim2.new(0.9, 0, 0.1, 0)
	toggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Medium Gray
	toggleFrame.BorderSizePixel = 0
	toggleFrame.Parent = scrollFrame

	local toggleFrameCorner = Instance.new("UICorner")
	toggleFrameCorner.CornerRadius = UDim.new(0, 8)
	toggleFrameCorner.Parent = toggleFrame

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
	toggleButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- Dark Purple
	toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggleButton.Parent = toggleFrame

	local toggleButtonCorner = Instance.new("UICorner")
	toggleButtonCorner.CornerRadius = UDim.new(0, 8)
	toggleButtonCorner.Parent = toggleButton

	toggleButton.MouseButton1Click:Connect(function()
		local isEnabled = toggleButton.Text == "OFF"
		toggleButton.Text = isEnabled and "ON" or "OFF"
		toggleButton.BackgroundColor3 = isEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(128, 0, 128)
		callback(isEnabled)
	end)
end

-- ESP Feature
createToggle("ESP", function(enabled)
	if enabled then
		for _, player in pairs(game.Players:GetPlayers()) do
			if player.Character and player ~= game.Players.LocalPlayer then
				local highlight = Instance.new("Highlight")
				highlight.FillColor = Color3.fromRGB(128, 0, 255) -- Purple
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

-- Fly Feature with Free Camera Movement (Space, Ctrl, WASD)
createToggle("Fly Mode", function(enabled)
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

	if enabled and humanoidRootPart then
		-- Create BodyVelocity and BodyGyro for flying
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(1e4, 1e4, 1e4) -- Limit max force
		bodyVelocity.Velocity = Vector3.zero -- Start stationary
		bodyVelocity.Parent = humanoidRootPart

		local bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(1e4, 1e4, 1e4)
		bodyGyro.P = 9e4 -- Keep rotation steady
		bodyGyro.CFrame = humanoidRootPart.CFrame
		bodyGyro.Parent = humanoidRootPart

		local userInputService = game:GetService("UserInputService")
		local runService = game:GetService("RunService")

		local flySpeed = 50 -- Default flying speed
		local moveDirection = Vector3.zero -- Initialize direction

		-- Update movement based on input and camera
		local function updateFlyMovement()
			moveDirection = Vector3.zero -- Reset direction every frame
			local camera = workspace.CurrentCamera -- Get the player's camera

			-- Check key inputs and calculate movement direction
			if userInputService:IsKeyDown(Enum.KeyCode.W) then
				moveDirection = moveDirection + camera.CFrame.LookVector
			end
			if userInputService:IsKeyDown(Enum.KeyCode.S) then
				moveDirection = moveDirection - camera.CFrame.LookVector
			end
			if userInputService:IsKeyDown(Enum.KeyCode.A) then
				moveDirection = moveDirection - camera.CFrame.RightVector
			end
			if userInputService:IsKeyDown(Enum.KeyCode.D) then
				moveDirection = moveDirection + camera.CFrame.RightVector
			end
			if userInputService:IsKeyDown(Enum.KeyCode.Space) then
				moveDirection = moveDirection + Vector3.new(0, 1, 0)
			end
			if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				moveDirection = moveDirection - Vector3.new(0, 1, 0)
			end

			-- Apply calculated movement and ensure it's smooth
			if moveDirection.Magnitude > 0 then
				bodyVelocity.Velocity = moveDirection.Unit * flySpeed
			else
				bodyVelocity.Velocity = Vector3.zero
			end

			-- Rotate the player to align with the camera's orientation
			bodyGyro.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + camera.CFrame.LookVector)
		end

		-- Run the movement updates each frame
		local flyConnection = runService.RenderStepped:Connect(updateFlyMovement)

		-- Clean up when Fly mode is disabled
		local function disableFly()
			flyConnection:Disconnect()
			bodyVelocity:Destroy()
			bodyGyro:Destroy()
		end

		-- Handle disabling Fly mode
		player.CharacterRemoving:Connect(function()
			disableFly()
		end)
	else
		-- Cleanup if Fly mode is toggled off
		if humanoidRootPart then
			if humanoidRootPart:FindFirstChild("BodyVelocity") then
				humanoidRootPart.BodyVelocity:Destroy()
			end
			if humanoidRootPart:FindFirstChild("BodyGyro") then
				humanoidRootPart.BodyGyro:Destroy()
			end
		end
	end
end)

-- Speed Boost Feature
createToggle("Speed Boost", function(enabled)
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChild("Humanoid")

	if humanoid then
		humanoid.WalkSpeed = enabled and 100 or 16
	end
end)

-- Infinite Jump
local infiniteJumpConnection

createToggle("Infinite Jump", function(enabled)
	local userInputService = game:GetService("UserInputService")
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChild("Humanoid")

	if enabled then
		infiniteJumpConnection = userInputService.JumpRequest:Connect(function()
			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)

		player.CharacterRemoving:Connect(function()
			if infiniteJumpConnection then
				infiniteJumpConnection:Disconnect()
				infiniteJumpConnection = nil
			end
		end)
	else
		-- Disconnect Infinite Jump when disabled
		if infiniteJumpConnection then
			infiniteJumpConnection:Disconnect()
			infiniteJumpConnection = nil
		end
	end
end)

-- Noclip
local noclipConnection

createToggle("Noclip", function(enabled)
	local runService = game:GetService("RunService")
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()

	if enabled then
		noclipConnection = runService.Stepped:Connect(function()
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
				end
			end
		end)

		player.CharacterRemoving:Connect(function()
			if noclipConnection then
				noclipConnection:Disconnect()
				noclipConnection = nil
			end
		end)
	else
		-- Disconnect Noclip when disabled
		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil
		end

		-- Re-enable collisions for all parts
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end
end)

-- Teleport Tool Feature
createToggle("Teleport Tool", function(enabled)
	local player = game.Players.LocalPlayer

	if enabled then
		-- Create the teleport tool
		local tool = Instance.new("Tool")
		tool.Name = "Teleport Tool"
		tool.RequiresHandle = false
		tool.Parent = player:WaitForChild("Backpack") -- Add the tool to the player's Backpack

		-- Tool activation behavior
		tool.Activated:Connect(function()
			local character = player.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart then
				-- Get the target position using the player's mouse
				local mouse = player:GetMouse()
				if mouse.Target then
					local targetPosition = mouse.Hit.Position
					humanoidRootPart.CFrame = CFrame.new(targetPosition)
				end
			else
				warn("HumanoidRootPart not found!")
			end
		end)

		-- Remove tool when disabled
		player.CharacterRemoving:Connect(function()
			if tool then
				tool:Destroy()
			end
		end)
	else
		-- Remove the teleport tool from the player's Backpack if it exists
		local backpack = player:FindFirstChild("Backpack")
		if backpack then
			for _, child in pairs(backpack:GetChildren()) do
				if child:IsA("Tool") and child.Name == "Teleport Tool" then
					child:Destroy()
				end
			end
		end
	end
end)

-- Close Button Cleanup
closeButton.MouseButton1Click:Connect(function()
	-- Disable ESP
	for _, player in pairs(game.Players:GetPlayers()) do
		if player.Character then
			for _, child in pairs(player.Character:GetChildren()) do
				if child:IsA("Highlight") then
					child:Destroy()
				end
			end
		end
	end

	-- Disable Infinite Jump
	if infiniteJumpConnection then
		infiniteJumpConnection:Disconnect()
		infiniteJumpConnection = nil
	end

	-- Disable Noclip
	if noclipConnection then
		noclipConnection:Disconnect()
		noclipConnection = nil
	end

	-- Re-enable collisions for all character parts (Noclip cleanup)
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = true
		end
	end

	-- Disable Fly Mode
	if character then
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			if humanoidRootPart:FindFirstChild("BodyVelocity") then
				humanoidRootPart.BodyVelocity:Destroy()
			end
			if humanoidRootPart:FindFirstChild("BodyGyro") then
				humanoidRootPart.BodyGyro:Destroy()
			end
		end
	end

	-- Disable Speed Boost
	local humanoid = character and character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 16 -- Reset to default speed
	end

	-- Destroy the GUI
	screenGui:Destroy()
end)