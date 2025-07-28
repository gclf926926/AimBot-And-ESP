-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Variável do estado do AimBot
local AimbotAtivo = false

-- Função: encontrar inimigo mais próximo (até 100 studs)
local function inimigoMaisProximo()
	local alvoMaisProximo = nil
	local menorDistancia = 100 -- distância máxima da mira

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local distancia = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if distancia < menorDistancia then
				menorDistancia = distancia
				alvoMaisProximo = player
			end
		end
	end

	return alvoMaisProximo
end

-- Loop de Aimbot
local function ativarAimbot()
	RunService.RenderStepped:Connect(function()
		if AimbotAtivo then
			local alvo = inimigoMaisProximo()
			if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
				local camera = workspace.CurrentCamera
				camera.CFrame = CFrame.new(camera.CFrame.Position, alvo.Character.HumanoidRootPart.Position)
			end
		end
	end)
end

-- Interface (botão para celular)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AimbotInterface"

local Botao = Instance.new("TextButton")
Botao.Size = UDim2.new(0, 150, 0, 50)
Botao.Position = UDim2.new(0, 20, 0, 100)
Botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Botao.Text = "Aimbot: OFF"
Botao.TextScaled = true
Botao.Font = Enum.Font.GothamBold
Botao.TextColor3 = Color3.new(1, 1, 1)
Botao.Parent = ScreenGui

-- Ação do botão
Botao.MouseButton1Click:Connect(function()
	AimbotAtivo = not AimbotAtivo

	if AimbotAtivo then
		Botao.Text = "Aimbot: ON"
		Botao.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		Botao.Text = "Aimbot: OFF"
		Botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

-- Começa o loop (fica esperando o botão ativar)
ativarAimbot()
