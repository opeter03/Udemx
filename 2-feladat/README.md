# Kiegészítő szolgáltatások telepítése



## NGINX webszerver telepítése

Egyenlőre csak a hosta (nem docker-rel) a reverse proxy végett:

`apt install nginx`

`systemctl status nginx`

`systemctl enable nginx`


Ellenőrzés bögnészőben, wget-tel, vagy karakteres bögnészőben (tetszés szerint):

http://localhost

http://127.0.0.1

`apt install lynx`

`lynx http://127.0.0.1`


`wget -O - http://127.0.0.1`




## MariaDB telepítése

Lásd később.

## Docker telepítése

`sudo apt update`

`sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common`

`curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -`

`sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"`

`sudo apt update`

`apt-cache policy docker-ce`

`sudo apt install docker-ce`

Adott usert bele kell tenni a docker csoportba, majd ki-be login, vagy reboot:

`sudo usermod -aG docker ${USER}`

Ellenőrzések és bekapcsolás automata indulásra rebootnál:

`sudo systemctl status docker`

`sudo systemctl enable docker`

`docker info`

### hello-world container futtatása

`docker image pull hello-world`

`docker run --name hello-world-1 hello-world`

### MariaDB container futtatása

lehúzás helyi tárolóba innen: https://hub.docker.com/_/mariadb

`docker pull mariadb`

jelszó generálás

`makepasswd --chars 12`

saját volume létrehozása mysql adatok tárolására (/var/libdocker/volumes)

`docker volume ls`

`docker volume create mariadb-server-volume`

MARIADB Docker konténer létrehozás futtatás háttérben automatikus elinduláskor rebootnál is

`docker run -p 127.0.0.1:3306:3306 -v mariadb-server-volume:/var/lib/mysql --restart always --detach --name mariadb-server1 --env MARIADB_USER=udemx --env MARIADB_PASSWORD=FWLtLnbPIDUr --env MARIADB_DATABASE=udemx-db --env MARIADB_ROOT_PASSWORD=vvzPjX4Sh9QQ  mariadb:latest`


Ellenőrzés:

`docker top mariadb-server1`

Mariadb kliens (csak!) telepítése a fő hosztre

`sudo apt -y install mariadb-client`

`mysql -h 127.0.0.1 -p -u udemx udemx-db`

`show databases;`

`mysql -h 127.0.0.1 -p -u root udemx-db`

`show databases;`

### NGINX container futtatása

NGINX konténer lehúzása innen: https://hub.docker.com/_/nginx

`docker pull nginx`

Volumeok létrehozása

`docker volume create nginx-server-http`

`docker volume create nginx-server-https`

NGINX konténerek létrehozása, futtatása háttérben automatikus elinduláskor rebootnál is

`docker run --restart always --detach -p 8081:80 --name nginx-server-http -v nginx-server-http:/usr/share/nginx/html:ro -d nginx`

`docker run --restart always --detach -p 8082:80 --name nginx-server-https -v nginx-server-https:/usr/share/nginx/html:ro -d nginx`

Önaláírt ssl generálása, beállítása:

`sudo mkdir /etc/nginx/ssl`

`sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-testsec.key -out /etc/nginx/ssl/nginx-testsec.crt`

`sudo openssl dhparam -out /etc/nginx/dhparam.pem 4096`

Az /etc/nginx/snippets/ssl-params.conf felvétele a mellékelt fájl alapján

Felvesszük a teszt domaineket a hosts fájlba a hoszton

`echo '127.0.0.1 testbase.home' | sudo tee -a /etc/hosts`

`echo '127.0.0.1 testsec.home' | sudo tee -a /etc/hosts`

Felvesszük az /etc/nginx/sites-available mappába a mellékelt fájlokat (testbase, testsec) vagyis a virtual hostokat. Majd symlinkeljük a /etc/nginx/sites-enabled alá.

Volumeokban módosítani a index.html-t a mellékelt fájlokkal (https/index.html, http/index.html):

/var/lib/docker/volumes/nginx-server-http/_data

/var/lib/docker/volumes/nginx-server-https/_data


Újraindítjuk az NGINX-et:

`sudo nginx -t && sudo service nginx restart`

Ellenőrzés a számunkra szinpatikus böngészővel vagy WGET-tel:

https://testsec.home

http://testbase.home






## Git telepítése
















