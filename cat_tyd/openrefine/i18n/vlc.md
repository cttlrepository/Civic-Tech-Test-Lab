# [OpenRefine](https://openrefine.org) 

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

<a name="desc"></a>
## Descripció


> OpenRefine es una ferramenta per a treballar amb dades _brutes_  per a _netejar-les_ transformant-les d'un format a un altre i estenent-les amb servicis i dades externes.




Els tractaments de dades es realitzen mitjançant filtres. La sintaxi dels filtres es pot definir amb [GREL](https://github.com/OpenRefine/OpenRefine/wiki/General-Refine-Expression-Language), [P](https://python.org)/[Jython](https://jython.org) o [Clojure](https://clojure.org).

A més de filtres, es poden realitzar transformacions sobre files, columnes o cel·les en funció dels filtres anteriors.


Definint el següent dataset com exemple:

|Nombre|Apellido 1|Apellido 2| Fecha de nacimiento| Género|
|------|----------|----------|-----|-------|
|Torcuato|Martínez|García|04/04/1995|H|
|Lucy|Ford| |05/06/1996|M|
|Benito|Martínez|Ocasio|10-03-1994|Hombre|
|Mister|Fantastic|Doom|09-01-1994|hh

... podem observar que les últimes dues columnes de la file la qual conté dades amb valors anònamls: `fecha` y `género` tenen un format diferent
del de les columnes anteriors. Això es apreciable a simple vista perquè solament exemplifiquem tres entrades de valors,
però en un dataset de milers o milions de dades ens seria imposible, per tant, aplicant un filtre
GREL amb la següent sintaxi sobre `género`:




```grel
length(value) < 2 
```
... ens tornaria  les dues files que compleixen els requereiments i les dues que no

Existeix una gran comunitat que comparteix aquests filtres anomenades receptes, per a
extraure informació de [datasets comuns](https://github.com/OpenRefine/OpenRefine/wiki/Recipes).

<a name="authorship"></a>
## Autoria

Projecte originalment create per Metaweb Tecnologies, adquirit en 2010 per Google per a ser convertit, en 2012, 
en un projecte comunitari liderat per [Qi Jacky Cui](https://github.com/jackyq2015). 
    
<a name="license"></a>
## Llicència

OpenRefine està llicenciat amb BSD-3.

<a name="reqs"></a>
## Requerimients hardware
<a name="install"></a>
## Instal·lació
<a name="env"></a>
### Entorn


Projecte desplegat sobre una imatge docker `Ubuntu:18.04`.
<a name="deps"></a>
### Dependències


|Servici|Versió minima|Versió recomendada|Gestor de paquets|
|--------|--------------|-------------------|------------------|
|Java|Per defecte|Per defecte|Sistema|
|wget/curl|Per defecte|Per defecte|Sistema|

<a name="deploy"></a>
### Desplegament



```bash
git clone https://github.com/openrefine/openrefine openrefine; cd openrefine
./refine
``` 

<a name="docs"></a>
## Documentació oficial
[Wiki oficial](https://github.com/openrefine/openrefine/wiki)

<a name="comms"></a>
## Comentaris adicionals
Proporcionem una imatge docker amb OpenRefine instal·lat i a punt per a testejar amb les dades d'example utilitzades en aquest document.


```
docker pull cttl/openrefine
docker run --name openrefine -it cttl/openrefine bash
cd /root/openrefine; ./refine -i 0.0.0.0
```

<a name="sec"></a>
## Seguretat
OpenRefine proveeix la seua interfície gràfica amb un servidor web sense cap tipus
de seguretat, per tant, en entorns on més d'una máquines treballen sobre un servidor OpenRefine,
serà interesant aplicar mesures de seguretat almenys bàsiques per a quest tipus de servicis -
proxy inverse per a encriptació HTTPS, entre altres.

<a name="val"></a>
## Valoració

Trobem OpenRefine fàcil d'instal·lar i fàcil d'utilitzar sempre que l'objectiu d'utilització estiga clar des d'un principi.
