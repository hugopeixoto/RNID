#!/bin/bash

source "scripts/functions.sh"

azores_http() {
  curl "http://www.azores.gov.pt/Portal/pt/principal/homepage.htm" |
    hxnormalize -x |
    hxselect -s "\n" "form input[type=password]"
}

incumprimento "Governo dos Açores" "http://www.azores.gov.pt" \
  "Utilização de Flash" "http://www.azores.gov.pt" has_flash

incumprimento "Governo dos Açores" "http://www.azores.gov.pt" \
  "Credenciais sem HTTPS" "http://www.azores.gov.pt" diff azores_http
