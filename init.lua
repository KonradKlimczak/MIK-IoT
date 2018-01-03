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

<<<<<<< HEAD
print("ATTACH HANDLER");
gpio.trig(1, "both", onChange);
print("HANDLER ATTACHED");

wifi.setmode(wifi.STATION)

station_cfg={};
station_cfg.ssid="does not work";
station_cfg.pwd="does not work";
wifi.sta.config(station_cfg)
tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
wifi.sta.connect()
tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
status_of_wifi = wifi.sta.status()
print(status_of_wifi);
print(wifi.STA_IDLE);
print(wifi.STA_WRONGPWD);
print(wifi.STA_FAIL);
if status_of_wifi == wifi.STA_IDLE then print("IDLE") end;
if status_of_wifi == wifi.STA_CONNECTING then print("CONNECTING") end;
if status_of_wifi == wifi.STA_WRONGPWD then print("WRONG PS") end;
if status_of_wifi == wifi.STA_APNOTFOUND then print("404") end;
if status_of_wifi == wifi.STA_FAIL then print("500") end;
print(wifi.sta.getip())

=======
>>>>>>> 0a54b2a1c09734e738c8049b5c06c378205a0abf
