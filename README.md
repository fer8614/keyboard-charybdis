# V&Z-Charybdis Bluetooth Configuration Guide

This guide explains how to connect your V&Z-Charybdis keyboard via Bluetooth on Linux (Fedora).

## Prerequisites

- Linux with BlueZ (bluetoothctl)
- V&Z-Charybdis keyboard with ZMK firmware

## Keyboard Layout Reference

The keyboard uses layers to access different functions. The main key to access **Layer 1** is **(⌘ spc)** located in the left thumb cluster.

### Layer 1 Bluetooth Functions

| Function | Key | Description |
|----------|-----|-------------|
| Bluetooth Clear | **G** | Clears the current Bluetooth profile |
| Bluetooth Next | **F** | Switches to the next Bluetooth profile |
| Caps Lock | **Q** | Toggle Caps Lock on/off |

## Step-by-Step Bluetooth Connection

### Step 1: Clear Bluetooth on the Keyboard

Before connecting, clear any existing Bluetooth pairing on the keyboard:

1. Press **(⌘ spc)** once to enter Layer 1
2. Press **G** to clear Bluetooth profile
3. Press **F** to switch to a clean profile
4. Press **(⌘ spc)** to return to Layer 0

### Step 2: Restart Bluetooth Service (Linux)

```bash
sudo systemctl restart bluetooth
sleep 2
bluetoothctl power on
```

### Step 3: Scan for the Keyboard

```bash
bluetoothctl --timeout 8 scan on &
sleep 6
bluetoothctl devices | grep -i chary
```

You should see output like:
```
Device DF:1F:E0:ED:35:2C V&Z-Charydbis
```

> **Note:** Your device MAC address may be different. Replace `DF:1F:E0:ED:35:2C` with your actual MAC address in the following commands.

### Step 4: Pair and Connect

This is the key step that works reliably:

```bash
bluetoothctl << EOF
agent on
default-agent
trust DF:1F:E0:ED:35:2C
pair DF:1F:E0:ED:35:2C
EOF
```

### Step 5: Verify Connection

```bash
bluetoothctl info DF:1F:E0:ED:35:2C
```

You should see:
```
Paired: yes
Bonded: yes
Connected: yes
```

## Troubleshooting

### Connection Fails with "AuthenticationFailed"

If you see this error:
```
Failed to pair: org.bluez.Error.AuthenticationFailed
```

**Solution - Complete Reset Method:**

#### Step 1: Remove device from Linux
```bash
bluetoothctl remove DF:1F:E0:ED:35:2C 2>/dev/null
```

#### Step 2: Clear Bluetooth on the keyboard
On the keyboard, press:
1. **(⌘ spc)** - Enter Layer 1
2. **G** - Hold for 2-3 seconds (Bluetooth Clear)
3. **F** - Press 3-4 times (cycle through Bluetooth profiles)

#### Step 3: Restart Bluetooth service
```bash
sudo systemctl restart bluetooth
sleep 2
bluetoothctl power on
```

#### Step 4: Scan for the keyboard
```bash
bluetoothctl --timeout 10 scan on &
sleep 8
bluetoothctl devices | grep -i chary
```

#### Step 5: Pair using the agent method
```bash
bluetoothctl << EOF
agent on
default-agent
trust DF:1F:E0:ED:35:2C
pair DF:1F:E0:ED:35:2C
EOF
```

#### Step 6: Verify connection
```bash
sleep 3
bluetoothctl info DF:1F:E0:ED:35:2C | grep -E "Name|Paired|Bonded|Connected|Battery"
```

Expected output:
```
Name: V&Z-Charydbis
Paired: yes
Bonded: yes
Connected: yes
Battery Percentage: 0x4d (77)
```

---

### Keyboard Connects but Disconnects Immediately

This happens when the keyboard has old pairing data that conflicts with Linux.

**Solution - Full Reset Procedure:**

#### Step 1: On the keyboard
1. Press **(⌘ spc)** to enter Layer 1
2. Press **G** (hold 2-3 seconds) to clear Bluetooth
3. Press **F** multiple times (3-4 times) to cycle profiles

#### Step 2: On Linux - Complete reset
```bash
# Remove old pairing
bluetoothctl remove DF:1F:E0:ED:35:2C 2>/dev/null

# Restart Bluetooth service
sudo systemctl restart bluetooth
sleep 2
bluetoothctl power on
sleep 1

# Scan for keyboard
bluetoothctl --timeout 10 scan on &
sleep 8

# Verify keyboard is visible
bluetoothctl devices | grep -i chary
```

#### Step 3: Pair with agent
```bash
bluetoothctl << EOF
agent on
default-agent
trust DF:1F:E0:ED:35:2C
pair DF:1F:E0:ED:35:2C
EOF
```

#### Step 4: Verify
```bash
sleep 3
bluetoothctl info DF:1F:E0:ED:35:2C | grep -E "Paired|Bonded|Connected"
```

---

### Keyboard Not Found in Scan

1. **Disconnect USB cable** - The keyboard must not be connected via USB
2. **Clear Bluetooth on keyboard**: 
   - Press **(⌘ spc)** → **G** (hold 2-3 seconds)
3. **Switch Bluetooth profile**: 
   - Press **(⌘ spc)** → **F** (press multiple times)
4. **Restart Bluetooth on Linux**:
   ```bash
   sudo systemctl restart bluetooth
   sleep 2
   bluetoothctl power on
   ```
5. **Try scanning again**:
   ```bash
   bluetoothctl --timeout 10 scan on &
   sleep 8
   bluetoothctl devices | grep -i chary
   ```

---

### Error: "org.bluez.Error.AlreadyExists"

The device already exists in the Bluetooth database but is corrupted.

**Solution:**
```bash
# Force remove the device
bluetoothctl remove DF:1F:E0:ED:35:2C

# Then follow the complete pairing procedure above
```

---

### Error: "org.bluez.Error.AuthenticationCanceled"

The keyboard cancelled the authentication. This means the keyboard's Bluetooth profile has old data.

**Solution:**
1. On keyboard: **(⌘ spc)** → **G** (hold) → **F** (multiple times)
2. On Linux: Follow the complete reset procedure above

## Quick Reference Script

Save this as `connect-charybdis.sh`:

```bash
#!/bin/bash

# V&Z-Charybdis Bluetooth Connection Script
# Replace MAC address with your keyboard's MAC address

MAC="DF:1F:E0:ED:35:2C"

echo "╔══════════════════════════════════════════════════════════╗"
echo "║     V&Z-Charybdis Bluetooth Connection Script            ║"
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
```

Make it executable:
```bash
chmod +x connect-charybdis.sh
```

Run it:
```bash
./connect-charybdis.sh
```

## Linux Permissions Setup (One-time)

If you have permission issues, run these commands once:

```bash
# Add udev rules for HID devices
echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", GROUP="input"' | sudo tee /etc/udev/rules.d/99-hidraw.rules

# Add user to required groups
sudo usermod -aG input $USER
sudo usermod -aG dialout $USER

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger

# Log out and log back in for group changes to take effect
```

## Keymap File

The keyboard keymap is defined in `charybdis.keymap`. Key Bluetooth bindings in Layer 1:

```dts
layer_1 {
    bindings = <
        ...
        &kp CAPS  ...  &bt BT_NXT  &bt BT_CLR  ...
        ...
    >;
};
```

- `&bt BT_NXT` - Bluetooth Next (key F position)
- `&bt BT_CLR` - Bluetooth Clear (key G position)
- `&kp CAPS` - Caps Lock (key Q position)

## Summary

1. **Clear keyboard Bluetooth**: (⌘ spc) → G → F
2. **Restart Linux Bluetooth**: `sudo systemctl restart bluetooth`
3. **Scan**: `bluetoothctl scan on`
4. **Pair with agent**: Use the `bluetoothctl << EOF` method
5. **Verify**: `bluetoothctl info <MAC>`

---

*Last updated: December 2024*
