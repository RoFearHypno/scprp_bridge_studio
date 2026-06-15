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
local Encoder = {}
-- \           / --

-- / Functionality \ --
do
function Vect3(Vect)
	return {Vect.X,Vect.Y,Vect.Z}
end

function CF(CF)
	return {CF:GetComponents()}
end

function GetSurfaceId(Name)
	return SurfaceIds.SurfaceToId[Name]	
end

function DoSurface(SurfaceType)
	return GetSurfaceId(Enum.SurfaceType.Smooth.Name)
end

function RbxAsset(Str)
	return string.gsub(Str,"rbxassetid://","")
end

function ContentAsset(Cont)
	if Cont.SourceType == Enum.ContentSourceType.Uri then
		return string.gsub(Cont.Uri,"rbxassetid://","")
	else
		return 0
	end
end
end

function Encoder.CFrame(Val)
	return CF(Val)
end

function Encoder.Size(Val)
	return Vect3(Val)
end

-- SpecialMeshes
do
function Encoder.Scale(Val)
	return Vect3(Val)
end

function Encoder.Offset(Val)
	return Vect3(Val)
end

function Encoder.MeshType(Val)
	return MeshTypeIds.MeshTypeToId[Val]
end

function Encoder.MeshId(Val)
	return string.gsub(Val,"rbxassetid://","")
end

function Encoder.TextureId(Val)
	return string.gsub(Val,"rbxassetid://","")
end

function Encoder.VertexColor(Val)
	return Vect3(Val)
end
end

-- Texture / Decal
do
--function Encoder.ColorMapContent(Val)
--	return ContentAsset(Val)
--end

--function Encoder.MetalnessMapContent(Val)
--	return ContentAsset(Val)
--end

--function Encoder.NormalMapContent(Val)
--	return ContentAsset(Val)
--end

--function Encoder.RoughnessMapContent(Val)
--	return ContentAsset(Val)
--end

function Encoder.Texture(Val)
	return RbxAsset(Val)
end

function Encoder.UVOffset(Val)
	return {Val.X,Val.Y}
end

function Encoder.UVScale(Val)
	return {Val.X,Val.Y}
end

--function Encoder.OffsetStudsU(Val)
--end

function Encoder.Face(Val)
	return FaceTypeIds.FaceTypeToId[Val.Name]
end
end

--function Encoder.Rotation()
--	return 
--end

--function Encoder.Name(Val)
--	return Val
--end

function Encoder.Color(Val)
	return {Val.R,Val.G,Val.B}
end

function Encoder.Color3(Val)
	return {Val.R,Val.G,Val.B}
end

do
function Encoder.TopSurface(Value)
	return DoSurface(Value)
end
function Encoder.BottomSurface(Value)
	return DoSurface(Value)
end
function Encoder.RightSurface(Value)
	return DoSurface(Value)
end
function Encoder.LeftSurface(Value)
	return DoSurface(Value)
end
function Encoder.FrontSurface(Value)
	return DoSurface(Value)
end	
function Encoder.BackSurface(Value)
	return DoSurface(Value)
end
end

return Encoder
-- \               / --
