#!/bin/bash

echo "=== ZMK Firmware Flasher for Charybdis ==="
echo ""
echo "1. Disconnect the keyboard completely"
echo "2. Press and hold the reset button"
echo "3. While holding it, connect the USB"
echo "4. Wait 2-3 seconds and release the button"
echo ""
echo "Press ENTER when you have completed these steps..."
read

echo "Searching for device in bootloader mode..."
sleep 2

# Search for the mounted drive
BOOTLOADER_PATH=$(find /media /mnt /run/media -name "*.uf2" -o -name "NICENANO" -o -name "INFO_UF2.TXT" 2>/dev/null | head -1 | xargs dirname 2>/dev/null)

if [ -z "$BOOTLOADER_PATH" ]; then
    echo "Device not found in bootloader mode."
    echo "Trying to search in /media..."
    BOOTLOADER_PATH=$(ls -d /media/*/NICENANO* 2>/dev/null | head -1)
fi

if [ -z "$BOOTLOADER_PATH" ]; then
    echo "ERROR: Keyboard not detected in bootloader mode."
    echo "Try:"
    echo "  1. Verify that the USB cable is working"
    echo "  2. Press the reset button longer (5-10 seconds)"
    echo "  3. Try with another USB port"
    exit 1
fi

echo "Device found at: $BOOTLOADER_PATH"
echo "Copying firmware..."

cp /home/yfcepeda/Documentos/AI/keyboard-charybdis/build/charybdis/zephyr/zmk.uf2 "$BOOTLOADER_PATH/"

if [ $? -eq 0 ]; then
    echo "✓ Firmware copied successfully!"
    echo "The keyboard will restart automatically..."
    sleep 3
    echo "✓ Flashing completed!"
else
    echo "ERROR: Could not copy firmware"
    exit 1
fi
