#!/bin/bash

IMG="$HOME/.config/hypr/papers/Yuuki_Yuuna_1.jpg"
CONF="$HOME/.config/hypr/hyprpaper.conf"

# Generar archivo de configuración válido para Hyprpaper
cat <<EOF > "$CONF"
preload = $IMG
wallpaper = ,$IMG
EOF

# Ejecutar hyprpaper con ese config
exec hyprpaper --config "$CONF"
