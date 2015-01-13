#!/bin/sh

#  example-build-script.sh

#
# GOLGI_WORK_DIR: Where the golgi_gen script will copied to run
# GOLGI_PKG_DIR: The Golgi Package install directory
# GOLGI_LIB_DIR: Where the Golgi runtime libraries whould be put
#

GOLGI_WORK_DIR="$PROJECT_DIR/$PROJECT_NAME"
GOLGI_PKG_DIR="$HOME/Golgi-Pkg/LATEST"
GOLGI_HDR_DIR="$PROJECT_DIR/$PROJECT_NAME"
GOLGI_LIB_DIR="$PROJECT_DIR/$PROJECT_NAME"

#
# Copy Thrift file(s) into place (if necessary)
#

cp -f "$PROJECT_DIR/../../Doorman.thrift" "$WKDIR"

#
# Create the GOLGI_KEYS.h file containing
# the Developer key and the application key
#

DEVKEY=`cat "$PROJECT_DIR/../../Golgi.DevKey"`
APPKEY=`cat "$PROJECT_DIR/../../Golgi.AppKey"`
echo "#define GOLGI_DEV_KEY @\"$DEVKEY\"" >"$GOLGI_HDR_DIR/GOLGI_KEYS.h"
echo "#define GOLGI_APP_KEY @\"$APPKEY\"" >>"$GOLGI_HDR_DIR/GOLGI_KEYS.h"


. "$GOLGI_PKG_DIR/iOS/golgi_gen.sh"

#
# Remove the thrift file because the canonical source is elsewhere
#

rm -f "$GOLGI_WORK_DIR/Doorman.thrift"

#
# Check and parse config
#
if [ ! -f $PROJECT_DIR/../../Doorman.conf ]; then
    echo "Cannot find Doorman.conf file .. exiting build"
    exit 2
fi

while read -r line; do
    if [[ $line == *'ADDR'* ]]; then
        ADDR=`echo $line | cut -d '=' -f 2 | tr -d ' \r\n'`
    fi
    if [[ $line == *'LAT'* ]]; then
        LAT=`echo $line | cut -d '=' -f 2 | tr -d ' \r\n'`
    fi
    if [[ $line == *'LON'* ]]; then
        LON=`echo $line | cut -d '=' -f 2 | tr -d ' \r\n'`
    fi
done < $PROJECT_DIR/../../Doorman.conf

#
# Replace Doorman Address value
#
cp $GOLGI_WORK_DIR/keyViewController.m.default /tmp/keyViewController.m.default
sed -i.bak s/'STAFF_ADDRESS'/"$ADDR"/g /tmp/keyViewController.m.default
mv /tmp/keyViewController.m.default $GOLGI_WORK_DIR/keyViewController.m

#
# Replace Doorman Latitude and Longitude values
#
cp $GOLGI_WORK_DIR/gdmViewController.m.default /tmp/gdmViewController.m.default
sed -i.bak s/'DoormanLatitude'/$LAT/g /tmp/gdmViewController.m.default
sed -i.bak s/'DoormanLongitude'/$LON/g /tmp/gdmViewController.m.default
mv /tmp/gdmViewController.m.default $GOLGI_WORK_DIR/gdmViewController.m


