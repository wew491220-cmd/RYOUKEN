-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer

-- DELETE OLD
if player.PlayerGui:FindFirstChild("RyoukenHub") then
	player.PlayerGui.RyoukenHub:Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "RyoukenHub"
gui.ResetOnSpawn = false

-- NOTIF
local function notify(text)
	pcall(function()
		game.StarterGui:SetCore("SendNotification", {
			Title = "RyoukenHub",
			Text = text,
			Duration = 3
		})
	end)
end

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,0,0,0)
main.Position = UDim2.new(0.5,-400,0.5,-225)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", main)

TweenService:Create(main,TweenInfo.new(0.4),{
	Size = UDim2.new(0,800,0,450)
}):Play()

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0,200,1,0)
sidebar.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", sidebar)

-- PROFILE
local pfp = Instance.new("ImageLabel", sidebar)
pfp.Size = UDim2.new(0,70,0,70)
pfp.Position = UDim2.new(0.5,-35,0,10)
pfp.Image = "rbxassetid://71582059950977"
pfp.BackgroundTransparency = 1
Instance.new("UICorner", pfp).CornerRadius = UDim.new(1,0)

local name = Instance.new("TextLabel", sidebar)
name.Size = UDim2.new(1,0,0,30)
name.Position = UDim2.new(0,0,0,80)
name.Text = "Ryouken Hub"
name.TextColor3 = Color3.new(1,1,1)
name.BackgroundTransparency = 1
name.TextScaled = true

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,-220,1,-20)
content.Position = UDim2.new(0,210,0,10)
content.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", content)

-- TOP BUTTONS (MINIMIZE + CLOSE)
local minimize = Instance.new("TextButton", main)
minimize.Size = UDim2.new(0,40,0,25)
minimize.Position = UDim2.new(1,-90,0,5)
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(50,150,255)
minimize.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", minimize)

local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0,40,0,25)
close.Position = UDim2.new(1,-45,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255,70,70)
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close)

local minimized = false
local originalSize = UDim2.new(0,800,0,450)

minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	
	if minimized then
		sidebar.Visible = false
		content.Visible = false
		
		TweenService:Create(main,TweenInfo.new(0.3),{
			Size = UDim2.new(0,300,0,40)
		}):Play()
	else
		sidebar.Visible = true
		content.Visible = true
		
		TweenService:Create(main,TweenInfo.new(0.3),{
			Size = originalSize
		}):Play()
	end
end)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- TITLE GLOW
local title = Instance.new("TextLabel", content)
title.Size = UDim2.new(1,0,0,50)
title.Text = "RYOUKEN HUB"
title.BackgroundTransparency = 1
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)

task.spawn(function()
	while true do
		TweenService:Create(title,TweenInfo.new(1),{TextColor3 = Color3.fromRGB(0,170,255)}):Play()
		task.wait(1)
		TweenService:Create(title,TweenInfo.new(1),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
		task.wait(1)
	end
end)

-- TAB SYSTEM
local pages = {}

local function createPage(name)
	local f = Instance.new("Frame", content)
	f.Size = UDim2.new(1,0,1,-50)
	f.Position = UDim2.new(0,0,0,50)
	f.BackgroundTransparency = 1
	f.Visible = false
	pages[name] = f
	return f
end

local function showPage(name)
	for _,v in pairs(pages) do v.Visible = false end
	title.Text = name
	
	if pages[name] then
		local p = pages[name]
		p.Visible = true
		p.BackgroundTransparency = 1
		
		TweenService:Create(p,TweenInfo.new(0.3),{
			BackgroundTransparency = 0
		}):Play()
	end
end

-- BUTTON SYSTEM
local function createButton(parent,text,y,cb)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0.9,0,0,45)
	b.Position = UDim2.new(0.05,0,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(30,30,30)
	b.TextColor3 = Color3.new(1,1,1)
	b.TextScaled = true
	Instance.new("UICorner", b)

	b.MouseEnter:Connect(function()
		TweenService:Create(b,TweenInfo.new(0.2),{
			BackgroundColor3 = Color3.fromRGB(60,60,60)
		}):Play()
	end)

	b.MouseLeave:Connect(function()
		TweenService:Create(b,TweenInfo.new(0.2),{
			BackgroundColor3 = Color3.fromRGB(30,30,30)
		}):Play()
	end)

	b.MouseButton1Click:Connect(cb)
end

local function createTab(name,y)
	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1,-20,0,40)
	btn.Position = UDim2.new(0,10,0,y)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	btn.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", btn)

	local page = createPage(name)

	btn.MouseButton1Click:Connect(function()
		showPage(name)
	end)

	return page
end

-- TABS
local homePage = createTab("Home",150)
local visualPage = createTab("Visual",200)
local miscPage = createTab("Misc",250)
createTab("Other",300)

showPage("Home")

-- HOME INFO
local info = Instance.new("TextLabel", homePage)
info.Size = UDim2.new(0.9,0,0,120)
info.Position = UDim2.new(0.05,0,0,10)
info.BackgroundColor3 = Color3.fromRGB(30,30,30)
info.TextColor3 = Color3.new(1,1,1)
info.TextScaled = true
info.TextWrapped = true
info.Text = "Halo Saya dari Ryouken (Dev)\n\nMohon maaf jika ada bugs karena ini masih Beta Test."
Instance.new("UICorner", info)

-- (SEMUA FITUR LAIN TETAP SAMA PERSIS DI BAWAH SINI, GAK DIUBAH)
