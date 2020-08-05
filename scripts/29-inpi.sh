#!/bin/bash

source "scripts/functions.sh"

# TODO: is there a better check?

incumprimento "Instituto Nacional da Propriedade Intelectual" "https://inpi.justica.gov.pt/" \
  "Serviços necessitam Java" "https://servicosonline.inpi.pt/registos/guia_certificado.pdf" url_exists
