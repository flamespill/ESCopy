local CoreGui = cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local Players = cloneref(game:GetService("Players")) or game:GetService("Players")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local ESCMenu = RobloxGui:WaitForChild("SettingsClippingShield")
local ESCMenu_PlayersList = ESCMenu:WaitForChild("SettingsShield"):WaitForChild("MenuContainer"):WaitForChild("PageViewClipper"):WaitForChild("PageView"):WaitForChild("PageViewInnerFrame"):WaitForChild("Players")

local function AddCopyClipboardButton(Player)
	local RightSideButtons = Player:WaitForChild("RightSideButtons")
	
	if RightSideButtons:FindFirstChild("CopyClipboard") then return end
		
	local CopyClipboard = RightSideButtons:WaitForChild("Inspect"):Clone()
	CopyClipboard.Name = "CopyClipboard"
	CopyClipboard.AutoButtonColor = true
	CopyClipboard:FindFirstChildOfClass("ImageLabel").Image = "rbxassetid://76443890191204"
	CopyClipboard:FindFirstChildOfClass("ImageLabel").ImageRectSize = Vector2.new(0, 0)
	CopyClipboard.Parent = RightSideButtons
	
	local Username = RightSideButtons.Parent:WaitForChild("NameLabel").Text:gsub("@", "")
	
	CopyClipboard.MouseButton1Click:Connect(function()
		setclipboard(Username)
	end)
end

for i,Player in pairs(ESCMenu_PlayersList:GetChildren()) do
	if Player:IsA("ImageLabel") then
		AddCopyClipboardButton(Player)
	end
end

Players.PlayerAdded:Connect(function(Player)
	AddCopyClipboardButton(ESCMenu_PlayersList:WaitForChild("PlayerLabel"..Player.Name))
end)

Players.PlayerRemoving:Connect(function(Player)
	ESCMenu_PlayersList:WaitForChild("PlayerLabel"..Player.Name):Destroy()
end)
