#!/bin/bash

source "scripts/functions.sh"

autentic_plugin() {
  curl "https://autenticacao.gov.pt/fa/ajuda/autenticacaogovpt.aspx" |
    hxnormalize -x -l 1000 2> /dev/null |
    hxselect -c -s '\n' ".info-box"
}

incumprimento "Autenticação.gov" "https://www.autenticacao.gov.pt" \
  "Precisa de extensão autenticacao.gov.pt para funcionar" "https://autenticacao.gov.pt/fa/ajuda/autenticacaogovpt.aspx#installAgent" \
  diff autentic_plugin
