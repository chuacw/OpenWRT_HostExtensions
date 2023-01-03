--[[
Examples of DHCP lease data
lease time(?) MAC address       IP address    hostname ?
1672693789 uu:uu:uu:uu:uu:uu 10.0.1.1 Aria2 *
1672682473 vv:vv:vv:vv:vv:vv 10.0.1.1 Note4 01:vv:vv:vv:vv:vv:vv
1672696413 ww:ww:ww:ww:ww:ww 10.0.1.2 AsusMonitor 01:ww:ww:ww:ww:ww:ww
]]
local File = require("File")
local HostData = require("HostData")

local DhcpLease = {}
function DhcpLease.new(filename)
    local DhcpLeaseData = File.ReadText(filename)
    local fn = { "leasetime", "macAddr", "ipAddr", "hostname", "unknown" }
    local result = {}
    for k, v in pairs(DhcpLeaseData) do
        local line = DhcpLeaseData[k]
        local temp = {}
        temp[fn[5]] = "host description" -- set default, in case it's missing
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

return DhcpLease
