local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.roact)

-- Create our virtual tree describing a full-screen text label.
local tree = Roact.createElement("ScreenGui", {}, {
	Label = Roact.createElement("TextLabel", {
		Text = "Hello, world!",
		Size = UDim2.new(1, 0, 1, 0),
	}),
})

-- Turn our virtual tree into real instances and put them in PlayerGui
Roact.mount(tree, LocalPlayer.PlayerGui, "HelloWorld")
