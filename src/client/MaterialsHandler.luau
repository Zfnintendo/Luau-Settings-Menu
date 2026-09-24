local MaterialsHandler = {}
MaterialsHandler.__index = MaterialsHandler

export type DefaultMaterials = { [Instance]: Enum.Material}
export type DefaultTextures = { [Instance]: string}
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
        
    }, MaterialsHandler)

    return self

end

-- // Getters //

-- // Setters //


return MaterialsHandler