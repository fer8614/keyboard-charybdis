#!/bin/bash

# Script para compilar el firmware del Charybdis con SDK de Zephyr

export ZEPHYR_SDK_INSTALL_DIR=/tmp/zephyr-sdk-0.16.8

cd /home/yfcepeda/Documentos/AI/KEYBOARD

echo "Limpiando compilaciones anteriores..."
rm -rf build

echo "Exportando configuración de Zephyr..."
west zephyr-export

echo "Compilando firmware..."
west build -b nice_nano_v2 -s zmk/app -d build/charybdis -- \
    -DZMK_CONFIG=/home/yfcepeda/Documentos/AI/KEYBOARD/config \
    -DSHIELD=charybdis_left

if [ -f "build/charybdis/zephyr/zmk.uf2" ]; then
    echo ""
    echo "✓ ¡Compilación exitosa!"
    echo "Archivo: build/charybdis/zephyr/zmk.uf2"
    ls -lh build/charybdis/zephyr/zmk.uf2
else
    echo ""
    echo "✗ Error: No se generó el archivo zmk.uf2"
    exit 1
fi
