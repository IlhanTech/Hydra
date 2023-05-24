#!/bin/bash

base_url="http://10.10.166.131"
wordlist="/usr/share/dirb/wordlists/common.txt"

while true; do
  # Exécuter la commande dirb
  output=$(dirb "$base_url" -w "$wordlist" -q)

  # Extraire les chemins des dossiers trouvés
  paths=$(echo "$output" | grep -oP '(?<=\+ )/\S+')

  # Vérifier s'il y a des dossiers trouvés
  if [ -z "$paths" ]; then
    echo "Aucun dossier trouvé. Arrêt du script."
    break
  fi

  # Afficher les dossiers trouvés
  echo "Dossiers trouvés :"
  echo "$paths"

  # Mettre à jour la base URL pour les itérations suivantes
  base_url="$base_url${paths%/*}/"

  sleep 1  # Attendre 1 seconde entre chaque itération
done
