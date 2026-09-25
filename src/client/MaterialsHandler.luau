local MaterialsHandler = {}
MaterialsHandler.__index = MaterialsHandler

export type DefaultMaterials = { [BasePart]: Enum.Material}
export type DefaultTextures = { [Texture]: string}
type MatchedDescendants = { Instance }

export type MaterialsHandler = setmetatable<{
    materialService: MaterialService,
    WorkSpace: Workspace,
    defaultMaterials: DefaultMaterials,
    defaultTextures: DefaultTextures
}, typeof(MaterialsHandler)>

-- // Helper Functions //

-- Gets the descendants of an instance and filters for the specific type provided in the string
local function getDescendantsAndFilter(inst: Instance, instType: string): MatchedDescendants

    local matchedDescendants: MatchedDescendants = {}

    for i, descendant: Instance in inst:GetDescendants() do 
        if descendant:IsA(instType) then
            table.insert(matchedDescendants, descendant)
        end
    end

    return matchedDescendants

end

-- Returns a key-value pairs of Instances to Enum.Materials
local function setMaterialToInstance(WorkSpace: Workspace): DefaultMaterials

    local matchedDescendants: MatchedDescendants = getDescendantsAndFilter(WorkSpace, "BasePart")
    local defaultMaterials: DefaultMaterials = {}

    for i, descendant: BasePart in matchedDescendants do 
        defaultMaterials[descendant] = descendant.Material
    end

    return defaultMaterials

end

-- Returns a key-value pairs of Instances to strings for textures
local function setTextureToInstance(WorkSpace: Workspace): DefaultTextures

    local matchedDescendants: MatchedDescendants = getDescendantsAndFilter(WorkSpace, "Texture")
    local defaultTextures: DefaultTextures = {}

    for i, descendant: Texture in matchedDescendants do
        defaultTextures[descendant] = descendant.ColorMapContent
    end

    return defaultTextures

end



-- // Constructor //
function MaterialsHandler.new(wSpace: Workspace, materialService: MaterialService): MaterialsHandler

    local self = setmetatable({
        materialService = materialService,
        WorkSpace = wSpace,
        defaultMaterials = setMaterialToInstance(wSpace),
        defaultTextures = setTextureToInstance(wSpace),
    }, MaterialsHandler)

    return self
end



-- // Getters //

-- Gets the MaterialService
function MaterialsHandler.getMaterialService(self: MaterialsHandler): MaterialService
    return self.materialService
end

-- Gets the workspace
function MaterialsHandler.getWorkspace(self: MaterialsHandler): Workspace
    return self.WorkSpace
end

-- Gets the key-value pairs of BaseParts
function MaterialsHandler.getDefaultMaterials(self: MaterialsHandler): DefaultMaterials
    return self.defaultMaterials
end

-- Gets the key-value pairs of Textures
function MaterialsHandler.getDefaultTextures(self: MaterialsHandler): DefaultTextures
    return self.defaultTextures
end

-- Gets the specific default Enum Material from a specific Instance
function MaterialsHandler.getSpecificMaterialFromInstance(self: MaterialsHandler, basePartInst: BasePart): Enum.Material
    return self.defaultMaterials[basePartInst]
end

-- Gets the specific default texture id from a specific Instance
function MaterialsHandler.getSpecificTextureFromInstance(self: MaterialsHandler, textureInst: Texture): string
    return self.defaultTextures[textureInst]
end



-- // Setters //

-- Sets the key valuye pairs of default materials?
function MaterialsHandler.setDefaultMaterials(self: MaterialsHandler, defaultMaterials: DefaultMaterials)
    self.defaultMaterials = defaultMaterials
end

-- Sets the key value pairs of default textures
function MaterialsHandler.setDefaultTextures(self: MaterialsHandler, defaultTextures: DefaultTextures)
    self.defaultTextures = defaultTextures
end

-- Sets the specific default enum material for a specific instance
function MaterialsHandler.setSpecificMaterial(self:MaterialsHandler, basePartInst: BasePart, material: Enum.Material)
    self.defaultMaterials[basePartInst] = material
end

-- Sets the specific default texture for a specific instance
function MaterialsHandler.setSpecificTexture(self: MaterialsHandler, textureInst: Texture, textureId: string)
    self.defaultTextures[textureInst] = textureId
end



return MaterialsHandler