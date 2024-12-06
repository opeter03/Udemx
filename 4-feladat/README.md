# CI-CD feladat 


## Jenkins telepítése dockerben és alap beállítások


Munka könyvtár létrehozása opeter03 userként (docker csoporttag)

`mkdir -p ~/jenkins && cd $_`

`mkdir -p ~/jenkins/jenkins_home`

Ssh jenkins agent végett kulcspár generálás

`ssh-keygen -t rsa -f jenkins_agent`

A mellékelt jenkins mappában lévő fájlok ide másolása és a docker-compose.yaml fájlban a JENKINS_AGENT_SSH_PUBKEY kulcsnak átadni értékként a generált puklibus kulcsot (jenkins_agent.pub).
A fájlokban láthatóan meg lett oldva, hogy a jenkins (dockerben futtatva) elérje a külső hoszt docker-jét (konténereit), így telepítve lett a docker.io és átadásra került a docker socket volume-ban. Ennek később lesz a jelentősége, amikor a jenkinsen keresztül pusholunk image-t pl.

Buildelés indítása

`docker compose up -d`

Logból kinézzük a jelszót

`docker logs jenkins | less`

Jenkins indítása kedvelt böngészőnkben:

http://localhost:8200

A fenti logból kinyert jelszó megadása, majd felhasználónév, jelszó megadása, belépés, stb.

Belépünk jenkinsbe: manage jenkins->credentials. A system usernél add credential. (mellékelt kép)
Kind: SSH Username with private key
Scope: System
ID:jenkins_agent
Username:jenkins
Private key megadása, amit ez alőbb generáltunk

Új node létrehozása: manage jenkins->Nodes->New node

Node name: jenkins_agent

Remote root directory: /home/jenkins/agent

Launch method: Launch agent via SSH

Host: agent

Credentials: jenkins

Host Key Ver. Strat.: Non ver...

Advanced gombra kattintva:

Java path: /opt/java/openjdk/bin/java

A Java path-ot ki lehet nézni az agent dockerbe belépve, mert nem mindig következetesen állítják be a Java egyes verziói.

`docker exec -it agent bash`

Többit értelemszerűen kitölteni

Ellenőrzés: Ha minden jól ment, akkor a baloldali sávban megjelenik az új node (pirox X nélkül), amit a jenkins így SSH kulcspárral ér el.


## Privát Docker registry telepítése dockerben


Létrehozunk egy mappát:

`mkdir -p ~/docker-registry && cd $_`

Létrehozzuk a yaml fájlt (mellékelve)

`touch docker-compose.yaml`

Létrehozzuk a volume mappát, ahol lesznek tárolva a privát imagek

`mkdir volume`

Beállítjuk, hogy autentikáció nélkül is lehessen konnektálni, ezt root-ként kell megcsinálni:

/etc/hosts fájbla betesszük a registry domainünket

127.0.0.1 docker-registry.local.com

Alábbi fájlt létrehozzuk, a mellékelt tartalommal (adott estben docker login kialakítása célszerűbb lenne)

touch /etc/docker/deamon.json

Újrarúgjuk a dockert

`systemctl restart docker`

Indtjuk most már a saját registry-nket, de már opeter03 felhasználóval

`docker compose up -d`

Ellenőrzés, fut-e

`docker ps`

http://localhost:8500

Tesztelés, vagyis egy kép beletolása:

`docker pull nginx`

`docker tag nginx:latest docker-registry.local.com:5000/docker-registry/nginx:v1`

`docker push docker-registry.local.com:5000/docker-registry/nginx:v1`


## Githubon egy privát repó és egy új projekt létrehozása

A mellékelt testrepo/Dockerfile-ban található a project.

A Github repo privat-tal lett tesztelve, de most átállításra került public státuszra:

https://github.com/opeter03/testrepo

## Jenkins job létrehozása

Létrehozzuk a jenkinsbe az új freestyle típusú jobot, adunk neki egy nevet, majd odagörgetünk a "Source Code Management" szekcióhoz és bepipáljuk a gitet.
Repository URL: https://github.com/opeter03/testrepo.git

A Credentials részben az Add gombra kattintunk. Hozzáadjuk a Jenkins-t. Ekkor felugrik egy ablak, amiben meg kell adni az azonosítás módját. Privát github repo esetében erre 2 módszer van: SSH keys, vagy access token-es. A mellékelt képen látható a kitöltés folyamata. Ha megfelelő a csatlakozás, akkor a Repository URL alatt eltűnik a piros hibaszöveg.

A "Branches to build" részben a master helyett lehet hogy main-t kell beírni, ezt nézzük meg a githubon hogy nevezi el nekünk.

A "Build Environment"-ben a "Delete workspace before build starts" kiválasztjuk igény szerint.


A "Build Steps" részben execute shell-t használunk, ahova beírjuk a shell parancsokat

`docker image build -t docker-registry.local.com:5000/docker-private-web:v$BUILD_NUMBER .`

`docker push docker-registry.local.com:5000/docker-private-web:v$BUILD_NUMBER`

Majd hozzáadunk még egy execute részt

`docker pull docker-registry.local.com:5000/docker-private-web:v$BUILD_NUMBER`

`docker run -p 81$BUILD_NUMBER:80 --name docker-private-server-v$BUILD_NUMBER -d docker-registry.local.com:5000/docker-private-web:v$BUILD_NUMBER`

Futtatjuk a buildet

Ellenőrzés (első build esetén, a port mindig a megfelelő build számmal növekszik):

http://localhost:811

