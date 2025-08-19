local sensorInfo = {
    name = "ToMidLanePos",
    desc = "Transform position to mid lane coordinate space",
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
    local x = pos.x or pos[1] or 0
    local y = pos.y or pos[2] or 0
    local z = Game.mapSizeZ - (pos.z or pos[3] or 0)

    -- distance along the diagonal
    local travel = (x + z) * 0.707107
    -- offset perpendicular to the diagoanal
    local offset = (x - z) * 0.707107

    return { travel = travel, offset = offset, height = y }
end
