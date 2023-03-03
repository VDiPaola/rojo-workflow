--example service
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local PointController = Knit.CreateController({
	Name = "PointController",
})

function PointController:KnitInit()
	print("PointController init")
end

function PointController:KnitStart()
	print("PointController started")
	local function observePoints(points)
		print("points: ", points)
	end
	local PointService = Knit.GetService("PointService")
	PointService:GetPoints():andThen(observePoints)
	PointService.PointsChanged:Connect(observePoints)
end

return PointController
