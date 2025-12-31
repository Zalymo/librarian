local types = require(script.Parent.Types)

local function getValue(dictionary: types.Environment, path: string): types.ContentDescriptor
	local keys: { string } = string.split(path, ".")

	for index = 1, #keys do
		local key: string = keys[index]
		local current: unknown = dictionary[key]
		local currentType: string = typeof(current)

		if index == #keys then
			if currentType == "table" then
				return { current, nil }
			else
				if currentType ~= "nil" and current ~= nil then
					return { current, key }
				end
			end
		else
			if currentType == "table" then
				dictionary = current :: types.Environment
			end
		end
	end

	return { nil, nil }
end

return getValue
