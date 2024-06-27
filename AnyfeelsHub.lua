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

    -- Valor
    _G.GetAnyMelee = true
    _G.DataPrinterEnabled = false
    _G.SliderValue = 1.0

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

    -- Inicia a função GetAnyMelee
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
            end
            wait(5)  -- Intervalo de tempo entre impressões
        end
    end

    -- Cria a aba de talentos
    local TalentsTab = Window:MakeTab({
        Name = "Talents",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    -- Cria a seção dentro da aba de talentos
    local Section = TalentsTab:AddSection({
        Name = "melee"
    })

    -- Adiciona um botão na aba de talentos
    TalentsTab:AddButton({
        Name = "Button!",
        Callback = function()
            print("button pressed")
            _G.GetAnyMelee = not _G.GetAnyMelee  -- Alterna o valor de _G.GetAnyMelee quando o botão é pressionado
            if _G.GetAnyMelee then
                spawn(GetAnyMelee)  -- Reinicia a função se o botão for pressionado e _G.GetAnyMelee for verdadeiro
            end
        end    
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
    -- Obter serviços necessários
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    -- Função para verificar a presença de aura em uma fruta e equipá-la se a aura estiver presente
    local function checkAndEquipFruitWithAura()
        -- Obtém o jogador local
        local player = Players.LocalPlayer
        local backpack = player.Backpack

        -- Itera sobre todos os itens na mochila
        for _, item in pairs(backpack:GetChildren()) do
            -- Verifica se o item possui o script "DF_Script"
            if item:FindFirstChild("DF_Script") then
                -- Obtém a mensagem de dados da fruta
                local message = item.Data.Value
                -- Divide a mensagem em partes
                local splitMessage = string.split(message, ",")
                -- Obtém o valor da aura (6º elemento da mensagem)
                local auraValue = tonumber(splitMessage[6])
                
                -- Verifica se a aura está presente e é igual a 1
                if auraValue == 1 then
                    -- Equipa a fruta se a aura estiver presente
                    player.Character.Humanoid:EquipTool(item)
                    print("Fruta com aura equipada:", item.Name)

                    -- Tentar armazenar a fruta em um dos locais de armazenamento
                    for i = 1, 12 do
                        local storageName = "StoredDF" .. i
                        local storageEvent = workspace.UserData[player.UserId]:FindFirstChild("StoredDFRequest")
                        
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

    -- Função para simular a resposta do servidor (somente para teste)
    -- Remova esta função em um ambiente de produção real
    local function mockServerResponse()
        return true -- Simula sempre sucesso
    end

    -- Conectar a função de simulação de resposta do servidor (somente para teste)
    workspace.UserData[Players.LocalPlayer.UserId].StoredDFRequest.OnServerInvoke = mockServerResponse

    -- Chama a função para verificar e equipar a fruta
    checkAndEquipFruitWithAura()

    -- Mensagem inicial
    print("Verificação de aura nas frutas na mochila iniciada.")
-- Cria a aba Autos
local AutosTab = Window:MakeTab({
    Name = "Autos",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Cria a seção AutoHaki dentro da aba Autos
local AutoHakiSection = AutosTab:AddSection({
    Name = "AutoHaki"
})

-- Adiciona um slider na seção AutoHaki
AutoHakiSection:AddSlider({
    Name = "Affinity Threshold",
    Min = 1.0,
    Max = 2.0,
    Default = 1.0,
    Color = Color3.fromRGB(255,255,255),
    Increment = 0.1,
    ValueName = "affinity",
    Callback = function(Value)
        _G.SliderValue = Value
    end    
})

-- Função para ajustar a afinidade
while wait(8) do
    local player = game.Players.LocalPlayer
    if player then
        local playerId = player.UserId
        local userDataName = game.Workspace.UserData["User_" .. playerId]
        if userDataName and userDataName.Data then
            -- DFT1 Variables
            local AffMelee1 = userDataName.Data.DFT1Melee.Value
            local AffSniper1 = userDataName.Data.DFT1Sniper.Value
            local AffDefense1 = userDataName.Data.DFT1Defense.Value
            local AffSword1 = userDataName.Data.DFT1Sword.Value
            
            -- DFT2 Variables
            local AffMelee2 = userDataName.Data.DFT2Melee.Value
            local AffSniper2 = userDataName.Data.DFT2Sniper.Value
            local AffDefense2 = userDataName.Data.DFT2Defense.Value
            local AffSword2 = userDataName.Data.DFT2Sword.Value

            if (AffSniper1 == 2 or AffSniper1 >= _G.SliderValue) and
               (AffSword1 == 2 or AffSword1 >= _G.SliderValue) and
               (AffMelee1 == 2 or AffMelee1 >= _G.SliderValue) and
               (AffDefense1 == 2 or AffDefense1 >= _G.SliderValue) then
                script.Parent:Destroy()
            end

            if (AffSniper2 == 2 or AffSniper2 >= _G.SliderValue) and
               (AffSword2 == 2 or AffSword2 >= _G.SliderValue) and
               (AffMelee2 == 2 or AffMelee2 >= _G.SliderValue) and
               (AffDefense2 == 2 or AffDefense2 >= _G.SliderValue) then
                script.Parent:Destroy()
            end

            local args1 = {
                [1] = "DFT1",
                [2] = false,  -- defense
                [3] = false,  -- melee
                [4] = false,  -- sniper
                [5] = false,  -- sword
                [6] = "Gems"
            }

            local args2 = {
                [1] = "DFT2",
                [2] = false,  -- defense
                [3] = false,  -- melee
                [4] = false,  -- sniper
                [5] = false,  -- sword
                [6] = "Gems"
            }

            if AffDefense1 == 2 or AffDefense1 >= _G.SliderValue then
                args1[2] = 0/0
            end

            if AffMelee1 == 2 or AffMelee1 >= _G.SliderValue then
                args1[3] = 0/0
            end

            if AffSniper1 == 2 or AffSniper1 >= _G.SliderValue then
                args1[4] = 0/0
            end

            if AffSword1 == 2 or AffSword1 >= _G.SliderValue then
                args1[5] = 0/0
            end

            if AffDefense2 == 2 or AffDefense2 >= _G.SliderValue then
                args2[2] = 0/0
            end

            if AffMelee2 == 2 or AffMelee2 >= _G.SliderValue then
                args2[3] = 0/0
            end

            if AffSniper2 == 2 or AffSniper2 >= _G.SliderValue then
                args2[4] = 0/0
            end

            if AffSword2 == 2 or AffSword2 >= _G.SliderValue then
                args2[5] = 0/0
            end

            workspace:WaitForChild("Merchants"):WaitForChild("AffinityMerchant"):WaitForChild("Clickable"):WaitForChild("Retum"):FireServer(unpack(args1))
            workspace:WaitForChild("Merchants"):WaitForChild("AffinityMerchant"):WaitForChild("Clickable"):WaitForChild("Retum"):FireServer(unpack(args2))
        end
    end
end
