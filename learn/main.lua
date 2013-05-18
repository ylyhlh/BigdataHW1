--[[
Example Main File for Binary Linear Learning using Torch 7
By Xiang Zhang @ New York University
Version 0.1, 02/25/2013
--]]

-- Load global libraries
require("nn")
require("optim")
require("sys")

-- Load the xtools library. Fixing bugs of torch and etc.
dofile("xtools.lua")
-- Add a path to support local libraries
xtools.addpath("./?/init.lua")
-- Load the xtrain library
require("xtrain")

-- Load dataset library
dofile("spambase.lua")

-- Load regularizers
dofile("regu.lua")

-- Load extra criteria
if nn.MMSECriterion == nil then dofile("criteria.lua") end

-- Configuration of datasets
local train_size = 3000
local test_size = 1000
local data_train, data_test = spambase:getDatasets(train_size, test_size)

-- Configuration of model
local model = nn.Linear(data_train:features(),1)

-- Configuration of loss
local loss = nn.MMSECriterion()
if arg[4] == "quant" then loss = nn.QuantCriterion() end
if arg[4] == "hinge" then loss = nn.MarginCriterion(1) end
if arg[4] == "logis" then loss = nn.LogisCriterion() end


--local loss = nn.LogisCriterion()


-- Configuration of regularizer
local lambda = arg[1] --0.05
local regu = reguL2(lambda)

-- Configuration of trainer
local config = {}
-- Decision function is sign for binary linear classification
local decfunc = function(output) return torch.sign(output)[1] end
-- Error is equality comparison
local errfunc = function(decision, label) return decision == label and 0 or 1 end

-- Configuration of optimizer
local state = {learningRate = arg[2]} --0.001}
-- Optimization algorithm used is optim.sgd
local optalg = optim.sgd
if arg[3] == "cg" then optalg = optim.cg end
if arg[3] == "bfgs" then optalg = optim.bfgs end
if arg[3] == "lbfgs" then optalg = optim.lbfgs end

-- Use a stochastic trainer
local trainer = xtrain.stochastic(model, loss, regu, decfunc, errfunc, optalg, state, config)
if arg[5] == "batch" then trainer = xtrain.batch(model, loss, regu, decfunc, errfunc, optalg, state, config) end
if arg[5] == "minibatch" then 
	batchSize = arg [7]
	trainer = xtrain.minibatch(model, loss, regu, decfunc, errfunc, optalg, state, config)  
end


-- Number of epoches is 20
local epoches = arg[6]

-- Start training
local t = sys.clock()
-- Train for epoches
local error_train, loss_train = trainer:train(data_train, epoches)
-- Test on testing data
local error_test, loss_test = trainer:test(data_test)
-- Record the time
t = sys.clock() - t

-- Print the results
print("error_train = " .. error_train .. " loss_train = " .. loss_train)
print("error_test = " .. error_test .. " loss_test = " .. loss_test)
print("Elapsed time = " .. t)
local log = torch.DiskFile('log','rw')
log:seekEnd()
log:writeString(arg[1] .. '\t' .. arg[2] .. '\t' .. arg[3] .. '\t' .. arg[4] .. '\t' .. arg[5] .. '\t' .. arg[6] .. '\t' .. arg[7] .. '\t')
log:writeString(error_train .. '\t' .. loss_train .. '\t' .. error_test .. '\t' .. loss_test .. '\t' .. t .. '\n')
