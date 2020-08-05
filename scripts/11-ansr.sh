#!/bin/bash

source "scripts/functions.sh"

ansr_docx() {
  curl "http://www.ansr.pt/Contraordenacoes/Formularios/Pages/default.aspx" |
    hxnormalize -x -l 1000 |
    hxselect -s '\n' 'div#listas-download-ficheiros ul li a::attr(href)'
}

incumprimento "Autoridade Nacional de Segurança Rodoviária" "http://www.ansr.pt" \
  "Documentos em DOCX" "http://www.ansr.pt/Contraordenacoes/Formularios/Pages/default.aspx" \
  diff ansr_docx
