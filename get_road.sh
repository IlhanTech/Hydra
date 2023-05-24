#!/bin/bash

base_url="http://10.10.166.131"
wordlist="/usr/share/dirb/wordlists/common.txt"

# Exécuter la commande dirb
output=$(dirb "$base_url" -w "$wordlist")

while true; do
  # Extraire le dernier dossier trouvé par dirb
  folder=$(echo "$output" | grep -oP '(?<=\+ )[^ ]+(?=/$)' | tail -1)

  if [ -n "$folder" ]; then
    # Afficher le contenu du dossier
    echo "Contenu du dossier $folder :"
    cat "$folder"

    # Relancer dirb pour explorer le nouveau dossier
    output=$(dirb "$base_url/$folder" -w "$wordlist")
  else
    # Aucun dossier trouvé, retourner le dernier URL
    last_url=$(echo "$output" | grep -oP '(?<=\+ )[^ ]+(?=/)' | tail -1)
    echo "Dernier URL : $last_url"
    break
  fi
done

