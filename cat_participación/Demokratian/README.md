# [Demokratian](http://demokratian.org/)

Esta aplicación fue instalada en una instancia t2.micro del servicio de Amazon de cloud computing (AWS) con Ubuntu 18.04.

## Tabla de contenidos

1. [Descripción](#Descripción)
2. [Autoría](#Autoría)
3. [Licencia](#Licencia)
4. [Requerimientos hardware](#Requerimientos-hardware)
5. [Instalación](#Instalación)  
  5.1. [Dependencias](#Dependencias)      
  5.3. [Instalar Demokratian](#Instalar-Demokratian)  
6. [Documentación oficial](#Documentación-oficial)
7. [Seguridad](#Seguridad)  
9. [Valoración](#Valoración)

## Descripción

Demokratian es una aplicación de código abierto de colaboración ciudadana que permite hacer distintos tipos de votaciones online y presenciales. En su página web encontrará una descripción más detallada de su funcionalidad.

## Autoría

Desarrollado por Carlos Salgado.

## Licencia
Está distribuido bajo la licencia GPL 3.0.

## Requerimientos hardware
Para una presentación o un testeo mínimo de la aplicación podrá utilizar un tipo de instancia t2.micro con un solo núcleo. Dependiendo del número de usuarios tendrá que aumentar bastante esta especificación.

## Instalación
###  Dependencias 
* Apache 
* php >= 7
* base de datos mysql

### Instalar Demokratian
Hay dos formas de instalar Demokratian, la "manual" y la automática. En este caso hemos instalado la automática.

Primero tendremos que subir todos los [archivos](https://bitbucket.org/csalgadow/demokratian_votaciones/src/master/) de la aplicación a nuestro servidor.

Tendremos que darle permisos de escritura al usuario con el que estemos utilizando Apache en las siguientes carpetas: config, upload_user, upload_pic, data_vut. Para ello podemos usar el comando chmod 700.

Lo siguiente que tendremos que hacer es ir a la carpeta install utilizando nuestro navegador web (midominio.org/install) y seguir los pasos de instalación que se mostrarán. Dado que tendrás que proporcionar datos de configuración de la base de datos y del servidor de correo recomendamos configurar ambos antes de este paso.

IMPORTANTE: si estamos instalando el servicio en una máquina EC2 de AWS probablemente no tengamos facilidades para ejecutar el script de instalación desde un navegador. Si se quiere acceder al script de instalación desplegado en la máquina EC2 desde local tenga en cuenta que deberá configurar la conexión remota con la base de datos (para el caso de Mysql habilitar en my.conf la ip de acceso, el puerto 3306 en el servidor, etc...).  

## Documentación oficial

[Demokratian](https://bitbucket.org/csalgadow/demokratian_votaciones/wiki/Instalaci%C3%B3n)

## Seguridad

Recomendamos configurar el servicio como https, cambiar la URL de acceso por defecto y controlar el acceso a la base de datos.

## Valoración

Demokratian es una aplicación fácil de instalar con un objetivo y funcionalidades claros. Muy recomendada para organizaciones de tamaño medio o grande.
