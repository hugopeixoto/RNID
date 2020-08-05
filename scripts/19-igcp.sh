#!/bin/bash

source "scripts/functions.sh"

igcp_xls() {
  contents="$(curl -L "https://www.igcp.pt/pt/gca/?id=80" | hxnormalize -x -l 100000)"

  echo "$contents" | hxselect -s "\n" '.texto table'
}

incumprimento "Agência de Gestão e Tesouraria e da Dívida Pública" "https://www.igcp.pt/" \
  "XLS" "https://www.igcp.pt/pt/gca/?id=80" diff "igcp_xls"
