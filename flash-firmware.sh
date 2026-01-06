#!/bin/bash

echo "=== Flasheador de Firmware ZMK para Charybdis ==="
echo ""
echo "1. Desconecta el teclado completamente"
echo "2. Presiona y mantén el botón de reset"
echo "3. Mientras lo mantienes, conecta el USB"
echo "4. Espera 2-3 segundos y suelta el botón"
echo ""
echo "Presiona ENTER cuando hayas completado estos pasos..."
read

echo "Buscando dispositivo en modo bootloader..."
sleep 2

# Buscar la unidad montada
BOOTLOADER_PATH=$(find /media /mnt /run/media -name "*.uf2" -o -name "NICENANO" -o -name "INFO_UF2.TXT" 2>/dev/null | head -1 | xargs dirname 2>/dev/null)

if [ -z "$BOOTLOADER_PATH" ]; then
    echo "No se encontró el dispositivo en modo bootloader."
    echo "Intentando buscar en /media..."
    BOOTLOADER_PATH=$(ls -d /media/*/NICENANO* 2>/dev/null | head -1)
fi

if [ -z "$BOOTLOADER_PATH" ]; then
    echo "ERROR: No se detectó el teclado en modo bootloader."
    echo "Intenta:"
    echo "  1. Verificar que el cable USB esté funcionando"
    echo "  2. Presionar el botón de reset más tiempo (5-10 segundos)"
    echo "  3. Probar con otro puerto USB"
    exit 1
fi

echo "Dispositivo encontrado en: $BOOTLOADER_PATH"
echo "Copiando firmware..."

cp /home/yfcepeda/Documentos/AI/KEYBOARD/build/charybdis/zmk.uf2 "$BOOTLOADER_PATH/"

if [ $? -eq 0 ]; then
    echo "✓ Firmware copiado exitosamente!"
    echo "El teclado se reiniciará automáticamente..."
    sleep 3
    echo "✓ ¡Flasheo completado!"
else
    echo "ERROR: No se pudo copiar el firmware"
    exit 1
fi
