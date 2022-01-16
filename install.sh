#!/bin/bash

PLIST_PROGRAM_NAME=local.nightShiftWithoutWifi
SCRIPTS_DIR=$HOME/.night-shift-without-wifi
PLIST_PATH=~/Library/LaunchAgents/$PLIST_PROGRAM_NAME.plist
SCRIPT_NAME=update-nightshift-schedule.sh
SCRIPT_PATH=$SCRIPTS_DIR/$SCRIPT_NAME

# Copy script file and config to home directory
mkdir -p $SCRIPTS_DIR
cp $SCRIPT_NAME $SCRIPTS_DIR/
chmod +x $SCRIPT_PATH
cp config $SCRIPTS_DIR/

# Setup launhagent
mkdir -p ~/Library/LaunchAgents
PLIST=$(cat <<-END
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>$PLIST_PROGRAM_NAME</string>
        <key>Program</key>
        <string>$SCRIPT_PATH</string>
        <key>EnvironmentVariables</key>
        <dict>
            <key>PATH</key>
            <string>/bin:/usr/bin:/usr/local/bin</string>
        </dict>
        <key>StandardInPath</key>
        <string>/tmp/$PLIST_PROGRAM_NAME.stdin</string>
        <key>StandardOutPath</key>
        <string>/tmp/$PLIST_PROGRAM_NAME.stdout</string>
        <key>StandardErrorPath</key>
        <string>/tmp/$PLIST_PROGRAM_NAME.stderr</string>
        <key>WorkingDirectory</key>
        <string>$SCRIPTS_DIR</string>
        <key>StartCalendarInterval</key>
        <dict>
            <key>Hour</key>
            <integer>15</integer>
            <key>Minute</key>
            <integer>0</integer>
        </dict>
    </dict>
</plist>
END
)

echo "${PLIST}" > $PLIST_PATH
launchctl load $PLIST_PATH
