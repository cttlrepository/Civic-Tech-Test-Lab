# [FixMyStreet](https://fixmystreet.org)

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
> Informa, mira o discute problemas locales

[FixMyStreet](https://fixmystreet.org) es una herramienta de recolección e informe de problemas que pueden surgir en una calle - una farola estropeada, un semáforo que no funciona, etc. _FMS_ define `órganos` - ayuntamientos, concejalías, etc - a los que se pasarán los reportes creados a partir de los problemas de los que los usuarios han ido informando utilizando el servicio _FMS_. Los usuarios pueden informar de un problema creándose una cuenta de usuario para configurar sus propios informes en cualquier otro momento, o hacerlo de manera anónima. Asimismo, cada informe permite recoger un título, una descripción del problema y varias fotos.

En cuanto a la comunicación con los órganos oficiales, esta es transparente al usuario, sin embargo, a la hora de configurar un órgano, se tiene que establecer qué tipo de envío se realizará, teniendo _Open311_ o _email_.

A la hora de administrar el servicio, la interfaz `/admin` ofrece una gran variedad de ajustes. En primer lugar y como se ha explicado anteriormente, la configuración de órganos oficiales a los que mandar los informes de los usuarios. Dado un órgano, se pueden establecer sobre el mismo `Plantillas`, `Prioridades` y `Estados`, así como administrar usuarios - creacion y eliminación - 

<a name="authorship"></a>
## Autoría
Servicio desarrollado y mantenido por [MySociety](https://www.mysociety.org/about/).
<a name="license"></a>
## Licencia
Servicio licenciado bajo GNU AGPLv3.
<a name="reqs"></a>
## Requerimientos hardware
Una instalación en un entorno de test o desarrollo no necesitará gran capacidad para correr el servicio.
Desglosando los requerimientos según estándares _cloud_/VPS, los servidores con
características mínimas de los principales proveedores son suficientes. Sin embargo,
en entornos de producción la medida aumenta en función del alacance de los usuarios así
de qué otras herramientas se empotran dentro del servicio.
<a name="install"></a>
## Instalación
<a name="env"></a>
### Entorno
Hemos desplegado el servicio con el que se ha realizado este documento en un entorno docker basado en la imagen `Ubuntu:18.04`.

<a name="deps"></a>
### Dependencias
|Software|Versión mínima| Versión recomendada|Gestor de paquetes|
|-----|----|------|------|
|postgresql|10|10|Sistema|
|wget|Sistema|Sistema|Sistema|

<a name="deploy"></a>
### Despliegue
```bash

wget https://raw.githubusercontent.com/mysociety/commonlib/master/bin/install-site.sh
# suponemos que el servicio postgres está iniciado y configurado 
vim conf/general.yml
# instalamos el servicio
# esto creará la carpeta fixmystreet dentro del $HOME del nuevo usuario fms
#  asignado al dominio fixmystreet.local
sh install-site.sh fixmystreet fms fixmystreet.local
su - fms
cd fixmsytreet
script/server
```
Llegados a este punto, el servicio debe estar disponible en el puerto 3000 de la máquina donde se instaló.

<a name="docs"></a>
## Documentación oficial
[Manual de instalación oficial](https://fixmystreet.org/install/)
<a name="comms"></a>
## Comentarios adicionales
- Si a la hora de instalar o iniciar el servicio observamos problemas con postgres por la salida de la terminal, será necesario configurar el acceso a la base de datos.

    Editamos el fichero de configuración general ajustando dichos datos:
    ```vim
    {
        # PostgreSQL database details for FixMyStreet
        FMS_DB_HOST: ''
        FMS_DB_PORT: '5432'
        FMS_DB_NAME: 'fixmystreet'
        FMS_DB_USER: 'postgres'
        FMS_DB_PASS: 'postgres'
    }
    ```

    Reconstruimos el esquema en la base de datos e instalamos
    ```bash
    # nos movemos a la carpeta raíz del proyecto, según nuestro ejemplo:
    cd /home/fms/fixmystreet
    ./script/setup
    ```

- Proveemos una imagen docker basada en `Ubuntu:18.04` con una instalación básica de
_FixMyStreet_ con los siguientes credenciales de administración:
    - Usuario: `admin@cttl.local`
    - Contraseña: `cttl`
    
    Para descargar la imagen solo hace falta realizar un pull:
    ```bash
    docker pull cttl/fms
    docker run --name fms -it cttl/fms bash --login
    su - fms
    cd fixmystreet; script/server
    ```
<a name="sec"></a>
## Seguridad
El script de instalación configura automáticamente un proxy inverso con Nginx para manejar el servicio _FMS_ por el puerto `80`, sin encriptación, en un fichero de configuración con el nombre del dominio dado en la instalación - `/etc/nginx/sites-available/fixmystreet.local`. Recomendamos, como medida de seguridad fundamental, crear un certificado gratuito de [Let's Encrypt](https://letsencrypt.org), realizar una configuración de Nginx parecida a la de por defecto pero utilizando el puerto `443` y redireccionar todas las peticiones del puerto `80` al anterior.
<a name="val"></a>
## Valoración
La instalación de `fixmystreet` puede ser más o menos tediosa en función de lo que se necesite, esto es, el tiempo necesario para una instalación rápida en entornos de test se puede medir en minutos, quizás segundos si no contamos la instalación de las dependencias, sin embargo, una instalación en un entorno de producción y customizada a una organización concreta puede ser tediosa por la cantidad de servicios a los que se puede unir este proyecto, destacando el motor geográfico `mapit`.
Por otro lado, mencionando lo obvio gracias a la fama y la gran cantidad de implementaciones en grandes entornos, se trata de uns servicio muy robusto.
