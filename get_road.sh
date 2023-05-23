#!/bin/bash

url=$1

dirb_recursive() {
    while true; do
        output=$(dirb "$url" /usr/share/dirb/wordlists/common.txt -X .html -r)

        # Vérifier si des dossiers ont été trouvés dans la sortie de Dirb
        if grep -q "DIRECTORY: " <<< "$output"; then
            # Extraire les noms de dossiers trouvés
            folders=$(grep "DIRECTORY: " <<< "$output" | cut -d ' ' -f 2-)

            # Parcourir chaque dossier trouvé
            while IFS= read -r folder; do
                # Effectuer une action supplémentaire avec chaque dossier
                echo "Dossier trouvé : $folder"
                # Récursion pour explorer le sous-dossier
                dirb_recursive "$url/$folder"
            done <<< "$folders"
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

# Exécuter la fonction dirb_recursive et rediriger la sortie vers le fichier output.txt
dirb_recursive > output.txt

echo "Exploration terminée. Les résultats ont été enregistrés dans output.txt."
