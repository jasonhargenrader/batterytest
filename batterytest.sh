#!/bin/bash
# calculate battery life from /proc/uptime
file=batterytime

# check for existing batterytime file
if [ -e $file ] ; then
    rm $file
fi

echo `date` | tee $file

# get the start time and strip the decimals
startTime=$(</proc/uptime)
startTime=${startTime%%.*}

# run until battery dies
while true;
do

    sleep 60;

    # get the current time and strip the decimals
    currentTime=$(</proc/uptime)
    currentTime=${currentTime%%.*}

    # math to determine time
    diff=$(($currentTime - $startTime))
    minutes=$(( diff/60%60 ))
    hours=$(( diff/60/60%24 ))

    # write the date, hours, and minutes to the first line of $file
    echo `date` - "$hours hours, $minutes minutes" | cat - $file > temp && mv temp $file

    # write to terminal
    echo `date` - "$hours hours, $minutes minutes"
done
