#!/bin/bash

source "scripts/functions.sh"

norte2020_xlsx() {
  curl "https://www.norte2020.pt/investimento-municipal" |
    hxnormalize -x |
    hxselect -c -s "\n" ".p-content a::attr(href)"
}

incumprimento "Norte 2020" "https://www.norte2020.pt/" \
  "XLSX" "https://www.norte2020.pt/investimento-municipal" diff norte2020_xlsx
