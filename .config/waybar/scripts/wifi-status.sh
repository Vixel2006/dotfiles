
ssid=$(rustnet list | grep "Connected" | awk '{print $2}')

if [[ -n "$ssid" ]]; then
  echo "Disconnected"
else
  echo "Disconnected"
fi
