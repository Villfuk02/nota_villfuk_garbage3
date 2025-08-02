local sensorInfo = {
    name = "MakeHeightGrid",
    desc = "Create a grid of points and stores their positions including ground height.",
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

-- @argument spacing [number] spacing between sample points
return function(spacing)
    -- validate inputs
    if (type(spacing) ~= "number") then
        Logger.warn("MakeHeightGrid", "Spacing is not a number.")
        return {}
    end

    local mapSizeX = Game.mapSizeX
    local mapSizeZ = Game.mapSizeZ
    local spots = {}
    local min = math.huge
    for x = 1, mapSizeX / spacing do
        spots[x] = {}
        for z = 1, mapSizeZ / spacing do
            posX = x * spacing
            posZ = z * spacing
            posY = Spring.GetGroundHeight(posX, posZ)
            spots[x][z] = Vec3(posX, posY, posZ)
            if posY < min then
                min = posY
            end
        end
    end
    return spots
end
