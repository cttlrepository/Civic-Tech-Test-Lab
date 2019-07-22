# [Citizen OS](https://citizenos.com)

Aquesta guia està disponible en valencià (aquest document), [espanyol](../README.md) i [anglès](en.md). Més traducciones son benvolgudes a través d'un PR.



### Tabla de continguts
1. [ Descripció ](#desc)
2. [ Autoria ](#authorship)
3. [ Llicència ](#license)
4. [ Requeriments hardware ](#reqs)
5. [ Instal·lació ](#install)

	5.1. [ Entorn ](#env) 
	
	5.2. [ Dependències ](#deps)
	
	5.3. [ Desplegament ](#deploy)

	
6. [ Documentació oficial ](#docs)
7. [ Comentaris adicionals ](#comms)
8. [ Seguretat ](#sec)
9. [ Valoració ](#val)


## Descripció

Citizen OS és una plataforma col·laborativa de codi lliure feta per a ajudar equips i organizacions a prendre decisions i totes les idiosincràsies que una peça de software pot resoldre per a ells. Permet la edició col·laborativa en temps real, votació, creació y gestió de projectes entre altes característiques.

A continuació deixem un llistat de totes les característiques d'aquest servici:

 * Autenticació social amb google/facebook, a més de la plataforma nativa.
 * Temes, proposicons per part dels usuarios on altres usuaris poden:
 
 	* Comentar.
 	* Agregar arguments a favor o en o contra. 
 	* Votar el tema.
 	* Editar en linea amb altres usuarios.
 	* Afegir empremta social amb l'ús de hashtags, posibilitant el tindre un log de mencions socials al hashtag.
 	* Categoritzar el tema.
 	
* Grups, agrupacions de temes i usuarios per a projectes subdividibles.

## Autoria
Citizen OS és fet i mantengut per l'empresa estoniana del mateix nom i la comunitat de desenvolupadors a [GitHub](https://github.com/citizenos).


## Llicències

Citizen OS está llicenciat sota Apache 2.0 i manté les llicencies dels diferents forks que utiliza amb submòduls. Més informació [aquí](https://www.apache.org/licenses/LICENSE-2.0).

## Requeriments hardware

Citizen OS està compost per tres servicis, on els seus requeriments es posaran a continuació. Com son tres servicis independents, recomanem tenir en compte que si es despleguen tots sobre la mateixa màquina, la suma de tots els requeriments serà necesaria.

| Servici    | [API](https://github.com/citizenos/citizenos-api)    | [FE](https://github.com/citizenos/citizenos-fe)     |  [Etherpad](https://github.com/ether/etherpad-lite/) |
| :---------- |:-----: | :----: | :-------: |
| **CPU**     | 1 core | 1 core | 1 core    |
| **Memoria** | 1GB    | 1GB    | 0.5 GB	   |

## Instal·lació

### Entorn
El desplegament dels servicis es fet via un contenidor docker amb image ubuntu:18.04.

```
# descarreguem la imatge official d'Ubuntu
docker pull ubuntu 
# construcció i arrencada interactiva del contenidor
docker run --name ubuntu  -it ubuntu:latest bash 
``` 
A causa de com *npm* funciona, es poden produir problemes en insta·lar aquest servei, motiu pel qual recomanem crear un usuario diferent, instalar **sudo** y afegir el nou usuari al grup **sudo**.

```
apt install sudo
useradd foo -G sudo -m
```

### Dependències

- [API](https://github.com/citizenos/citizenos-api)

| Software   | Versió mínima | Versió recomendada|
| :-----     | :------------: |:-----------------: |
| [postgresql](https://www.postgresql.org/) | 9.5            | > 9.5              | 
| [nodejs](https://nodejs.org/es/)     | 6.13.1         | >6.13.1            |

- [API](https://github.com/citizenos/citizenos-api)
	- nodejs
- [Etherpad](https://github.com/ether/etherpad-lite/)
	- nodejs v8.9	

### Desplegament
- Etherpad
Instal·lació d'Etherpad en un sol comandament, on el seu repositori es clonat i el seu seridor llançat

```
git clone --branch master https://github.com/ether/etherpad-lite.git && cd etherpad-lite && bin/run.sh
```

- API
L'instal·lació d'Etherpad va crear una carpeta anomenada etherpad-lite/. Dins d'aquesta carpeta existeix un fitxer anomenat APIKEY.txt el cual té el token API HTTP necesari per a enganxar servici API de Citizen OS amb Ethehrpad. Aques token i la direcció del servici - per defecte, http://localhost:9001 - son necesari a l'hora de configurar el servici.

```
git clone https://github.com/citizenos/citizenos-api.git 
cd citizenos-api/bin
bash install.sh 
```
A partir d'ara será necesari configurar el servici. Dins de la carpeta arrel d'aquest està una altra carpeta anomenada **config/** la qual guarda els fitxers de configuració de l'API. Modificarem el proper fitxer de configuració segons l'entorn de desplegament del serivici: default, development, production o test, cadascú amb un fitext .json associat. Independentment de l'entorn elegit, tots els fitxers hauran d'estar configurats amb l'API d'Etherpad. Per a fer això, serà necesari cercar el diccionari etherpad dins dels fitxers de configuració:

```
"etherpad": {
  "host": "localhost", 
  "port": "9001", 
  "ssl": true,
  "rejectUnauthorized": false,
  "apikey": "fb1f98df49f80182296ce2dbc72b3b848be2f1c7b2ede082eaff5261e1a408ab"
}
```
I finalment, per a inicialitzar el servici

```
cd config/
npm start
```
- FE

```
git clone https://github.com/citizenos/citizenos-fe.git 
cd citizenos-fe
npm run dev
```

## Documentació oficial

## Comentaris adicionals
- Bugs esperables

A l'hora d'instal·lar els servicis node (FE i API), poden sorgir problemes per questió de dependencies npm. Si al arrencar aquests, el proces retorna un error de dependència amb algun paquet npm, es recomanable isntal·lar-los de manera global amb usuari root:
```
npm install -g [paquet]
```


- Entorn docker

Es pot descarregar el entorn d'instalació realitzat per a crear aquest documenti [aquí](/container.tar-).
Per a importar el contenidor:
```
zcat container.tar.gz | docker - import citizenos
docker run --name citizenos -i -t /bin/bash
su - foo
```
The services folders are available at /home/foo


## Securetat

En entorns de producció recomanem bloquejar la eixida dels ports que els servicis exponen i enrutar les petici
ones externes desde un proxy invers - Apache o Nginx - amb tots els protocolos de seguretat que aquests servicis soporten, principalment SSL.

## Valoració
Realizarem la nostra valoració principalmment la instalació - en funció de si es tediosa, sobrependent d'altres tecnologies, etc - i en l'ús del servici.

La instalació pot arribar a ser tediosa si no es té experiència, d'una banda, treballant amb servicis node, per les idiosincrásies del seu gestor de paquets ```npm```, o amb ```postgresql``` servici que sol funcionar de manera diferent a altes exemples clàsics com ```mariadb``` o ```mysql```. Exceptuant aquests casos, existeixen molt poques dependencies i la instalació es ràpida i senzilla.

Quant l'ús, Citizen os proveeix una interfície d'usuari moderna i amigable, motiu pel qual considerem que es facil d'utilitzar per un usuari amb cualsevol nivell de coneixements.
