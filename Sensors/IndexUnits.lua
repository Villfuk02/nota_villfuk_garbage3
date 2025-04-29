local sensorInfo = {
    name = "IndexUnits",
    desc = "Assign an index to each unit",
    author = "Villfuk",
    date = "2025-04-29",
    license = "notAlicense"
}

local EVAL_PERIOD_DEFAULT = -1 -- instant, no caching

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

-- @argument priorityDefName [string] the defName of units that should get lower IDs
return function(priorityDefName)
    local def = UnitDefNames[priorityDefName]
    local defId = def and def.id

    local i = 1
    local indexedUnits = {}

    for _, unit in ipairs(units) do
        local unitDefId = Spring.GetUnitDefID(unit)
        if (unitDefId == defId) then
            indexedUnits[unit] = i
            i = i + 1
        end
    end

    for _, unit in ipairs(units) do
        if (not indexedUnits[unit]) then
            indexedUnits[unit] = i
            i = i + 1
        end
    end

    return indexedUnits
end
