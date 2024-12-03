#!/bin/sh
#5 napon belül módosított fájlok listázása a /var/log/* mappákból rekurzívan a last_five-<DATE>.out fájlba

DIR="/var/statistic"
NOW=$(date +"%Y-%m-%d-%H%M%S")
FILE=$DIR/last_five-$NOW.out

#statistic könyvtár létrehozása rekurzívan, ha nem létezik
[ ! -d $DIR ] && mkdir -p $DIR || :

#fő parancs
find /var/log -type f -mtime -5 > $FILE
