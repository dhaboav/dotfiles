# DAMX Installation Guide

This guide walks you through setting up **DAMX**, including the required BIOS configuration, application installation, and NitroSense key mapping and already tested for Acer AN515-57 in ubuntu 26.04 LTS.

## Prerequisites

Before installing DAMX, make sure:

- You can access your system BIOS/UEFI.
- **Secure Boot** is disabled.
- You have `sudo` privileges.

## 1. Configure BIOS/UEFI

Restart your computer and repeatedly press **F2** during boot to enter the BIOS setup.

### Set a Supervisor Password

1. Open the **Security** tab.
2. Set a **Supervisor Password**.

> **Note**
> A Supervisor Password is required to unlock advanced BIOS options on supported Acer laptops.

### Disable Secure Boot

1. Go to the **Boot** tab.
2. Set **Secure Boot** to **Disabled**.
3. Save your changes and reboot.

## 2. Install DAMX

Run the following command to download and install DAMX:

```bash
curl -fsSL https://raw.githubusercontent.com/PXDiv/Div-Acer-Manager-Max/refs/heads/main/scripts/remoteSetup.sh -o /tmp/setup.sh && sudo bash /tmp/setup.sh
```

### Initial Configuration

After installation:

1. Launch **DAMX**.
2. Open **System Settings**.
3. Find **Internal Manager**.
4. Set **Driver Paramaters** to `Load with enableall`
5. Click **Restart Driver and Daemon** for the effect work.

## 3. Configure the NitroSense Key

To allow DAMX to respond to the dedicated **NitroSense** key, remap the key to **F14**.

### Step 1 — Verify the Key

Install `evtest`:

```bash
sudo apt install evtest
```

Run:

```bash
evtest
```

Select **AT Translated Set keyboard**, then press the NitroSense key to verify it is detected.

### Step 2 — Create a udev Hardware Database Rule

Create (or edit):

```text
/etc/udev/hwdb.d/99-nitro.hwdb
```

Add:

```text
evdev:atkbd:*
KEYBOARD_KEY_f5=f14
```

Then update the hardware database:

```bash
sudo systemd-hwdb update
sudo udevadm trigger
```
> You may need to reboot if the new key mapping does not take effect immediately.

### Step 3 — Create a Keyboard Shortcut

Open:

**Settings → Keyboard → Custom Shortcuts**

Create a new shortcut:

| Field | Value |
| ----- | ----- |
| **Name** | `DAMX` |
| **Command** | `DAMX` *(or the full executable path)* |
| **Shortcut** | Press the physical **NitroSense** key |

## Done

Your NitroSense key should now launch DAMX whenever it is pressed.
