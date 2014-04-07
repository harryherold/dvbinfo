local dvb = require "dvbinfo"

name       = dvb.get_station_name("Zwinglistr")
time_table = dvb.get_timeinfo_of_station( name )

for key,value in pairs(time_table) do print(key,value[1],value[2],value[3]) end
