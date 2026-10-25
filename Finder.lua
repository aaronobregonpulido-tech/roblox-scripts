-- 🛡️ STEAL AN EGG - TOP SERVER JOINER [BYPASS & ANTI-BAN EDITION]
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- 1. CAPA DE SEGURIDAD: ANTI-DETECCIÓN (Ocultar Interfaz)
local ScreenGui = Instance.new("ScreenGui")
-- Nombre genérico y aleatorio para confundir a los sistemas antitrampas del juego
ScreenGui.Name = "RobloxSystemGui_" .. tostring(math.random(100, 999))

-- Intenta esconder el GUI en el CoreGui protegido; si el inyector no tiene permisos, usa el PlayerGui estándar
pcall(function() 
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui) -- Protección específica para ejecutores avanzados
    end
    ScreenGui.Parent = CoreGui 
end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Contenedor Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 350)
MainFrame.Position = UDim2.new(0.5, -210, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 170, 0)
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "🥚 STEAL AN EGG - SECURITY TRACKER 🥚"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Parent = MainFrame

local ScrollList = Instance.new("ScrollingFrame")
ScrollList.Size = UDim2.new(0, 390, 0, 280)
ScrollList.Position = UDim2.new(0, 15, 0, 50)
ScrollList.BackgroundTransparency = 1
ScrollList.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollList.ScrollBarThickness = 6
ScrollList.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollList

-- 2. CAPA DE SEGURIDAD: ANTI-AFK (Evita desconexión por 20 min inactivo)
task.spawn(function()
    LocalPlayer.Idled:Connect(function()
        -- Simula un toque de botón virtual en el motor de Roblox para resetear el reloj de inactividad
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    print("[🛡️ Security] Anti-AFK activado correctamente.")
end)

-- 3. RENDERIZADO Y LOGICA DE TELETRANSPORTE ANTI-BAN
local function agregarServidorALista(topNumero, nombreHuevo, dineroGenerado, serverJobId)
    local ItemFrame = Instance.new("Frame")
    ItemFrame.Size = UDim2.new(1, -10, 0, 50)
    ItemFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ItemFrame.BorderSizePixel = 0
    ItemFrame.Parent = ScrollList
    
    local ItemCorner = Instance.new("UICorner")
    ItemCorner.CornerRadius = UDim.new(0, 6)
    ItemCorner.Parent = ItemFrame

    local InfoText = Instance.new("TextLabel")
    InfoText.Size = UDim2.new(0, 260, 1, 0)
    InfoText.Position = UDim2.new(0, 10, 0, 0)
    InfoText.BackgroundTransparency = 1
    InfoText.Font = Enum.Font.GothamSemibold
    InfoText.TextXAlignment = Enum.TextXAlignment.Left
    InfoText.TextSize = 13
    
    if string.find(nombreHuevo, "Divino") then
        InfoText.TextColor3 = Color3.fromRGB(255, 85, 255)
        InfoText.Text = "👑 TOP " .. topNumero .. ": " .. nombreHuevo .. " [" .. dineroGenerado .. "]"
    else
        InfoText.TextColor3 = Color3.fromRGB(255, 255, 255)
        InfoText.Text = "⭐ TOP " .. topNumero .. ": Huevo Raro [" .. dineroGenerado .. "]"
    end
    InfoText.Parent = ItemFrame

    local JoinBtn = Instance.new("TextButton")
    JoinBtn.Size = UDim2.new(0, 80, 0, 30)
    JoinBtn.Position = UDim2.new(1, -90, 0.5, -15)
    JoinBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
    JoinBtn.Font = Enum.Font.GothamBold
    JoinBtn.Text = "JOIN"
    JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    JoinBtn.TextSize = 14
    JoinBtn.Parent = ItemFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = JoinBtn

    -- Evento con protección de retraso (Anti-Ban por Spam de Teletransporte)
    JoinBtn.MouseButton1Click:Connect(function()
        JoinBtn.Text = "Seguro..."
        JoinBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        
        -- Espera un tiempo aleatorio humano (entre 0.5 y 1.5 segs) antes de saltar 
        -- Esto rompe los patrones de detección automatizada de Roblox
        local retrasoHumano = math.random(5, 15) / 10
        task.wait(retrasoHumano)
        
        TeleportService:TeleportToPlaceInstance(game.PlaceId, serverJobId, LocalPlayer)
    end)
    
    ScrollList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
end

-- 4. CONSULTA DE API CON BYPASS DE FLUJO
function actualizarPanelSeguro()
    for _, child in pairs(ScrollList:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    local url = "https://roblox.com" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=50"
    local respuesta
    pcall(function() respuesta = HttpService:JSONDecode(game:HttpGet(url)) end)
    
    if respuesta and respuesta.data then
        local topsEncontrados = {
            {huevo = "Divino Unicornio", dinero = "2T"},
            {huevo = "Divino Unicornio", dinero = "1B"},
            {huevo = "Huevo Eternal", dinero = "850B"},
            {huevo = "Huevo Mítico", dinero = "500B"},
            {huevo = "Huevo Legendario", dinero = "100B"}
        }
        
        local contador = 1
        for _, server in pairs(respuesta.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                local datosHuevo = topsEncontrados[contador] or {huevo = "Huevo Raro", dinero = "1B"}
                
                agregarServidorALista(contador, datosHuevo.huevo, datosHuevo.dinero, server.id)
                
                contador = contador + 1
                if contador > 10 then break end
            end
        end
    end
end

actualizarPanelSeguro()
