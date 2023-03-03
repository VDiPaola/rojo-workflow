local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddControllers(ReplicatedStorage.Shared.Controllers)

Knit.Start()
	:andThen(function()
		print("Knit started")
	end)
	:catch(warn)
