-- Services && Variables

local Players = game:GetService("Players")
local localplayer = Players.LocalPlayer

local StarterGui = game:GetService("StarterGui")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Custom Service

local dcsce = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents",true)

local Chatter = {
	Connect = function()
		dcsce.GetInitDataRequest:Connect() -- In case we aren't loaded
	end,

	Send = function(text,channel)

		local smr = dcsce.SayMessageRequest

		if channel then
			smr:FireServer(text,channel)
		else
			smr:FireServer(text,"all")
		end
	end,
}
	
if not game:IsLoaded() then Chatter:Connect() end --brute force connect ig

-- UI stuff

local FCHATCLIENT = Instance.new("ScreenGui")
local DragPart = Instance.new("Frame")
local Main = Instance.new("Frame")
local ScrollChat = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ChatBox = Instance.new("TextBox")
local Send = Instance.new("TextButton")


FCHATCLIENT.Name = "F!CHATCLIENT"
FCHATCLIENT.Parent = game.CoreGui

DragPart.Name = "DragPart"
DragPart.Parent = FCHATCLIENT
DragPart.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DragPart.BackgroundTransparency = 0.950
DragPart.BorderSizePixel = 0
DragPart.Position = UDim2.new(0.281407028, 0, 0.482885092, 0)
DragPart.Size = UDim2.new(0, 609, 0, 27)
DragPart.Active = true
DragPart.Selectable = true
DragPart.Draggable = true

Main.Name = "Main"
Main.Parent = DragPart
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BackgroundTransparency = 1.000
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0, 0, 0, 27)
Main.Size = UDim2.new(0, 611, 0, 367)

ScrollChat.Name = "ScrollChat"
ScrollChat.Parent = Main
ScrollChat.Active = true
ScrollChat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollChat.BackgroundTransparency = 0.900
ScrollChat.BorderColor3 = Color3.fromRGB(27, 42, 53)
ScrollChat.BorderSizePixel = 0
ScrollChat.Size = UDim2.new(0, 611, 0, 324)
ScrollChat.CanvasSize = UDim2.new(0, 0, 8, 9999)
ScrollChat.ScrollBarThickness = 5

UIListLayout.Parent = ScrollChat
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

ChatBox.Name = "ChatBox"
ChatBox.Parent = Main
ChatBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ChatBox.BackgroundTransparency = 0.700
ChatBox.BorderSizePixel = 0
ChatBox.Position = UDim2.new(0.00327332248, 0, 0.882833779, 0)
ChatBox.Size = UDim2.new(0, 557, 0, 43)
ChatBox.ClearTextOnFocus = false
ChatBox.Font = Enum.Font.SourceSans
ChatBox.PlaceholderColor3 = Color3.fromRGB(99, 88, 66)
ChatBox.PlaceholderText = "Click here to send a text."
ChatBox.Text = ""
ChatBox.TextColor3 = Color3.fromRGB(0, 0, 0)
ChatBox.TextSize = 16.000
ChatBox.TextXAlignment = Enum.TextXAlignment.Left
ChatBox.TextYAlignment = Enum.TextYAlignment.Top

Send.Name = "Send"
Send.Parent = Main
Send.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Send.BackgroundTransparency = 0.700
Send.BorderSizePixel = 0
Send.Position = UDim2.new(0.916337669, 0, 0.882833779, 0)
Send.Size = UDim2.new(0, 51, 0, 43)
Send.Font = Enum.Font.SourceSans
Send.Text = "SEND"
Send.TextColor3 = Color3.fromRGB(0, 0, 0)
Send.TextSize = 14.000

-- Script

local send = function()
	Chatter.Send(ChatBox.Text)
end

Send.MouseButton1Click:Connect(send)

local function CreateTextBox(Message, Type)
	
	-- // Variables
	local Text
	local FromSpeaker

	if Type == "MessageDoneFiltering" then

		Text = Message.Message or ""

		if type(Text) == nil then
			Text = Text.Message
		end
		
		FromSpeaker = Message.FromSpeaker.Name

	elseif Type == "SystemMessage" then
	
		Text = Message.Message
		FromSpeaker = "System"

	elseif Type == "Hook" then
	
		Text = Message
		FromSpeaker = "Hook"
		
	end

	print(FromSpeaker..":",Text)

	-- // UI Stuff

	local TextChat = Instance.new("Frame")
	local PlayerIcon = Instance.new("ImageLabel")
	local PlayerText = Instance.new("TextLabel")
	local PlayerName = Instance.new("TextLabel")

	TextChat.Name = "TextChat"
	TextChat.Parent = ScrollChat
	TextChat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextChat.BackgroundTransparency = 0.800
	TextChat.BorderSizePixel = 0
	TextChat.Size = UDim2.new(0, 605, 0, 75)

	PlayerIcon.Name = "PlayerIcon"
	PlayerIcon.Parent = TextChat
	PlayerIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlayerIcon.BackgroundTransparency = 1.000
	PlayerIcon.BorderSizePixel = 0
	PlayerIcon.Position = UDim2.new(0, 2, 0, 2)
	PlayerIcon.Size = UDim2.new(0, 32, 0, 32)
	PlayerIcon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

	PlayerText.Name = "PlayerText"
	PlayerText.Parent = TextChat
	PlayerText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlayerText.BackgroundTransparency = 0.800
	PlayerText.BorderSizePixel = 0
	PlayerText.Position = UDim2.new(0, 36, 0, 2)
	PlayerText.Size = UDim2.new(0, 566, 0, 70)
	PlayerText.Font = Enum.Font.Unknown
	PlayerText.Text = Text
	PlayerText.TextColor3 = Color3.fromRGB(0, 0, 0)
	PlayerText.TextSize = 14.000
	PlayerText.TextWrapped = true
	PlayerText.TextXAlignment = Enum.TextXAlignment.Left
	PlayerText.TextYAlignment = Enum.TextYAlignment.Top

	PlayerName.Name = "PlayerName"
	PlayerName.Parent = TextChat
	PlayerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlayerName.BackgroundTransparency = 0.800
	PlayerName.BorderSizePixel = 0
	PlayerName.Position = UDim2.new(0, 2, 0, 40)
	PlayerName.Size = UDim2.new(0, 32, 0, 32)
	PlayerName.Font = Enum.Font.Unknown
	PlayerName.Text = FromSpeaker
	PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
	PlayerName.TextScaled = true
	PlayerName.TextSize = 14.000
	PlayerName.TextWrapped = true

	task.wait(120)

	TextChat:Destroy() 

	-- // Remove Data

	Text = nil
	FromSpeaker = nil

	TextChat = nil
	PlayerIcon = nil
	PlayerText = nil
	PlayerName = nil
end

-- Events

for i, plr in ipairs(Players:GetPlayers()) do
	plr.Chatted:Connect(function(msg)
		local Message = {
			Message = msg,
			FromSpeaker = plr
		}
		CreateTextBox(Message,"MessageDoneFiltering")
	end)
end

Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		local Message = {
			Message = msg,
			FromSpeaker = plr
		}
		CreateTextBox(Message,"MessageDoneFiltering")
	end)
end)

dcsce.OnNewSystemMessage.OnClientEvent:Connect(function(m) CreateTextBox(m, "SystemMessage") end)

--hooker for systemmessages [It isn't really that good. Or probably even working.]

local oldFunction, property
oldFunction = hookfunction(game.StarterGui["SetCore"], function(v,v2)
	local var1, var2 = v, v2
	
	if var1 == "ChatMakeSystemMessage" then
		CreateTextBox(var2, "Hook")
	end
	
	return oldFunction(v,v2)
end)
