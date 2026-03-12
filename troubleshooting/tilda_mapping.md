## Problem

M1 MBP (ISO layout) internal keyboard needs a tilde swap (`§`/`±` ↔ ```/`~`), but the fix must **not** affect external keyboards. Using simple `plist` matching can fail if the system IDs for the internal keyboard are handled via the SPI bus.

## Temporary Solution (Universal Internal Fix)

Run this command. It targets **any** device marked as "Built-in" by the system:

```bash
hidutil property --matching '{"Built-In":true}' --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035},{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064}]}'

```

## Persistent Solution

We will create a small shell script and a Launch Agent to run it. This avoids the "Input/Output" errors and ensures the fix only hits the internal keys.

**1. Create the script:**

```bash
mkdir -p ~/.local/bin
cat << 'EOF' > ~/.local/bin/fix_tilde.sh
#!/bin/sh
# Resets any global mapping first
/usr/bin/hidutil property --set '{"UserKeyMapping":[]}'
# Applies fix ONLY to built-in keyboard
/usr/bin/hidutil property --matching '{"Built-In":true}' --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035},{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064}]}'
EOF
chmod +x ~/.local/bin/fix_tilde.sh

```

**2. Create the Launch Agent:**

```bash
cat << 'EOF' > ~/Library/LaunchAgents/com.user.tilde-fix.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.tilde-fix</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/sh</string>
        <string>/Users/$(whoami)/.local/bin/fix_tilde.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF
```

**3. Load the fix:**

```bash
launchctl unload ~/Library/LaunchAgents/com.user.tilde-fix.plist 2>/dev/null
launchctl load -w ~/Library/LaunchAgents/com.user.tilde-fix.plist
```
