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

rootPermsCheck() {
    if [[ $(whoami) != "root" ]]; then
        echo "This script is intended to be run as root/with sudo. Exiting."
        exit 1
    fi
}

intelMacCheck() {
    
    if [[ "$(sysctl -a | grep brand | grep Intel)" = "" ]]; then
        echo "This script is intended to be run on Intel Macs, not Apple Silicon. To run Linux on Apple Silicon Macs, check out https://asahilinux.org."
        exit
    else
        echo hello
    fi
}

disclaimer() {
    echo "Macbian is currently in extremely early alpha stages. It doesn't contain a lot of features, and some or all of the features currently implemented may not work."
    echo "I am NOT responsible if Macbian dev-alpha renders your Mac OS X installation unbootable. Make sure that you don't have any important data on your Mac, or back it up."
    printf "Do you still want to continue installation? (Y/n): "
    read CHOICE
    if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "Y" ] || [ "$CHOICE" = "" ]; then
        echo "Ok, beginning installation."
    else
        echo "Ok, bye! See you later."
        exit
    fi
}

downloadBase() {
    echo "Downloading the base system..."
    echo "Creating temporary directory..."
    mkdir -p /var/tmp/macbian-$USER-session
    TEMPDIR=/var/tmp/$(ls /var/tmp/ | grep macbian-$USER-session) 
    echo "Downloading base system into $TEMPDIR..."
    #curl -o $TEMPDIR 
    

}

mountESP() {
    echo "Mounting EFI System Partition..."
    
    mkdir -p /Volumes/EFI
    mount_msdos /dev/disk0s1 /Volumes/EFI # Todo: Fix detection for installation on external disks.
    if [[ $(echo $?) != 0 ]]; then
        echo "Something went wrong mounting your EFI partition! See above for error. This may mean that you don't have root privileges, your EFI partition was deleted, or you are booted off an external drive."
        exit 1
    fi
}
partitionDisk() {

}



macOSCheck
#rootPermsCheck # Comment for debug
intelMacCheck
disclaimer
downloadBase
mountESP