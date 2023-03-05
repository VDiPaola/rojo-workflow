local Helpers = {}

function Helpers.GetKeyFromValue(_table, _value)
	for key, value in pairs(_table) do
		if value == _value then
			return key
		end
	end
end

function Helpers.Lerp(a, b, t) --from, to, percentage
	return a + (b - a) * t
end

function Helpers.StringNumberFormat(str: string | number): string
	local n = tostring(str)
	return n:reverse():gsub("...", "%0,", math.floor((#n - 1) / 3)):reverse()
end

return Helpers
