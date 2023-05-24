#!/bin/bash

base_url="http://10.10.166.131"
wordlist="/usr/share/dirb/wordlists/common.txt"

# Fonction récursive pour explorer les dossiers
explore_folders() {
  local url="$1"

  # Exécuter dirb pour le dossier actuel
  output=$(dirb "$url" "$wordlist")

  # Extraire les nouveaux dossiers trouvés
  folders=$(echo "$output" | grep -oP '(?<=\+ )[^ ]+(?=/)')

  # Parcourir les dossiers et explorer récursivement
  for folder in $folders; do
    # Construire le nouvel URL pour le dossier
    new_url="$url$folder/"

    # Afficher le contenu du dossier
    echo "Contenu du dossier $new_url :"
    cat "$new_url"

    # Explorer récursivement les sous-dossiers
    explore_folders "$new_url"
  done
}

# Exécuter la commande dirb initiale
output=$(dirb "$base_url" "$wordlist")

# Extraire les dossiers trouvés par dirb
folders=$(echo "$output" | grep -oP '(?<=\+ )[^ ]+(?=/)')

if [ -n "$folders" ]; then
  # Parcourir les dossiers et explorer récursivement
  for folder in $folders; do
    # Construire l'URL pour le dossier initial
    url="$base_url/$folder/"

    # Afficher le contenu du dossier initial
    echo "Contenu du dossier $url :"
    cat "$url"

    # Explorer récursivement les sous-dossiers
    explore_folders "$url"
  done
else
  # Aucun dossier trouvé, afficher le dernier URL
  last_url=$(echo "$output" | grep -oP '(?<=+ )[^ ]+' | tail -1)
  echo "Dernier URL : $last_url"
fi
