-- / Services \ --
-- \          / --

-- / Types \ --
-- \       / --

-- / Variables \ --
local Main = script.Parent.Parent
local IdsFolder = Main.Ids
local SurfaceIds = require(IdsFolder.SurfaceIds)
local MeshTypeIds = require(IdsFolder.MeshTypeIds)
local FaceTypeIds = require(IdsFolder.FaceTypeIds)
local Decoder = {}
-- \           / --

-- / Functionality \ --
--> Helper Functions
do
function Vect3(Tbl)
	return Vector3.new(table.unpack(Tbl))
end

function Vect2(Tbl)
	return Vector2.new(table.unpack(Tbl))
end

function CF(Tbl)
	return CFrame.new(table.unpack(Tbl))
end

function GetSurfaceName(Id)
	return SurfaceIds.IdToSurface[Id]
end

function DoSurface(TargetSurface, Id)
	local Name = GetSurfaceName(Id) 
	return Name
end

function RbxAsset(Id)
	return "rbxassetid://"..tostring(Id)
end

function ContentAsset(Id)
	return Content.fromUri("rbxassetid://"..tostring(Id))
end
end

function Decoder.Position(Value)
	return Vect3(Value)
end

function Decoder.Orientation(Value)
	return Vect3(Value)
end

function Decoder.Size(Value)
	return Vect3(Value)
end

function Decoder.CFrame(Value)
	return CF(Value)
end

--function Decoder.Parent(Value)
--	print(`{Part} would parent to: '{Value}'!`)
--end

-- SpecialMeshes
do
function Decoder.Scale(Value, SM)
	return Vect3(Value)
end

function Decoder.Offset(Value, SM)
	return Vect3(Value)
end

function Decoder.MeshType(Value, SM)
	return MeshTypeIds.IdToMeshType[Value]
end

function Decoder.MeshId(Value, SM)
	return RbxAsset(Value)
end

function Decoder.TextureId(Value, SM)
	return RbxAsset(Value)
end

function Decoder.VertexColor(Value, SM)
	return Vect3(Value)
end
end

do
--function Decoder.ColorMapContent(Val, Obj)
--	return ContentAsset(Val)
--end

--function Decoder.MetalnessMapContent(Val)
--	return ContentAsset(Val)
--end

--function Decoder.NormalMapContent(Val)
--	return ContentAsset(Val)
--end

--function Decoder.RoughnessMapContent(Val)
--	return ContentAsset(Val)
--end

function Decoder.Texture(Val)
	return RbxAsset(Val)
end

function Decoder.UVOffset(Val)
	return Vect2(Val)
end

function Decoder.UVScale(Val)
	return Vect2(Val)
end

function Decoder.Face(Val)
	return FaceTypeIds.IdToFaceType[Val]
end
end

function Decoder.Color3(Value)
	return Color3.new(table.unpack(Value))
end

function Decoder.Color(Value)
	return Color3.new(table.unpack(Value))
end

function Decoder.Name(Value)
	if type(Value) ~= "string" then return end
	return Value
end

--> Surfaces
do
--function Decoder.AllSurfaces(Value)
--	local Name = GetSurfaceName(Value) if not Name then return end
--	Part.TopSurface=Name
--	Part.BottomSurface=Name
--	Part.RightSurface=Name
--	Part.LeftSurface=Name
--	Part.FrontSurface=Name
--	Part.BackSurface=Name
--end
function Decoder.TopSurface(Value)
	return DoSurface("TopSurface",Value)
end
function Decoder.BottomSurface(Value)
	return DoSurface("BottomSurface",Value)
end
function Decoder.RightSurface(Value)
	return DoSurface("RightSurface",Value)
end
function Decoder.LeftSurface(Value)
	return DoSurface("LeftSurface",Value)
end
function Decoder.FrontSurface(Value)
	return DoSurface("FrontSurface",Value)
end
function Decoder.BackSurface(Value)
	return DoSurface("BackSurface",Value)
end
end

return Decoder
-- \               / --
