#!/bin/bash

source "scripts/functions.sh"

cnpd_xlsx() {
  curl -L "https://www.cnpd.pt/home/rgpd/rgpd.htm" |
    hxnormalize -x |
    hxselect -s '\n' li
}

incumprimento "Comissão Nacional de Proteção de Dados" "https://www.cnpd.pt/home/rgpd/rgpd.htm" \
  "XLS" "https://www.cnpd.pt/home/rgpd/rgpd.htm" diff cnpd_xlsx
