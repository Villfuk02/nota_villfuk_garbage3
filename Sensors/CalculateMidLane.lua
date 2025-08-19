local sensorInfo = {
    name = "CalculateMidLane",
    desc = "Find all units in the mid lane and calculate their positions in mid lane coordinate space, also finds the frontline",
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

function isEnemy(unitID, enemyIDs)
    local unitTeam = Spring.GetUnitTeam(unitID)
    for index, value in ipairs(enemyIDs) do
        if value == unitTeam then
            return true
        end
    end
    return false
end

return function(enemyBuildings, myUnits, width)
    enemyUnitData = {}

    local maxDist = (Game.mapSizeX + Game.mapSizeZ) * 0.707107
    local buildingFrontline = maxDist
    local closestEnemy = maxDist
    local fartherstAlly = 0
    local secondAlly = 0
    local thirdAlly = 0

    for unitID, value in pairs(enemyBuildings) do
        local midLanePos = Sensors.ToMidLanePos(value.position)

        if math.abs(midLanePos.offset) < width then
            enemyUnitData[unitID] = value
            enemyUnitData[unitID].midLanePos = midLanePos
            buildingFrontline = math.min(buildingFrontline, midLanePos.travel - value.weaponRange)
            closestEnemy = math.min(closestEnemy, midLanePos.travel)
            anyBuildings = true
        else
            enemyUnitData[unitID] = nil
        end
    end


    local enemyIDs = Sensors.core.EnemyTeamIDs()
    local allUnits = Spring.GetAllUnits()
    for _, unitID in ipairs(allUnits) do
        if isEnemy(unitID, enemyIDs) then
            -- enemies
            if not Spring.GetUnitIsDead(unitID) then
                local x, y, z    = Spring.GetUnitPosition(unitID)
                local position   = Vec3(x, y, z)
                local midLanePos = Sensors.ToMidLanePos(position)

                if math.abs(midLanePos.offset) < width then
                    enemyUnitData[unitID] = {
                        position = position,
                        midLanePos = midLanePos
                    }
                    closestEnemy = math.min(closestEnemy, midLanePos.travel)
                else
                    enemyUnitData[unitID] = nil
                end
            else
                enemyUnitData[unitID] = nil
            end
            -- allies
        elseif not myUnits[unitID] then
            if not Spring.GetUnitIsDead(unitID) then
                local x, y, z    = Spring.GetUnitPosition(unitID)
                local position   = Vec3(x, y, z)
                local midLanePos = Sensors.ToMidLanePos(position)

                if math.abs(midLanePos.offset) < width then
                    if midLanePos.travel > fartherstAlly then
                        thirdAlly = secondAlly
                        secondAlly = fartherstAlly
                        fartherstAlly = midLanePos.travel
                    elseif midLanePos.travel > secondAlly then
                        thirdAlly = secondAlly
                        secondAlly = midLanePos.travel
                    elseif midLanePos.travel > thirdAlly then
                        thirdAlly = midLanePos.travel
                    end
                end
            end
        end
    end

    frontline = math.min(thirdAlly, closestEnemy)
    if closestEnemy >= maxDist then
        closestEnemy = maxDist / 2
    end


    myUnitData = {}
    for unitID, alive in pairs(myUnits) do
        if alive then
            local x, y, z = Spring.GetUnitPosition(unitID)
            local position = Vec3(x, y, z)
            local midLanePos = Sensors.ToMidLanePos(position)

            if math.abs(midLanePos.offset) < width then
                myUnitData[unitID] = {
                    position = position,
                    midLanePos = midLanePos
                }
            else
                myUnitData[unitID] = nil
            end
        end
    end


    return { enemy = enemyUnitData, my = myUnitData, buildingFrontline = buildingFrontline, closestEnemy = closestEnemy, frontline = frontline }
end
