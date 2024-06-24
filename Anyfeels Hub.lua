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
        IntroEnabled = false
        Icon = "https://cdn.discordapp.com/attachments/1046940183733473372/1254799137681965189/e04b135ee5ded5ce13c76cf98ea7db9e.png?ex=667ace43&is=66797cc3&hm=fcb4ee9677dcb11b40f946922c56e8f9df39edebc1037de34ffff968adb5f74c&"
    })
        --Valor
    _G.GetAnyMelee = true


    --função
    function GetAnyMelee()
        while GetAnyMelee == true then
            
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


    local TalentsTab = Window:MakeTab({
        Name = "Talents",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local Section = TalentsTab:AddSection({
        Name = "melee"

    })

    TalentsTab:AddToggle({
        Name = "This is a toggle!",
        Default = false,
        Callback = function(Value)
            print(Value)
        end    
    })
    

    OrionLib:Init()