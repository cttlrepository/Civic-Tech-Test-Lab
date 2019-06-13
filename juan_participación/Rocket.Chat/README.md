# [RocketChat](https://rocket.chat/)

Esta aplicación fue instalada en una instancia t2.micro del servicio de Amazon de cloud computing (AWS) con Ubuntu 18.04.

## Tabla de contenidos

1. [Descripción](#Descripción)
2. [Autoría](#Autoría)
3. [Licencia](#Licencia)
4. [Requerimientos hardware](#Requerimientos-hardware)
5. [Instalación](#Instalación)  
  5.1. [Dependencias](#Dependencias)  
  5.2. [Instalar RocketChat](#Instalar-RocketChat)  
  5.3. [Configuración](#Configurar-RocketChat)  
6. [Documentación oficial](#Documentación-oficial)
7. [Seguridad](#Seguridad)  
9. [Valoración](#Valoración)

## Descripción

RocketChat es una aplicación de mensajería rápida e intuitiva que ayudará a cualquier equipo a mejorar sus canales de comunicación.Tiene herramientas para la creación de grupos privados y de canales. Cada usuario puede también comunicarse con otro por mensajes privados.
Cada usuario puede tener distintos roles para la gestión del contenido o de la configuración de la aplicación tales como "Admin" o "Propietario".

## Autoría

Desarrollado por el grupo RocketChat. 

## Licencia
Está distribuido bajo [licencia del MIT](https://opensource.org/licenses/MIT).

## Requerimientos hardware
### Mínimo (50 usuarios, 25 usuarios concurrentemente)
* Raspberry Pi 3 o Pi 2 
* 4 nucleos 1 GB de memoria
* 32 GB de almacenamiento

### VPS Mínimo (200 usuarios, 50 usuarios concurrentemente)
* 1 núcleo (2 GHz)
* 1 GB RAM
* 30 GB de SSD

### VPS Recomendado (500 usuarios, 100 usuarios concurrentemente)
* Dos núcleos (2 GHz) 
* 2 GB RAM
* 40 GB de SSD

## Instalación
Para probar y mostrar su funcionamiento básico recomendamos instalar la versión [docker](https://github.com/RocketChat/Rocket.Chat#docker) propuesta en su cuenta.

###  Dependencias
* Mongodb 4.0.9
* NodeJS 8.11.4

Actualizamos la lista de paquetes. 

`sudo apt-get -y update` 

Configuramos apt para instalar los paquetes oficiales de MongoDb con la llave proporcionada.

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4  
``` 

```
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
```

Configuramos Node.js para que sea instalado por el manejador de paquetes.

```
sudo apt-get -y update && sudo apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -`
``` 

Instalamos las herramientas de desarrollo, MongoDB, nodejs y graphicksmagick.

```
sudo apt-get install -y build-essential mongodb-org nodejs graphicsmagick
```

Instalamos npm si trabajamos en Ubuntu 19.04.

`sudo apt-get install -y npm`  

Instalamos inherits, n y la versión que requiera Rocket.Chat, en este caso 8.11.4.

```
sudo npm install -g inherits n && sudo n 8.11.4  
```

### Instalar RocketChat

Descargamos la última versión de RocketChat.

```
curl -L https://releases.rocket.chat/latest/download -o /tmp/rocket.chat.tgz
```

Extraemos los archivos comprimidos.

`tar -xzf /tmp/rocket.chat.tgz -C /tmp`  

Instalación (esta guía utiliza /opt pero puede elegir el directorio que prefiera).

``` 
cd /tmp/bundle/programs/server && npm install  
sudo mv /tmp/bundle /opt/Rocket.Chat
```

### Configurar RocketChat

Creamos el usuario rocketchat y le damos permisos sobre la carpeta Rocket.Chat.

```
sudo useradd -M rocketchat && sudo usermod -L rocketchat
sudo chown -R rocketchat:rocketchat /opt/Rocket.Chat
```

Creamos el archivo de servicio de RocketChat.

```
cat << EOF |sudo tee -a /lib/systemd/system/rocketchat.service
[Unit]
Description=The Rocket.Chat server
After=network.target remote-fs.target nss-lookup.target nginx.target mongod.target
[Service]
ExecStart=/usr/local/bin/node /opt/Rocket.Chat/main.js
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=rocketchat
User=rocketchat
Environment=MONGO_URL=mongodb://localhost:27017/rocketchat?replicaSet=rs01 MONGO_OPLOG_URL=mongodb://localhost:27017/local?replicaSet=rs01 ROOT_URL=http://localhost:3000/ PORT=3000
[Install]
WantedBy=multi-user.target
EOF
```
Abrimos el archivo de servicio Rocket.Chat que acabamos de crear en /usr/lib/systemd/system/rocketchat.service y lo editamos utilizando sudo para cambiar la variable ROOT_URL  por la URL que quieras usar para acceder al server (por defecto estará http://localhost:3000 como URL de acceso). Opcionalmente se puede cambiar también MONGO_URL, MONGO_OPLOG Y PORT.

```
MONGO_URL=mongodb://localhost:27017/rocketchat?replicaSet=rs01
MONGO_OPLOG_URL=mongodb://localhost:27017/local?replicaSet=rs01
ROOT_URL=http://your-host-name.com-as-accessed-from-internet:3000
PORT=3000
```
Configuraremos el almacenamiento de la base de datos (_storage engine_) y la replicación para MongoDB.

```
sudo sed -i "s/^#  engine:/  engine: mmapv1/"  /etc/mongod.conf
sudo sed -i "s/^#replication:/replication:\n  replSetName: rs01/" /etc/mongod.conf
```
Habilitamos MongoDB y ejecutamos RocketChat.

```
sudo systemctl enable mongod && sudo systemctl start mongod
mongo --eval "printjson(rs.initiate())"
sudo systemctl enable rocketchat && sudo systemctl start rocketchat
```

Finalmente tendremos nuestro servicio desplegado en http://el_nombre_de_tu_url_o_tu_ip.com:3000

## Documentación oficial

[RocketChat](https://rocket.chat/)  
[Guía de instalación oficial](https://rocket.chat/install)

## Seguridad

Recomendamos configurar el servicio como https, cambiar la URL de acceso por defecto y configurar el control de acceso a la base de datos.

## Valoración

RocketChat es una aplicación de mensajería con canales, grupos y roles, es perfecta para cualquier tamaño de organización. No es una aplicación de gestión de proyectos o cronogramas.

