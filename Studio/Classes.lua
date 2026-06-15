-- / Variables \ --
local Classes = {}
-- \           / --

-- / Functionality \ --
for Class, Mod in script:GetChildren() do
	local Data = require(Mod)
	Classes[Class] = Data
end

return Classes
-- \               / --
