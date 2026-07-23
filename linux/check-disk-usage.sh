#!/usr/bin/env bash

# Controlla l'utilizzo dei filesystem montati.
# Mostra solo filesystem reali e segnala eventuali soglie critiche.
# Autore: Matteo Di Lonardo

WARNING_THRESHOLD=80
CRITICAL_THRESHOLD=90

printf "%-25s %8s %8s %8s %6s %-30s %s\n" \
    "FILESYSTEM" "SIZE" "USED" "AVAIL" "USE%" "MOUNTPOINT" "STATUS"

df -hP \
    -x tmpfs \
    -x devtmpfs \
    -x squashfs \
    -x overlay |
awk -v warning="$WARNING_THRESHOLD" -v critical="$CRITICAL_THRESHOLD" '
NR > 1 {
    utilizzo = $5
    gsub("%", "", utilizzo)

    if (utilizzo >= critical) {
        stato = "CRITICO"
    }
    else if (utilizzo >= warning) {
        stato = "ATTENZIONE"
    }
    else {
        stato = "OK"
    }

    printf "%-25s %8s %8s %8s %5s%% %-30s %s\n",
        $1, $2, $3, $4, utilizzo, $6, stato
}'
