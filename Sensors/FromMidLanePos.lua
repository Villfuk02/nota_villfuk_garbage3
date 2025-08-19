local sensorInfo = {
    name = "FromMidLanePos",
    desc = "Transform position in mid lane coordinate space to world space, inverse of ToMidLanePos",
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

return function(pos)
    local x = (pos.travel + pos.offset) * 0.707107
    local y = pos.height
    local z = Game.mapSizeZ - (pos.travel + pos.offset) * 0.707107

    return Vec3(x, y, z)
end
