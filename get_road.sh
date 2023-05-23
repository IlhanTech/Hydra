#!/bin/bash

url=$1
output_file="output.txt"

dir_recursive() {
    local url="$1"
    local indent="$2"

    echo "Exploration de $url"

    wget --spider --no-check-certificate --recursive --level=1 --no-parent "$url" 2>&1 | grep -oP 'https?://\K[^ ]+' | grep -v 'index\.\(html\|php\)$' | awk '{print "'$indent'" $0}' >> "$output_file"

    local sub_urls=$(grep -oP 'https?://\K[^ ]+' "$output_file")
    for sub_url in $sub_urls; do
        dir_recursive "$sub_url" "$indent  "
    done
}

# Vérifier si l'adresse IP a été fournie en argument
if [ -z "$url" ]; then
    echo "Veuillez fournir l'adresse IP en argument."
    exit 1
fi

# Supprimer le fichier de sortie s'il existe déjà
rm -f "$output_file"

# Exécuter la fonction dir_recursive
dir_recursive "$url" ""

echo "Exploration terminée. Les résultats ont été enregistrés dans $output_file."
