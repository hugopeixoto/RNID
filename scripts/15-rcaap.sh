#!/bin/bash

source "scripts/functions.sh"

rcaap_mp3() {
  curl "https://dre.tretas.org/dre/2159741/despacho-14167-2015-de-1-de-dezembro" |
    grep in_links -c
}

incumprimento "Repositórios Científicos de Acesso Aberto de Portugal" "https://www.rcaap.pt/" \
  "MP3" "https://dre.pt/application/conteudo/72779297" \
  diff rcaap_mp3
