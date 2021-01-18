#!/bin/sh
drms="/sys/class/drm"
card="$drms/card0/device/gpu_busy_percent"
[ -f "$card" ] || exit 1
usage="$(cat "$card")"
printf 'GPU %2d%%\n' "$usage"
