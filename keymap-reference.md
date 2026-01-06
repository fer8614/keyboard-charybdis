# V&Z-Charybdis Keymap Reference

## Layer 0 (Default Layer)

```
┌───────┬───────┬───────┬───────┬───────┬───────┐     ┌───────┬───────┬───────┬───────┬───────┬───────┐
│  ESC  │   1   │   2   │   3   │   4   │   5   │     │   6   │   7   │   8   │   9   │   0   │ BKSPC │
├───────┼───────┼───────┼───────┼───────┼───────┤     ├───────┼───────┼───────┼───────┼───────┼───────┤
│  TAB  │   Q   │   W   │   E   │   R   │   T   │     │   Y   │   U   │   I   │   O   │   P   │   \   │
├───────┼───────┼───────┼───────┼───────┼───────┤     ├───────┼───────┼───────┼───────┼───────┼───────┤
│ SHIFT │   A   │   S   │   D   │   F   │   G   │     │   H   │   J   │   K   │   L   │   ;   │   '   │
├───────┼───────┼───────┼───────┼───────┼───────┤     ├───────┼───────┼───────┼───────┼───────┼───────┤
│ CTRL  │   Z   │   X   │   C   │   V   │   B   │     │   N   │   M   │   ,   │   [   │   /   │   -   │
└───────┴───────┴───────┴───────┴───────┴───────┘     └───────┴───────┴───────┴───────┴───────┴───────┘

                        ┌───────┬───────┬───────┐     ┌───────┬───────┐
                        │  ALT  │ SPACE │ TO(1) │     │  WIN  │ SPACE │
                        └───────┼───────┼───────┤     ├───────┼───────┘
                                │ MB1   │ MB2   │     │ ENTER │
                                │(L-Clk)│(R-Clk)│     │       │
                                └───────┴───────┘     └───────┘
                                                              (trackball)
```

### Layer 0 Key Descriptions:

| Position | Key | ZMK Code | Description |
|----------|-----|----------|-------------|
| Row 1, Col 1 | ESC | `&kp ESC` | Escape key |
| Row 1, Col 2-6 | 1-5 | `&kp N1` - `&kp N5` | Number keys |
| Row 1, Col 7-11 | 6-0 | `&kp N6` - `&kp N0` | Number keys |
| Row 1, Col 12 | BKSPC | `&kp BACKSPACE` | Backspace |
| Row 2, Col 1 | TAB | `&kp TAB` | Tab key |
| Row 2, Col 12 | \ | `&kp BSLH` | Backslash |
| Row 3, Col 1 | SHIFT | `&kp LEFT_SHIFT` | Left Shift |
| Row 3, Col 11 | ; | `&kp SEMI` | Semicolon |
| Row 3, Col 12 | ' | `&kp SQT` | Single quote |
| Row 4, Col 1 | CTRL | `&kp LCTRL` | Left Control |
| Row 4, Col 10 | [ | `&kp LEFT_BRACKET` | Left bracket |
| Row 4, Col 11 | / | `&kp FSLH` | Forward slash |
| Row 4, Col 12 | - | `&kp MINUS` | Minus |
| Thumb L1 | ALT | `&kp LEFT_ALT` | Left Alt |
| Thumb L2 | SPACE | `&kp SPACE` | Space |
| **Thumb L3** | **TO(1)** | `&to 1` | **Switch to Layer 1** |
| Thumb L4 | MB1 | `&mkp MB1` | Mouse Left Click |
| Thumb L5 | MB2 | `&mkp MB2` | Mouse Right Click |
| Thumb R1 | WIN | `&kp LWIN` | Windows/Super key |
| Thumb R2 | SPACE | `&kp SPACE` | Space |
| Thumb R3 | ENTER | `&kp ENTER` | Enter key |

---

## Layer 1 (Function/Bluetooth Layer)

```
┌───────┬───────┬───────┬───────┬───────┬───────┐     ┌───────┬───────┬───────┬───────┬───────┬───────┐
│  F1   │  F2   │  F3   │  F4   │  F5   │  F6   │     │  F7   │  F8   │  F9   │  F10  │  F11  │  F12  │
├───────┼───────┼───────┼───────┼───────┼───────┤     ├───────┼───────┼───────┼───────┼───────┼───────┤
│ CAPS  │ (none)│ (none)│ (none)│ (none)│ (none)│     │ (none)│ (none)│   ↑   │ (none)│ (none)│ (none)│
├───────┼───────┼───────┼───────┼───────┼───────┤     ├───────┼───────┼───────┼───────┼───────┼───────┤
│ SHIFT │ (none)│ (none)│ (none)│BT_NXT │BT_CLR │     │ (none)│   ←   │   ↓   │   →   │ (none)│ (none)│
├───────┼───────┼───────┼───────┼───────┼───────┤     ├───────┼───────┼───────┼───────┼───────┼───────┤
│ CTRL  │ (none)│ (none)│ (none)│ (none)│ (none)│     │ (none)│ (none)│   .   │   ]   │ (none)│   =   │
└───────┴───────┴───────┴───────┴───────┴───────┘     └───────┴───────┴───────┴───────┴───────┴───────┘

                        ┌───────┬───────┬───────┐     ┌───────┬───────┐
                        │  ALT  │ SPACE │ TO(0) │     │ (none)│ (none)│
                        └───────┼───────┼───────┤     ├───────┼───────┘
                                │ MB1   │ MB2   │     │ ENTER │
                                └───────┴───────┘     └───────┘
```

### Layer 1 Key Descriptions:

| Position | Key | ZMK Code | Description |
|----------|-----|----------|-------------|
| Row 1 | F1-F12 | `&kp F1` - `&kp F12` | Function keys |
| **Row 2, Col 1** | **CAPS** | `&kp CAPS` | **Caps Lock Toggle** |
| Row 2, Col 9 | ↑ | `&kp UP` | Arrow Up |
| Row 3, Col 1 | SHIFT | `&kp LEFT_SHIFT` | Left Shift |
| **Row 3, Col 5** | **BT_NXT** | `&bt BT_NXT` | **Bluetooth Next Profile** |
| **Row 3, Col 6** | **BT_CLR** | `&bt BT_CLR` | **Bluetooth Clear** |
| Row 3, Col 8 | ← | `&kp LEFT` | Arrow Left |
| Row 3, Col 9 | ↓ | `&kp DOWN` | Arrow Down |
| Row 3, Col 10 | → | `&kp RIGHT` | Arrow Right |
| Row 4, Col 1 | CTRL | `&kp LCTRL` | Left Control |
| Row 4, Col 9 | . | `&kp PERIOD` | Period |
| Row 4, Col 10 | ] | `&kp RIGHT_BRACKET` | Right bracket |
| Row 4, Col 12 | = | `&kp EQUAL` | Equal sign |
| **Thumb L3** | **TO(0)** | `&to 0` | **Return to Layer 0** |

---

## Quick Reference - Important Keys

### Bluetooth Controls (Layer 1)
| Action | How to Access |
|--------|---------------|
| **Caps Lock** | Press `TO(1)` → Press `Q` position |
| **Bluetooth Next** | Press `TO(1)` → Press `F` position |
| **Bluetooth Clear** | Press `TO(1)` → Press `G` position |
| **Return to Layer 0** | Press `TO(0)` (same thumb key) |

### Mouse Controls (Layer 0)
| Action | Key |
|--------|-----|
| Left Click | Thumb MB1 |
| Right Click | Thumb MB2 |
| Move Cursor | Trackball |

### Encoders
| Encoder | Action |
|---------|--------|
| Encoder 1 | Scroll Up/Down |
| Encoder 2 | Scroll Left/Right |

---

## Visual Layer 0 Map

```
LEFT HALF                                          RIGHT HALF
┌─────────────────────────────────────┐     ┌─────────────────────────────────────┐
│ ESC    1      2      3      4    5  │     │  6     7      8      9      0  BKSP │
│                                     │     │                                     │
│ TAB    Q      W      E      R    T  │     │  Y     U      I      O      P    \  │
│                                     │     │                                     │
│ SHIFT  A      S      D      F    G  │     │  H     J      K      L      ;    '  │
│                                     │     │                                     │
│ CTRL   Z      X      C      V    B  │     │  N     M      ,      [      /    -  │
└─────────────────────────────────────┘     └─────────────────────────────────────┘

         THUMB CLUSTER LEFT                      THUMB CLUSTER RIGHT
              ┌─────┬─────┬─────┐                    ┌─────┬─────┐
              │ ALT │SPACE│TO(1)│                    │ WIN │SPACE│
              └─────┴──┬──┴──┬──┘                    └──┬──┴─────┘
                       │ MB1 │ MB2 │                    │ENTER│  (trackball)
                       └─────┴─────┘                    └─────┘
```

## Visual Layer 1 Map

```
LEFT HALF                                          RIGHT HALF
┌─────────────────────────────────────┐     ┌─────────────────────────────────────┐
│ F1     F2     F3     F4     F5   F6 │     │ F7     F8     F9    F10    F11  F12 │
│                                     │     │                                     │
│ CAPS   ---    ---    ---    ---  ---│     │ ---    ---     ↑    ---    ---  --- │
│                                     │     │                                     │
│SHIFT   ---    ---    ---  BT_NXT CLR│     │ ---     ←      ↓      →    ---  --- │
│                                     │     │                                     │
│ CTRL   ---    ---    ---    ---  ---│     │ ---    ---     .      ]    ---    = │
└─────────────────────────────────────┘     └─────────────────────────────────────┘

         THUMB CLUSTER LEFT                      THUMB CLUSTER RIGHT
              ┌─────┬─────┬─────┐                    ┌─────┬─────┐
              │ ALT │SPACE│TO(0)│                    │ --- │ --- │
              └─────┴──┬──┴──┬──┘                    └──┬──┴─────┘
                       │ MB1 │ MB2 │                    │ENTER│
                       └─────┴─────┘                    └─────┘

Legend: --- = no function, CLR = BT_CLR, BT_NXT = Bluetooth Next
```
