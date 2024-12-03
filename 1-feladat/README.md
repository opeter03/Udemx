# Linux rendszer telepítése



## Debian 11 telepítése

A telepítés VirtualBosban valósult meg.
A feladatban megadott felhasználók létrehozásra kerültek.



## Linux beállítása

### Feltételek megteremtése (segédprogramok)

Sajnos nem volt jó a sources.list alapból, így frissítenie kellet:

Átváltunk root-ba:

`su -`

`cp /etc/apt/sources.list /etc/apt/sources.list.backup`

`nano /etc/apt/sources.list`

`apt update`

`echo "opeter03 ALL=(ALL:ALL) ALL" > /etc/sudoers.d/opeter03`

### Feladatbeli telepítések

#### Egyéb telepítések: sudo, mc, htop, java

`apt install mc htop sudo`

Java telepítések

`apt install openjdk-11-jdk`

`sudo wget https://corretto.aws/downloads/latest/amazon-corretto-8-x64-linux-jdk.deb`

`sudo dpkg --install amazon-corretto-8-x64-linux-jdk.deb`

Automatán a Java8-ra (Java 1.8 = Java8) áll. De az alábbi paranccsal áttudjuk állítani a defualt java futtatót:

`update-alternatives --config java`

`update-alternatives --config javac`

Ellenőrés:

`java -version`

`javac -version`

#### udemx user létrehozása

Jelszó generálás új usernek (segédprogram):

`apt install makepasswd`

`makepasswd --chars 12`

`sudo adduser udemx --home /opt/udemx`

Ellenőrés: 

`sudo -i -u udemx`

`cd ~ && pwd`

`cat /etc/passwd | tail -1`











