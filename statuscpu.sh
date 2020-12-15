#!/bin/sh
printf '%.2f, %d°C' $(cut -d' ' -f1 /proc/loadavg) $(($(cat /sys/class/thermal/thermal_zone2/temp) / 1000))
