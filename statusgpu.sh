#!/bin/sh
path="/sys/class/drm/card0/device"
[ -f "$path/gpu_busy_percent" ] || exit 1 
usage="$(cat "$path/gpu_busy_percent")"
printf "%s%%\\n" "$usage"
