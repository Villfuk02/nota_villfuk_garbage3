function getInfo()
    return {
        onNoUnits = SUCCESS, -- instant success
        tooltip = "Move units in the given direction, in a row perpendicualr to it.",
        parameterDefs = {
            {
                name = "direction",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "nota_villfuk_garbage3.Wind()",
            },
            {
                name = "leader",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "leader",
            },
            {
                name = "distance",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "100",
            },
            {
                name = "spacing",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "40",
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

-- speed-ups
local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit

function Run(self, units, parameter)
    local direction = parameter.direction -- Vector3
    local leader = parameter.leader[1]    -- unitID
    local distance = parameter.distance   -- number
    local spacing = parameter.spacing     -- number
    local fight = parameter.fight         -- boolean

    -- pick the spring command implementing the move
    local cmdID = fight and CMD.FIGHT or CMD.MOVE
    direction = Vec3(direction.normX, direction.normY, direction.normZ)
    local move = direction * distance
    local posX, posY, posZ = SpringGetUnitPosition(leader)
    local pos = Vec3(posX, posY, posZ)
    local targetPos = pos + move
    local offset = Vec3(-direction.z, direction.y, direction.x) * spacing

    local unitPositions = {}
    local unitCount = 0
    for _, unit in ipairs(units) do
        if unit ~= leader then
            local unitX, unitY, unitZ = SpringGetUnitPosition(unit)
            local unitPos = Vec3(unitX, unitY, unitZ)
            unitPositions[unit] = unitPos
            unitCount = unitCount + 1
        end
    end

    local formationSpotsPerSide = math.ceil(unitCount / 2)
    local formationSpots = {}
    for i = 1, formationSpotsPerSide do
        formationSpots[pos + offset * i + direction * 25] = false
        formationSpots[pos - offset * i + direction * 25] = false
    end

    local maxDistance = 0

    for _ = 1, unitCount do
        local minUnit = nil
        local minDistance = math.huge
        local minSpot = nil
        for unit, p in pairs(unitPositions) do
            for spot, occupied in pairs(formationSpots) do
                if not occupied then
                    local dist = (p - spot):Length()
                    if dist < minDistance then
                        minDistance = dist
                        minUnit = unit
                        minSpot = spot
                    end
                end
            end
        end
        if minUnit and minSpot then
            formationSpots[minSpot] = minUnit
            unitPositions[minUnit] = nil
            if (minDistance > maxDistance) then
                maxDistance = minDistance
            end
        end
    end

    if (maxDistance > distance) then
        local newMove = direction * 25
        targetPos = targetPos - move + newMove
    end

    SpringGiveOrderToUnit(leader, cmdID, targetPos:AsSpringVector(), {})
    for spot, unit in pairs(formationSpots) do
        if (unit) then
            SpringGiveOrderToUnit(unit, cmdID, spot:AsSpringVector(), {})
        end
    end

    return RUNNING
end

function Reset(self)
end
