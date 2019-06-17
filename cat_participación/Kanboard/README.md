# [Kanboard](https://kanboard.org/)

Esta aplicación fue instalada en una instancia t2.micro del servicio de Amazon de cloud computing (AWS) con Ubuntu 18.04.

## Tabla de contenidos

1. [Descripción](#Descripción)
2. [Autoría](#Autoría)
3. [Licencia](#Licencia)
4. [Requerimientos hardware](#Requerimientos-hardware)
5. [Instalación](#Instalación)  
  5.1. [Dependencias](#Dependencias)  
  5.2. [Instalar Kanboard](#Instalar-kanboard)  
6. [Documentación oficial](#Documentación-oficial)
7. [Comentarios adicionales](#comentarios-adicionales)
8. [Seguridad](#Seguridad)
9. [Valoración](#Valoración)

## Descripción

Kanboard es una aplicación para la gestión de tareas de un proyecto basado en el sistema de información kanban.

## Autoría

Principalmente desarrollado por Frédéric Guillot. 

## Licencia
Está distribuido bajo [licencia del MIT](https://opensource.org/licenses/MIT).

## Requerimientos hardware

Para una presentación o un testeo de la aplicación no necesitará mas de 1 o 2 GB de RAM y 1 GB de almacenamiento pero conforme aumenten el número de usuarios y accesos está configuración será insuficiente.

## Instalación
Para probar y mostrar su funcionamiento básico recomendamos instalar la versión [docker](https://docs.kanboard.org/en/latest/admin_guide/docker.html) propuesta en su cuenta.

###  Dependencias
* Apache2
* PHP

Actualizamos la lista de paquetes. 

`sudo apt-get -y update` 

Añadimos el repositorio siguiente

```
sudo add-apt-repository ppa:ondrej/php  
``` 
Instalamos apache2 y las versiones que necesitemos para trabajar con PHP y nuestra base de datos. Descargamos las versiones 7.1 ya que la 7.0 ya no está disponible.
```
sudo add-apt-repository ppa:ondrej/php  
sudo apt-get install -y apache2 libapache2-mod-php7.1 php7.1-cli php7.1-mbstring php7.1-sqlite3 \
    php7.1-opcache php7.1-json php7.1-mysql php7.1-pgsql php7.1-ldap php7.1-gd php7.1-xml
```

### Instalar kanboard

Descargamos la última versión de Kanboard desde su repositorio oficial. Comprobamos cual es su [última versión](https://github.com/kanboard/kanboard/releases). En nuestro caso es la 1.2.9.

```
cd /var/www/html  
wget https://github.com/kanboard/kanboard/archive/v1.2.9.zip
``` 

Descomprimimos el fichero que hemos descargado (añadimos el comando para instalar unzip en el caso de no tenerlo instalado).

```
sudo apt-get install unzip  
unzip v1.2.9.zip

```

Le damos permisos sobre la carpeta que acabamos de descomprimir y eliminamos el archivo comprimido.

```
chown -R www-data:www-data kanboard-<version>/data
rm v1.2.9.zip
```

La aplicación estará escuchando en el puerto 80 y podremos acceder a ella desde la URL http://localhost/kanboard-1.2.9/.


## Documentación oficial

[Kanboard](https://kanboard.org/)  
[Guía de instalación oficial](https://docs.kanboard.org/en/latest/admin_guide/installation.html)

## Comentarios adicionales

Recomendamos utilizar esta guía para la instalación en Ubuntu puesto que la oficial utiliza una versión de Ubuntu y PHP más antigua.

## Seguridad

Recomendamos configurar el servicio como https, cambiar el usuario y contraseña por defecto y controlar el acceso al directorio data y a otros ficheros de configuración del servidor y la base de datos de vuestra elección.

## Valoración

Kanboard es una aplicación intuitiva y sencilla, es útil para trabajos que utilicen el método Kanban. 
