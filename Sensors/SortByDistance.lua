local sensorInfo = {
    name = "SortByDIstance",
    desc = "Sort positions by distance from a point",
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

local function SquareDistance(a, b)
    return (a.x - b.x) * (a.x - b.x) + (a.z - b.z) * (a.z - b.z) + ((a.y or 0) - (b.y or 0)) * ((a.y or 0) - (b.y or 0))
end

-- @argument target [vector] the target point to sort by distance from
-- @argument points [array of vectors] source points
return function(target, points)
    local sortedPoints = {}
    for _, p in ipairs(points) do
        local sqDist = SquareDistance(target, p)
        sortedPoints[#sortedPoints + 1] = { x = p.x, y = p.y, z = p.z, sqDist = sqDist }
    end
    table.sort(sortedPoints, function(a, b) return a.sqDist < b.sqDist end)

    return sortedPoints
end
