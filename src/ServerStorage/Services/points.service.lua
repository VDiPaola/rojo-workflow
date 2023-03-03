--example service
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local PointService = Knit.CreateService({
	Name = "PointService",
	Client = {
		PointsChanged = Knit.CreateSignal(),
	},
	_Points = 0,
})

function PointService.Client:GetPoints()
	return self.Server._Points
end

function PointService:GetPoints()
	return self._Points
end

function PointService:AddPoints(player, increment: number)
	local amount = self._Points + increment
	self._Points = amount

	self.Client.PointsChanged:Fire(player, amount)
end

function PointService:KnitInit()
	print("point service init")
end

function PointService:KnitStart()
	print("point service started")

	task.wait(5)
	self:AddPoints(game.Players:GetChildren()[1], 10)
end

return PointService
