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

return HostData
