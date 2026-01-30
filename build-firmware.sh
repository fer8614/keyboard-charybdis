#!/bin/bash

# Script to compile Charybdis firmware with Zephyr SDK

export ZEPHYR_SDK_INSTALL_DIR=/tmp/zephyr-sdk-0.16.8

cd /home/yfcepeda/Documentos/AI/keyboard-charybdis

echo "Cleaning previous builds..."
rm -rf build

echo "Exporting Zephyr configuration..."
west zephyr-export

echo "Compiling firmware..."
west build -b nice_nano_v2 -s zmk/app -d build/charybdis -- \
    -DZMK_CONFIG=/home/yfcepeda/Documentos/AI/keyboard-charybdis/config \
    -DSHIELD=charybdis_left

if [ -f "build/charybdis/zephyr/zmk.uf2" ]; then
    echo ""
    echo "✓ Compilation successful!"
    echo "File: build/charybdis/zephyr/zmk.uf2"
    ls -lh build/charybdis/zephyr/zmk.uf2
else
    echo ""
    echo "✗ Error: zmk.uf2 file was not generated"
    exit 1
fi
