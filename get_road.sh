#!/bin/bash

url="http://10.10.166.131"
wordlist="/usr/share/dirb/wordlists/common.txt"

# Fonction pour explorer les dossiers
explore_folders() {
    local current_url="$1"
    local current_wordlist="$2"

    # Exécution de la commande dirb
    dirb_output=$(dirb "$current_url" "$current_wordlist")

    # Analyse de la sortie de dirb pour récupérer les dossiers trouvés
    folders=$(echo "$dirb_output" | grep -oP '\[\+\] (\/\S+\/)')

    # Vérification s'il y a des dossiers trouvés
    if [ -z "$folders" ]; then
        echo "Aucun dossier trouvé dans $current_url"
        return
    fi

    # Parcourir les dossiers trouvés
    for folder in $folders; do
        # Supprimer les caractères '[+]' du début du dossier
        folder="${folder#[+]}"

        # Afficher le dossier trouvé
        echo "Dossier trouvé : $folder"

        # Construire l'URL complète du dossier
        next_url="$current_url$folder"

        # Appeler récursivement la fonction pour explorer le dossier suivant
        explore_folders "$next_url" "$current_wordlist"
    done
}

# Appeler la fonction d'exploration des dossiers
explore_folders "$url" "$wordlist"
