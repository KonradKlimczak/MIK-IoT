-- shamelessly adapted from github https://gist.github.com/marcelstoer/59563e791effa4acb65f
function debounce (func)
    local last = 0
    local delay = 1000 * 1000 -- 1000ms * 1000 as tmr.now() has μs resolution

    return function (...)
        local now = tmr.now()
        local delta = now - last
        if delta < 0 then delta = delta + 2147483647 end; -- proposed because of delta rolling over, https://github.com/hackhitchin/esp8266-co-uk/issues/2
        if delta < delay then return end;

        last = now
        return func(...)
    end
end

--init.lua
print("Setting up wifi")
wifi.setmode(wifi.STATION)
--WIFI_CONFIG LOADED FROM secrets.lue
wifi.sta.config(WIFI_CONFIG)
wifi.sta.connect()
wifi.sta.autoconnect(1)
tmr.alarm(1, 1000, 1, function()
    if wifi.sta.getip()== nil then
      print("Waiting on dhcp...")
    else
      tmr.stop(1)
      print("Config done, IP is "..wifi.sta.getip())
      print("You have 5 seconds to abort startup")
      print("Waiting...")
      tmr.alarm(0, 5000, 0, startup)
    end
 end)

