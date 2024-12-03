# Linux rendszer telepítése



## Debian 11 telepítése

A telepítés VirtualBosban valósult meg.
A feladatban megadott felhasználók létrehozásra kerültek.



## Linux beállítása

### Feltételek megteremtése

Sajnos nem volt jó a sources.list alapból, így frissítenie kellet:

Átváltunk root-ba:

`su -`

`cp /etc/apt/sources.list /etc/apt/sources.list.backup`

`nano /etc/apt/sources.list`

`apt update`

`echo "opeter03 ALL=(ALL:ALL) ALL" > /etc/sudoers.d/opeter03`

### Feladatbeli telepítések

`apt install mc htop sudo`




