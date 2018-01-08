wifi.setmode(wifi.STATION)

station_cfg={};
station_cfg.ssid="networkid";
station_cfg.pwd="password";

function showip(params)
    print("Connected to Wifi.  Got IP: " .. params.IP)
    http.get("http://192.168.1.107:3000/sock/matex2", nil, function(code, data)
        if (code < 0) then
          print("HTTP request failed")
        else
          print(code, data)
        end
      end)
end

station_cfg.got_ip_cb = showip
wifi.sta.config(station_cfg)
tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
wifi.sta.connect()
tmr.delay(1000000)   -- wait 1,000,000 us = 1 second
status_of_wifi = wifi.sta.status()