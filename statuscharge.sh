#!/bin/sh

BAT="/sys/class/power_supply/BAT0"
[ -d "$BAT" ] || exit 1
printf "%s%d%%\n" "$(sed 's/Discharging/🔋/; s/Charging\|Full\|Unknown/🔌/' < $BAT/status)" "$(cat $BAT/capacity)"
