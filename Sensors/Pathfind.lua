local sensorInfo = {
    name = "Pathfind",
    desc = "Find the best paths using a precomputed navigation grid.",
    author = "Villfuk",
    date = "2025-08-01",
    license = "notAlicense"
}

local EVAL_PERIOD_DEFAULT = -1 -- instant, no caching

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

local function getClosestGridPoint(pos)
    local gridX = math.floor(pos.x / bb.spacing + 0.5)
    local gridZ = math.floor(pos.z / bb.spacing + 0.5)
    if gridX < 1 then
        gridX = 1
    elseif gridX > #bb.height_grid then
        gridX = #bb.height_grid
    end
    if gridZ < 1 then
        gridZ = 1
    elseif gridZ > #bb.height_grid[1] then
        gridZ = #bb.height_grid[1]
    end
    return { gridX, gridZ }
end

return function(to, reverse)
    local targetPos = (type(to) == "number") and Vec3(Spring.GetUnitPosition(to)) or Vec3(to.x, to.y or 0, to.z)

    local current = getClosestGridPoint(targetPos)
    local path = { bb.height_grid[current[1]][current[2]] }

    while bb.prev[current[1]][current[2]] do
        local prev = bb.prev[current[1]][current[2]]
        path[#path + 1] = bb.height_grid[prev[1]][prev[2]]
        current = prev
    end

    if not reverse then
        -- reverse the path if needed
        local realPath = {}
        for i = #path, 1, -1 do
            realPath[#realPath + 1] = path[i]
        end
        path = realPath
        path[#path + 1] = targetPos
    else
        path[#path + 1] = startPos
    end

    return path
end
