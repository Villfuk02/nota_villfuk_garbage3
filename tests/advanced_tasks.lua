require "tests.basic_tasks"

print("ADVANCED TASKS")

local elements = {
    [8695] = {
        air = false,
        ammo = {
            [1] = {
                count = 45,
                defName = "rifle",
            },
            [2] = {
                count = 1,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 5984,
        teamID = 3,
    },
    [23] = {
        air = false,
        ammo = {
            [1] = {
                count = 25,
                defName = "mg",
            }
        },
        defName = "machinegunner",
        distance = 350,
        teamID = 1,
    },
    [2454] = {
        air = true,
        ammo = {
            [1] = {
                count = 1140,
                defName = "aircannon",
            }
        },
        defName = "fighter",
        distance = 1840,
        teamID = 2,
    },
    [13541] = {
        air = false,
        ammo = {
            [1] = {
                count = 15,
                defName = "rifle",
            },
            [2] = {
                count = 3,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 5321,
        teamID = 3,
    },
    [13544] = {
        air = false,
        ammo = {
            [1] = {
                count = 25,
                defName = "rifle",
            },
            [2] = {
                count = 2,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 5328,
        teamID = 3,
    },
    [14584] = {
        air = false,
        ammo = {
            [1] = {
                count = 45,
                defName = "rifle",
            },
            [2] = {
                count = 1,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 5228,
        teamID = 3,
    },
    [19854] = {
        air = false,
        ammo = {
            [1] = {
                count = 70,
                defName = "rifle",
            },
            [2] = {
                count = 6,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 5541,
        teamID = 3,
    },
    [52411] = {
        air = false,
        ammo = {
            [1] = {
                count = 7,
                defName = "HE",
            },
            [2] = {
                count = 15,
                defName = "sabot",
            },
        },
        defName = "tank",
        distance = 684,
        teamID = 1,
    },
    [58411] = {
        air = false,
        ammo = {
            [1] = {
                count = 5,
                defName = "HE",
            },
            [2] = {
                count = 8,
                defName = "sabot",
            },
        },
        defName = "tank",
        distance = 1001,
        teamID = 1,
    },
    [98741] = {
        air = false,
        ammo = {
            [1] = {
                count = 17,
                defName = "HE",
            },
            [2] = {
                count = 0,
                defName = "sabot",
            },
        },
        defName = "tank",
        distance = 1021,
        teamID = 2,
    },
    [22248] = {
        air = false,
        ammo = {
            [1] = {
                count = 18,
                defName = "rifle",
            },
            [2] = {
                count = 4,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 284,
        teamID = 1,
    },
    [85471] = {
        air = false,
        ammo = {
            [1] = {
                count = 0,
                defName = "rifle",
            },
            [2] = {
                count = 2,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 284,
        teamID = 1,
    },
    [95450] = {
        air = false,
        ammo = {
            [1] = {
                count = 0,
                defName = "rifle",
            },
            [2] = {
                count = 0,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 400,
        teamID = 1,
    },
    [95520] = {
        air = false,
        ammo = {
            [1] = {
                count = 0,
                defName = "rifle",
            },
            [2] = {
                count = 5,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 421,
        teamID = 1,
    },
    [89562] = {
        air = false,
        ammo = {
            [1] = {
                count = 0,
                defName = "rifle",
            },
            [2] = {
                count = 5,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 500,
        teamID = 1,
    },
    [84515] = {
        air = false,
        ammo = {},
        defName = "bugBuilder",
        distance = 1080,
        teamID = 4,
    },
    [98741] = {
        air = false,
        ammo = {
            [1] = {
                count = math.huge,
                defName = "acid",
            }
        },
        defName = "bugSpitter",
        distance = 1080,
        teamID = 4,
    },
}

local inserts = {
    [14751] = {
        air = false,
        ammo = {
            [1] = {
                count = 15,
                defName = "HE",
            },
            [2] = {
                count = 14,
                defName = "sabot",
            },
        },
        defName = "tank",
        distance = 2685,
        teamID = 1,
    },
    [95520] = {
        air = false,
        ammo = {
            [1] = {
                count = 14,
                defName = "HE",
            },
            [2] = {
                count = 14,
                defName = "sabot",
            },
        },
        defName = "tank",
        distance = 552,
        teamID = 1,
    },
    [84564] = {
        air = false,
        ammo = {},
        defName = "bugBuilder",
        distance = 1154,
        teamID = 4,
    },
    [84585] = {
        air = false,
        ammo = {},
        defName = "bugBuilder",
        distance = 1150,
        teamID = 4,
    },
    [55854] = {
        air = false,
        ammo = {
            [1] = {
                count = 58,
                defName = "rifle",
            },
            [2] = {
                count = 3,
                defName = "grenade",
            },
        },
        defName = "soldier",
        distance = 400,
        teamID = 2,
    },
    [11474] = {
        air = true,
        ammo = {
            [1] = {
                count = 1300,
                defName = "aircannon",
            }
        },
        defName = "fighter",
        distance = 10585,
        teamID = 2,
    },
}

local deletionsByID = { 8695, 84585, 84515 }

--Use Inputs to Initalize table
--by reading elements
--Insert all new elements contained in inserts
for key, value in pairs(inserts) do
    elements[key] = value
end

--Delete all elements by ID contained in deletionsByID
for _, id in ipairs(deletionsByID) do
    elements[id] = nil
end

--Query all “air” units
print(Format(table.filter(elements,
    function(unit)
        return unit.air
    end
)))
print()

--Query all “tank” units
print(Format(table.filter(elements,
    function(unit)
        return unit.defName == "tank"
    end
)))
print()

--Query ammunition of “tank” units of team 1
print(Format(table.filter(elements,
    function(unit)
        return unit.defName == "tank" and unit.teamID == 1
    end
)))
print()

--Query all units in team 4 which have any weapon (no ammo means unit has not weapon).
print(Format(table.filter(elements,
    function(unit)
        return unit.teamID == 4 and next(unit.ammo) ~= nil
    end
)))
print()

--Query all enemy units in 1500 radius considering
--You are team 1
--All other teams are enemies
print(Format(table.filter(elements,
    function(unit)
        return unit.teamID ~= 1 and unit.distance <= 1500
    end
)))
print()

--Measure for each one of 4 teams:
--How many grenades they have available per unit
for i = 1, 4 do
    print("Team " .. i .. " grenades: " .. Format(table.map(table.filter(elements,
            function(unit)
                return unit.teamID == i and unit.ammo[2] and unit.ammo[2].defName == "grenade"
            end
        ),
        function(unit)
            return unit.ammo[2].count
        end
    )))
end
print()

--How many grenades they have available per “soldier” unit
for i = 1, 4 do
    print("Team " .. i .. " grenades: " .. Format(table.map(table.filter(elements,
            function(unit)
                return unit.teamID == i and unit.defName == "soldier" and unit.ammo[2] and unit.ammo[2].defName == "grenade"
            end
        ),
        function(unit)
            return unit.ammo[2].count
        end
    )))
end
print()

--Considering “rifle”, “machinegun”, “acid” is ammunition which can kill 1 “soldier” and “HE” is ammunition which can kill 10 “soldiers”, for each one of 4 teams make decision:
--With all units our team have available can we kill 100 soldiers? YES/NO
for i = 1, 4 do
    local total = 0
    for _, unit in pairs(elements) do
        if unit.teamID == i and unit.ammo[1] then
            if unit.ammo[1].defName == "rifle" then
                total = total + unit.ammo[1].count
            elseif unit.ammo[1].defName == "machinegun" then
                total = total + unit.ammo[1].count
            elseif unit.ammo[1].defName == "acid" then
                total = total + unit.ammo[1].count
            elseif unit.ammo[1].defName == "HE" then
                total = total + unit.ammo[1].count * 10
            end
        end
    end
    print("Team " .. i .. " can kill 100 soldiers: " .. (total >= 100 and "YES" or "NO") .. " (" .. total .. ")")
end
