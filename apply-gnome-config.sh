#!/bin/bash

# Chemin vers le fichier de configuration sauvegardé
CONFIG_FILE="gnome-interface-conf.txt"

# Vérifiez si le fichier de configuration existe
if [ ! -f "$CONFIG_FILE" ]; 
then
    echo "Le fichier de configuration $CONFIG_FILE n'existe pas."
    exit 1
fi

# Lire les configurations ligne par ligne et les appliquer avec gsettings
while IFS= read -r line; do
    # Ignorer les lignes vides ou les commentaires
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    
    # Extraire la clé et la valeur
    key=$(echo "$line" | cut -d= -f1)
    value=$(echo "$line" | cut -d= -f2-)
    
    # Appliquer la configuration avec gsettings
    gsettings set org.gnome.desktop.interface "$key" "$value"
done < "$CONFIG_FILE"

echo "Configurations GNOME appliquées avec succès depuis $CONFIG_FILE"
