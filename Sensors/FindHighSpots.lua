local sensorInfo = {
    name = "FindHighSpots",
    desc = "Find high spots in the map",
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

-- @argument spacing [number] spacing between sample points
-- @argument height [number] height threshold for high spots
return function(spacing, height)
    -- validate inputs
    if (type(spacing) ~= "number") then
        Logger.warn("FindHighSpots", "Spacing is not a number.")
        return {}
    end

    if (type(height) ~= "number") then
        Logger.warn("FindHighSpots", "Height is not a number.")
        return {}
    end

    local mapSizeX = Game.mapSizeX
    local mapSizeZ = Game.mapSizeZ
    local spots = {}
    for x = spacing, mapSizeX, spacing do
        for z = spacing, mapSizeZ, spacing do
            if (Spring.GetGroundHeight(x, z) >= height) then
                spots[#spots + 1] = { x = x, z = z }
            end
        end
    end
    return spots
end
