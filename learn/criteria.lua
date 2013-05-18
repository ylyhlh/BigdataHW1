--[[
Extra criteria for the demo
By Xiang Zhang @ New York University
Version 0.1, 02/05/2013
]]

local MSECriterion, parent = torch.class('nn.MMSECriterion', 'nn.Criterion')

function MSECriterion:__init()
   parent.__init(self)
   self.sizeAverage = true
end

function MSECriterion:updateOutput(input, target)
   local t = torch.Tensor{target}
   return input.nn.MSECriterion_updateOutput(self, input, t)
end

function MSECriterion:updateGradInput(input, target)
   local t = torch.Tensor{target}
   return input.nn.MSECriterion_updateGradInput(self, input, t)
end

local QuantCriterion, parent = torch.class('nn.QuantCriterion', 'nn.Criterion')

function QuantCriterion:__init()
   parent.__init(self)
   self.sizeAverage = true
end

function QuantCriterion:updateOutput(input, target)
   local t = torch.Tensor{target}
   return torch.abs(input-t)[1]
end

function QuantCriterion:updateGradInput(input, target)
   local t = torch.Tensor{target}
   
   if t[1] - input[1] > 0 then
      return torch.ones(1)*-1
   else
      return torch.ones(1)
   end
end

local LogisCriterion, parent = torch.class('nn.LogisCriterion', 'nn.Criterion')

function LogisCriterion:__init()
   parent.__init(self)
   self.sizeAverage = true
end

function LogisCriterion:updateOutput(input, target)
   local t = torch.Tensor{target}
   return 2*torch.log(torch.ones(1) + torch.exp(-input*t))[1]
end

function LogisCriterion:updateGradInput(input, target)
   local t = torch.Tensor{target}
   return t/(torch.exp(input*t)+1)*(-2)
end
