function getInfo()
    return {
        onNoUnits = SUCCESS, -- instant success
        tooltip = "Find the first unit with given def name and store its ID in a blackboard variable.",
        parameterDefs = {
            {
                name = "variable",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "\"leader\"",
            },
            {
                name = "defName",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "\"armmav\"",
            }
        }
    }
end

function Run(self, units, parameter)
    local variable = parameter.variable -- string
    local defName = parameter.defName   -- string

    -- validation
    if (defName == nil) then
        Logger.warn("findUnitByDef", "defName is not defined.")
        return FAILURE
    end
    local def = UnitDefNames[defName]
    if (def == nil) then
        Logger.warn("findUnitByDef", "defName is not valid.")
        return FAILURE
    end
    if (type(variable) ~= "string") then
        Logger.warn("findUnitByDef", "variable is not a valid string.")
        return FAILURE
    end

    -- find the first unit with given def name and store its ID
    local defId = def.id
    for _, unit in ipairs(units) do
        local unitDefId = Spring.GetUnitDefID(unit)
        if (unitDefId == defId) then
            bb[variable] = unit
            return SUCCESS
        end
    end

    return FAILURE
end

function Reset(self)
end
