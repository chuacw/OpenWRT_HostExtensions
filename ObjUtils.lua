local dump
dump = function (o)
    if type(o) == 'table' then
        local s = '{ ' .. string.char(10)
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. string.char(9) .. '[' .. k .. '] = ' .. dump(v) .. string.char(10)
        end
        return s .. '} ' .. string.char(10)
    else
        return tostring(o)
    end
end

local ObjUtils = {}

function ObjUtils.dump(o)
    local result = dump(o)
    return result
end

--[[
    Returns the number of keys in a dictionary by counting it
]]
function ObjUtils.length(o)
    local result = 0
    if type(o) == 'table' then
        for k, v in pairs(o) do
            result = result + 1
        end
    end
    return result
end

return ObjUtils