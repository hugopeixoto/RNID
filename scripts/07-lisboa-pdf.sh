#!/bin/bash

source "scripts/functions.sh"

lisboa_pdf_xfa() {
  curl "https://informacoeseservicos.lisboa.pt/fileadmin/informacoes_servicos/pedidos/pagamentos_taxas_tarifas/CML_participacao_ocorrencia.pdf" |
    pdfinfo -
}

incumprimento "Câmara Municipal de Lisboa" "https://www.lisboa.pt/" \
  "PDF com XFA" "https://informacoeseservicos.lisboa.pt/servicos/detalhe/participacao-de-ocorrencia-em-espaco-publico-e-pedido-de-indemnizacao" diff lisboa_pdf_xfa
