local utils = require 'utils';
local secrets = require 'secrets';

print("Hello Konrad :)");

print("Setting up WiFi to Station mode.");
wifi.setmode(wifi.STATION);

print("Setting configuration object for WiFi connection");
station_cfg={};
station_cfg.ssid=secrets.ID;
station_cfg.pwd=secrets.PASS;

function showip(params)
    print("Connected to Wifi. Got IP: " .. params.IP);
    print("Sending test request.");
    http.post("http://192.168.1.107:3000/test/matex2", nil, function(code, data)
      if (code < 0) then
        print("HTTP request failed")
      else
        print(code, data)
      end
    end)
    -- debounce make on change function callable only once every 30 seconds.
    gpio.trig(1, "both", utils.debounce(onSockProduced));
end
station_cfg.got_ip_cb = showip;

print("Setting up mode for PIN 1.");
gpio.mode(1, gpio.INT, gpio.PULLUP);

print("Connecting to WiFi");
wifi.sta.config(station_cfg);
wifi.sta.connect();

function onSockProduced(level)
  print("Sock produced.");
  print("Sending POST request.");
  http.post("http://192.168.1.107:3000/sock/matex2", nil, function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code, data)
    end
  end)
end
