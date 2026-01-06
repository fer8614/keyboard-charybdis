# Guía de Configuración y Flasheo del Charybdis con ZMK

## Tabla de Contenidos
1. [Requisitos Previos](#requisitos-previos)
2. [Estructura del Proyecto](#estructura-del-proyecto)
3. [Modificar el Keymap](#modificar-el-keymap)
4. [Compilar el Firmware](#compilar-el-firmware)
5. [Flashear el Firmware](#flashear-el-firmware)
6. [Solución de Problemas](#solución-de-problemas)

> **⚠️ IMPORTANTE:** Este teclado es un teclado split (dividido). Se requiere compilar y flashear **AMBOS LADOS** del teclado (izquierdo y derecho) para que funcione correctamente.

---

## Requisitos Previos

Asegúrate de tener instalado:
- **west**: Herramienta de gestión de ZMK
- **ZMK v0.3**: Firmware de teclado
- **SDK de Zephyr 0.16.8**: Compilador y herramientas
- **Python 3.8+**: Para scripts de compilación
- **CMake y Ninja**: Para compilación

Si no tienes estas herramientas instaladas, ejecuta:

```bash
# Instalar dependencias en Fedora 43
sudo dnf install -y cmake ninja-build gcc-arm-linux-gnu git python3-pip python3-pyelftools

# Instalar west
pip3 install --user west

# Descargar e instalar SDK de Zephyr (si no lo tienes)
cd /tmp
wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.8/zephyr-sdk-0.16.8_linux-x86_64.tar.xz
tar xf zephyr-sdk-0.16.8_linux-x86_64.tar.xz
cd zephyr-sdk-0.16.8
./setup.sh
```

---

## Estructura del Proyecto

```
/home/yfcepeda/Documentos/AI/KEYBOARD/
├── config/                          # Configuración del Charybdis
│   ├── charybdis.keymap            # Definición del keymap (EDITAR AQUÍ)
│   ├── charybdis.conf              # Configuración del firmware
│   ├── charybdis.json              # Layout del teclado
│   ├── west.yml                    # Configuración de west
│   └── boards/shields/charybdis/   # Configuración del shield
├── build/charybdis/                # Carpeta de compilación (generada)
│   └── zephyr/zmk.uf2             # Firmware compilado (USAR PARA FLASHEAR)
├── zmk/                            # Código fuente de ZMK
├── zephyr/                         # Código fuente de Zephyr
├── keymap-layer0.svg               # Visualización Layer 0
├── keymap-layer1.svg               # Visualización Layer 1
└── README_CONFIGURACION.md         # Este archivo
```

---

## Modificar el Keymap

### Paso 1: Abrir el archivo de configuración

```bash
nano /home/yfcepeda/Documentos/AI/KEYBOARD/config/charybdis.keymap
```

### Paso 2: Entender la estructura

El archivo `charybdis.keymap` contiene dos capas (layers):

**Layer 0 (Capa por defecto):**
```
&kp ESC         &kp N1  &kp N2  &kp N3  ...
&kp TAB         &kp Q   &kp W   &kp E   ...
&kp LEFT_SHIFT  &kp A   &kp S   &kp D   ...
&kp LCTRL       &kp Z   &kp X   &kp C   ...
```

**Layer 1 (Capa de funciones):**
```
&kp F1  &kp F2  &kp F3  &kp F4  ...
&kp CAPS &none  &none   &none   ...
```

### Paso 3: Códigos de teclas disponibles

Algunos códigos comunes:
- **Letras/Números:** `&kp A`, `&kp N1`, `&kp N0`
- **Símbolos:** `&kp SEMI` (;), `&kp SQT` ('), `&kp COMMA` (,), `&kp FSLH` (/), `&kp MINUS` (-)
- **Teclas especiales:** `&kp SPACE`, `&kp ENTER`, `&kp BACKSPACE`, `&kp TAB`, `&kp ESC`
- **Modificadores:** `&kp LSHIFT`, `&kp LCTRL`, `&kp LALT`, `&kp LWIN`
- **Función:** `&kp F1` a `&kp F12`
- **Flechas:** `&kp UP`, `&kp DOWN`, `&kp LEFT`, `&kp RIGHT`
- **Bluetooth:** `&bt BT_NXT` (siguiente dispositivo), `&bt BT_CLR` (limpiar)
- **Mouse:** `&mkp MB1` (clic izquierdo), `&mkp MB2` (clic derecho)
- **Capas:** `&to 0` (ir a Layer 0), `&to 1` (ir a Layer 1)
- **Ninguna:** `&none`

### Paso 4: Ejemplo de modificación

Para cambiar la tecla F12 en Layer 1 por el símbolo `+`:

**Antes:**
```
&kp F1  &kp F2  &kp F3  &kp F4  &kp F5  &kp F6  &kp F7  &kp F8  &kp F9  &kp F10  &kp F11  &kp F12
```

**Después:**
```
&kp F1  &kp F2  &kp F3  &kp F4  &kp F5  &kp F6  &kp F7  &kp F8  &kp F9  &kp F10  &kp F11  &kp PLUS
```

### Paso 5: Guardar cambios

- En `nano`: Presiona `Ctrl+O`, luego `Enter`, luego `Ctrl+X`
- En tu editor favorito: Guarda normalmente

---

## Compilar el Firmware

### Paso 1: Navega a la carpeta del proyecto

```bash
cd /home/yfcepeda/Documentos/AI/KEYBOARD
```

### Paso 2: Exporta la configuración de Zephyr (solo la primera vez)

```bash
west zephyr-export
```

### Paso 3: Compila los tres firmwares necesarios

Se necesitan compilar **3 firmwares**:
1. **settings_reset** - Para limpiar la configuración antes de flashear
2. **charybdis_left** - Firmware del lado izquierdo
3. **charybdis_right** - Firmware del lado derecho

#### 3.1 Compilar Settings Reset

```bash
west build -b nice_nano_v2 -s zmk/app -d build/reset -- -DSHIELD=settings_reset
```

#### 3.2 Compilar Lado Izquierdo

```bash
west build -b nice_nano_v2 -s zmk/app -d build/left -- \
  -DZMK_CONFIG=/home/yfcepeda/Documentos/AI/KEYBOARD/config \
  -DSHIELD=charybdis_left
```

#### 3.3 Compilar Lado Derecho

```bash
west build -b nice_nano_v2 -s zmk/app -d build/right -- \
  -DZMK_CONFIG=/home/yfcepeda/Documentos/AI/KEYBOARD/config \
  -DSHIELD=charybdis_right
```

**Explicación del comando:**
- `-b nice_nano_v2`: Especifica el board (microcontrolador)
- `-s zmk/app`: Especifica la carpeta fuente
- `-d build/xxx`: Carpeta de salida de la compilación
- `-DZMK_CONFIG=...`: Ruta a la carpeta de configuración
- `-DSHIELD=xxx`: Especifica el shield (reset, left o right)

### Paso 4: Espera a que se complete la compilación

La compilación puede tomar 2-5 minutos por cada firmware. Verás un mensaje como:

```
[100%] Linking C executable zmk.elf
[100%] Built target zmk
-- west build: building for board nice_nano_v2
Wrote 346624 bytes to zmk.uf2
```

### Paso 5: Verifica que los firmwares se compilaron

```bash
ls -lh /home/yfcepeda/Documentos/AI/KEYBOARD/build/reset/zephyr/zmk.uf2
ls -lh /home/yfcepeda/Documentos/AI/KEYBOARD/build/left/zephyr/zmk.uf2
ls -lh /home/yfcepeda/Documentos/AI/KEYBOARD/build/right/zephyr/zmk.uf2
```

**Archivos generados:**
- `build/reset/zephyr/zmk.uf2` - Settings Reset (~93 KB)
- `build/left/zephyr/zmk.uf2` - Lado Izquierdo (~347 KB)
- `build/right/zephyr/zmk.uf2` - Lado Derecho (~446 KB)

---

## Flashear el Firmware

> **⚠️ IMPORTANTE:** Se debe flashear **primero el settings_reset** y luego la configuración en **CADA LADO** del teclado.

### Cómo entrar en modo bootloader

Hay dos métodos:
1. **Método 1:** Presiona el botón de reset **2 veces rápidamente** (como doble clic)
2. **Método 2:** Mantén presionado el botón de reset mientras conectas el cable USB

Cuando el teclado está en modo bootloader, aparecerá una carpeta llamada **"NICENANO"** en tu sistema.

---

### LADO IZQUIERDO (4 pasos)

#### Paso 1: Flashear Settings Reset en lado izquierdo

1. Conecta el **lado IZQUIERDO** por USB
2. Entra en modo bootloader (reset 2 veces)
3. Espera a que aparezca la carpeta **NICENANO**
4. Copia el archivo:
   ```
   /home/yfcepeda/Documentos/AI/KEYBOARD/build/reset/zephyr/zmk.uf2
   ```
5. Pégalo en la carpeta NICENANO
6. Espera a que el teclado se reinicie (la carpeta desaparecerá)

#### Paso 2: Flashear configuración del lado izquierdo

1. El teclado se reinició, entra en modo bootloader nuevamente (reset 2 veces)
2. Espera a que aparezca la carpeta **NICENANO**
3. Copia el archivo:
   ```
   /home/yfcepeda/Documentos/AI/KEYBOARD/build/left/zephyr/zmk.uf2
   ```
4. Pégalo en la carpeta NICENANO
5. Espera a que el teclado se reinicie
6. **Desconecta el lado izquierdo**

---

### LADO DERECHO (4 pasos)

#### Paso 3: Flashear Settings Reset en lado derecho

1. Conecta el **lado DERECHO** por USB
2. Entra en modo bootloader (reset 2 veces)
3. Espera a que aparezca la carpeta **NICENANO**
4. Copia el archivo:
   ```
   /home/yfcepeda/Documentos/AI/KEYBOARD/build/reset/zephyr/zmk.uf2
   ```
5. Pégalo en la carpeta NICENANO
6. Espera a que el teclado se reinicie

#### Paso 4: Flashear configuración del lado derecho

1. El teclado se reinició, entra en modo bootloader nuevamente (reset 2 veces)
2. Espera a que aparezca la carpeta **NICENANO**
3. Copia el archivo:
   ```
   /home/yfcepeda/Documentos/AI/KEYBOARD/build/right/zephyr/zmk.uf2
   ```
4. Pégalo en la carpeta NICENANO
5. Espera a que el teclado se reinicie
6. **Desconecta el lado derecho**

---

### Verificación final

1. Desconecta ambos lados del USB
2. Presiona el botón de reset **2 veces** en el lado **izquierdo** para activar el modo de emparejamiento Bluetooth (la luz roja parpadeará)
3. Presiona el botón de reset **2 veces** en el lado **derecho**
4. Conecta el teclado por Bluetooth desde la configuración de tu sistema
5. Prueba que ambos lados funcionen correctamente

---

## Flujo Completo de Modificación

```bash
# 1. Edita el keymap
nano /home/yfcepeda/Documentos/AI/KEYBOARD/config/charybdis.keymap

# 2. Navega a la carpeta del proyecto
cd /home/yfcepeda/Documentos/AI/KEYBOARD

# 3. Limpia compilaciones anteriores (recomendado)
rm -rf build

# 4. Compila los 3 firmwares
west build -b nice_nano_v2 -s zmk/app -d build/reset -- -DSHIELD=settings_reset

west build -b nice_nano_v2 -s zmk/app -d build/left -- \
  -DZMK_CONFIG=/home/yfcepeda/Documentos/AI/KEYBOARD/config \
  -DSHIELD=charybdis_left

west build -b nice_nano_v2 -s zmk/app -d build/right -- \
  -DZMK_CONFIG=/home/yfcepeda/Documentos/AI/KEYBOARD/config \
  -DSHIELD=charybdis_right

# 5. Flashear LADO IZQUIERDO:
#    a) Conectar lado izquierdo, entrar bootloader (reset x2)
#    b) Copiar build/reset/zephyr/zmk.uf2 a NICENANO
#    c) Esperar reinicio, entrar bootloader de nuevo
#    d) Copiar build/left/zephyr/zmk.uf2 a NICENANO

# 6. Flashear LADO DERECHO:
#    a) Conectar lado derecho, entrar bootloader (reset x2)
#    b) Copiar build/reset/zephyr/zmk.uf2 a NICENANO
#    c) Esperar reinicio, entrar bootloader de nuevo
#    d) Copiar build/right/zephyr/zmk.uf2 a NICENANO

# 7. Conectar por Bluetooth:
#    a) Desconectar ambos lados del USB
#    b) Presionar reset x2 en ambos lados (luz roja parpadeará)
#    c) Conectar desde configuración Bluetooth del sistema
```

---

## Solución de Problemas

### El teclado no se detecta en modo bootloader

**Problema:** La carpeta NICENANO no aparece después de presionar reset.

**Soluciones:**
1. Intenta presionar el botón de reset **2 veces rápidamente** (como doble clic)
2. Prueba con otro puerto USB
3. Verifica que el cable USB sea de datos (no solo de carga)
4. Mantén presionado el botón de reset mientras conectas el cable USB

### El firmware no se compila

**Problema:** Error durante la compilación.

**Soluciones:**
1. Verifica que tengas todas las dependencias instaladas
2. Limpia la carpeta de compilación: `rm -rf build`
3. Ejecuta `west zephyr-export` nuevamente
4. Verifica que el archivo `charybdis.keymap` no tenga errores de sintaxis

### El teclado no responde después del flasheo

**Problema:** El teclado se flasheó pero no responde a las pulsaciones.

**Soluciones:**
1. **Flashea AMBOS lados del teclado** (izquierdo Y derecho)
2. **Flashea settings_reset ANTES** de flashear la configuración en cada lado
3. Verifica que estás usando el firmware correcto para cada lado:
   - `build/left/zephyr/zmk.uf2` para lado **izquierdo**
   - `build/right/zephyr/zmk.uf2` para lado **derecho**

### La conexión Bluetooth falla (AuthenticationFailed)

**Problema:** El emparejamiento Bluetooth falla con error de autenticación.

**Soluciones:**
1. **En la laptop:** Olvida/elimina el dispositivo "V&Z-Charydbis" de Bluetooth
2. **En el teclado:** Flashea `settings_reset` para limpiar la configuración guardada
3. Vuelve a emparejar desde cero

### El teclado no se conecta por Bluetooth

**Problema:** El teclado no aparece en los dispositivos Bluetooth.

**Soluciones:**
1. Presiona el botón de reset **2 veces** en el lado **izquierdo** (la luz roja debe parpadear)
2. Presiona el botón de reset **2 veces** en el lado **derecho**
3. Busca el dispositivo "V&Z-Charydbis" en la configuración de Bluetooth
4. Si sigue sin aparecer, flashea `settings_reset` en ambos lados y repite

### Solo funciona un lado del teclado

**Problema:** Un lado del teclado funciona pero el otro no.

**Soluciones:**
1. Verifica que flasheaste el firmware correcto en cada lado
2. Asegúrate de que ambos lados tienen el firmware actualizado
3. Presiona reset 2 veces en ambos lados para sincronizarlos

---

## Información Útil

### Ubicaciones importantes

- **Keymap:** `/home/yfcepeda/Documentos/AI/KEYBOARD/config/charybdis.keymap`
- **Configuración:** `/home/yfcepeda/Documentos/AI/KEYBOARD/config/`
- **Visualización del layout:** `keymap-layer0.svg`, `keymap-layer1.svg`

### Firmwares compilados

| Archivo | Ubicación | Uso |
|---------|-----------|-----|
| Settings Reset | `build/reset/zephyr/zmk.uf2` | Limpiar configuración (usar primero) |
| Lado Izquierdo | `build/left/zephyr/zmk.uf2` | Mitad izquierda del teclado |
| Lado Derecho | `build/right/zephyr/zmk.uf2` | Mitad derecha del teclado |

### Repositorio del fabricante

- **URL:** https://github.com/Vzhao-L/zmk-for-charybdis/tree/main-20250226
- **Copia local:** `/home/yfcepeda/Documentos/AI/KEYBOARD/zmk-for-charybdis-main-20250226/`

### Documentación oficial

- [ZMK Documentation](https://zmk.dev/)
- [ZMK Keycodes](https://zmk.dev/docs/reference/keycodes)
- [ZMK Behaviors](https://zmk.dev/docs/reference/behaviors)

### Contacto y Soporte

Si tienes problemas, verifica:
1. La sintaxis del archivo `charybdis.keymap`
2. Que todas las herramientas estén instaladas correctamente
3. Los logs de compilación para mensajes de error específicos

---

**Última actualización:** 25 de Diciembre de 2025
**Versión de ZMK:** v0.3
**Board:** Nice Nano v2
**Shield:** Charybdis (Split - Izquierdo y Derecho)
**Repositorio del fabricante:** https://github.com/Vzhao-L/zmk-for-charybdis
