#!/bin/bash

source "scripts/functions.sh"

incumprimento "Base - Contratos Públicos Online" "http://online.dgo.pt/" \
  "TLSv1.2" "https://www.base.gov.pt/idp/profile/SAML2/POST/SSO" tlsv12
