local LightingHandler = {}
LightingHandler.__index = LightingHandler

export type LightingHandler = setmetatable<{
    lighting: Lighting,
}, typeof(LightingHandler)>



-- // Constructor //
function LightingHandler.new(lighting: Lighting): LightingHandler

    local self = setmetatable({
        lighting = lighting,
    }, LightingHandler)

    return self

end



-- // Getters //

-- Gets the shadows status
function LightingHandler.getGlobalShadows(self: LightingHandler): boolean
    return self.lighting.GlobalShadows
end

-- Gets the time
function LightingHandler.getClockTime(self: LightingHandler): number
    return self.lighting.ClockTime
end

-- Gets the ambient color
function LightingHandler.getAmbient(self: LightingHandler): Color3
    return self.lighting.Ambient
end

-- Gets the outdoor ambient color
function LightingHandler.getOutdoorAmbient(self: LightingHandler): Color3
    return self.lighting.OutdoorAmbient
end

-- Gets the brightness
function LightingHandler.getBrightness(self: LightingHandler): number
    return self.lighting.Brightness
end

-- Gets the lighting style
function LightingHandler.getLightingStyle(self: LightingHandler): Enum.LightingStyle
    return self.lighting.LightingStyle
end

-- Gets prioritise lighting quality
function LightingHandler.getLightingQuality(self: LightingHandler): boolean
    return self.lighting.PrioritizeLightingQuality
end



-- // Setters //

-- Sets the shadow status
function LightingHandler.setGlobalShadows(self: LightingHandler, value: boolean)
    self.lighting.GlobalShadows = value
end

-- Sets the time
function LightingHandler.setClockTime(self: LightingHandler, value: number)
    self.lighting.ClockTime = value
end

-- Sets the ambient color
function LightingHandler.setAmbient(self: LightingHandler, value: Color3)
    self.lighting.Ambient = value
end

-- Sets the outdoor ambient color
function LightingHandler.setOutdoorAmbient(self: LightingHandler, value: Color3)
    self.lighting.OutdoorAmbient = value
end

-- Sets the brightness
function LightingHandler.setBrightness(self: LightingHandler, value: number)
    self.lighting.Brightness = value
end

-- Sets the lighting style
function LightingHandler.setLightingStyle(self: LightingHandler, value: Enum.LightingStyle)
    self.lighting.LightingStyle = value
end

-- Sets the prioritise lighting quality
function LightingHandler.setLightingQuality(self: LightingHandler, value: boolean)
    self.lighting.PrioritizeLightingQuality = value
end



return LightingHandler