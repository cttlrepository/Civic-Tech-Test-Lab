# [Shareabouts](https://github.com/openplans/shareabouts)

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

> [Shareabouts](https://github.com/openplans/shareabouts#shareabouts-) es un mapa online para recoger procesos sociales de colaboración abierta. Al desplazar un pin en el mapa se pueden proveer ideas, sugerencia y comentarios para planear o diseñar mejoras y problemas. Además, al ser una aplicación mobile-friendly, resulta facil añadir entradas rápidamente.

[Shareabouts](https://github.com/openplans/shareabouts), teniendo como base el mapa de un lugar específico, permite a los usuarios - sin necesidad de registro ni tratamiento de datos - registrar una mejora o un problema en un punto del mismo.


<a name="authorship"></a>
## Autoría

Desarrollado por el grupo [OpenPlans](https://openplans.org).

<a name="license"></a>
## Licencia

Desarrollado bajo la licencia [GPLv3](https://github.com/openplans/shareabouts/blob/master/LICENSE.txt). Asimismo, usa otros módulos y dependencias con licencias diferentes, siempre en el marco del software libre.

<a name="reqs"></a>
## Requerimientos hardware
Una instalación básica para testear la aplicación no necesitará más de 0.5GB de RAM y 1 core para cada parte de la aplicación (frontend y backend) - suponiendo un entorno virtualizado. Un entorno de producción necesitará por lo menos el doble - en función del acoplamiento con otros servicios (proxies inversos, respaldos, bases de datos en otras máquinas). En cuanto al almacenamiento, dependerá del número de usuarios, por lo que recomendamos tener la base de datos en una máquina o entorno separado.

<a name="install"></a>
## Instalación
<a name="env"></a>
### Entorno
Hemos desplegado el servicio en la imagen docker estándar de `postgres:latest`, basada a su vez en Ubuntu 18.04.
<a name="deps"></a>
### Dependencias
|Software|Versión mínima| Versión recomendada| Gestor de paquetes|
|-----|-----|----|----|
|virtualenv|por defecto|por defecto| sistema|
|git | por defecto|por defecto| sistema|
|python2|2.6| 2.6+ | virtualenv|
|pip|por defecto| por defecto| virtualenv|
|postgresql| 9.1| 9.1+|sistema|
|postgis| 2.0| 2.0|sistema|
|geodjango| por defecto| por defecto| pip (env)|
|requirements.txt del proyecto| por defecto| por defecto | pip (env)|

<a name="deploy"></a>
### Despliegue
<a name="docs"></a>
- [shareabouts-api](https://github.com/openplans/shareabouts-api/blob/master/doc/README.md)
    
    Gestionaremos el versionado de python y sus dependencias mediante un entorno virtual `virtualenv`, luego, una vez instaladas las dependencias anteriores:
    ```bash
    git clone https://github.com/openplans/shareabouts-api
    cd shareabouts-api
    # creamos un nuevo entorno - en este caso llamado env
    virtualenv env
    # activamos el nuevo entorno 
    # el prompt tendrá el texto `(env)` delante, por ejemplo:
    # (env) root@a84602169892:~/shareabouts-api# 
    source env/bin/activate
    # instalamos las dependencias del fichero requierments.
    pip install -r requirements.txt
    ```
    Añadimos el fichero de configuración desde la plantilla del proyecto y la editamos según las características de la base de datos postgres.
    ```bash
    cp src/project/local_settings.py.template src/project/local_settings.py
    vim src/project/local_settings.py
    ```
    ```python
    DATABASES = {
        'default': {
            'ENGINE': 'django.contrib.gis.db.backends.postgis',
            'NAME': 'shareabouts',
            'USER': 'shareabouts',
            'PASSWORD': 'shareabouts',
            'HOST': '', # vacío significa por defecto
            'PORT': '', # vacío significa por defecto
        }
    }
    
    ```
    Creamos un usuario administrador.
    ```bash
    src/manage.py createsuperuser
    ```
    Iniciamos el servicio según la interfaz y puertos deseados.
    ```
    src/manage.py runserver 0.0.0.0:8001
    ```
    Accedemos al panel de administración del servicio web mediante http://IP:8001/admin, donde IP
    hace referencia a la dirección IP de la máquina que contiene el servidor, entramos con el usuario administrador anteriormente creado y creamos un dataset de claves para que el frontend acceda mediante REST al API.

- [shareabouts](https://github.com/openplans/shareabouts/blob/master/doc/README.md)

    Seguimos las mismas indicaciones de la instalación del backend hasta la gestión del fichero local de configuración, donde:
    ```bash
    cp src/project/local_settings.py.template src/project/local_settings.py
    vim src/project/local_settings.py
    ```
    Editamos el fichero de configuración para unir este servicio con su backend:
    ```python
    SHAREABOUTS = {
        'FLAVOR': 'defaultflavor',
        'DATASET_ROOT': 'http://localhost:8001/api/v2/foo/datasets/aaa',
        'DATASET_KEY': 'MTUzNmQ0MmVmZDJhYzE0NjAyNDA1YTlm',
    }
    ```
    `DATASET_ROOT` y `DATASET_KEY` fueron creados con anterioridad en el paso final de la instalación del backend. La url es accesible una vez creado el `dataset` _aaa_ - localhost:8001/api/v2/foo/datasets/__aaa__.

    Finalmente iniciamos el servicio frontend
    ```bash
    src/manage.py runserver 0.0.0.0:8000
    ```
## Documentación oficial
<a name="comms"></a>
- [shareabouts]([https://github.com/openplans/shareabouts/blob/master/doc/README.m)
- [shareabouts-api](https://github.com/openplans/shareabouts-api/blob/master/doc/README.md)
- [geodjango](https://docs.djangoproject.com/en/dev/ref/contrib/gis/install/#django)

## Comentarios adicionales
Proveemos una imagen docker con los servicios ya instalados. Para importar la imagen e iniciar un servidor.
```bash
docker pull cttl/shareabouts
docker run --name shareabouts -it shareabouts bash --login
```
Dentro del contenedor
```bash
# iniciamos el servidor postgres
su - postgres
/usr/lib/postgresql/11/bin/pg_ctl -D /var/lib/postgresql/data -l logfile start
exit
# iniciamos el backend
cd shareabouts-api
source env/bin/activate
src/manage.py runserver 0.0.0.0:8001

# frontend
cd; cd shareabouts
source env/bin/activate
src/manage.py runserver 0.0.0.0:8000
```
<a name="sec"></a>
## Seguridad
<a name="val"></a>
Recomendamos dejar acceso público al servidor frontend detrás de un proxy inverso como Nginx o Apache. 

## Valoración
Si se necesita un servicio básico de imputación de problemas comunitarios en un vecindario o calle,
Shareabouts es perfecto ya que la instalación no es muy compleja. Sin embargo, no es
un servicio con gran alcance, por lo que si se necesitan grandes o complejas características,
recomendamos un servicio como [FixMyStreet](https://github.com/cttlrepository/cat_participación/fms)
