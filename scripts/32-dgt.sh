#!/bin/bash

source "scripts/functions.sh"

dgt_xls() {
  curl "https://tcp.dgterritorio.gov.pt/procurar" |
    hxnormalize -x |
    hxselect -s "\n" ".feed-icon"
}

dgt_shp() {
  output="$(curl "https://snig.dgterritorio.gov.pt/rndg/srv/por/q?_content_type=json&bucket=s101&facet.q=dataPolicy%2FDados%2520abertos%26orgNameSNIG%2FDire%25C3%25A7%25C3%25A3o-Geral%2520do%2520Territ%25C3%25B3rio%26dataFormat%2FESRI%2520Shapefile&fast=index&from=1&resultType=details&sortBy=referenceDateOrd&sortOrder=&to=20&type=dataset%2Bor%2Bseries" | jq -r '.metadata[0].link[]')"

  curl "$(echo "$output" | tail -n1 | cut '-d|' -f3)" | sha1sum
}

incumprimento "Direção-Geral do Território" "https://www.dgterritorio.gov.pt/" \
  "Conteúdo em SHP" "https://snig.dgterritorio.gov.pt/rndg/srv/por/catalog.search#/search?facet.q=dataPolicy%2FDados%2520abertos%26orgNameSNIG%2FDire%25C3%25A7%25C3%25A3o-Geral%2520do%2520Territ%25C3%25B3rio%26dataFormat%2FECW&resultType=details&sortBy=referenceDateOrd&fast=index&_content_type=json&type=dataset%2Bor%2Bseries&from=1&to=20" diff dgt_shp

incumprimento "Direção-Geral do Território" "https://tcp.dgterritorio.gov.pt/" \
  "XLS" "https://tcp.dgterritorio.gov.pt/procurar" diff dgt_xls
