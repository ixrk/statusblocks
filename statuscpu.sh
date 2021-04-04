#!/bin/sh
# run in intervals

prevfile="$XDG_RUNTIME_DIR/cpu"
[ -f "$prevfile" ] || echo "0 0" > "$prevfile"
read prevtotal prevused <"$prevfile"

current="$(awk 'NR==1 { sum=0; for(i=2; i<=11; i++) sum+=$(i); print sum, sum-$5 }' /proc/stat)"
for mon in /sys/class/hwmon/*
do 
    if [ "$(cat "$mon/name")" = "coretemp" ]
    then 
        temperature="$(awk 'BEGIN {max = 0} {if ($1 > max) max=$1} END {print max/1000}' "$mon"/temp*_input)"
        break
    fi
done

printf '%2d%% %.2f, %d°C\n' \
    $(( 100 * (${current#* } - prevused) / (${current% *} - prevtotal) )) \
    "$(cut -d' ' -f1 /proc/loadavg)" \
    "$temperature"

echo "$current" > "$prevfile"
