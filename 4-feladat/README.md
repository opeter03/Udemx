# CI-CD feladat 


## Jenkins telepítése dockerben és alap beállítások


Munka könyvtár létrehozása opeter03 userként (docker csoporttag)

`mkdir -p ~/jenkins && cd $_`

`mkdir -p ~/jenkins/jenkins_home`

Ssh jenkins agent végett kulcspár generálás

`ssh-keygen -t rsa -f jenkins_agent`

A mellékelt jenkins mappában lévő fájlok id másolása és a docker-compose.yaml fájlban a JENKINS_AGENT_SSH_PUBKEY kulcsnak átadni értékként a generált puklibus kulcsot (jenkins_agent.pub).
A fájlokban láthatóan meg lett oldva, hogy a jenkins (dockerben futtatva) elérje a külcső hoszt docker-jét (konténereit), így telepítve lett a docker.io és átadásra került a docker socket volume-ban. Ennek később lesz a jelentősége, amikor a jenkinsen kersztük pusholunk image-t pl.

Buildelést indítása

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

Új node léterhozása: manage jenkins->Nodes->New node

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

Ha minden jól ment, akkor a baloldali sávban megjelenik az új node, amit a jenkins így SSH kulcspárral ér el.





## Privát Docker registry telepítése dockerben


## Githubon egy privát repó és egy új projekt létrehozása


## Jenkins job létrehozása

