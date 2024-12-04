# Nehezebb feladatok plusz pontokért



## Iptables beállítása

Megnézzük fenn van-e, ha nincs telepítjük:

`sudo iptables --version`

`sudo apt update`

`sudo apt install iptables`

Segédprogram, hogy a beállított szabályok újraindítás után is megmaradjanak

`sudo apt install iptables-persistent`

Bekapcsolás, induláskor is menjen majd

`sudo systemctl enable netfilter-persistent`

`sudo systemctl status netfilter-persistent`

Megnézzük milyen szabályok vannak beállítva

`sudo iptables -L -v`

`sudo iptables -L --line-numbers`

sudo iptables -D INPUT 5
sudo iptables -D FORWARD 7


Belső hálózati forgalom engedése (hurkok):

`sudo iptables -A INPUT -i lo -j ACCEPT`

`sudo iptables -A INPUT ! -i lo -d 127.0.0.0/8 -j REJECT`

`sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT`

`sudo iptables -A OUTPUT -o lo -j ACCEPT`

Minden kimenő forgalom engedése:

`sudo iptables -A OUTPUT -j ACCEPT`

Minden bejövő SSH kapcsolatot enged:

`sudo iptables -A INPUT -p tcp -m state --state NEW --dport 33333 -j ACCEPT`

Minden webes forgalom engedése (HTTP, HTTPS):

`sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT`

`sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT`

Ping engedése:

`sudo iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT`

`sudo iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7`

Minden más bejövő forgalom visszautasítása:

`sudo iptables -A INPUT -j REJECT`

`sudo iptables -A FORWARD -j REJECT`

Változások mentése:

`sudo netfilter-persistent save`


## Írni egy-egy külön shell scriptet

### Mysql dump cron-ba

A mellékelt jelszó fájl létrehozása

`sudo su -`

`chmod 600 /root/.my.cnf`

Mellékelt script megírása a /root/scripts mappába

`chmod 744 /root/scripts/mysqldump.sh`

crontab-ba állítás root alá

`crontab -e`

"0 2 * * * /root/scripts/mysqldump.sh >/dev/null 2>&1"

Ellenőrzés:

/var/backups/databases

### a 3 legutoljára módosított fájl listázása...

Mellékelt last3logfiles.sh

### 5 napon belül módosított fájlok listázása...

Mellékelt 5dayslogfiles.sh

### A /proc/loadavg-ból a 15 perces érték kiíratása...

Mellékelt loadavg.sh

### Az NGINX default konfigurációs fájljában az alábbi sztringben...

Mellékelt nginx.sh



## Docker project feladat

A docker compose felkerül a docker-rel együtt.

Létrehozzuk a mappát és belépünk

`mkdir -p ~/compose-demo && cd $_`

Kiklónozzuk az alábbi helyről: https://github.com/opeter03/udemx-laravel

`git clone https://github.com/opeter03/udemx-laravel.git .`

Beállításokat megváltoztatjuk

`cp .env.example .env`

`awk -F= ' $1=="SESSION_DRIVER" {printf "%s=%s\n",$1,"file"; next}1' .env > /tmp/.env && mv /tmp/.env .env`

`awk -F= ' $1=="DB_CONNECTION" {printf "%s=%s\n",$1,"mysql"; next}1' .env > /tmp/.env && mv /tmp/.env .env`

`awk -F= ' $1=="# DB_HOST" {printf "DB_HOST=%s\n","db"; next}1' .env > /tmp/.env && mv /tmp/.env .env`

`awk -F= ' $1=="# DB_PORT" {printf "DB_PORT=%s\n","3306"; next}1' .env > /tmp/.env && mv /tmp/.env .env`

`awk -F= ' $1=="# DB_DATABASE" {printf "DB_DATABASE=%s\n","udemx"; next}1' .env > /tmp/.env && mv /tmp/.env .env`

`awk -F= ' $1=="# DB_USERNAME" {printf "DB_USERNAME=%s\n","udemx_user"; next}1' .env > /tmp/.env && mv /tmp/.env .env`

`awk -F= ' $1=="# DB_PASSWORD" {printf "DB_PASSWORD=%s\n","tNbxUECKq"; next}1' .env > /tmp/.env && mv /tmp/.env .env`


Volume létrehozása az adatbázisnak

`docker volume create udemx-laravel-mysql-server-volume`

Docker konténer buildelés és indítás

`docker compose build app`

`docker compose up -d`

Laravel specifikus inicializációs parancsok futtatása

`docker compose exec app composer install`

`docker compose exec app php artisan key:generate`

`docker compose exec app php artisan migrate`

`docker compose exec app php artisan db:seed --class=CitiesSeeder`

Ellenőrzés:

http://localhost:8090



## +1 (VIM text editor)

kilépés mentés nélkül:

`ESC és :q!`

kilépés mentéssel:

`ESC és wq!`

