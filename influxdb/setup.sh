/etc/init.d/influxdb start
until (curl -X POST 'http://localhost:8086/db?u=root&p=root' -d '{"name": "graphite"}' 2>/dev/null) do sleep 1; done
/etc/init.d/influxdb stop