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