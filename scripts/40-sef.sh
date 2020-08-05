#!/bin/bash

source "scripts/functions.sh"

sef_doc() {
  curl -L "https://www.sef.pt/pt/pages/conteudo-detalhe.aspx?nID=73" |
    hxnormalize -x 2> /dev/null |
    hxselect -s "\n" "a[href$='.doc']"
}

incumprimento "Serviços de Estrangeiros e Fronteiras" "https://www.sef.pt/" \
  "DOC" "https://www.sef.pt/pt/pages/conteudo-detalhe.aspx?nID=73" diff sef_doc
