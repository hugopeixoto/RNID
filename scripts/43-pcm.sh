#!/bin/bash

source "scripts/functions.sh"

incumprimento "Secretaria-Geral da Presidência do Conselho de Ministros" "http://www.sg.pcm.gov.pt/" \
  "Credenciais sem HTTPS" "http://www2.sg.pcm.gov.pt/GEUPF/Login.aspx" url_exists
