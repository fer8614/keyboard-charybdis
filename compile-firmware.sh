#!/bin/bash

# Script para compilar el firmware del Charybdis con ZMK

echo "=== Compilador de Firmware ZMK para Charybdis ==="
echo ""

# Verificar que estamos en la carpeta correcta
if [ ! -f "config/charybdis.keymap" ]; then
    echo "ERROR: No se encontró config/charybdis.keymap"
    echo "Asegúrate de ejecutar este script desde /home/yfcepeda/Documentos/AI/KEYBOARD"
    exit 1
fi

# Verificar que west está instalado
if ! command -v west &> /dev/null; then
    echo "ERROR: west no está instalado"
    echo "Instálalo con: pip3 install --user west"
    exit 1
fi

echo "Paso 1: Exportando configuración de Zephyr..."
west zephyr-export

if [ $? -ne 0 ]; then
    echo "ERROR: No se pudo exportar la configuración de Zephyr"
    echo "Verifica que el SDK de Zephyr esté instalado correctamente"
    exit 1
fi

echo "Paso 2: Limpiando compilaciones anteriores..."
rm -rf build

echo "Paso 3: Compilando firmware para Charybdis (lado izquierdo)..."
west build -b nice_nano_v2 -s zmk/app -d build/charybdis -- \
    -DZMK_CONFIG=/home/yfcepeda/Documentos/AI/KEYBOARD/config \
    -DSHIELD=charybdis_left

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ ¡Compilación exitosa!"
    echo ""
    echo "Archivo compilado:"
    ls -lh /home/yfcepeda/Documentos/AI/KEYBOARD/build/charybdis/zephyr/zmk.uf2
    echo ""
    echo "Próximos pasos:"
    echo "1. Desconecta el teclado del USB"
    echo "2. Presiona y mantén el botón de reset durante 3-5 segundos"
    echo "3. Conecta el USB mientras mantienes el botón presionado"
    echo "4. Suelta el botón después de 2-3 segundos"
    echo "5. Copia el archivo zmk.uf2 a la carpeta NICENANO que aparecerá"
else
    echo ""
    echo "✗ Error durante la compilación"
    echo ""
    echo "Posibles soluciones:"
    echo "1. Verifica que el SDK de Zephyr esté instalado:"
    echo "   ls -la ~/.cmake/packages/Zephyr-sdk/"
    echo ""
    echo "2. Si no está instalado, descárgalo e instálalo:"
    echo "   cd /tmp"
    echo "   wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.8/zephyr-sdk-0.16.8_linux-x86_64.tar.xz"
    echo "   tar xf zephyr-sdk-0.16.8_linux-x86_64.tar.xz"
    echo "   cd zephyr-sdk-0.16.8"
    echo "   ./setup.sh"
    echo ""
    echo "3. Luego intenta compilar de nuevo"
    exit 1
fi
