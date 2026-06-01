
connected=$(bluetoothctl devices Connected | awk '{print $2}' | head -n1)

if [[ -n "$connected" ]]; then
  echo "$connected"
else
  echo "Off"
fi
