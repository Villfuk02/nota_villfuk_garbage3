-- Practice loops
local N = 4

-- Given number N, print all numbers up to N.
function A(n)
    for i = 1, n do
        print(i)
    end
end

A(N)
print()

-- Given number N, print every odd number up to N without using an if.
function B(n)
    for i = 1, n, 2 do
        print(i)
    end
end

B(N)
print()

-- Given number N, print all numbers up to N in reverse order.
function C(n)
    for i = n, 1, -1 do
        print(i)
    end
end

C(N)
print()

-- Practice arrays
local A = { 25, 16, 9, 4, 1, 0, 81, 64, 49, 36 }

-- Given an array of numbers, print the sum of all of them.
function Sum(a)
    local sum = 0
    for _, x in ipairs(a) do
        sum = sum + x
    end
    return sum
end

print(Sum(A))
print()

-- Given an array of numbers, print the index of the largest number.
function ArgMax(a)
    if #a == 0 then
        return nil
    end

    local max = a[1]
    local argmax = 1
    for i, x in ipairs(a) do
        if x > max then
            max = x
            argmax = i
        end
    end
    return argmax
end

print(ArgMax(A))
print()

-- Given number N, make an array containing the squares of every number up to N.
function PrintArray(a)
    print(table.concat(a, ", "))
end

function Squares(a)
    local squares = {}
    for i, x in ipairs(a) do
        squares[i] = x * x
    end
    return squares
end

PrintArray(Squares(A))
print()


-- Given an array of numbers and a number N, print the N-th odd number in the array.
function GetNthOddNumber(a, n)
    for _, x in ipairs(a) do
        if x % 2 == 1 then
            n = n - 1
            if n == 0 then
                return x
            end
        end
    end
    return nil
end

print(GetNthOddNumber(A, N))
print()

-- Practice arrays vs. tables
local T = { [true] = 1, b = { 1, 2, two = "two" }, [{ [3] = "three" }] = false, [4] = 4, ["the number five"] = 5, [{ 6, 7, 8, 9 }] = "VI" }

-- Given an array, print every element and its index.
-- Given a table, print every element and its key.
function PrintTable(t)
    local stringified = {}
    for key, value in pairs(t) do
        stringified[#stringified + 1] = tostring(key) .. ": " .. tostring(value)
    end
    print(table.concat(stringified, ", "))
end

PrintTable(A)
PrintTable(T)
print()

-- Given an array, count the number of its elements.
print(#A)

-- Given a table, count the number of its elements.
function CountTable(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

print(CountTable(T))
print()

-- Given an array, determine if it is empty.
function IsEmptyArray(a)
    return #a == 0
end

print(IsEmptyArray(A))

-- Given a table, determine if it is empty.
function IsEmpty(t)
    return next(t) == nil
end

print(IsEmpty(T))
print()

-- Practice tables in basic applications
-- Create a function that can print any boolean, number, string, array or table; arrays and tables may themselves contain arrays and tables.
function Format(e, level)
    level = level or 0
    local t = type(e)
    if t == "string" then
        return "\"" .. e .. "\""
    end
    if t == "table" then
        local stringified = {}
        if #e == CountTable(e) then
            for _, value in ipairs(e) do
                stringified[#stringified + 1] = Format(value, level + 1)
            end
            return "[" .. table.concat(stringified, ", ") .. "]"
        end
        for key, value in pairs(e) do
            stringified[#stringified + 1] = string.rep("  ", level + 1) .. Format(key, level + 1) .. " = " .. Format(value, level + 1)
        end
        return "{\n" .. table.concat(stringified, "\n") .. "\n" .. string.rep("  ", level) .. "}"
    end
    return tostring(e)
end

print(Format(nil))
print()
print(Format(N))
print()
print(Format(A))
print()
print(Format(T))
print()

-- Create a function that takes an array and a predicate, and returns an array of all elements that pass the predicate.
function FilterArray(a, p)
    local filtered = {}
    for _, x in ipairs(a) do
        if p(x) then
            filtered[#filtered + 1] = x
        end
    end
    return filtered
end

function table.filter(a, p)
    local filtered = {}
    for k, v in pairs(a) do
        if p(v) then
            filtered[k] = v
        end
    end
    return filtered
end

PrintArray(FilterArray(A, function(x) return x % 3 ~= 0 end))

function table.map(a, f)
    local mapped = {}
    for k, v in pairs(a) do
        mapped[k] = f(v)
    end
    return mapped
end
