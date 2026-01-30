#!/bin/bash

# Script to compile Charybdis firmware with ZMK

echo "=== ZMK Firmware Compiler for Charybdis ==="
echo ""

# Verify we are in the correct folder
if [ ! -f "config/charybdis.keymap" ]; then
    echo "ERROR: config/charybdis.keymap not found"
    echo "Make sure to run this script from /home/yfcepeda/Documentos/AI/keyboard-charybdis"
    exit 1
fi

# Verify that west is installed
if ! command -v west &> /dev/null; then
    echo "ERROR: west is not installed"
    echo "Install it with: pip3 install --user west"
    exit 1
fi

echo "Step 1: Exporting Zephyr configuration..."
west zephyr-export

if [ $? -ne 0 ]; then
    echo "ERROR: Could not export Zephyr configuration"
    echo "Verify that the Zephyr SDK is installed correctly"
    exit 1
fi

echo "Step 2: Cleaning previous builds..."
rm -rf build

echo "Step 3: Compiling firmware for Charybdis (left side)..."
west build -b nice_nano_v2 -s zmk/app -d build/charybdis -- \
    -DZMK_CONFIG=/home/yfcepeda/Documentos/AI/keyboard-charybdis/config \
    -DSHIELD=charybdis_left

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Compilation successful!"
    echo ""
    echo "Compiled file:"
    ls -lh /home/yfcepeda/Documentos/AI/keyboard-charybdis/build/charybdis/zephyr/zmk.uf2
    echo ""
    echo "Next steps:"
    echo "1. Disconnect the keyboard from USB"
    echo "2. Press and hold the reset button for 3-5 seconds"
    echo "3. Connect USB while holding the button"
    echo "4. Release the button after 2-3 seconds"
    echo "5. Copy the zmk.uf2 file to the NICENANO folder that appears"
else
    echo ""
    echo "✗ Error during compilation"
    echo ""
    echo "Possible solutions:"
    echo "1. Verify that the Zephyr SDK is installed:"
    echo "   ls -la ~/.cmake/packages/Zephyr-sdk/"
    echo ""
    echo "2. If not installed, download and install it:"
    echo "   cd /tmp"
    echo "   wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.8/zephyr-sdk-0.16.8_linux-x86_64.tar.xz"
    echo "   tar xf zephyr-sdk-0.16.8_linux-x86_64.tar.xz"
    echo "   cd zephyr-sdk-0.16.8"
    echo "   ./setup.sh"
    echo ""
    echo "3. Then try compiling again"
    exit 1
fi
