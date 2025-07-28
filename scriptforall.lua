-- Camera Snap para Delta Executor por ChatGPT 💜

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Variável de controle
local cameraSnapAtivo = false

-- Função para encontrar inimigo mais próximo
local function inimigoMaisProximo()
	local menorDist = math.huge
	local alvo = nil

	for _, jogador in pairs(Players:GetPlayers()) do
		if jogador ~= LocalPlayer and jogador.Character and jogador.Character:FindFirstChild("HumanoidRootPart") and jogador.Team ~= LocalPlayer.Team then
			local pos = jogador.Character.HumanoidRootPart.Position
			local dist = (LocalPlayer.Character.HumanoidRootPart.Position - pos).Magnitude

			if dist < menorDist then
				menorDist = dist
				alvo = jogador
			end
		end
	end

	return alvo
end

-- Loop do Snap
RunService.RenderStepped:Connect(function()
	if cameraSnapAtivo then
		local alvo = inimigoMaisProximo()
		if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
			workspace.CurrentCamera.CFrame = CFrame.new(
				workspace.CurrentCamera.CFrame.Position,
				alvo.Character.HumanoidRootPart.Position
			)
		end
	end
end)

-- Interface
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local BotaoSnap = Instance.new("TextButton", ScreenGui)

BotaoSnap.Size = UDim2.new(0, 150, 0, 50)
BotaoSnap.Position = UDim2.new(0, 20, 0, 100)
BotaoSnap.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
BotaoSnap.Text = "Teste 1: OFF"
BotaoSnap.TextColor3 = Color3.new(1, 1, 1)
BotaoSnap.TextScaled = true
BotaoSnap.Font = Enum.Font.SourceSansBold
BotaoSnap.BackgroundTransparency = 0.1
BotaoSnap.BorderSizePixel = 0
BotaoSnap.AutoButtonColor = false
BotaoSnap.Active = true

-- Lógica do botão
BotaoSnap.MouseButton1Click:Connect(function()
	cameraSnapAtivo = not cameraSnapAtivo

	if cameraSnapAtivo then
		BotaoSnap.Text = "Teste 1: ON"
		BotaoSnap.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		BotaoSnap.Text = "Teste 1: OFF"
		BotaoSnap.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)
