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