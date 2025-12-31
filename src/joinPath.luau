function joinPath(basePath: string, ...: string): string
	local pathComponents = { ... }

	for _, key in pathComponents do
		basePath = basePath .. "." .. key
	end

	return basePath
end

return joinPath
