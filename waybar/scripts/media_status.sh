#!/bin/bash

# Detectar procesos usando la cámara
camera_apps=$(lsof /dev/video0 2>/dev/null | awk 'NR>1 {print $1}' | sort -u)

# Detectar nombres limpios de apps usando el micrófono
mic_apps=$(pactl list source-outputs 2>/dev/null \
  | grep -F 'application.name = "' \
  | sed -E 's/.*"(.+)".*/\1/' \
  | sort -u)

tooltip_parts=()
used=false

if [ -n "$mic_apps" ]; then
    tooltip_parts+=("<tt><big></big></tt>: $(echo "$mic_apps" | paste -sd ', ' -)")
    used=true
fi

if [ -n "$camera_apps" ]; then
    tooltip_parts+=("<tt><big></big></tt> : $(echo "$camera_apps" | paste -sd ', ' -)")
    used=true
fi

# Tooltip y clase
if $used; then
    tooltip=$(printf "%s\n" "${tooltip_parts[@]}" | sed ':a;N;$!ba;s/\n/\\n/g')
    tooltip=$(echo "$tooltip" | sed 's/"/\\"/g')
    class="media-on"
else
    tooltip="Micrófono y cámara no están en uso"
    class="media-off"
fi

# Ícono fijo (puedes cambiarlo si quieres)
icon=""

# Salida JSON válida para Waybar
echo "{\"text\": \"$icon\", \"tooltip\": \"$tooltip\", \"class\": \"$class\", \"alt\": \"$used\"}"

# chmod +x ~/.config/waybar/scripts/media_status.sh
