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
            local Data = userData.Data
            print(player.UserId)
            print("Name:", player.Name)
            print("Beri:", Data.Cash.Value)
            print("Bounty:", Data.Bounty.Value)
            print("Compasses:", Data.CompassTokens.Value)
            print("Gems:", Data.Gems.Value)
            print("Kills:", Data.Kills.Value)
            print("DF1:", Data.DevilFruit.Value)
            print("DF2:", Data.DevilFruit2.Value)
            print("StoredDF1:", Data.StoredDF1.Value)
            print("StoredDF2:", Data.StoredDF2.Value)
            print("StoredDF3:", Data.StoredDF3.Value)
            print("StoredDF4:", Data.StoredDF4.Value)
            print("StoredDF5:", Data.StoredDF5.Value)
            print("StoredDF6:", Data.StoredDF6.Value)
            print("StoredDF7:", Data.StoredDF7.Value)
            print("StoredDF8:", Data.StoredDF8.Value)
            print("StoredDF9:", Data.StoredDF9.Value)
            print("StoredDF10:", Data.StoredDF10.Value)
            print("StoredDF11:", Data.StoredDF11.Value)
            print("StoredDF12:", Data.StoredDF12.Value)
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

    -- Adiciona um toggle na aba Uteis
    UteisTab:AddToggle({
        Name = "Data Printer",
        Default = false,
        Callback = function(Value)
            _G.DataPrinterEnabled = Value
            if _G.DataPrinterEnabled then
                spawn(DataPrinter)
            end
        end
    })

    -- Inicializa o OrionLib
    OrionLib:Init()
end
