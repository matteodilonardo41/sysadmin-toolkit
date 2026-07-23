#!/usr/bin/env bash

# Controlla lo stato dei principali servizi Linux
# Autore: Matteo Di Lonardo

SERVICES=(
    "ssh"
    "cron"
    "systemd-timesyncd"
)

printf "%-25s %-12s %-12s\n" "SERVIZIO" "ATTIVO" "ABILITATO"

for SERVICE in "${SERVICES[@]}"; do
    ACTIVE_STATUS=$(systemctl is-active "$SERVICE" 2>/dev/null)
    ENABLED_STATUS=$(systemctl is-enabled "$SERVICE" 2>/dev/null)

    if [[ -z "$ACTIVE_STATUS" ]]; then
        ACTIVE_STATUS="non trovato"
    fi

    if [[ -z "$ENABLED_STATUS" ]]; then
        ENABLED_STATUS="non trovato"
    fi

    printf "%-25s %-12s %-12s\n" \
        "$SERVICE" \
        "$ACTIVE_STATUS" \
        "$ENABLED_STATUS"
done
