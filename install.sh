#!/bin/bash
##############################################
###  For developers and power users only.  ###
##############################################
macOSCheck() {
    if [[ $(uname -s) != "Darwin" ]]; then
        echo "This script is intended to be run as root under Mac OS X. Exiting." 
        exit 1
    fi
}

rootPermsCheck()
    if [[ $(whoami) != "root" ]]; then
        echo "This script is intended to be run as root/with sudo. Exiting."
        exit 1
    fi

echo hello
macOSCheck
rootPermsCheck