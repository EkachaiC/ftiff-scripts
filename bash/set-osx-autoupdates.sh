#!/bin/bash

# Sets OS X Auto-updates settings
# See: http://macadminsdoc.readthedocs.org/en/latest/Profiles-and-Settings/OS-X-Updates/
#
# Following test found on http://stackoverflow.com/questions/5195607/checking-bash-exit-status-of-several-commands-efficiently
function test_command {
    "$@"
    local status=$?
    echo -n "Executing '$@'… "
    if [ $status -ne 0 ]; then
        echo "ERROR: $@" >&2
        exit $status
    fi
    echo "OK"
    
}

test_command defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool TRUE
test_command defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdateRestartRequired -bool TRUE
test_command defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool TRUE
test_command defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool TRUE
test_command defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool TRUE
test_command defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool TRUE

echo "Done."
exit 0
