#!/bin/bash

#TODO: find a good tool to make the validation on request
# https://achecker.ca/documentation/web_service_api.php - API usage depends on user account creation
# webaim.org - API's not gratis

# While we don't have a validator on request, let's find out if a known violation still exists
## several images without an alt attribute:
## Empty links are also WCAG violations

fails="$(wget https://www.portugal.gov.pt -o /dev/null -O - | grep "<img" |grep -v alt|wc -l)"
fails=$((fails + $(wget https://www.portugal.gov.pt -o /dev/null -O - | hxnormalize -x -l 10000|hxselect a -c -s'\n'|grep -c ^$)))

if [ "$fails" -eq "0" ]; then
	echo "gov.pt: incumprimento pode já não existir";
else
	echo "gov.pt: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test $(echo "$line"|grep -v portugal.gov.pt|wc -l) -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
