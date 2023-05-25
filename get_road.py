import requests
import sys

def directory_search(wordlist, ip_address):
    with open(wordlist, 'r') as f:
        for word in f:
            word = word.strip()
            url = f"http://{ip_address}/{word}"
            response = requests.get(url)
            if response.status_code == 200:
                print(f"Directory found: {url}")
                # Concaténation du dossier trouvé
                found_directory = f"{ip_address}/{word}"
                print(f"Concatenated directory: {found_directory}")
                # Relancer la recherche avec le résultat
                directory_search(wordlist, found_directory)

# Vérification des arguments en ligne de commande
if len(sys.argv) != 3:
    print("Usage: python script.py wordlist.txt ip_address")
    sys.exit(1)

wordlist_file = sys.argv[1]
ip_address = sys.argv[2]

# Appel initial de la fonction pour effectuer la recherche de répertoires
directory_search(wordlist_file, ip_address)
