#!/bin/bash

#check for the file existance /usr/bin/sentinelctl

if [ ! -f /usr/bin/sentinelctl ]

then
        echo 1

else
        status_check=$( /usr/bin/sentinelctl management status | grep -i "Connectivity" )


if echo "$status_check" | grep -qi "On"

then
        echo 0

else
        echo 1

fi

fi