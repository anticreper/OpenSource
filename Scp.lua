local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

function Init()
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
end

function Test()
    print(Fluent.Options)
end

Init()
Test()

local Window = Fluent:CreateWindow({
    Title = "승리재단 스크립트",
    SubTitle = "by anticreeper",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

Fluent:Notify({
        Title = "로드됨",
        Content = "스크립트가 성공적으로 로드 되었어요!",
        Duration = 2 -- Set to nil to make the notification not disappear
})

local MainTab = Window:AddTab({ Title = "Main", Icon = "home" })
local SpawnsTab = Window:AddTab({ Title = "Spawns", Icon = "map-pin" })
local KillsTab = Window:AddTab({ Title = "Kill", Icon = "sword" })

local MainSection = MainTab:AddSection("Main Functions")
local SpawnsSection = SpawnsTab:AddSection("Spawns Teleport")
local KillsSection = KillsTab:AddSection("Kiil Functions")

MainTab:AddButton({
    Title = "안티치트 우회(사일런트 에임 관련)",
    Description = "먼저 실행부터 해주세요(안해도 상관은 없음)",
        Callback = function()
            task.spawn(function()
                for k, v in pairs(getgc(true)) do
                    if pcall(function() return rawget(v, "indexInstance") end) 
                        and type(rawget(v, "indexInstance")) == "table" 
                        and rawget(v, "indexInstance")[1] == "kick" then
                        setreadonly(v, false)
                    v.tvk = { "kick", function() return game.Workspace:WaitForChild("") end }
                end
            end
        end)
    end
})

MainSection:AddButton({
    Title = "안티치트 우회(총관련)",
    Description = "PlayerScripts 안 빈 이름 스크립트 제거",
    Callback = function()
        local playerScripts = game.Players.LocalPlayer:FindFirstChild("PlayerScripts")
        if playerScripts then
            local deleted = false

            for _, obj in pairs(playerScripts:GetChildren()) do
                if obj.Name == "" then  -- 빈 이름 체크
                    obj:Destroy()
                    deleted = true
                end
            end

            if deleted then
                Fluent:Notify({ 
                    Title = "삭제 완료", 
                    Content = "빈 이름 스크립트가 제거되었습니다!", 
                    Duration = 5 
                })
            else
                Fluent:Notify({ 
                    Title = "검사 결과", 
                    Content = "빈 이름 스크립트가 발견되지 않았습니다.", 
                    Duration = 5 
                })
            end

        else
            Fluent:Notify({ 
                Title = "오류", 
                Content = "PlayerScripts 폴더를 찾을 수 없습니다.", 
                Duration = 5 
            })
        end
    end
})

MainTab:AddButton({
    Title = "총 얻기",
    Description = "죽으면 알아서 다시 실행됩니다 2번 누르지 마세요",
    Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        local function collectTools()
            for _, t in pairs(game.Players:GetDescendants()) do
                if t:IsA("Tool") then
                        t.Parent = LocalPlayer.Backpack
                end
            end
        end


        collectTools()


        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            collectTools()
        end)
    end
})

MainTab:AddButton({
    Title = "사일런트 에임",
    Description = "오른쪽 컨트롤 키로 토글",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Averiias/Universal-SilentAim/refs/heads/main/main.lua"))()
    end
})

SpawnsSection:AddButton({
    Title = "권력자들쪽 스폰",
    Description = "관리자 계열 전용 스폰으로 이동",
    Callback = function()
        local spawnsFolder = workspace:FindFirstChild("Maps") and workspace.Maps:FindFirstChild("Spawns")
        if not spawnsFolder then return end

        local adminObj = spawnsFolder:FindFirstChild("윤리위원회 스폰")
        if adminObj then
            local part = adminObj:IsA("BasePart") and adminObj or adminObj:FindFirstChildWhichIsA("BasePart") or adminObj:FindFirstChild("HumanoidRootPart")
            if part then
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                end
            end
        end
    end
})

SpawnsSection:AddButton({
    Title = "경비쪽 스폰",
    Description = "MTF 계열 전용 스폰으로 이동",
    Callback = function()
        local spawnsFolder = workspace:FindFirstChild("Maps") and workspace.Maps:FindFirstChild("Spawns")
        if not spawnsFolder then return end

        local mtfObj = spawnsFolder:FindFirstChild("MTF스폰")
        if mtfObj then
            local part = mtfObj:IsA("BasePart") and mtfObj or mtfObj:FindFirstChildWhichIsA("BasePart") or mtfObj:FindFirstChild("HumanoidRootPart")
            if part then
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                end
            end
        end
    end
})

local otherSpawns = {
    "Chaos - 반란군 스폰",
    "Elite 스폰",
    "연구원 스폰",
}

for _, spawnName in pairs(otherSpawns) do
    SpawnsSection:AddButton({
        Title = spawnName,
        Callback = function()
            local spawnsFolder = workspace:FindFirstChild("Maps") and workspace.Maps:FindFirstChild("Spawns")
            if not spawnsFolder then return end

            local obj = spawnsFolder:FindFirstChild(spawnName)
            if obj then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart") or obj:FindFirstChild("HumanoidRootPart")
                if part then
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                    end
                end
            end
        end
    })
end

-- KillsSection에 붙일 코드 (로직만 네 최신 버전으로 교체)

local damageRemote = game:GetService("ReplicatedStorage"):WaitForChild("ACS_Engine"):WaitForChild("Events"):WaitForChild("Damage")

-- Tool 찾는 함수 (네 코드 그대로)
local function ReturnTool()
    for i, v in pairs(game.Players:GetDescendants()) do
        if v.Name == "ACS_Settings" then
            return v.Parent
        end
    end
end

-- 특정 유저 킬 함수 (네 로직 그대로 적용)
local function killPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("Humanoid") then
        return
    end

    local tool = ReturnTool()
    if not tool then return end

    local acsSettings = require(tool:FindFirstChild("ACS_Settings"))
    local UserId = game.Players.LocalPlayer.UserId
    local AcsId = game:GetService("ReplicatedStorage"):WaitForChild("ACS_Engine"):WaitForChild("Events"):WaitForChild("AcessId"):InvokeServer(game.Players.LocalPlayer.UserId, game.Players.LocalPlayer.Name)

    local args = {
        [1] = tool,
        [2] = targetPlayer.Character.Humanoid,
        [3] = -math.huge,
        [4] = -math.huge,
        [5] = acsSettings,
        [6] = {
            ["SpreadRM"] = 1,
            ["RecoilPowerStepAmount"] = 1,
            ["Zoom2Value"] = 60,
            ["MaxSpread"] = 1,
            ["MinRecoilPower"] = 1,
            ["DamageMod"] = 1,
            ["minDamageMod"] = 1,
            ["MaxRecoilPower"] = 1,
            ["AimInaccuracyStepAmount"] = 1,
            ["WalkMult"] = 1,
            ["AimRM"] = 1,
            ["gunRecoilMod"] = { ["RecoilRight"] = 1, ["RecoilUp"] = 1, ["RecoilTilt"] = 1, ["RecoilLeft"] = 1 },
            ["MuzzleVelocity"] = 1,
            ["ZoomValue"] = 60,
            ["MinSpread"] = 1,
            ["AimInaccuracyDecrease"] = 1,
            ["camRecoilMod"] = { ["RecoilRight"] = 1, ["RecoilTilt"] = 1, ["RecoilUp"] = 1, ["RecoilLeft"] = 1 },
            ["adsTime"] = 1
        },
        [9] = AcsId .. "-" .. tostring(UserId),
        [10] = AcsId
    }

    damageRemote:InvokeServer(unpack(args))
end

-- 같은 팀 제외한 플레이어 선택 Dropdown
local playerDropdown = KillsSection:AddDropdown("KillPlayerDropdown", {
    Title = "킬할 플레이어 선택",
    Description = "다른 팀 플레이어만 표시",
    Values = (function()
        local list = {}
        local myTeam = game.Players.LocalPlayer.Team  -- 내 팀 가져오기

        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Team ~= myTeam then
                table.insert(list, plr.Name)
            end
        end
        return list
    end)(),
    Multi = false,
    Default = 1,
    Callback = function() end
})

-- 입장/퇴장 시 자동 업데이트 (같은 팀 제외 로직 유지)
game.Players.PlayerAdded:Connect(function(plr)
    if plr ~= game.Players.LocalPlayer and plr.Team ~= game.Players.LocalPlayer.Team then
        playerDropdown:Add(plr.Name)
    end
end)

game.Players.PlayerRemoving:Connect(function(plr)
    playerDropdown:Remove(plr.Name)
end)

-- 2. 선택된 플레이어 킬 버튼 (로직만 새걸로 변경)
KillsSection:AddButton({
    Title = "선택된 플레이어 킬",
    Description = "Dropdown에서 고른 유저 즉사",
    Callback = function()
        local selected = playerDropdown.Value
        if selected then
            local target = game.Players:FindFirstChild(selected)
            if target then
                killPlayer(target)
            end
        end
    end
})

-- 3. 킬올 반복 토글 (로직만 새걸로 변경)
local killAllLoop = nil

local function killAllOnce()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer then
            killPlayer(plr)
        end
    end
end

KillsSection:AddToggle("KillAllToggle", {
    Title = "킬올 반복",
    Description = "ON 시 모든 플레이어 지속 공격",
    Default = false,
    Callback = function(state)
        if state then
            killAllOnce()  -- 즉시 실행
            killAllLoop = game:GetService("RunService").Heartbeat:Connect(killAllOnce)
        else
            if killAllLoop then
                killAllLoop:Disconnect()
                killAllLoop = nil
            end
        end
    end
})

KillsSection:AddButton({
    Title = "플레이어 목록 리프레시",
    Description = "다른 팀 플레이어 목록 새로고침",
    Callback = function()
        local newList = {}
        local myTeam = game.Players.LocalPlayer.Team

        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Team ~= myTeam then
                table.insert(newList, plr.Name)
            end
        end

        playerDropdown:SetValues(newList)

        if #newList > 0 then
            playerDropdown:SetValue(newList[1])
        end

        Fluent:Notify({ 
            Title = "리프레시 완료", 
            Content = "다른 팀 플레이어 " .. #newList .. "명 업데이트", 
            Duration = 5 
        })
    end
})
