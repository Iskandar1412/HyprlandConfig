#!/usr/bin/env bash

STATE="$HOME/.cache/waybar_cal_state"
mkdir -p "$(dirname "$STATE")"

# Offset actual (meses desde el actual)
offset=0
if [[ -f "$STATE" ]]; then
  offset=$(<"$STATE")
fi

# Ajuste según botón clickeado
case "$1" in
  prev) ((offset--));;
  next) ((offset++));;
esac

echo "$offset" > "$STATE"

# Obtenemos año y mes
year=$(date -d "$offset month" +%Y)
month=$(date -d "$offset month" +%m)
monthname=$(date -d "$offset month" +'%B %Y')

# Generamos calendario
cal=$(cal "$month" "$year")

# Output para Waybar
# Línea con botones [<] mes [>]
# Luego el calendario
printf "< %s >\n\n%s" "$monthname" "$cal"

# chmod +x ~/.config/waybar/scripts/calendar.sh