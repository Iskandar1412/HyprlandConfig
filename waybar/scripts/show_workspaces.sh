#!/bin/bash

selected=$(wofi --show dmenu --prompt "Selecciona escritorio" < <(hyprctl workspaces -j | jq -r '.[].id'))

if [[ "$selected" =~ ^[0-9]+$ ]]; then
  hyprctl dispatch workspace "$selected"
fi
