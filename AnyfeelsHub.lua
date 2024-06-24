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

    -- Inicializa o OrionLib
    OrionLib:Init()
end
