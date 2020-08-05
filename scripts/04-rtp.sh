#!/bin/bash

source "scripts/functions.sh"

incumprimento "RTP" "https://www.rtp.pt" \
  "Utilização de Flash" "https://media.rtp.pt/empresa/utilizacao/flash-player/" url_exists

incumprimento "RTP" "https://www.rtp.pt" \
  "Utilização de WMV" "https://media.rtp.pt/empresa/utilizacao/windows-media-player/" url_exists
