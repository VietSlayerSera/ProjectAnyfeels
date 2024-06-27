-- Verifica se o jogo está no lugar correto
if game.PlaceId == 3237168 then
    -- Carrega a biblioteca Orion
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

    -- Cria a janela principal usando Orion
    local Window = OrionLib:MakeWindow({
        Name = "Anyfeels Hub",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "OplScripts",
        IntroEnabled = false,
        Icon = "https://cdn.discordapp.com/attachments/1046940183733473372/1254799137681965189/e04b135ee5ded5ce13c76cf98ea7db9e.png?ex=667ace43&is=66797cc3&hm=fcb4ee9677dcb11b40f946922c56e8f9df39edebc1037de34ffff968adb5f74c&"
    })

    -- Cria a aba Uteis
    local UteisTab = Window:MakeTab({
        Name = "Uteis",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    -- Cria a seção dentro da aba Uteis
    local UteisSection = UteisTab:AddSection({
        Name = "Data Printer"
    })

    -- Adiciona um toggle na seção Uteis
    UteisSection:AddToggle({
        Name = "Enable Data Printer",
        Default = false,
        Callback = function(Value)
            _G.DataPrinterEnabled = Value
            if _G.DataPrinterEnabled then
                spawn(DataPrinter)
            end
        end
    })

    -- Cria a aba de Talentos
    local TalentsTab = Window:MakeTab({
        Name = "Talents",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    -- Cria a seção dentro da aba de Talentos
    local TalentsSection = TalentsTab:AddSection({
        Name = "melee"
    })

    -- Adiciona um botão na aba de Talentos
    TalentsTab:AddButton({
        Name = "Toggle GetAnyMelee",
        Callback = function()
            _G.GetAnyMelee = not _G.GetAnyMelee
            if _G.GetAnyMelee then
                spawn(GetAnyMelee)
            end
        end    
    })

    -- Cria a aba de Autos
    local AutosTab = Window:MakeTab({
        Name = "Autos",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    -- Cria a seção AutoHaki na aba de Autos
    local AutoHakiSection = AutosTab:AddSection({
        Name = "AutoHaki"
    })

    -- Adiciona um slider na seção AutoHaki
    AutoHakiSection:AddSlider({
        Name = "Affinity Level",
        Min = 1.0,
        Max = 2.0,
        Default = 1.0,
        Color = Color3.fromRGB(255,255,255),
        Increment = 0.1,
        ValueName = "Level",
        Callback = function(Value)
            _G.SliderValue = Value
            print("Slider Value:", Value)
        end    
    })

    -- Inicializa o OrionLib
    OrionLib:Init()
end
-- Função para atualizar melee
function GetAnyMelee()
    while _G.GetAnyMelee do
        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer
        local userID = localPlayer.UserId

        local function updateMeleeForUser(userID)
            local user = workspace.UserData:FindFirstChild("User_" .. userID)
            if user then
                user.UpdateMelee:FireServer("Seastone Cestus")
            else
                warn("Usuário com ID " .. userID .. " não encontrado.")
            end
        end

        updateMeleeForUser(userID)
        wait(1)  -- Adiciona um intervalo de espera para evitar loops infinitos sem pausas
    end
end

-- Valor inicial
_G.GetAnyMelee = true
spawn(GetAnyMelee)

-- Função para imprimir dados
function DataPrinter()
    while _G.DataPrinterEnabled do
        local player = game.Players.LocalPlayer
        local userData = game.Workspace.UserData:FindFirstChild("User_" .. player.UserId)
        if userData then
            local Data = userData.Data
            local output = "UserId: " .. player.UserId .. "\n" ..
                           "Name: " .. player.Name .. "\n" ..
                           "Beri: " .. Data.Cash.Value .. "\n" ..
                           "Bounty: " .. Data.Bounty.Value .. "\n" ..
                           "Compasses: " .. Data.CompassTokens.Value .. "\n" ..
                           "Gems: " .. Data.Gems.Value .. "\n" ..
                           "Kills: " .. Data.Kills.Value .. "\n" ..
                           "DF1: " .. Data.DevilFruit.Value .. "\n" ..
                           "DF2: " .. Data.DevilFruit2.Value .. "\n" ..
                           "StoredDF1: " .. Data.StoredDF1.Value .. "\n" ..
                           "StoredDF2: " .. Data.StoredDF2.Value .. "\n" ..
                           "StoredDF3: " .. Data.StoredDF3.Value .. "\n" ..
                           "StoredDF4: " .. Data.StoredDF4.Value .. "\n" ..
                           "StoredDF5: " .. Data.StoredDF5.Value .. "\n" ..
                           "StoredDF6: " .. Data.StoredDF6.Value .. "\n" ..
                           "StoredDF7: " .. Data.StoredDF7.Value .. "\n" ..
                           "StoredDF8: " .. Data.StoredDF8.Value .. "\n" ..
                           "StoredDF9: " .. Data.StoredDF9.Value .. "\n" ..
                           "StoredDF10: " .. Data.StoredDF10.Value .. "\n" ..
                           "StoredDF11: " .. Data.StoredDF11.Value .. "\n" ..
                           "StoredDF12: " .. Data.StoredDF12.Value
            print(output)
        else
            warn("User data not found for player: " .. player.Name)
            print("User data not found for player: " .. player.Name)
        end
        wait(5)  -- Intervalo de tempo entre impressões
    end
end

-- Valor inicial
_G.DataPrinterEnabled = false

-- Função para verificar e equipar frutas com aura
local function checkAndEquipFruitWithAura()
    for _, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v:FindFirstChild("DF_Script") then
            local Message = v.Data.Value
            local SplitMessage = string.split(Message, ",")
            local AuraValue = tonumber(SplitMessage[6])
            
            if AuraValue == 1 then
                game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(v)
                print("Fruta com aura equipada:", v.Name)
                
                -- Tentar armazenar a fruta em um dos locais de armazenamento
                for i = 1, 12 do
                    local storageName = "StoredDF" .. i
                    local storageEvent = workspace.UserData[game:GetService("Players").LocalPlayer.UserId]:FindFirstChild("StoredDFRequest")
                    
                    if storageEvent then
                        local success = storageEvent:InvokeServer(storageName)
                        if success then
                            print("Fruta armazenada em:", storageName)
                            break
                        end
                    end
                end
            end
        end
    end
end

-- Valor inicial
_G.CheckAndEquipFruitWithAuraEnabled = true

-- Valor inicial
local AuraThreshold = 1.0  -- Valor inicial da aura

-- Slider para controle do valor da aura
Tab:AddSlider({
    Name = "Aura Threshold",
    Min = 0,
    Max = 20,
    Default = 10,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Aura",
    Callback = function(Value)
        AuraThreshold = Value / 10  -- Converte o valor do slider para a escala de 0.1 a 2.0
    end
})

-- Função para verificar e equipar frutas com aura
local function checkAndEquipFruitWithAura()
    for _, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v:FindFirstChild("DF_Script") then
            local Message = v.Data.Value
            local SplitMessage = string.split(Message, ",")
            local AuraValue = tonumber(SplitMessage[6])
            
            if AuraValue >= AuraThreshold then
                game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(v)
                print("Fruta com aura equipada:", v.Name)
                
                -- Tentar armazenar a fruta em um dos locais de armazenamento
                for i = 1, 12 do
                    local storageName = "StoredDF" .. i
                    local storageEvent = workspace.UserData[game:GetService("Players").LocalPlayer.UserId]:FindFirstChild("StoredDFRequest")
                    
                    if storageEvent then
                        local success = storageEvent:InvokeServer(storageName)
                        if success then
                            print("Fruta armazenada em:", storageName)
                            break
                        end
                    end
                end
            end
        end
    end
end

-- Iniciar verificação de frutas com aura
_G.CheckAndEquipFruitWithAura = true

-- Loop para verificar continuamente e equipar frutas com aura
spawn(function()
    while _G.CheckAndEquipFruitWithAura do
        checkAndEquipFruitWithAura()
        wait(8)  -- Intervalo de verificação
    end
end)
