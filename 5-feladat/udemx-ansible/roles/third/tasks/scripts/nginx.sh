#!/bin/sh
#Az NGINX default konfigurációs fájljában az alábbi sztringben <title>Welcome to nginx!</title> cseréljük le a<title>-t Title: -ra és a </title>-t ne bántsuk.

#fő parancs: értelmezés függvényében a megfelelő parancs használata
sed -i 's/<title>/<Title>/' /var/www/html/index.nginx-debian.html
#sed -i 's/<title>/Title:/' /var/www/html/index.html
