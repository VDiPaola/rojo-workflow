local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddServices(ServerStorage.Server.Services)

Knit.Start()
	:andThen(function()
		print("Knit started")
	end)
	:catch(warn)
