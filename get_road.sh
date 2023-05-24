#!/bin/bash

base_url="http://10.10.166.131"
wordlist="/usr/share/dirb/wordlists/common.txt"

# Exécuter la commande dirb pour une seule itération
dirb "$base_url" -w "$wordlist" -q
