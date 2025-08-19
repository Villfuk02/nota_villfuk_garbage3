local sensorInfo = {
    name = "UpdateMyUnits",
    desc = "Find my units and sort them by type",
    author = "Villfuk",
    date = "2025-08-17",
    license = "notAlicense"
}

local EVAL_PERIOD_DEFAULT = -1 -- instant, no caching

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

return function(units)
    myTeamID = Spring.GetMyTeamID()
    myUnits = Spring.GetTeamUnits(myTeamID)

    units = units or {}
    units.is_assigned = units.is_assigned or {}
    units.fark = units.fark or {}
    units.spy = units.spy or {}
    units.maverick = units.maverick or {}
    units.zeus = units.zeus or {}
    units.warrior = units.warrior or {}
    units.artillery = units.artillery or {}
    units.box = units.box or {}
    units.seer = units.seer or {}
    units.peeper = units.peeper or {}
    units.atlas = units.atlas or {}

    for _, unitID in ipairs(myUnits) do
        if unitID ~= 1 and units.is_assigned[unitID] == nil then
            units.is_assigned[unitID] = true
            local name = UnitDefs[Spring.GetUnitDefID(unitID)].name

            if name == "armfark" then
                table.insert(units.fark, unitID)
            elseif name == "armspy" then
                table.insert(units.spy, unitID)
            elseif name == "armmav" then
                table.insert(units.maverick, unitID)
            elseif name == "armzeus" then
                table.insert(units.zeus, unitID)
            elseif name == "armwar" then
                table.insert(units.warrior, unitID)
            elseif name == "armmart" then
                table.insert(units.artillery, unitID)
            elseif name == "armbox" then
                table.insert(units.box, unitID)
            elseif name == "armseer" then
                table.insert(units.seer, unitID)
            elseif name == "armpeep" then
                table.insert(units.peeper, unitID)
            elseif name == "armatlas" then
                table.insert(units.atlas, unitID)
            end
        end
    end

    for _, list in pairs(units) do
        for i = #list, 1, -1 do
            local value = list[i]
            if not Spring.ValidUnitID(value) or Spring.GetUnitHealth(value) == 0 then
                table.remove(list, i)
                units.is_assigned[value] = nil
            end
        end
    end

    return units
end
