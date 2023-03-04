local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TestEZ = require(ReplicatedStorage.Packages.testez)

local tests = script.Parent:GetDescendants()

TestEZ.TestBootstrap:run(tests)
