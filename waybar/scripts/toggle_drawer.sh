#!/bin/bash

# Busca si ya está corriendo
if pgrep -f "waybar.*config-drawer.jsonc" > /dev/null; then
  pkill -f "waybar.*config-drawer.jsonc"
else
  waybar -c ~/.config/waybar/config-drawer.jsonc -s ~/.config/waybar/style.css &
fi
