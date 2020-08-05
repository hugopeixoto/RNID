#!/bin/bash

source "scripts/functions.sh"

economia_doc() {
  curl -s -I "https://www.dgae.gov.pt/gestao-de-ficheiros-externos-dgae-ano-2015/1_formulario-registo_mf_nao_harmonizadas-doc.aspx" |
    grep filename|
    cut -d= -f2 |
    tr -d '\r'
}

incumprimento "Direção-Geral das Atividades Económicas" "https://www.dgae.gov.pt" \
  "Microsoft Office" "https://www.dgae.gov.pt/documentacao-/formularios.aspx" diff economia_doc
