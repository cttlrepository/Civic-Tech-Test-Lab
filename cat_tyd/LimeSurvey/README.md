# [LimeSurvey](https://github.com/LimeSurvey/LimeSurvey)

Esta aplicación fue instalada en una instancia t2.micro del servicio de Amazon de cloud computing (AWS) con Ubuntu 18.04.

## Tabla de contenidos

1. [Descripción](#Descripción)
2. [Autoría](#Autoría)
3. [Licencia](#Licencia)
4. [Requerimientos hardware](#Requerimientos-hardware)
5. [Instalación](#Instalación)  
  5.1. [Dependencias mínimas](#Dependencias-mínimas)    
  5.2. [Recomendaciones](#Recomendaciones)   
  5.3. [Instalar LimeSurvey](#Instalar-LimeSurvey)  
6. [Documentación oficial](#Documentación-oficial)
7. [Seguridad](#Seguridad)  
9. [Valoración](#Valoración)

## Descripción

LimeSurvey es una herramienta de código abierto que permite hacer y gestionar encuestas online.

## Autoría

Desarrollado por el equipo de LimeSurvey.

## Licencia
Está distribuido bajo la licencia [GPL 2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html).

## Requerimientos hardware
Para una presentación o un testeo mínimo de la aplicación no necesitará mas de 1 núcleo virtual, 1 o 2 GB de RAM y 250 MB de almacenamiento pero conforme aumenten el número de usuarios será necesario aumentar la ram y la capacidad de almacenamiento.

## Instalación
Para probar y mostrar su funcionamiento le recomendamos visitar la [demo ofical como administrador](https://demo.limesurvey.org/index.php?r=admin) para crear y gestionar encuestas o pruebe a rellenar una en la [encuesta de prueba](https://survey.limesurvey.org/78184?lang=en) propuesta en su cuenta.

###  Dependencias mínimas
* Apache >= 2.4 | nginx >= 1.1 | otra versión de servidor web con PHP
* php >= 5.4 con mbstring y los drivers pdo-database
* mysql >= 5.5.3 | pgsql >= 9 | mariadb >= 5.5 | mssql >= 2005
* Tener habilitadas las librerías por defecto de PHP.

### Recomendaciones
* nginx 1.4.6
* php 5.6.x with php-fpm, mbstring, gd2 with freetype, imap, ldap, zip, zlib and databse drivers (muy recomendado)
* mysql 5.5.50

### Instalar LimeSurvey
En este caso vamos a instalar la versión de servidor. 

Descargamos la [última versión](https://www.limesurvey.org/downloads/category/25-latest-stable-release) de LimeSurvey y la descomprimimos en el directorio de nuestro servidor web.
```
unzip limesurvey3.17.5+190604.zip
```
Ahora tendremos que permitir la lectura y escritura de algunos directorios por nuestro servidor web. Los directorios son:
* "/limesurvey/tmp"
* "/limesurvey/upload/"
* "/limesurvey/application/config/"
Si utiliza Apache puede hacer uso de los siguientes comandos para permitir la lectura por todos pero la escritura solo por el servidor web.
``` 
chmod -R 755 <directory>  
chown -R apache <directory>
```
Lo siguiente que tendremos que hacer es crear un usuario de la base de datos que estemos utilizando y opcionalmente una base de datos para la aplicación (en caso de no crearla ahora se creara automáticamente durante el proceso de instalación). Se recomienda que el usuario tenga los siguientes permisos o equivalentes (ejemplo de Mysql): SELECT, CREATE, INSERT, UPDATE, DELETE, ALTER, DROP, INDEX.  

Si utiliza Mysql puede crear un usuario de la siguiente forma
```
mysql -u root -p
CREATE USER 'nombre_usuario'@'localhost' IDENTIFIED BY 'tu_contrasena';
GRANT [permiso] ON [nombre de bases de datos].[nombre de tabla] TO ‘[nombre de usuario]’@'localhost’;
```
Iremos ahora a "localhost/limesurvey/admin" para acceder al script de instalación. Aquí se nos preguntará por el usuario que acabamos de crear y si queremos crear una nueva base de datos.   

IMPORTANTE: si estamos instalando el servicio en una máquina EC2 de AWS probablemente no tengamos facilidades para ejecutar el script de instalación desde un navegador. Si se quiere acceder al script de instalación desplegado en la máquina EC2 desde local tenga en cuenta que deberá configurar la conexión remota con la base de datos (para el caso de Mysql: habilitar en my.conf la ip de acceso, el puerto 3306 en el servidor, etc...).  

Una vez terminado el proceso de instalación podrá ir a "http://www.example.com/limesurvey/admin". Si no hemos cambiado las credenciales durante la instalación podremos acceder mediante las credenciales por defecto.
```
User: admin
Password: password
```

## Documentación oficial

[LimeSurvey](https://github.com/LimeSurvey/LimeSurvey)

## Seguridad

Recomendamos configurar el servicio como https, cambiar la URL de acceso por defecto y controlar el acceso a la base de datos.

## Valoración

LimeSurvey es una aplicación muy extendida y fácil de usar tanto por parte del administrador como por parte del cliente al que se encueste. Es bastante intuitiva y permite mostrar los datos obtenidos de forma gráfica. Dada su licencia se permite su uso y distribución pero no cambios. 
