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




## Git telepítése
















