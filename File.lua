local File = {}

function File.Exists(filename)
    local f = io.open(filename, "rb")
    if f then
        f:close()
    end
    return f ~= nil
end

--[[
get all lines from a filename, returns an empty 
list/table if the filename does not exist
]]
function File.ReadText(filename)
    local lines = {}
    if not File.Exists(filename) then
        return lines
    end
    for line in io.lines(filename) do
        lines[#lines + 1] = line
    end
    return lines
end

return File