local sensorInfo = {
    name = "FindUnitsToRescue",
    desc = "Returns a list of unitsto rescue in ttdr. Based on script by Kahlan.",
    author = "Villfuk",
    date = "2025-08-01",
    license = "none",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

function insertToList(listToInsert, returnList)
    for _, item in ipairs(listToInsert) do
        table.insert(returnList, item)
    end
end

-- @description returns list of units ordered by priorities (number of points)
return function(myUnits)
    local orderedUnits = {}
    local unitFilter = Sensors.core.FilterUnitsByCategory

    local runners = unitFilter(myUnits, Categories.nota_kahlan_ttdr.runner)
    local rockos = unitFilter(myUnits, Categories.nota_kahlan_ttdr.rocko)
    local bulldogs = unitFilter(myUnits, Categories.nota_kahlan_ttdr.bulldog)
    local hatracks = unitFilter(myUnits, Categories.nota_kahlan_ttdr.hatracks)
    local bods = unitFilter(myUnits, Categories.nota_kahlan_ttdr.bod)

    insertToList(bods, orderedUnits)
    insertToList(hatracks, orderedUnits)
    insertToList(bulldogs, orderedUnits)
    insertToList(rockos, orderedUnits)
    insertToList(runners, orderedUnits)

    return orderedUnits
end
