#!/bin/bash

url=$1

dirb_recursive() {
    while true; do
        output=$(dirb "$url" /usr/share/dirb/wordlists/common.txt -r)

        # Vérifier si des dossiers ont été trouvés dans la sortie de Dirb
        if grep -q "/T/" <<< "$output"; then
            # Effectuer une action supplémentaire lorsque le dossier /T/ est trouvé
            echo "Le dossier /T/ a été trouvé ! Faire quelque chose..."

            # Extraire le chemin du dossier /T/ pour la prochaine itération
            url="$url/T/"
        else
            # Aucun dossier trouvé, sortir de la boucle
            break
        fi
    done
}

# Vérifier si l'adresse IP a été fournie en argument
if [ -z "$url" ]; then
    echo "Veuillez fournir l'adresse IP en argument."
    exit 1
fi

# Exécuter la fonction dirb_recursive
dirb_recursive
