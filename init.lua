print("PIN TEST");

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

couter = 0

print("SETTING UP PIN 1 - this is the one I use probably");
gpio.mode(1, gpio.INT, gpio.PULLUP)

print("DEFINE HANDLER");
function onChange (level)
    print("LEVEL"..level);
    print("OPENN TIMES "..couter)
    couter = couter + 1
    print("PIN IS GETING SIGNAL");
    print("IT WORKS");
end

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

