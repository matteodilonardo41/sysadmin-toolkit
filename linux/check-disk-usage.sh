#!/usr/bin/env bash

# Mostra l'utilizzo dei filesystem montati
# Autore: Matteo Di Lonardo

df -hP | awk '
NR == 1 {
    print
    next
}

{
    gsub("%", "", $5)

    if ($5 >= 90) {
        stato = "CRITICO"
    }
    else if ($5 >= 80) {
        stato = "ATTENZIONE"
    }
    else {
        stato = "OK"
    }

    print $0, stato
}'
