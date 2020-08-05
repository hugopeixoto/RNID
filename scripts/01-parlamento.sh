#!/bin/bash

source "scripts/functions.sh"

parlamento_wmv() {
  curl -L "http://www.parlamento.pt/ActividadeParlamentar/Paginas/DetalheAudiencia.aspx?BID=99371" |
    grep -v "<link " | # this was breaking hxnormalize
    hxnormalize -x -l 100000 2> /dev/null |
    hxselect -s '\n' '#ctl00_ctl52_g_1d0614cc_f7c9_4544_a067_a6d1e32c35ae_ctl00_pnlLinksAssociados a::attr(href)'
}

parlamento_flash() {
  (curl -L https://canal.parlamento.pt/ | grep embedplayer.min.js) &&
    curl -L https://canal.parlamento.pt/scripts/embedplayer.min.js | sha1sum
}

incumprimento "Parlamento" "https://www.parlamento.pt" \
  "Vídeos disponibilizados em WMV" "https://www.parlamento.pt" diff "parlamento_wmv"

incumprimento "Parlamento" "https://www.parlamento.pt" \
  "Canal Parlamento em Flash" "https://canal.parlamento.pt" diff "parlamento_flash"

incumprimento "Parlamento" "https://www.parlamento.pt" \
  "Domínio com certificado HTTPS inválido" "https://www.canal.parlamento.pt" https
