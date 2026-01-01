local types = require(script.Parent.types)

local function getEnvironment(dictionary: types.Environment, path: string): types.Environment?
	local keys: { string } = string.split(path, ".")
	local keyComponentSize = #keys

	for index = 1, keyComponentSize do
		local key: string = keys[index]

		if index == keyComponentSize then
			return dictionary
		else
			dictionary = dictionary[key] :: types.Environment
		end
	end

	return nil
end

return getEnvironment