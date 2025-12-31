--!strict

local JestGlobals = require(game:GetService("ReplicatedStorage").Packages.JestGlobals)
local describe = JestGlobals.describe
local expect = JestGlobals.expect
local it = JestGlobals.it

local getEnvironment = require(script.Parent.Parent.getEnvironment)
local getValue = require(script.Parent.Parent.getValue)
local joinPath = require(script.Parent.Parent.joinPath)

describe("Librarian", function()
	describe("getEnvironment", function()
		it("returns the original environment for single-segment path", function()
			local env = { name = "value" }
			local result = getEnvironment(env, "name")
			expect(result).toBe(env)
		end)

		it("returns parent environment of final key in nested path", function()
			local env = { level1 = { level2 = { target = 10 } } }
			local result = getEnvironment(env, "level1.level2.target")
			expect(result).toBe(env.level1.level2)
		end)

		it("returns nil when an intermediate segment is missing", function()
			local env = { level1 = { level2 = { target = 10 } } }
			local result = getEnvironment(env, "level1.missing.target")
			expect(result).toBeNil()
		end)
	end)

	describe("joinPath", function()
		it("joins base path with multiple components", function()
			local result = joinPath("root", "child", "leaf")
			expect(result).toBe("root.child.leaf")
		end)

		it("returns the base path when no additional components provided", function()
			local result = joinPath("root")
			expect(result).toBe("root")
		end)
	end)

	describe("getValue", function()
		it("should return value at simple path", function()
			local dict = { name = "test" }
			local result = getValue(dict, "name")
			local value, key = result[1], result[2]
			expect(value).toBe("test")
			expect(key).toBe("name")
		end)

		it("should return nested table without key", function()
			local dict = { nested = { inner = "value" } }
			local result = getValue(dict, "nested")
			local value, key = result[1], result[2]
			expect(value).toBe(dict.nested)
			expect(key).toBeNil()
		end)

		it("should traverse nested paths", function()
			local dict = { level1 = { level2 = { level3 = "deep" } } }
			local result = getValue(dict, "level1.level2.level3")
			local value, key = result[1], result[2]
			expect(value).toBe("deep")
			expect(key).toBe("level3")
		end)

		it("should return nil for non-existent path", function()
			local dict = { name = "test" }
			local result = getValue(dict, "nonexistent")
			local value, key = result[1], result[2]
			expect(value).toBeNil()
			expect(key).toBe(nil)
		end)
	end)
end)

return nil

