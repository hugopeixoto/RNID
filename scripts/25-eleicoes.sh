#!/bin/bash

source "scripts/functions.sh"

incumprimento "Eleições - Ministério da Administração Interna" "https://www.eleicoes.mai.gov.pt/" \
  "Não cumpre norma de acessibilidade WCAG 2.0 AA" "https://www.eleicoes.mai.gov.pt/" accessibility

incumprimento "Eleições - Ministério da Administração Interna" "https://www.eleicoes.mai.gov.pt/" \
  "CSS inválido" "https://www.eleicoes.mai.gov.pt/" css
