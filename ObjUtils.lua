local ObjUtils = {}
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

function ObjUtils.dump(o)
    local result = dump(o)
    return result
end

return ObjUtils