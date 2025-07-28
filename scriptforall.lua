-- Interface Bonita e Simples
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ManinhoInterface"

-- Função pra criar botões facilmente
local function criarBotao(nome, cor, posY)
	local botao = Instance.new("TextButton")
	botao.Size = UDim2.new(0, 150, 0, 50)
	botao.Position = UDim2.new(0, 20, 0, posY)
	botao.BackgroundColor3 = cor
	botao.Text = nome
	botao.TextScaled = true
	botao.Font = Enum.Font.GothamBold
	botao.TextColor3 = Color3.new(1, 1, 1)
	botao.Parent = ScreenGui
	return botao
end

-- BOTÃO 1: Aimbot
local ToggleAimbot = criarBotao("Teste 1: OFF", Color3.fromRGB(255, 0, 0), 100)
local aimbotAtivado = false
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local mouse = localPlayer:GetMouse()

-- Função: Encontrar inimigo mais próximo dentro de 100 studs
local function inimigoMaisProximo()
	local maisProximo, menorDistancia = nil, 100  -- Distância aumentada para 100
	for _, player in pairs(players:GetPlayers()) do
		if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Team ~= localPlayer.Team then
			local distancia = (player.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
			if distancia < menorDistancia then
				menorDistancia = distancia
				maisProximo = player
			end
		end
	end
	return maisProximo
end

-- Funções de Aimbot
local aimbotLoop
local function ativarAimbot()
	aimbotLoop = runService.RenderStepped:Connect(function()
		local inimigo = inimigoMaisProximo()
		if inimigo and inimigo.Character and inimigo.Character:FindFirstChild("HumanoidRootPart") then
			mouse.TargetFilter = inimigo.Character
			local camera = workspace.CurrentCamera
			camera.CFrame = CFrame.new(camera.CFrame.Position, inimigo.Character.HumanoidRootPart.Position)
		end
	end)
end

local function desativarAimbot()
	if aimbotLoop then
		aimbotLoop:Disconnect()
		aimbotLoop = nil
	end
end

-- Evento Botão 1 (Aimbot)
ToggleAimbot.MouseButton1Click:Connect(function()
	aimbotAtivado = not aimbotAtivado
	if aimbotAtivado then
		ToggleAimbot.Text = "Teste 1: ON"
		ToggleAimbot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		ativarAimbot()
	else
		ToggleAimbot.Text = "Teste 1: OFF"
		ToggleAimbot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		desativarAimbot()
	end
end)
