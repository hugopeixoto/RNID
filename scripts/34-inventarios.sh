#!/bin/bash

source "scripts/functions.sh"

inventarios_plugin() {
  curl -L "https://www.inventarios.pt/" |
    hxnormalize -x |
    hxselect -s "\n" "section.container--notice:nth-child(2) div.one-whole"
}

incumprimento "Inventários - Ordem dos notários" "https://www.inventarios.pt/" \
  "Precisa de extensão para assinar documentos" "https://www.inventarios.pt/" diff inventarios_plugin
