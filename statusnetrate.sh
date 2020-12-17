#!/bin/bash
# run once a second

logfile="$XDG_RUNTIME_DIR/net_bytes.csv"
prevfile="$XDG_RUNTIME_DIR/net_bytes"
[ -f "$logfile" ] || echo "0 0" > "$logfile"
[ -f "$prevfile" ] || echo "0 0" > "$prevfile"
prevdata="$(cat "$prevfile")"

rx_bytes=$(cat /sys/class/net/{enp5s0,eth0,wlan0,wlp2s0}/statistics/rx_bytes 2>/dev/null)
tx_bytes=$(cat /sys/class/net/{enp5s0,eth0,wlan0,wlp2s0}/statistics/tx_bytes 2>/dev/null)
rxtotal=$(($(echo "$rx_bytes" | paste -sd '+')))
txtotal=$(($(echo "$tx_bytes" | paste -sd '+')))
rx="$(( (rxtotal-${prevdata%% *}) / 1024 ))"
tx="$(( (txtotal-${prevdata##* }) / 1024 ))"

printf "🔻%sKiB 🔺%sKiB\\n" "$rx" "$tx"
echo "$rxtotal $txtotal" > "$prevfile"
echo "$rx,$tx" >> "$logfile"
