#!/bin/sh

printf "%s%d%%\n" "$(sed 's/Discharging/🔋/; s/Charging\|Full\|Unknown/🔌/' < /sys/class/power_supply/BAT0/status)" "$(cat /sys/class/power_supply/BAT0/capacity)"
