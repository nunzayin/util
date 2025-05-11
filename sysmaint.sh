#!/bin/bash

function efat() {
# SYNTAX:
#   efat ERROR_MESSAGE
# Panics the whole script if exit code is not zero.
# Prints ERROR_MESSAGE and exit code.
    local EXIT_CODE=$?
    if [[ $EXIT_CODE -ne 0 ]]; then
        echo "$1: exit code $EXIT_CODE" >&2
        exit $EXIT_CODE
    fi
}

function stage() {
# SYNTAX:
#   stage STAGE_NAME
# Just a macros to print a fancy header for the following stage of the script.
# Adds a little delay though
echo -e "\n----------------------------------------------------"
echo $1
echo -e "----------------------------------------------------\n"
sleep 1s
}

echo "Checking dependencies..."
DEPS="
rate-mirrors
yay
paccache
trash
"
MISSING_DEPS=0
for DEP in $DEPS; do
    if ! [[ -x "$(command -v $DEP)" ]]; then
        MISSING_DEPS=1
        echo "Missing dependency: $DEP" >%2
    fi
done
if [[ $MISSING_DEPS -ne 0 ]]; then
    echo "Satisfy the dependencies above to use sysmaint."
    exit 127
else
    echo "All seems good to go :D"
fi

stage "REFRESHING MIRRORS"
rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist
efat "Could not rate mirrors"

stage "UPDATING SYSTEM"
yay -Syu
efat "Could not update system"

stage "CLEARING PACMAN CACHE"
pacman_cache_space_used="$(du -sh /var/cache/pacman/pkg/)"
echo -e "Space currently in use: $pacman_cache_space_used\n"
echo "Clearing Cache, leaving newest 2 versions:"
paccache -vrk2
efat "Could not clear pacman cache"
echo -e "\nClearing all uninstalled packages:"
paccache -ruk0
efat "Could not clear uninstalled packages"

stage "REMOVING ORPHANED PACKAGES"
orphaned=$(yay -Qdtq)
if [ -n "$orphaned" ]; then
    echo "$orphaned" | yay -Rns -
    efat "Could not delete orphans"
else
    echo "No orphaned packages to remove."
fi

stage "CLEARING SYSTEM LOGS"
sudo journalctl --vacuum-time=7d
efat "Could not clear syslogs"

stage "FINAL"
trash_size="$(du -sh .local/share/Trash/)"
echo "Trash size is $trash_size"
echo -e "Run 'trash-empty' if you feel it too large\n"
echo "System maintenance complete. You better reboot to apply all the changes"

exit 0
