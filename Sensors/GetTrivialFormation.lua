local sensorInfo = {
    name = "GetTrivialFormation",
    desc = "Return a formation definition of one unit in front and other units behind it",
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

return function(what)
    local positions = {}

    positions[1] = Vec3(0, 0, 0)
    for _, _ in ipairs(units) do
        positions[#positions + 1] = Vec3(0, 0, -20)
    end

    return positions
end
