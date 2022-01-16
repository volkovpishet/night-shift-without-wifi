#!/bin/bash

# Usage: extractTimeFromRes JSON_STRING FIELD_NAME
# Response format: {"results":{"sunrise":"6:05:01 AM","sunset":"6:14:28 PM","solar_noon":"12:09:45 PM","day_length":"12:09:27","civil_twilight_begin":"5:44:03 AM","civil_twilight_end":"6:35:26 PM","nautical_twilight_begin":"5:18:19 AM","nautical_twilight_end":"7:01:10 PM","astronomical_twilight_begin":"4:52:29 AM","astronomical_twilight_end":"7:27:00 PM"},"status":"OK"}
function extractTimeFromRes() {
    RES=$1
    FIELD=$2

    echo $RES | awk -F "$FIELD\":" '{print $2}' | awk -F "," '{print $1}' | awk -F " " '{print $1$2}' | sed "s/\"//g"
}

# Util to convert UTC time to local
# Usage: applyTzToTime 4:43:00AM
function applyTzToTime() {
    HOURS_UTC=$(echo $1 | awk -F ":" '{print $1}')
    MINUTES=$(echo $1 | awk -F ":" '{print $2}')
    SUFFIX=$(echo $1 | awk -F ":" '{print $3}')
    TZ_OFFSET_EXPR=$(date +%Z | awk '{ gsub(/([[:alpha:]]+|[[:digit:].-]+|[^[:alnum:].-]+)/,"&\n",$0) ; printf $0 }')
    HOURS_LOCAL=$(expr $HOURS_UTC $TZ_OFFSET_EXPR)

    echo $HOURS_LOCAL:$MINUTES:$SUFFIX;
}

# Usage: extractConfValue CONFIG_AS_STRING FIELD
function extractConfValue() {
    CONFIG_AS_STRING=$1
    FIELD=$2

    echo $CONFIG_AS_STRING | awk -F "$FIELD:" '{print $2}' | awk -F " " '{print $1}'
}

CONFIG=$(cat config)
LAT=$(extractConfValue "${CONFIG}" lat);
LON=$(extractConfValue "${CONFIG}" lon);

SCHEDULE_RES=$(curl -s "https://api.sunrise-sunset.org/json?lat=$LAT&lng=$LON&date=today");
SUNRISE=$(extractTimeFromRes "${SCHEDULE_RES}" sunrise)
SUNSET=$(extractTimeFromRes "${SCHEDULE_RES}" sunset)

echo "Lat: $LAT"
echo "Lon: $LON"
echo "Sunrise time (UTC): $SUNRISE"
echo "Sunset time (UTC): $SUNSET"

nightlight schedule $(applyTzToTime $SUNSET) $(applyTzToTime $SUNRISE)