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

    -- Cria a janela do console
    local ConsoleWindow = OrionLib:MakeWindow({
        Name = "Console",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "ConsoleOutput",
        IntroEnabled = false,
        Icon = "rbxassetid://4483345998"
    })

    -- Adiciona uma área de texto para exibir a saída
    local ConsoleTab = ConsoleWindow:MakeTab({
        Name = "Output",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local ConsoleSection = ConsoleTab:AddSection({
        Name = "Console Output"
    })

    local OutputBox = ConsoleSection:AddTextbox({
        Name = "Output",
        Default = "",
        TextDisappear = false,
        Callback = function() end
    })

    -- Função para atualizar a área de texto
    local function updateConsole(text)
        OutputBox:Set(text)
    end

    -- Valor
    _G.GetAnyMelee = true
    _G.DataPrinterEnabled = false

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
                updateConsole(output)
            else
                warn("User data not found for player: " .. player.Name)
                updateConsole("User data not found for player: " .. player.Name)
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
                ConsoleWindow:Show()  -- Mostra a janela do console quando ativado
                spawn(DataPrinter)
            else
                ConsoleWindow:Hide()  -- Esconde a janela do console quando desativado
            end
        end
    })

    -- Cria a aba de Autos
    local AutosTab = Window:MakeTab({
        Name = "Autos",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    -- Cria a seção dentro da aba de Autos para AutoHaki
    local AutoAffySection = AutosTab:AddSection({
        Name = "AutoAffy"
    })

    -- Adiciona um slider na seção AutoHaki
    AutoAffySection:AddSlider({
        Name = "Slider",
        Min = 0,
        Max = 20,
        Default = 10,  -- Valor inicial correspondente a 1.0 (10/10)
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,  -- Incremento de 1 para que cada unidade no slider corresponda a 0.1 na escala de 1.0 a 2.0
        ValueName = "x10",  -- Indicando que o valor será multiplicado por 0.1
        Callback = function(Value)
            local sliderValue = Value / 10  -- Converte o valor do slider para a escala de 1.0 a 2.0
            print("Slider value:", sliderValue)

            -- Script de auto Affy adaptado para usar o valor do slider
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

                        if (AffSniper1 >= sliderValue or AffSniper1 == 2) and
                           (AffSword1 >= sliderValue or AffSword1 == 2) and
                           (AffMelee1 >= sliderValue or AffMelee1 == 2) and
                           (AffDefense1 >= sliderValue or AffDefense1 == 2) then
                            script.Parent:Destroy()
                        end

                        if (AffSniper2 >= sliderValue or AffSniper2 == 2) and
                           (AffSword2 >= sliderValue or AffSword2 == 2) and
                           (AffMelee2 >= sliderValue or AffMelee2 == 2) and
                           (AffDefense2 >= sliderValue or AffDefense2 == 2) then
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

                        if AffDefense1 >= sliderValue then
                            args1[2] = 0/0
                        end

                        if AffMelee1 >= sliderValue then
                            args1[3] = 0/0
                        end

                        if AffSniper1 >= sliderValue then
                            args1[4] = 0/0
                        end

                        if AffSword1 >= sliderValue then
                            args1[5] = 0/0
                        end

                        if AffDefense2 >= sliderValue then
                            args2[2] = 0/0
                        end

                        if AffMelee2 >= sliderValue then
                            args2[3] = 0/0
                        end

                        if AffSniper2 >= sliderValue then
                            args2[4] = 0/0
                        end

                        if AffSword2 >= sliderValue then
                            args2[5] = 0/0
                        end

                        workspace:WaitForChild("Merchants"):WaitForChild("AffinityMerchant"):WaitForChild("Clickable"):WaitForChild("Retum"):FireServer(unpack(args1))
                        workspace:WaitForChild("Merchants"):WaitForChild("AffinityMerchant"):WaitForChild("Clickable"):WaitForChild("Retum"):FireServer(unpack(args2))
                    end
                end
            end
        end    
    })

    -- Cria a aba Extra
    local ExtraTab = Window:MakeTab({
        Name = "Extra",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    -- Cria a seção dentro da aba Extra para o script de varredura
    local ScanSection = ExtraTab:AddSection({
        Name = "Scanner"
    })

    -- Adiciona um botão para iniciar a varredura na seção Extra
    ScanSection:AddButton({
        Name = "Start Scan",
        Callback = function()
            print("Starting scan...")
            -- Coloque aqui a lógica para varredura de recursos ou o que for necessário
        end
    })

    -- Função de varredura que destaca tudo e traz a parte principal de muitos recursos
