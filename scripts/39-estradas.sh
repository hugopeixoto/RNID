#!/bin/bash

source "scripts/functions.sh"

incumprimento "Estradas - Infraestruturas de Portugal" "http://www.estradas.pt/index" \
  "Flash" "http://www.estradas.pt/js/mapservices/camaras.js" has_flash

incumprimento "Estradas - Infraestruturas de Portugal" "http://www.estradas.pt/index" \
  "TLSv1.2" "https://www.estradas.pt" tlsv12
