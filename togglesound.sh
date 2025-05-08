#!/bin/bash

current_sink=$(pactl get-default-sink)

declare -a sinks=( $(pactl list short sinks | \
while IFS="" read -r line || [ -n "$line" ]; do
    raw=( $line )
    echo -e "${raw[1]}"
done) )

for i in ${!sinks[*]}; do
    if [[ $current_sink = ${sinks[$i]} ]]; then
        break
    fi
done

if [[ $(($i + 1)) -eq ${#sinks[*]} ]]; then
    pactl set-default-sink ${sinks[0]}
else
    pactl set-default-sink ${sinks[$(($i + 1))]}
fi
