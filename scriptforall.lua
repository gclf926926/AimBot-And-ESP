-- Interface simples
local Gui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", Gui)
local Button = Instance.new("TextButton", Frame)

Gui.Name = "SnapGui"
Frame.Size = UDim2.new(0, 200, 0, 50)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0

Button.Size = UDim2.new(1, 0, 1, 0)
Button.Text = "Teste 1: OFF"
Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.SourceSansBold
Button.TextScaled = true

-- Variáveis
local enabled = false
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Função para pegar inimigo mais próximo
local function getNearestEnemy()
	local closest = nil
	local shortestDistance = math.huge
	local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position

	if not myPos then return nil end

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local enemyPos = player.Character.HumanoidRootPart.Position
			local distance = (enemyPos - myPos).Magnitude

			if distance < shortestDistance then
				shortestDistance = distance
				closest = player
			end
		end
	end

	return closest
end

-- Loop de snap instantâneo
RunService.RenderStepped:Connect(function()
	if enabled then
		local enemy = getNearestEnemy()
		if enemy and enemy.Character and enemy.Character:FindFirstChild("Head") then
			local camera = workspace.CurrentCamera
			camera.CFrame = CFrame.new(camera.CFrame.Position, enemy.Character.Head.Position)
		end
	end
end)

-- Botão ON/OFF
Button.MouseButton1Click:Connect(function()
	enabled = not enabled
	if enabled then
		Button.Text = "Teste 1: ON"
		Button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		Button.Text = "Teste 1: OFF"
		Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)
