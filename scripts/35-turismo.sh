#!/bin/bash

source "scripts/functions.sh"

turismo_xlsx() {
  curl "https://business.turismodeportugal.pt/pt/Planear_Iniciar/Licenciamento_Registo_da_Atividade/Empreendimentos_Turisticos/Paginas/classificacao-et.aspx" |
    hxnormalize -x |
    hxselect -c -s "\n" ".documents ul li a::attr(href)"
}

incumprimento "Turismo de Portugal" "http://www.turismodeportugal.pt/" \
  "XLSX" "https://business.turismodeportugal.pt/pt/Planear_Iniciar/Licenciamento_Registo_da_Atividade/Empreendimentos_Turisticos/Paginas/classificacao-et.aspx" diff turismo_xlsx
