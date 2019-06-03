# Títol del projecte

Aquesta guia està disponible en valencià (aquest document), [espanyol](README.md) i [anglès](README_en.md). Més traducciones son benvolgudes a través d'un PR.


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

<a name="desc"></a>
## Descripció

> [Shareabouts](https://github.com/openplans/shareabouts) és un mapa online per
a recollir processos sociales de col·laboració oberta. En desplaçar un pin en el mapa
es poden proveïr idees, suggeriments i comentaris per a planejar o disenyar problemes
i millores. Ademés, com a aplicacio mobile-friendly, resulta fàcil afegir entrades ràpidament.


[Shareabouts](https://github.com/openplans/shareabouts), tenint com a base un
lloc específic del mapa, permet als usuarios - sense la necessitat de registrar-se - registrar una
millora o un problema en un punt del mapa.


<a name="authorship"></a>
## Autoria

Desenvolupat pel group [OpenPlans](https://openplans.org).

<a name="license"></a>
## Llicència

Desenvolupat sota la llicència [GPLv3](https://github.com/openplans/shareabouts/blob/master/LICENSE.txt). Així mateix, el serivii utilitza altres móduls i dependències amb llicencies lliures.

<a name="reqs"></a>
## Requerimients hardware

Una instal·lació bàsica pera testejar l'aplicació no necessitarà més de 0.5GB de RAM
i 1 core per a cada aplicació (frontend i backend) - tenint com a referència un entorn virtualitzat.
Un entorn de producció necessitarà al menys el doble d'aquestes mesures - en funció
de l'acoplament amb altres servicis (proxies inversos, backups, etc).

Una instalación básica para testear la aplicación no necesitará más de 0.5GB de RAM y 1 core para cada parte de la aplicación (frontend y backend) - suponiendo un entorno virtualizado. Un entorno de producción necesitará por lo menos el doble - en función del acoplamiento con otros servicios (proxies inversos, respaldos, bases de datos en otras máquinas). En cuanto al almacenamiento, dependerá del número de usuarios, por lo que recomendamos tener la base de datos en una máquina o entorno separado.


<a name="install"></a>
## Instalació


<a name="env"></a>
### Entorn

Hem desplegat el servici amb una imatge docker estàndard de `postgres:latest`.

<a name="deps"></a>
### Dependències
|Software|Versió mínima| Versió recomendada| Gestor de paquets|
|-----|-----|----|----|
|virtualenv|per defecte|per defecte| sistema|
|git | per defecte|per defecte| sistema|
|python2|2.6| 2.6+ | virtualenv|
|pip|per defecte| per defecte| virtualenv|
|postgresql| 9.1| 9.1+|sistema|
|postgis| 2.0| 2.0|sistema|
|geodjango| per defecte| per defecte| pip (env)|
|requirements.txt del proyecto| per defecte| per defecte | pip (env)|

<a name="deploy"></a>
### Desplegament
- [shareabouts-api](https://github.com/openplans/shareabouts-api/blob/master/doc/README.md)
    Gestionarem el versionatge de python i les seues dependències mitjançant 
    un entorn virtual `virtualenv`.
    
    ```bash
    git clone https://github.com/openplans/shareabouts-api
    cd shareabouts-api
    virtualenv env
    source env/bin/activate
    pip install -r requirements.txt
    ```
   Afegim el fitxer de configuració des d'una plantilla del projecte i la editem
   segons les característiques de la nostra base de dades.
    
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
            'HOST': '', # buit es per defecte 
            'PORT': '', # buit es per defecte 
        }
    }
    
    ```
    Creem un superusuari.
    ```bash
    src/manage.py createsuperuser
    ```
    Iniciem el servici segons l'interficie i el port desitjat.
    ```
    src/manage.py runserver 0.0.0.0:8001
    ```
    Accedim al panel d'administració del servici web mijançant `http://IP:8001/admin`, donde `IP`
    hae referencia a la dirección IP de la máquina que contiene el servidor. Entrem
    amb el superusuario creat i ja podem crear un dataset de parell de claus per a que
    el frontend puga accedir medjançant REST a l'API.
    

- [shareabouts](https://github.com/openplans/shareabouts/blob/master/doc/README.md)
    
    Seguim les mateixes indicacions de la instal·lació del backend fins la gestió
    del fitxer local de configuració, a on:
    
    ```bash
    cp src/project/local_settings.py.template src/project/local_settings.py
    vim src/project/local_settings.py
    ```
    Editem el fitxer de configuració per a unir aquest servici amb el backend.
    ```python
    SHAREABOUTS = {
        'FLAVOR': 'defaultflavor',
        'DATASET_ROOT': 'http://localhost:8001/api/v2/foo/datasets/aaa',
        'DATASET_KEY': 'MTUzNmQ0MmVmZDJhYzE0NjAyNDA1YTlm',
    }
    ```
    `DATASET_ROOT` y `DATASET_KEY` van ser creats amb anterioritat en l'instal·lació del backend. La URL es accessible
    quan creem un `dataset` - en aquest cas anomenant _aaa_. 
   
    Finalment iniciem el servici frontend. 
    ```bash
    src/manage.py runserver 0.0.0.0:8000
    ```

<a name="docs"></a>
## Documentació oficial

- [shareabouts]([https://github.com/openplans/shareabouts/blob/master/doc/README.m)
- [shareabouts-api](https://github.com/openplans/shareabouts-api/blob/master/doc/README.md)
- [geodjango](https://docs.djangoproject.com/en/dev/ref/contrib/gis/install/#django)

<a name="comms"></a>
## Comentaris adicionals

Proveïm una imatge docker amb els servicis ja instal·lats. Per a importar l'imatge
e iniciar un servidor.
```bash
docker pull cttl/shareabouts
docker run --name shareabouts -it shareabouts bash --login
```
Dins del contenidor
```bash
# iniciem el servici postgres
su - postgres
/usr/lib/postgresql/11/bin/pg_ctl -D /var/lib/postgresql/data -l logfile start
exit
# iniciem el backend 
cd shareabouts-api
source env/bin/activate
src/manage.py runserver 0.0.0.0:8001

# frontend
cd; cd shareabouts
source env/bin/activate
src/manage.py runserver 0.0.0.0:8000
```

<a name="sec"></a>
## Seguretat
Recomanem deixar l'access públic al servidor frontend darrere d'un proxy inverse com Nginx o Apache.
<a name="val"></a>
## Valoració

En cas de necessitar un servici bàsic d'imputació de problemes comunitars en 
un veïnat o carrer, Shareabouts es perfect ja que la seua instal·lació no es molt complexa.
Però no es un servici amb gran abast, motiu pel que si es necessiten característiques méx complexes,
recomanem [FixMyStreet](https://github.com/cttlrepository/cat_participación/fms).
