
-- LocalScript (Full Ragdoll + Stumble + Fire Orbit + GUI)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")

--------------------------------------------------
-- STATE
--------------------------------------------------
local isLaying = false
local isRagdolled = false
local isStumbling = false
local ragdollStiffness = 5
local orbiting = false
local fullRagdollData = {}
local fireParts = {}
local stumbleConnections = {}

--------------------------------------------------
-- GUI ROOT
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- ALWAYS-ON RAGDOLL BUTTON
--------------------------------------------------
local ragdollAlwaysButton = Instance.new("TextButton")
ragdollAlwaysButton.Size = UDim2.new(0,48,0,48)
ragdollAlwaysButton.Position = UDim2.new(0,6,0,6)
ragdollAlwaysButton.Text = "🦴"
ragdollAlwaysButton.TextScaled = true
ragdollAlwaysButton.BackgroundColor3 = Color3.fromRGB(120,30,30)
ragdollAlwaysButton.TextColor3 = Color3.new(1,1,1)
ragdollAlwaysButton.BorderSizePixel = 0
ragdollAlwaysButton.Parent = gui

--------------------------------------------------
-- SHOW MENU (+)
--------------------------------------------------
local showMenuButton = Instance.new("TextButton")
showMenuButton.Size = UDim2.new(0,32,0,32)
showMenuButton.Position = UDim2.new(0,60,0,10)
showMenuButton.Text = "+"
showMenuButton.TextScaled = true
showMenuButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
showMenuButton.TextColor3 = Color3.new(1,1,1)
showMenuButton.BorderSizePixel = 0
showMenuButton.Visible = false
showMenuButton.Parent = gui

--------------------------------------------------
-- SCROLLABLE MENU
--------------------------------------------------
local menuFrame = Instance.new("ScrollingFrame")
menuFrame.Size = UDim2.new(0,190,0,380)
menuFrame.Position = UDim2.new(0,6,0,60)
menuFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
menuFrame.BackgroundTransparency = 0.15
menuFrame.BorderSizePixel = 0
menuFrame.ScrollBarThickness = 8
menuFrame.CanvasSize = UDim2.new(0,0,0,700)
menuFrame.Parent = gui

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0,8)
uiListLayout.Parent = menuFrame

--------------------------------------------------
-- HIDE MENU (-)
--------------------------------------------------
local hideMenuButton = Instance.new("TextButton")
hideMenuButton.Size = UDim2.new(0,32,0,32)
hideMenuButton.Position = UDim2.new(1,-36,0,4)
hideMenuButton.Text = "−"
hideMenuButton.TextScaled = true
hideMenuButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
hideMenuButton.TextColor3 = Color3.new(1,1,1)
hideMenuButton.BorderSizePixel = 0
hideMenuButton.Parent = menuFrame

--------------------------------------------------
-- BUTTON FACTORY
--------------------------------------------------
local function createButton(text)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -20, 0, 42)
	b.Text = text
	b.TextScaled = true
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.TextColor3 = Color3.new(1,1,1)
	b.BorderSizePixel = 0
	b.Parent = menuFrame
	return b
end

local layButton = createButton("Lay Down")
local backflipButton = createButton("Backflip")
local fireAuraButton = createButton("Fire Aura Orbit")
local stopAuraButton = createButton("Stop All Auras")
local ragdollFlingButton = createButton("Ragdoll Fling")
local resetButton = createButton("Reset")
local stumbleButton = createButton("Ragdoll Stumble") -- NEW

--------------------------------------------------
-- LAY / STAND
--------------------------------------------------
local function setLay(state)
	local char = player.Character
	if not char or isRagdolled then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if not hum or not root then return end

	if state then
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		hum.AutoRotate = false
		hum.WalkSpeed = 0
		hum.JumpPower = 0
		root.CFrame *= CFrame.Angles(math.rad(90),0,0)
	else
		hum.PlatformStand = false
		hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		hum.AutoRotate = true
		hum.WalkSpeed = 16
		hum.JumpPower = 50
	end
end

--------------------------------------------------
-- RAGDOLL FULL
--------------------------------------------------
local function ragdollOn(stumble)
	if isRagdolled then return end
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	hum.PlatformStand = true
	hum.AutoRotate = false
	hum:ChangeState(Enum.HumanoidStateType.Physics)

	fullRagdollData = {}
	for _,m in ipairs(char:GetDescendants()) do
		if m:IsA("Motor6D") then
			local a0 = Instance.new("Attachment", m.Part0)
			local a1 = Instance.new("Attachment", m.Part1)
			a0.CFrame = m.C0
			a1.CFrame = m.C1

			local s = Instance.new("BallSocketConstraint")
			s.Attachment0 = a0
			s.Attachment1 = a1
			s.LimitsEnabled = true
			s.UpperAngle = stumble and 40 or (25 + ragdollStiffness * 5)
			s.TwistLimitsEnabled = true
			s.TwistLowerAngle = stumble and -20 or -25
			s.TwistUpperAngle = stumble and 20 or 25
			s.MaxFrictionTorque = stumble and 1 or (ragdollStiffness * 3)
			s.Parent = m.Part0

			m.Enabled = false
			table.insert(fullRagdollData,{m,a0,a1,s})
		end
	end
	isRagdolled = true
	isStumbling = stumble or false
end

local function ragdollOff()
	if not isRagdolled then return end
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	for _,d in ipairs(fullRagdollData) do
		d[1].Enabled = true
		d[2]:Destroy()
		d[3]:Destroy()
		d[4]:Destroy()
	end
	fullRagdollData = {}
	hum.PlatformStand = false
	hum.AutoRotate = true
	hum:ChangeState(Enum.HumanoidStateType.GettingUp)
	isRagdolled = false
	isStumbling = false
end

--------------------------------------------------
-- RAGDOLL STUMBLE (WORKING)
--------------------------------------------------
local function ragdollStumbleOn()
	if isStumbling then return end
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	-- Keep movement active
	hum.PlatformStand = false
	hum.WalkSpeed = 16
	hum.JumpPower = 50

	-- Loosen limbs using BodyGyros
	stumbleConnections = {}
	for _, part in ipairs(char:GetChildren()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			local bg = Instance.new("BodyGyro")
			bg.D = 8
			bg.P = 2000
			bg.MaxTorque = Vector3.new(4000,4000,4000)
			bg.CFrame = part.CFrame
			bg.Parent = part
			table.insert(stumbleConnections, bg)
		end
	end

	-- Slight wobble
	local wobble = 0
	local conn
	conn = RunService.RenderStepped:Connect(function(delta)
		wobble = wobble + delta*5
		for i=1,#stumbleConnections do
			local bg = stumbleConnections[i]
			if bg.Parent then
				bg.CFrame = bg.Parent.CFrame * CFrame.Angles(math.sin(wobble)*0.2,0,math.sin(wobble*1.2)*0.2)
			end
		end
	end)
	table.insert(stumbleConnections, conn)

	isStumbling = true
end

local function ragdollStumbleOff()
	for _,v in ipairs(stumbleConnections) do
		if typeof(v) == "RBXScriptConnection" then
			v:Disconnect()
		elseif v:IsA("BodyGyro") then
			v:Destroy()
		end
	end
	stumbleConnections = {}
	isStumbling = false
end

--------------------------------------------------
-- BACKFLIP
--------------------------------------------------
local function backflip()
	if isRagdolled then return end
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local av = Instance.new("BodyAngularVelocity", root)
	av.AngularVelocity = Vector3.new(-12,0,0)
	av.MaxTorque = Vector3.new(1e5,0,0)
	local bv = Instance.new("BodyVelocity", root)
	bv.Velocity = Vector3.new(0,30,0)
	bv.MaxForce = Vector3.new(0,1e5,0)
	task.delay(0.5,function() av:Destroy() bv:Destroy() end)
end

--------------------------------------------------
-- FIRE ORBIT AURA
--------------------------------------------------
local function clearAuras()
	for _,f in ipairs(fireParts) do f:Destroy() end
	fireParts = {}
	orbiting = false
end

local function fireAuraOrbit()
	clearAuras()
	local char = player.Character
	if not char then return end
	orbiting = true
	local radius = 3
	local angle = 0
	local speed = math.rad(120)

	for _,v in ipairs(char:GetChildren()) do
		if v:IsA("BasePart") then
			local f = Instance.new("Fire", v)
			f.Size = 5
			f.Heat = 10
			table.insert(fireParts,f)
		end
	end

	task.spawn(function()
		while orbiting and player.Character do
			local root = player.Character:FindFirstChild("HumanoidRootPart")
			if root then
				angle = angle + speed * RunService.RenderStepped:Wait()
				local x = math.cos(angle)*radius
				local z = math.sin(angle)*radius
				for _,f in ipairs(fireParts) do
					if f.Parent and f.Parent:IsA("BasePart") then
						f.Position = f.Parent.Position + Vector3.new(x,2,z)
					end
				end
			end
		end
	end)
end

--------------------------------------------------
-- RAGDOLL FLING
--------------------------------------------------
local function ragdollFling()
	local char = player.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	ragdollOn()
	local bv = Instance.new("BodyVelocity", root)
	bv.Velocity = root.CFrame.LookVector*80 + Vector3.new(0,20,0)
	bv.MaxForce = Vector3.new(1e5,1e5,1e5)
	task.delay(0.5,function() bv:Destroy() end)
end

--------------------------------------------------
-- RESET PLAYER
--------------------------------------------------
local function resetPlayer()
	local char = player.Character
	if char then char:BreakJoints() end
end

--------------------------------------------------
-- MENU TOGGLE
--------------------------------------------------
hideMenuButton.Activated:Connect(function()
	menuFrame.Visible = false
	showMenuButton.Visible = true
end)

showMenuButton.Activated:Connect(function()
	menuFrame.Visible = true
	showMenuButton.Visible = false
end)

--------------------------------------------------
-- BUTTON CONNECTIONS
--------------------------------------------------
ragdollAlwaysButton.Activated:Connect(function()
	if isRagdolled then ragdollOff() else ragdollOn(false) end
end)

layButton.Activated:Connect(function()
	isLaying = not isLaying
	setLay(isLaying)
	layButton.Text = isLaying and "Stand Up" or "Lay Down"
end)

backflipButton.Activated:Connect(backflip)
fireAuraButton.Activated:Connect(function()
	clearAuras()
	fireAuraOrbit()
end)
stopAuraButton.Activated:Connect(clearAuras)
ragdollFlingButton.Activated:Connect(ragdollFling)
resetButton.Activated:Connect(resetPlayer)

stumbleButton.Activated:Connect(function()
	if isStumbling then
		ragdollStumbleOff()
	else
		ragdollStumbleOn()
	end
end)

--------------------------------------------------
-- RESET ON RESPAWN
--------------------------------------------------
player.CharacterAdded:Connect(function()
	isLaying = false
	isRagdolled = false
	isStumbling = false
	fullRagdollData = {}
	fireParts = {}
	stumbleConnections = {}
	orbiting = false
	menuFrame.Visible = true
	showMenuButton.Visible = false
end)
