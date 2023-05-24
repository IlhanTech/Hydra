#!/bin/bash

base_url="http://10.10.166.131"
wordlist="/usr/share/dirb/wordlists/common.txt"

#!/bin/bash

base_url="http://ip_adresse/"
wordlist="common.txt"

# Exécuter la commande dirb
output=$(dirb "$base_url" -w "$wordlist")

while true; do
  # Extraire le dernier dossier trouvé par dirb
  folder=$(echo "$output" | grep -oP '(?<=\+ )[^ ]+(?=/$)' | tail -1)

  if [ -n "$folder" ]; then
    # Concaténer l'URL avec le dossier trouvé
    url="$base_url/$folder"

    # Relancer dirb pour explorer le nouveau dossier
    output=$(dirb "$url" -w "$wordlist")
  else
    # Aucun dossier trouvé, afficher le dernier URL
    last_url=$(echo "$output" | grep -oP '(?<=\+ )[^ ]+(?=/)' | tail -1)
    echo "Dernier URL : $last_url"
    break
  fi
done

