#!/bin/sh
# run in intervals

prevfile="$XDG_RUNTIME_DIR/cpu"
[ -f "$prevfile" ] || echo "0 0" > "$prevfile"
read prevtotal prevused <"$prevfile"

current="$(awk 'NR==1 { sum=0; for(i=2; i<=11; i++) sum+=$(i); print sum, sum-$5 }' /proc/stat)"

printf '%2d%% %.2f, %d°C\n' \
    $(( 100 * (${current#* } - prevused) / (${current% *} - prevtotal) )) \
    "$(cut -d' ' -f1 /proc/loadavg)" \
    $(( $(cat /sys/class/thermal/thermal_zone2/temp) / 1000 )) \

echo "$current" > "$prevfile"
