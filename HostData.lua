local HostData = {}

function HostData.new(macAddr, ipAddr, hostname, leasetime, description)
    local result = {
        MacAddress = macAddr,
        IP = ipAddr,
        HostName = hostname,
        Description = description,
        LeaseTime = leasetime
    }
    return result
end

return HostData
