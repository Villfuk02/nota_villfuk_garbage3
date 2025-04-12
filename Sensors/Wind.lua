local sensorInfo = {
    name = "Wind",
    desc = "Provides the wind data in a table with named variables",
    author = "Villfuk",
    date = "02-04-2025",
    license = "MIT",
}

-- get madatory module operators
VFS.Include("modules.lua")                                        -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

local EVAL_PERIOD_DEFAULT = -1    -- acutal, no caching

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

-- @description return current wind statistics
return function()
    local winddirX, winddirY, winddirZ, windstrength, windnormDirX, windnormDirY, windnormDirZ = Spring.GetWind()
    return {
        x = winddirX,
        y = winddirY,
        z = winddirZ,
        strength = windstrength,
        normX = windnormDirX,
        normY = windnormDirY,
        normZ = windnormDirZ
    }
end
