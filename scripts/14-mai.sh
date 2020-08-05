#!/bin/bash

source "scripts/functions.sh"

mai_xls() {
  curl "https://www.sg.mai.gov.pt/AdministracaoEleitoral/RecenseamentoEleitoral/ResultadosRecenseamento/Paginas/default.aspx" |
    hxnormalize -x |
    hxselect -s '\n' 'div.conteudo a::attr(href)'
}

incumprimento "Secretaria Geral do Ministério da Administração Interna" "https://www.sg.mai.gov.pt/Paginas/default.aspx" \
  "XLS" "https://www.sg.mai.gov.pt/AdministracaoEleitoral/RecenseamentoEleitoral/ResultadosRecenseamento/Paginas/default.aspx" \
  diff mai_xls
