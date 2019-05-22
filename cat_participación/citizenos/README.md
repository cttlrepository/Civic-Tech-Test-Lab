# [Citizen OS](https://citizenos.com)

Esta guia está disponible en castellano (este documento), [inglés](README_en.md) y [valenciano](README_cat.md). Más traducciones son bienvenidas mediante un PR.

### Tabla de contenidos
1. [ Descripción ](#desc)
2. [ Autoría ](#authorship)
3. [ Licencia ](#license)
4. [ Requerimientos hardware ](#reqs)
5. [ Instalación ](#install)

	5.1. [ Entorno ](#env) 
	
	5.2. [ Dependencias ](#deps)
	
	5.3. [ Despliegue ](#deploy)


	
6. [ Documentación oficial ](#docs)
7. [ Comentarios adicionales ](#comms)
8. [ Seguridad ](#sec)
9. [ Valoración ](#val)

<a name="desc"></a>
## Descripción

Citizen OS es una plataforma colaborativa y de código libre para la toma de decisiones y colaboración de equipos y organizaciones. Permite editar documentos colaborativos en tiempo real, votar, montar proyectos, entre otras características. 

A continuación dejamos un listado de todas las características de este servicio:
 * Autenticación social con google/facebook, además de la plataforma nativa
 * Temas, proposiciones por parte de los usuarios donde otros usuarios pueden:
 
 	* Comentar.
 	* Añadir argumentos a favor y en contra.
 	* Votar el tema.
 	* Editar en línea junto a otros usuarios.
 	* Añadir huella social mediante hashtags, lo que posibilita tener un log de menciones sociales a ese hashtag.
 	* Categorizar el tema.
 	
* Grupos, los cuales funcionan como agrupación de tema y usuarios para proyectos subdividibles.
	

<a name="authorship"></a>
## Autoría

Citizen OS fue desarrollado y es mantenido por la compañía estona con el mismo nombre y la comunidad de desarrolladores de GitHub en la siguiente [comunidad](https://github.com/citizenos).

<a name="license"></a>
## Licencia

Citizen OS está licenciado bajo Apache 2.0   y mantiene las licencias originales de los forks utilizados en el proyecto. Más información [aquí](https://www.apache.org/licenses/LICENSE-2.0).

<a name="reqs"></a>
## Requerimientos hardware

Citizen OS se compone de tres servicios separables. A continuación se listarán los requerimientos según cada componente. Si se van a servir todos en el mismo entorno, habrá que tener en cuenta su suma.

| Servicio    | [API](https://github.com/citizenos/citizenos-api)    | [FE](https://github.com/citizenos/citizenos-fe)     |  [Etherpad](https://github.com/ether/etherpad-lite/) |
| :---------- |:-----: | :----: | :-------: |
| **CPU**     | 1 core | 1 core | 1 core    |
| **Memoria** | 1GB    | 1GB    | 0.5 GB	   |

<a name="install"></a>
## Instalación

<a name="env"></a>
### Entorno
El despliegue de los servicios se han realizado en un contenedor docker con imagen ubuntu:18.04.

```
# bajamos la imagen desde el el repo oficial 
docker pull ubuntu 
# construimos e iniciamos de manera interactiva
#  un contendor que se llamará ubuntu
docker run --name ubuntu  -it ubuntu:latest bash 
``` 
Por como funciona *npm* pueden surgir problemas al intentar instalar este servicio con *root*, por lo que recomendamos trabajar con usuario diferente, instalar **sudo** y añadir dicho usuario al grupo **sudo**. 

```
apt install sudo
useradd foo -G sudo -m
```
<a name="deps"></a>
### Dependencias

- [API](https://github.com/citizenos/citizenos-api)

| Software   | Versión mínima | Versión recomendada|
| :-----     | :------------: |:-----------------: |
| [postgresql](https://www.postgresql.org/) | 9.5            | > 9.5              | 
| [nodejs](https://nodejs.org/es/)     | 6.13.1         | >6.13.1            |

- [API](https://github.com/citizenos/citizenos-api)
	- nodejs
- [Etherpad](https://github.com/ether/etherpad-lite/)
	- nodejs con versión mínima 8.9	

<a name="deploy"></a>
### Despliegue
- Etherpad

Instalación en un comando de Etherpad, donde se clona su repositorio y se lanza el servidor. 
```
git clone --branch master https://github.com/ether/etherpad-lite.git && cd etherpad-lite && bin/run.sh
```

- API

La instalación en un comando de Etherpad creó una carpeta llamada etherpad-lite. Dentro de la misma existe un fichero llamado APIKEY.txt el cual contiene el tóken para la API HTTP necesario para unir la API de Citzen OS con Etherpad. Ese tóken junto con la dirección y el puerto del servicio Etherpad - por defecto, http://127.0.0.1:9001 - serán necesarios a la hora de configurar este servicio.

```
git clone https://github.com/citizenos/citizenos-api.git 
cd citizenos-api/bin
bash install.sh 
```

A partir de este punto será necesario configurar dicho servicio. Dentro de la carpeta raíz del mismo se encuentra la carpeta de configuración llamada **config/**. Modificamos el fichero de configuración según el entorno para desplegar, teniendo cuatro ficheros json con nombres default, development, production o test. Según se quiera una configuración u otra, se modificará el fichero correspondiente. Independientemente del fichero, será necesario configurar la conexión con Etherpad. Buscamos el diccionario etherpad y modificamos consecuentemente la IP y el puerto. Un ejemplo:
```
"etherpad": {
  "host": "localhost", 
  "port": "9001", 
  "ssl": true,
  "rejectUnauthorized": false,
  "apikey": "fb1f98df49f80182296ce2dbc72b3b848be2f1c7b2ede082eaff5261e1a408ab"
}
```
Por último, para iniciar el servicio:
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
<a name="docs"></a>
## Documentación oficial
* [Citizen OS Web](https://github.com/citizenos/citizenos-web)
* [Citizen OS API](https://github.com/citizenos/citizenos-api)
* [Etherpad Lite](https://github.com/ether/etherpad-lite)

<a name="comms"></a>
## Comentarios adicionales

- Bugs esperables

A la hora de instalar los servicios node (FE y API), pueden surgir problemas por cuestión de dependencias npm. Si al arrancar los mismos, este proceso da un error por fallo de dependencia con algún paquete npm, es recomendable instalarlos de manera global con usuario root:
```
npm install -g [paquete]
```

- Entorno docker 

Se puede descargar el entorno con la instalación realizada para crear este documento [aquí](/container.tar-). 
Para importar el contenedor:
```
zcat container.gz | docker - import citizenos
docker run --name citizenos -i -t /bin/bash
su - foo
```
Las carpetas de los tres servicios se encuentran en /home/foo.

<a name="sec"></a>
## Seguridad
En entornos de producción recomendamos bloquear la salida de los puertos que los servicios exponen y redirigr las peticiones a los mismos desde un proxy inverso - Apache o Nginx - con todos los protocolos de seguridad que dichos servicios soportan, principalmente SSL.
<a name="val"></a>
## Valoración
Realizaremos nuestra valoración principalmente sobre la instalación - en función de si es tediosa, sobredependiente de diferentes tecnologías, etc - y el uso del servicio.

La instalación puede llegar a ser tediosa si no se tiene experiencia, per un por un lado, trabajando con servicios node por las idiosincrasias del gestor de paquetes ```npm```, o con ```postgresql```, servicio que suele funcionar de manera diferente a gestores de bases de datos clásicos como ```mariadb``` o ```mysql```. Exceptuando estos dos casos, existen muy pocas dependencias y la instalación es rápida y fácil.

En cuanto al uso, Citizen OS provee una interfaz de usuario moderna y amigable, por lo que consideramos que es fácil de usar por un usuario de cualquier nivel de conocimientos.
