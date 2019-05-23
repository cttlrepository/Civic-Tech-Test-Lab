# [Votainteligente Portal Electoral](https://github.com/ciudadanointeligente/votainteligente-portal-electoral)

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
> Votainteligente, la plataforma electoral de la Fundación Ciudadano Inteligente, se utiliza para transparentar las posiciones electorales de los diferentes candidatos a una elección.

Votainteligente es un portal tanto para usuarios como para organizaciones, donde, para los primeros, permite:
- Crear propuestas para resolver problemas en función de una categoría.
- Apoyar propuestas existentes para darles visibilidad.
- Revisar los compromisos de un candidato

En cuanto a las organizaciones:
- Crear propuestas
- Crear eventos
- Visualizar estadísticas respecto a las propuestas

<a name="authorship"></a>
## Autoría
Desarrollado por el la [Fundación Ciudadano Inteligente](https://ciudadanointeligente.org) junto a sus constribuidores en [Github](https://github.com/cttlrepository/cttl/tree/dev/cat_rdc/ddh)
<a name="license"></a>
## Licencia
Licenciado bajo GPLv3
<a name="reqs"></a>
## Requerimientos hardware
<a name="install"></a>
## Instalación
<a name="env"></a>
### Entorno
<a name="deps"></a>
Proyecto desplegado en nuestra imagen docker `cttl/cttl:py` con algunas dependencias ya resueltas. Por defecto existen dos directorios `env2` y `env3` que sirven como entorno de desarrollo python realizados gracias a `virtualenv`. A continuación se verán comandos que impliquen el directorio `env2` para activar dicho entorno.
### Dependencias
<a name="deploy"></a>

|Software|Versión mínima|Versión recomendada|Gestor de paquetes|
|--|--|--|--|--|
|virtualenv|Por defecto|Por defecto|Sistema|
|git|Por defecto|Por defecto|Sistema|
|elasticsearch|2.4.2|2.4.2|Manual|
|java|8|8|Sistema|
|pgmagick|Por defecto|Por defecto|Sistema|
|zlib|Por defecto|Por defecto|Sistema|
|zlib-dev|Por defecto|Por defecto|Sistema|
|libjpeg|Por defecto|Por defecto|Sistema|
|libjpeg-dev|Por defecto|Por defecto|Sistema|
|redis|Por defecto|Por defecto|Sistema|

### Despliegue
Para instalar `elasticsearch`
```bash
useradd elastic
mkhomedir_helper elastic
apt install openjdk-8-jre
wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.4.2/elasticsearch-2.4.2.tar.gz; tar xvf elasticsearch-2.4.2.tar.gz
cd elasticsearch-2.4.2/
bin/elasticsearch
```
Con elasticsearch corriendo:

```bash
git clone https://github.com/ciudadanointeligente/votainteligente-portal-electo
ral.gi portal; cd portal
source $HOME/env2/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver 0.0.0.0:3000
```


<a name="docs"></a>
## [Documentación oficial](https://github.com/ciudadanointeligente/votainteligente-portal-electoral)
<a name="comms"></a>
## Comentarios adicionales
- Proveemos una imagen docker con todas las dependencias y el servicio instalados. Para tener acceso a la misma e iniciar el servicio:
```bash
docker pull cttl/cttl:portal
docker run --name portal -it cttl/cttl:portal bash
su - elastic
elasticsearch-2.4.2/bin/elasticsearch
# en otra terminal con el contenedor iniciado de forma interactiva
cd $HOME/votainteligente-portal-electoral
source env/bin/activate
python manage.py runserver 0.0.0.0:3000
```
Existe un usuario de administración con credenciales disponibles en el fichero `TEST_AUTH` en la carpeta raíz.

- Este proyecto está basado en Django, luego por defecto existe un portal de administración accesible vía `/admin`. Para crear una cuenta de administracion será necesario lanzar el comando 
```
python manage.py createsuperuser
```

<a name="sec"></a>
## Seguridad
Recomendamos seguir las recomendaciones de seguridad, por lo menos, típicas, para la securización de servidores HTTP mediante proxies inversos, certificados SSL, etcétera.
<a name="val"></a>
## Valoración
