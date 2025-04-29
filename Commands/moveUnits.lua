function getInfo()
    return {
        onNoUnits = SUCCESS, -- instant success
        tooltip = "Move units to the given positions.",
        parameterDefs = {
            {
                name = "positions",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = ""
            },
            {
                name = "fight",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "false",
            }
        }
    }
end

local function SquareDistance(a, b)
    return (a.x - b.x) * (a.x - b.x) + (a.z - b.z) * (a.z - b.z) + ((a.y or 0) - (b.y or 0)) * ((a.y or 0) - (b.y or 0))
end

-- speed-ups
local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit

function Run(self, units, parameter)
    local positions = parameter.positions -- Vector3 array
    local fight = parameter.fight         -- boolean

    -- validation
    if (type(positions) ~= "table") then
        Logger.warn("moveUnits", "Positions is not a table.")
        return FAILURE
    end
    if (type(fight) ~= "boolean") then
        Logger.warn("moveUnits", "Fight is not a boolean.")
        return FAILURE
    end

    local cmdID = fight and CMD.FIGHT or CMD.MOVE

    -- move each unit to the given position
    local allArrived = true
    for i, unitID in ipairs(units) do
        local pos = positions[i]
        if (pos == nil) then
            break
        end
        local unitX, unitY, unitZ = SpringGetUnitPosition(unitID)
        if (SquareDistance({ x = pos.x, z = pos.z }, { x = unitX, z = unitZ }) > 500) then
            allArrived = false
            SpringGiveOrderToUnit(unitID, cmdID, { pos.x, pos.y, pos.z }, {})
        end
    end

    return allArrived and SUCCESS or RUNNING
end

function Reset(self)
end
