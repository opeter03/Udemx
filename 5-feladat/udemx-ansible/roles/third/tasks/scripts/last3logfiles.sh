#!/bin/sh
#3 legutoljára módosított fájl listázása a/var/log mappából a mod-<DATE>.out fájlba

DIR="/var/statistic"
NOW=$(date +"%Y-%m-%d-%H%M%S")
FILE=$DIR/mod-$NOW.out

#statistic könyvtár létrehozása rekurzívan, ha nem létezik
[ ! -d $DIR ] && mkdir -p $DIR || :

#fő parancs
ls -la1t /var/log | grep -v '^d' | awk ' { print $9 }' | head -n 4 | tail -n 3 > $FILE
