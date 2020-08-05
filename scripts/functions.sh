INCUMPRIMENTO_UA="Mozilla/5.0 Gecko/20100101 Firefox/21.0"

check_accessibility() {
  #TODO: find a good tool to make the validation on request
  # https://achecker.ca/documentation/web_service_api.php - API usage depends on user account creation
  # webaim.org - API's not gratis

  # hxselect does not support :blank so we're using hxselect -c | grep
  contents="$(cat | hxnormalize -x)"

  # no img alt attribute:
  echo "$contents" | hxselect -s "\n" "img:not([alt])" | awk '$0="img[alt]: "$0'

  # blank img alt attribute:
  echo "$contents" | hxselect -c -s "\n" "img::attr(alt)" | grep '^\s*$' | awk '$0="img[alt]: "$0'

  # blank a:
  echo "$contents" | hxselect -c -s "\n" "a" | grep '^\s*$' | awk '$0="a: "$0'

  # blank h2:
  echo "$contents" | hxselect -c -s "\n" "h2" | grep '^\s*$' | awk '$0="h2: "$0'

  # no html lang:
  echo "$contents" | hxselect -s "\n" 'html:not([lang])' | awk '$0="html[lang]: "$0'
}

check_css() {
  curl -L "https://jigsaw.w3.org/css-validator/validator?uri=$(echo "$1" | jq -sRr @uri)" --user-agent "$INCUMPRIMENTO_UA" |
    hxnormalize -x |
    hxselect '#errors'
}

check_markup() {
  curl -L "https://validator.w3.org/check?uri=$(echo "$1" | jq -sRr @uri)" --user-agent "$INCUMPRIMENTO_UA" |
    hxnormalize -x | tee \
    >(hxselect -s '\n' '#results .error') \
    >(hxselect -s '\n' '#result .msg_err') \
    > /dev/null
}

incumprimento_refresh() {
  url="$1"
  check_type="$2"
  check_args="${@:3}"

  case $check_type in
    diff)
      $check_args > "scripts/outputs/${check_args[0]}"
      ;;
    css)
      ;;
    markup)
      ;;
    accessibility)
      ;;
    url_exists)
      ;;
    has_flash)
      ;;
    https)
      ;;
    tlsv12)
      ;;
    manual)
      ;;
    *)
      echo "unknown check type $check_type"
  esac
}

incumprimento_verify() {
  url="$1"
  check_type="$2"
  check_args="${@:3}"

  case $check_type in
    accessibility)
      output="$(curl -L "$url" --user-agent "$INCUMPRIMENTO_UA" | check_accessibility)"
      if [ "$DEBUG" != "" ]; then echo "$output"; fi
      [ -n "$output" ]
      ;;
    css)
      output="$(check_css "$url")"
      if [ "$DEBUG" != "" ]; then echo "$output"; fi
      [ -n "$output" ]
      ;;
    markup)
      output="$(check_markup "$url")"
      if [ "$DEBUG" != "" ]; then echo "$output"; fi
      [ -n "$output" ]
      ;;
    diff)
      output="$($check_args)"
      if [ "$DEBUG" != "" ]; then echo "$output"; fi
      diff "scripts/outputs/${check_args[0]}" <(echo "$output") > /dev/null
      ;;
    url_exists)
      output="$(curl -I "$url" -sw "%{http_code}" --user-agent "$INCUMPRIMENTO_UA" -o /dev/null)"
      if [ "$DEBUG" != "" ]; then echo "$output"; fi
      [ "200" == "$output" ]
      ;;
    has_flash)
      curl -L "$url" --user-agent "$INCUMPRIMENTO_UA" | grep --quiet -i x-shockwave-flash
      ;;
    https)
      curl -v "$url" 2>&1 | grep -q 'SSL: no alternative certificate subject name matches target host name'
      ;;
    tlsv12)
      curl -v "$url" 2>&1 | grep -q 'unsupported protocol\|SSL_ERROR_SYSCALL'
      ;;
    manual)
      ;;
    *)
      echo "Unknown command $COMMAND"
  esac
}

incumprimento() {
  titulo="$1"
  url="$2"
  problema="$3"
  check_url="$4"
  check_type="$5"
  check_args="${@:6}"

  case "${BASH_ARGV[0]}" in
    verify)
      if [ "$check_type" == "manual" ]; then
        echo $'\e[0;33m'"Incumprimento de verificação manual:"$'\e[0;39m' "$titulo - $problema"
      elif incumprimento_verify "$check_url" "$check_type" "$check_args"; then
        echo $'\e[0;31m'"Incumprimento mantém-se:"$'\e[0;39m' "$titulo - $problema"
      else
        echo $'\e[0;32m'"Incumprimento pode ter sido resolvido:"$'\e[0;39m' "$titulo - $problema"
      fi
      ;;
    refresh)
      incumprimento_refresh "$check_url" "$check_type" "$check_args"
      ;;
    manual)
      if [ "$check_type" == "manual" ]; then
        echo $'\e[0;33m'"Incumprimento de verificação manual:"$'\e[0;39m' "$titulo - $problema"
        $check_args
      fi
      ;;
    *)
      echo "Unknown command $COMMAND"
  esac
}
