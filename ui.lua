local gui = Instance.new("ScreenGui")
gui.Name = "RyoukenHub"
gui.Parent = game.CoreGui

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 900, 0, 550)
main.Position = UDim2.new(0.5, -450, 0.5, -275)
main.BackgroundColor3 = Color3.fromRGB(15,15,20)
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(170, 0, 255)
stroke.Thickness = 2

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 220, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(20,20,25)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 15)

-- TITLE PROFILE
local profile = Instance.new("TextLabel", sidebar)
profile.Size = UDim2.new(1, 0, 0, 100)
profile.BackgroundTransparency = 1
profile.Text = "Ryouken Hub\nNext Generation Script"
profile.TextColor3 = Color3.fromRGB(255,255,255)
profile.TextScaled = true

-- BUTTON CONTAINER
local container = Instance.new("Frame", sidebar)
container.Size = UDim2.new(1, 0, 1, -120)
container.Position = UDim2.new(0, 0, 0, 110)
container.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0, 8)

local padding = Instance.new("UIPadding", container)
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)

-- BUTTON LIST
local tabs = {"Home","Combat","Player","Visual","Teleport","Misc","Settings"}

for _, v in ipairs(tabs) do
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, 0, 0, 45)
    b.Text = v
    b.BackgroundColor3 = Color3.fromRGB(25,25,30)
    b.TextColor3 = Color3.fromRGB(200,200,200)
    b.TextScaled = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = Color3.fromRGB(40,40,60)
    end)

    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = Color3.fromRGB(25,25,30)
    end)
end

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -220, 1, 0)
content.Position = UDim2.new(0, 220, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(25,25,30)
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 15)

-- TITLE
local title = Instance.new("TextLabel", content)
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundTransparency = 1
title.Text = "Ryouken Hub"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true

-- BUTTON TEST
local btn = Instance.new("TextButton", content)
btn.Size = UDim2.new(0.5, 0, 0, 60)
btn.Position = UDim2.new(0.25, 0, 0.2, 0)
btn.Text = "Test Button"
btn.BackgroundColor3 = Color3.fromRGB(30,30,40)
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.TextScaled = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

-- DRAG UI
local UIS = game:GetService("UserInputService")
local dragging, mousePos, framePos

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = main.Position
    end
end)

main.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - mousePos
        main.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)
