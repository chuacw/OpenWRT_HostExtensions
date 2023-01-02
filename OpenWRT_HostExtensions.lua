--[[
    This is written to test out how to extend OpenWRT's DHCP page
    in order to give meaningful names to the hosts
]]
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

local HostData = {}
function HostData.new(macAddr, ipAddr, hostname, leasetime, description)
    return {
        MacAddress = macAddr,
        IP = ipAddr,
        HostName = hostname,
        Description = description,
        LeaseTime = leasetime
    }
end

-- see if the file exists
local function file_exists(file)
    local f = io.open(file, "rb")
    if f then
        f:close()
    end
    return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
local function lines_from(file)
    if not file_exists(file) then
        return {}
    end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

--[[
Examples of DHCP lease data
lease time(?) MAC address       IP address    hostname ?
1672693789 uu:uu:uu:uu:uu:uu 10.0.1.1 Aria2 *
1672682473 vv:vv:vv:vv:vv:vv 10.0.1.1 Note4 01:vv:vv:vv:vv:vv:vv
1672696413 ww:ww:ww:ww:ww:ww 10.0.1.2 AsusMonitor 01:ww:ww:ww:ww:ww:ww
]]
local DhcpLease = {}
function DhcpLease.new(filename)
    local DhcpLeaseData = lines_from(filename)
    local fn = { "leasetime", "macAddr", "ipAddr", "hostname", "unknown" }
    local result = {}
    for k, v in pairs(DhcpLeaseData) do
        local line = DhcpLeaseData[k]
        local temp = {}
        temp["unknown"] = "host description"
        local i = 1
        for w in line:gmatch("%S+") do
            local fieldname = fn[i]
            temp[fieldname] = w
            i = i + 1
        end
        local hostdata = HostData.new(temp[fn[2]], temp[fn[3]], temp[fn[4]], 
          temp[fn[1]], temp[fn[5]])
        result[hostdata.MacAddress] = hostdata
    end
    return result
end

--[[ dhcp.lease is located at /tmp/dhcp.leases
 https://192.168.1.1/cgi-bin/luci/admin/network/dhcp Resolv and Host Files
]]
local dhcpLeaseDictionary = DhcpLease.new("./dhcp.leases")
print("dictionary: ", dump(dhcpLeaseDictionary))
