local types = require(script.types)

export type Environment = types.Environment

return {
	getEnvironment = require(script.getEnvironment),
	getValue = require(script.getValue),
	joinPath = require(script.joinPath),
}
