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
                local output = {
                    "UserId: " .. player.UserId,
                    "Name: " .. player.Name,
                    "Beri: " .. Data.Cash.Value,
                    "Bounty: " .. Data.Bounty.Value,
                    "Compasses: " .. Data.CompassTokens.Value,
                    "Gems: " .. Data.Gems.Value,
                    "Kills: " .. Data.Kills.Value,
                    "DF1: " .. Data.DevilFruit.Value,
                    "DF2: " .. Data.DevilFruit2.Value,
                    "StoredDF1: " .. Data.StoredDF1.Value,
                    "StoredDF2: " .. Data.StoredDF2.Value,
                    "StoredDF3: " .. Data.StoredDF3.Value,
                    "StoredDF4: " .. Data.StoredDF4.Value,
                    "StoredDF5: " .. Data.StoredDF5.Value,
                    "StoredDF6: " .. Data.StoredDF6.Value,
                    "StoredDF7: " .. Data.StoredDF7.Value,
                    "StoredDF8: " .. Data.StoredDF8.Value,
                    "StoredDF9: " .. Data.StoredDF9.Value,
                    "StoredDF10: " .. Data.StoredDF10.Value,
                    "StoredDF11: " .. Data.StoredDF11.Value,
                    "StoredDF12: " .. Data.StoredDF12.Value
                }
                -- Atualiza a janela de output
                outputWindow:SetContent(table.concat(output, "\n"))
            else
                warn("User data not found for player: " .. player.Name)
                outputWindow:SetContent("User data not found for player: " .. player.Name)
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

    -- Cria a janela de output
    local outputWindow = OrionLib:MakeWindow({
        Name = "Data Printer Output",
        HidePremium = false,
        SaveConfig = false,
        ConfigFolder = "OutputWindow",
        IntroEnabled = false,
        IntroText = "Data Printer",
        Icon = "rbxassetid://4483345998"
    })

    -- Adiciona um toggle na seção Uteis
    UteisSection:AddToggle({
        Name = "Enable Data Printer",
        Default = false,
        Callback = function(Value)
            _G.DataPrinterEnabled = Value
            if _G.DataPrinterEnabled then
                outputWindow:Show()  -- Mostra a janela de output quando ativado
                spawn(DataPrinter)
            else
                outputWindow:Hide()  -- Esconde a janela de output quando desativado
            end
        end
    })

    -- Inicializa o OrionLib
    OrionLib:Init()
end
