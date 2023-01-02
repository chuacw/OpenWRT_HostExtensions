--[[
    This is written to test out how to extend OpenWRT's DHCP page
    in order to give meaningful names to the hosts
]]
local ObjUtils = require("ObjUtils")
local DhcpLease = require("DhcpLease")
--[[ dhcp.lease is located at /tmp/dhcp.leases
 https://192.168.1.1/cgi-bin/luci/admin/network/dhcp Resolv and Host Files
]]
local dhcpLeaseDictionary = DhcpLease.new("./dhcp.leases")
print("dictionary: ", ObjUtils.dump(dhcpLeaseDictionary))
