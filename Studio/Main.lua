-- / Services \ --
-- \          / --

-- / Variables \ --
local ClassBases = require(script.Classes)
--local TblFormater = require(script.TblFormat)
local DataFolder = script.Parent.Data
local Decoder = require(DataFolder.Decoder)
local Encoder = require(DataFolder.Encoder)

local ExportLocation = workspace.export_stuff
-- \           / --

-- / Functionality \ --
function Encode(List)
	local Encoded = {}
	local ObjectToId = {}

	for Id, Obj in ipairs(List) do
		ObjectToId[Obj] = Id
	end
	
	for Id, Obj in ipairs(List) do
		local Class = Obj.ClassName
		local Base = ClassBases[Class]
		if not Base then warn(`{Class} isn't a supported type!`) continue end
		
		local Data = {
			Class = Class
		}
		
		local Parent = Obj.Parent
		if Parent then
			Data.Parent = ObjectToId[Parent]
		end
		
		for PropName, DefVal in Base do
			local Val = Obj[PropName]
			if Val == DefVal then continue end
			
			local EncodeFunction = Encoder[PropName]
			if EncodeFunction then
				Data[PropName] = EncodeFunction(Val)
			elseif typeof(Val) == "Instance" then
				Data[PropName] = ObjectToId[Val]
			else
				Data[PropName] = Val
			end
		end
		
		Encoded[Id] = Data
	end
	return Encoded
end

local Data = Encode(ExportLocation:GetDescendants())
ExportLocation:ClearAllChildren()

function DecodeAndCreate(EncodedData)
	local IdToObject = {}
	local Refs = {}
	
	for Id, Data in EncodedData do
		local Object = Instance.new(Data.Class)
		IdToObject[Id] = Object
		
		Data.Class = nil
		
		for PropName, Val in Data do
			local DecodeFunction = Decoder[PropName]
			if DecodeFunction then
				Object[PropName] = DecodeFunction(Val, Object)
			elseif PropName == "Parent" or typeof(Object[PropName]) == "Instance" then
				table.insert(Refs, {
					Obj = Object,
					Prop = PropName,
					Ref = Val
				})
			else
				Object[PropName] = Val
			end
		end
		
		if not Data.Parent then
			Object.Parent = workspace
		end
	end
	
	for _, Ref in Refs do
		Ref.Obj[Ref.Prop] = IdToObject[Ref.Ref]
	end
end

DecodeAndCreate(Data)
-- \               / --
