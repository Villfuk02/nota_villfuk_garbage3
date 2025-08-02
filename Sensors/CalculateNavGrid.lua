local sensorInfo = {
    name = "CalculateNavGrid",
    desc = "Find the navigation directions using a grid of positions and their heights.",
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


local directions = { { -1, 0, 1 }, { 1, 0, 1 }, { 0, -1, 1 }, { 0, 1, 1 }, { -1, -1, 1.41 }, { 1, -1, 1.41 }, { -1, 1, 1.41 }, { 1, 1, 1.41 } }


return function(startPos, radius)
    local start = getClosestGridPoint(startPos)

    -- initialize
    local prev = {}
    local dist = {}
    local cost = {}
    local queue = {}
    for x = 1, #bb.height_grid do
        prev[x] = {}
        dist[x] = {}
        cost[x] = {}
        for z = 1, #bb.height_grid[1] do
            dist[x][z] = math.huge
            cost[x][z] = 100 + math.max(0, bb.height_grid[x][z].y)

            -- set distance to 0 when in starting area
            if ((x - start[1]) * (x - start[1]) + (z - start[2]) * (z - start[2])) * bb.spacing * bb.spacing <= radius * radius then
                dist[x][z] = 0
                queue[#queue + 1] = { x, z }
            end
        end
    end

    Spring.Echo("Grid points: ", #bb.height_grid * #bb.height_grid[1])

    local visited = 0
    -- calculate distances
    while #queue > 0 do
        visited = visited + 1
        local current = table.remove(queue, 1)

        local d = dist[current[1]][current[2]]
        for _, dir in ipairs(directions) do
            local newX, newZ = current[1] + dir[1], current[2] + dir[2]
            if newX >= 1 and newX <= #bb.height_grid and newZ >= 1 and newZ <= #bb.height_grid[1] then
                local nd = dist[newX][newZ]
                local nnd = d + math.max(cost[newX][newZ], cost[current[1]][current[2]]) * dir[3]
                if nnd < nd then
                    prev[newX][newZ] = current
                    dist[newX][newZ] = nnd
                    table.insert(queue, { newX, newZ })
                end
            end
        end
    end

    Spring.Echo("Visited grid points: ", visited)

    return prev
end
