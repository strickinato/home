#!/bin/bash
# Disable macOS built-in screenshot shortcuts so CleanShot X can use them instead

# 28 = Cmd+Shift+3 (full screenshot)
# 30 = Cmd+Shift+4 (selection screenshot)
# 184 = Cmd+Shift+5 (screenshot toolbar)

for key in 28 30 184; do
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$key" '<dict><key>enabled</key><false/></dict>'
done

# Apply changes
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo "macOS screenshot shortcuts disabled. CleanShot X should now capture them."
