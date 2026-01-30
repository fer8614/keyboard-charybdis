#!/bin/bash

# Charybdis Bluetooth Connection Script
# Replace MAC address with your keyboard's MAC address

MAC="DF:1F:E0:ED:35:2C"

echo "╔══════════════════════════════════════════════════════════╗"
echo "║     Charybdis Bluetooth Connection Script                ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "IMPORTANT: Before continuing, do this on the keyboard:"
echo ""
echo "  1. Press (⌘ spc) to enter Layer 1"
echo "  2. Press G (hold 2-3 seconds) - Bluetooth Clear"
echo "  3. Press F (3-4 times) - Cycle Bluetooth profiles"
echo ""
read -p "Press Enter when ready..."

echo ""
echo "[1/5] Removing old pairing..."
bluetoothctl remove $MAC 2>/dev/null

echo "[2/5] Restarting Bluetooth service..."
sudo systemctl restart bluetooth
sleep 2
bluetoothctl power on
sleep 1

echo "[3/5] Scanning for keyboard..."
bluetoothctl --timeout 10 scan on &
sleep 8

echo ""
echo "[4/5] Checking if keyboard is visible..."
if bluetoothctl devices | grep -q "$MAC"; then
    echo "✓ Keyboard found!"
else
    echo "✗ Keyboard not found. Please try clearing Bluetooth on keyboard again."
    exit 1
fi

echo ""
echo "[5/5] Pairing with keyboard..."
bluetoothctl << EOF
agent on
default-agent
trust $MAC
pair $MAC
EOF

sleep 3
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║                   CONNECTION STATUS                      ║"
echo "╚══════════════════════════════════════════════════════════╝"
bluetoothctl info $MAC | grep -E "Name|Paired|Bonded|Connected|Battery"
