#!/usr/bin/env bash
# Muestra workspaces 1–0 indicando estado (empty, default, active, visible)

# Obtenemos el JSON de los workspaces actuales
json=$(hyprctl workspaces -j 2>/dev/null)
# Si falla, salimos
if [[ -z "$json" ]]; then exit 1; fi

# Recorremos del 1 al 9 y luego 0
for i in {1..9} 0; do
  # Si no existe, agregamos un entry vacío
  if ! jq --arg id "$i" 'map(.id|tostring) | index($id)' <<<"$json" >/dev/null; then
    json=$(jq --argjson j "$(({1..9}+([0])) )" '. += [{"id":'$i', "name": "'$i'", "focused": false, "visible": false, "occupied": false}]' <<<"$json")
  fi
done

# Ordenamos por id y lo imprimimos
echo "$json" | jq -c 'sort_by(.id)'
