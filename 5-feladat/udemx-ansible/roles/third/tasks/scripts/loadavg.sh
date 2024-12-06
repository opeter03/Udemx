#!/bin/sh
#A /proc/loadavg-ból a 15 perces érték kiíratása a loadavg-<DATE>.out fájlba

DIR="/var/statistic"
NOW=$(date +"%Y-%m-%d-%H%M%S")
FILE=$DIR/loadavg-$NOW.out

#statistic könyvtár létrehozása rekurzívan, ha nem létezik
[ ! -d $DIR ] && mkdir -p $DIR || :

#fő parancs
cat /proc/loadavg | awk ' { print $3 }' > $FILE
