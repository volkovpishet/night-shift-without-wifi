#!/bin/bash

PLIST_PATH=~/Library/LaunchAgents/local.nightShiftWithoutWifi.plist
SCRIPTS_DIR=$HOME/.night-shift-without-wifi

rm -r $SCRIPTS_DIR
launchctl unload $PLIST_PATH
rm $PLIST_PATH
