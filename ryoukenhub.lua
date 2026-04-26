local p=game:GetService("Players").LocalPlayer
local UIS=game:GetService("UserInputService")
local L=game:GetService("Lighting")
local RS=game:GetService("RunService")
local TS=game:GetService("TweenService")
local VU=game:GetService("VirtualUser")

pcall(function() p.PlayerGui.RyoukenHub:Destroy() end)

local g=Instance.new("ScreenGui",p.PlayerGui) g.Name="RyoukenHub" g.ResetOnSpawn=false
local function N(t) pcall(function() game.StarterGui:SetCore("SendNotification",{Title="RyoukenHub",Text=t,Duration=3}) end) end

local m=Instance.new("Frame",g)
m.Size=UDim2.new(0,0,0,0) m.Position=UDim2.new(0.5,-400,0.5,-225)
m.BackgroundColor3=Color3.fromRGB(20,20,20) Instance.new("UICorner",m)
TS:Create(m,TweenInfo.new(.4),{Size=UDim2.new(0,800,0,450)}):Play()

local top=Instance.new("Frame",m) top.Size=UDim2.new(1,0,0,30) top.BackgroundTransparency=1
local min=Instance.new("TextButton",top)
min.Size=UDim2.new(0,30,0,30) min.Position=UDim2.new(1,-70,0,0) min.Text="-"
min.BackgroundColor3=Color3.fromRGB(40,40,40) min.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",min)

local cls=Instance.new("TextButton",top)
cls.Size=UDim2.new(0,30,0,30) cls.Position=UDim2.new(1,-35,0,0) cls.Text="X"
cls.BackgroundColor3=Color3.fromRGB(170,0,0) cls.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",cls)

local side=Instance.new("Frame",m)
side.Size=UDim2.new(0,200,1,0) side.BackgroundColor3=Color3.fromRGB(15,15,15) Instance.new("UICorner",side)

local pfp=Instance.new("ImageLabel",side)
pfp.Size=UDim2.new(0,70,0,70) pfp.Position=UDim2.new(0.5,-35,0,10)
pfp.Image="rbxassetid://71582059950977" pfp.BackgroundTransparency=1 Instance.new("UICorner",pfp).CornerRadius=UDim.new(1,0)

local name=Instance.new("TextLabel",side)
name.Size=UDim2.new(1,0,0,30) name.Position=UDim2.new(0,0,0,80)
name.Text="Ryouken Hub" name.TextColor3=Color3.new(1,1,1)
name.BackgroundTransparency=1 name.TextScaled=true

local c=Instance.new("Frame",m)
c.Size=UDim2.new(1,-220,1,-20) c.Position=UDim2.new(0,210,0,10)
c.BackgroundColor3=Color3.fromRGB(25,25,25) Instance.new("UICorner",c)

local title=Instance.new("TextLabel",c)
title.Size=UDim2.new(1,0,0,50) title.Text="RYOUKEN HUB"
title.BackgroundTransparency=1 title.TextScaled=true title.TextColor3=Color3.new(1,1,1)

task.spawn(function()
	while true do
		TS:Create(title,TweenInfo.new(1),{TextColor3=Color3.fromRGB(0,170,255)}):Play()
		task.wait(1)
		TS:Create(title,TweenInfo.new(1),{TextColor3=Color3.fromRGB(255,255,255)}):Play()
		task.wait(1)
	end
end)

local pages={}
local function page(n)
	local f=Instance.new("Frame",c)
	f.Size=UDim2.new(1,0,1,-50) f.Position=UDim2.new(0,0,0,50)
	f.BackgroundTransparency=1 f.Visible=false pages[n]=f return f
end

local function show(n)
	for _,v in pairs(pages) do v.Visible=false end
	title.Text=n
	if pages[n] then
		local p=pages[n] p.Visible=true p.BackgroundTransparency=1
		TS:Create(p,TweenInfo.new(.3),{BackgroundTransparency=0}):Play()
	end
end

local function btn(par,t,y,cb)
	local b=Instance.new("TextButton",par)
	b.Size=UDim2.new(.9,0,0,45) b.Position=UDim2.new(.05,0,0,y)
	b.Text=t b.BackgroundColor3=Color3.fromRGB(30,30,30)
	b.TextColor3=Color3.new(1,1,1) b.TextScaled=true Instance.new("UICorner",b)
	b.MouseButton1Click:Connect(cb)
end

local function tab(n,y)
	local b=Instance.new("TextButton",side)
	b.Size=UDim2.new(1,-20,0,40) b.Position=UDim2.new(0,10,0,y)
	b.Text=n b.BackgroundColor3=Color3.fromRGB(30,30,30)
	b.TextColor3=Color3.new(1,1,1) Instance.new("UICorner",b)
	local pg=page(n)
	b.MouseButton1Click:Connect(function() show(n) end)
	return pg
end

local home=tab("Home",150)
local vis=tab("Visual",200)
local misc=tab("Misc",250)
tab("Other",300)
show("Home")

local info=Instance.new("TextLabel",home)
info.Size=UDim2.new(.9,0,0,120) info.Position=UDim2.new(.05,0,0,10)
info.BackgroundColor3=Color3.fromRGB(30,30,30)
info.Text="Halo Saya dari Ryouken (Dev)\n\nMohon maaf jika ada bugs karena ini masih Beta Test."
info.TextColor3=Color3.new(1,1,1) info.TextScaled=true info.TextWrapped=true Instance.new("UICorner",info)

local esp,fb=false,false
local ob,ot=L.Brightness,L.ClockTime

btn(vis,"ESP",10,function() esp=not esp N("ESP: "..(esp and "ON" or "OFF")) end)
btn(vis,"FullBright",60,function()
	fb=not fb
	if fb then L.Brightness=2 L.ClockTime=14 else L.Brightness=ob L.ClockTime=ot end
	N("FullBright: "..(fb and "ON" or "OFF"))
end)

local h
p.CharacterAdded:Connect(function(c) h=c:WaitForChild("Humanoid") end)
if p.Character then h=p.Character:FindFirstChildOfClass("Humanoid") end

local ws,jp,jh,inf,fly,noclip,afk=false,false,false,false,false,false,false

btn(misc,"WalkSpeed",10,function() ws=not ws if h then h.WalkSpeed=ws and 50 or 16 end N("WS: "..(ws and "ON" or "OFF")) end)
btn(misc,"JumpPower",60,function() jp=not jp if h then h.JumpPower=jp and 100 or 50 end N("JP: "..(jp and "ON" or "OFF")) end)
btn(misc,"JumpHeight",110,function() jh=not jh if h then h.JumpHeight=jh and 50 or 7.2 end N("JH: "..(jh and "ON" or "OFF")) end)

UIS.JumpRequest:Connect(function() if inf and h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end)
btn(misc,"Infinite Jump",160,function() inf=not inf N("InfJump: "..(inf and "ON" or "OFF")) end)

local bv,bg,ctrl={},{},{f=0,b=0,l=0,r=0,u=0,d=0}

UIS.InputBegan:Connect(function(i,g)
	if g then return end
	if i.KeyCode==Enum.KeyCode.W then ctrl.f=1 end
	if i.KeyCode==Enum.KeyCode.S then ctrl.b=-1 end
	if i.KeyCode==Enum.KeyCode.A then ctrl.l=-1 end
	if i.KeyCode==Enum.KeyCode.D then ctrl.r=1 end
	if i.KeyCode==Enum.KeyCode.Space then ctrl.u=1 end
	if i.KeyCode==Enum.KeyCode.LeftControl then ctrl.d=-1 end
end)

UIS.InputEnded:Connect(function(i)
	if i.KeyCode==Enum.KeyCode.W then ctrl.f=0 end
	if i.KeyCode==Enum.KeyCode.S then ctrl.b=0 end
	if i.KeyCode==Enum.KeyCode.A then ctrl.l=0 end
	if i.KeyCode==Enum.KeyCode.D then ctrl.r=0 end
	if i.KeyCode==Enum.KeyCode.Space then ctrl.u=0 end
	if i.KeyCode==Enum.KeyCode.LeftControl then ctrl.d=0 end
end)

RS.RenderStepped:Connect(function()
	local r=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if fly and r and bv then
		local cam=workspace.CurrentCamera
		local dir=(cam.CFrame.LookVector*(ctrl.f+ctrl.b)+cam.CFrame.RightVector*(ctrl.r+ctrl.l)+Vector3.new(0,ctrl.u+ctrl.d,0))
		bv.Velocity=dir*50
	end
end)

btn(misc,"Fly",210,function()
	fly=not fly
	local r=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if fly and r then
		bv=Instance.new("BodyVelocity",r) bv.MaxForce=Vector3.new(1e9,1e9,1e9)
		bg=Instance.new("BodyGyro",r) bg.MaxTorque=Vector3.new(1e9,1e9,1e9)
	else
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
	end
	N("Fly: "..(fly and "ON" or "OFF"))
end)

RS.Stepped:Connect(function()
	if noclip and p.Character then
		for _,v in pairs(p.Character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide=false end
		end
	end
end)

btn(misc,"Noclip",260,function() noclip=not noclip N("Noclip: "..(noclip and "ON" or "OFF")) end)

p.Idled:Connect(function()
	if afk then
		VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		task.wait(1)
		VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end
end)

btn(misc,"Anti AFK",310,function() afk=not afk N("AFK: "..(afk and "ON" or "OFF")) end)

local minimized=false
min.MouseButton1Click:Connect(function()
	minimized=not minimized
	if minimized then
		side.Visible=false c.Visible=false
		TS:Create(m,TweenInfo.new(.3),{Size=UDim2.new(0,300,0,40)}):Play()
	else
		side.Visible=true c.Visible=true
		TS:Create(m,TweenInfo.new(.3),{Size=UDim2.new(0,800,0,450)}):Play()
	end
end)

cls.MouseButton1Click:Connect(function() g:Destroy() end)
