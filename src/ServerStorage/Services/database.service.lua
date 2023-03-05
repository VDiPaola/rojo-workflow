--handles database using profile service
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
local ProfileService = require(ReplicatedStorage.Packages.profileservice)

local Players = game:GetService("Players")

local DatabaseService = Knit.CreateService({
	Name = "DatabaseService",
	Client = {},
	_Profiles = {},
	_ProfileStore = ProfileService.GetProfileStore("PlayerData", {}),
	_hooks = {
		DataInitialised = {},
	},
})

function DatabaseService:KnitInit()
	--player added get data for player
	Players.PlayerAdded:Connect(function(player)
		--get initial data for player
		local profile = self._ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
		if profile ~= nil then
			profile:AddUserId(player.UserId) -- GDPR compliance
			profile:Reconcile() -- Fill in missing variables from ProfileTemplate (optional)
			profile:ListenToRelease(function()
				self._Profiles[player] = nil
				-- The profile could've been loaded on another Roblox server:
				player:Kick()
			end)
			if player:IsDescendantOf(Players) == true then
				self._Profiles[player] = profile
				-- A profile has been successfully loaded:
				--run all callback functions
				for _, v in pairs(self._hooks.DataInitialised) do
					pcall(v, player)
				end
			else
				-- Player left before the profile loaded:
				profile:Release()
			end
		else
			-- The profile couldn't be loaded
			player:Kick()
		end
	end)

	--player removing clear profile
	Players.PlayerRemoving:Connect(function(player)
		local profile = self._Profiles[player]
		if profile ~= nil then
			profile:Release()
		end
	end)
end

function DatabaseService:Get(player: Player, key: string, defaultValue: any)
	local profile = self._Profiles[player]
	local data = profile.Data[key]
	if not data then
		data = defaultValue
	end
	return data
end

function DatabaseService:Set(player: Player, key: string, value: any)
	local profile = self._Profiles[player]
	profile.Data[key] = value
end

function DatabaseService:Reset(player: Player)
	local profile = self._Profiles[player]
	profile.Data = {}
end

function DatabaseService.DataInitialised:Connect(func: (Player, any) -> any)
	table.insert(self._hooks.DataInitialised, func)
end

return DatabaseService
