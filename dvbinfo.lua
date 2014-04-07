local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")
local json = require("json")
local wibox = require("wibox")
local awful = require("awful")

local dvbinfo = {}
local url              = "http://widgets.vvo-online.de/abfahrtsmonitor/"
local station_option   = "Haltestelle.do?ort=dresden&hst="
local departure_option = "Abfahrten.do?ort=dresden&hst="

function dvbinfo.get_station_name( pattern )
   local respbody = {}
   http.request{
      url = url..station_option..pattern,
      sink = ltn12.sink.table(respbody)
   }
   table = json.decode(respbody[1])
   return table[2][1][1]
end

--[[
   return is a table with the stucture:
  table = {
   ride      tram number:      target:    time in min:
   [1]
   [2]
   [...] : { [1]                [2]           [3]       }
   [n]
   }
   example
   table[1][1] => "1"
   table[1][2] => "Prohils"
   table[1][3] => "5"
   table[2][1] => "2"
   table[2][2] => "Cotta"
   table[2][3] => "6"
]]
function dvbinfo.get_timeinfo_of_station( station )
   local respbody = {}
   http.request{
      url = url..departure_option..station,
      sink = ltn12.sink.table(respbody)
   }
   table = json.decode(respbody[1])
   return table
end

function dvbinfo.get_widget()
    mytextbox = wibox.widget.textbox()
    mytextbox:set_text("dvbinfo")
    mytextbox:buttons(awful.util.table.join(
                         awful.button({ }, 1, function () mytextbox:set_text("Hallo 2") end)
                      ))

    return mytextbox
end

return dvbinfo
-- for key,value in pairs(o[2][1]) do print(key,value) end
