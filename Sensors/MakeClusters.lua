local sensorInfo = {
    name = "MakeClusters",
    desc = "Make clusters from points",
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

-- @argument points [array of vectors] source points
-- @argument spacing [number] maximum spacing between points in a cluster
return function(points, maxSpacing)
    -- validate inputs
    if (type(maxSpacing) ~= "number") then
        Logger.warn("MakeClusters", "MaxSpacing is not a number.")
        return {}
    end

    local squareSpacing = maxSpacing * maxSpacing
    local processed = {}

    for _, p in ipairs(points) do
        for q, _ in pairs(processed) do
            if (SquareDistance(p, q) <= squareSpacing) then
                processed[p] = q
                local cluster = processed[q]
                while not cluster.count do
                    cluster = processed[cluster]
                end
                cluster.count = cluster.count + 1
                cluster.sum = { x = cluster.sum.x + p.x, z = cluster.sum.z + p.z, y = (cluster.sum.y or 0) + (p.y or 0) }
                break
            end
        end
        if (not processed[p]) then
            processed[p] = { count = 1, sum = p }
        end
    end


    local clusters = {}
    for _, c in pairs(processed) do
        if c.sum then
            clusters[#clusters + 1] = { x = c.sum.x / c.count, z = c.sum.z / c.count, y = (c.sum.y or 0) / c.count, count = c.count }
        end
    end

    return clusters
end
