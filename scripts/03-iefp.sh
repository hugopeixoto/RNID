#!/bin/bash

source "scripts/functions.sh"

# 20/05/2018: - several images without an alt attribute:
# 28/02/2019: the missing alts case is no longer a problem, but to comply with WCAG the XHTML also needs to be valid...
#             https://validator.w3.org/nu/?doc=https%3A%2F%2Fwww.iefp.pt%2F
#             tidy is a great validator, but isn't catching the errors on this
#             page as errors, even if it shows them as warnings... let's be hacky and pay
#             attention only on the current use case:
# 03/04/2019: XHTML is now valid, but there are empty headers now, in violation of levels A and AA

incumprimento "IEFP" "https://www.iefp.pt/" \
  "Não cumpre norma de acessibilidade WCAG 2.0 AA" "https://www.iefp.pt/" accessibility
