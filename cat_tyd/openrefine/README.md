# [OpenRefine](https://openrefine.org)

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

> OpenRefine es una herramienta para trabajar con datos _sucios_ para _limpiarlos_ transformándolos de un formato a otro y extendiéndolos a con servicios y datos externos.

OpenRefine abre un servicio web local para tratar grandes cantidades de datos. La base del tratamiento es la limpieza de datos erróneos anómalos. OpenRefine trabaja con formatos comunes de texto o binarios - csv, tsv, json, xls, xml entre otros.

Los tratamientos de datos se realizan mediante filtros. La sintaxis de los filtros se puede definir en [GREL](https://github.com/OpenRefine/OpenRefine/wiki/General-Refine-Expression-Language), [P](https://python.org)/[Jython](https://jython.org) o [Clojure](https://clojure.org).

Además de filtros, se pueden realizar transformaciones sobre filas, columnas o celdas en función de los filtros anteriores.

En pos de un ejemplo, si definimos el siguiente dataset,

|Nombre|Apellido 1|Apellido 2| Fecha de nacimiento| Género|
|------|----------|----------|-----|-------|
|Torcuato|Martínez|García|04/04/1995|H|
|Lucy|Ford| |05/06/1996|M|
|Benito|Martínez|Ocasio|10-03-1994|Hombre|
|Mister|Fantastic|Doom|09-01-1994|hh

... podemos observar que las últimas dos columnas de la última fila contiene datos con valores anómalos: la fecha y el género tienen un formato diferente a los de las columnas anteriores. Esto es apreciable a simple vista porque solo ejemplificamos tres entradas de valores, sin embargo, en un dataset de miles o millones de datos nos sería imposible, para ello, aplicando un filtro GREL con la siguiente sintaxis sobre el campo Género:
```grel
length(value) < 2 
```
... nos devolvería dos filas que cumplen los requisitos y dos que no las cumplen.

Existe una gran comunidad que comparte estos filtros bajo el nombre de recetas, para extraer información de [datasets comunes](https://github.com/OpenRefine/OpenRefine/wiki/Recipes).
<a name="authorship"></a>
## Autoría
Proyecto originalmente creado por Metaweb Technologies, en 2010 adquirido por Google para que posteriormente en 2012 fuera convertido en un proyecto comunitario liderado por [Qi Jacky Cui](https://github.com/jackyq2015). 
<a name="license"></a>
## Licencia
OpenRefine está licenciado bajo BSD-3

<a name="reqs"></a>
## Requerimientos hardware

<a name="install"></a>
## Instalación
<a name="env"></a>
### Entorno

Proyecto desplegado sobre una imagen docker `Ubuntu:18.04`.

<a name="deps"></a>
### Dependencias

|Servicio|Versión minima|Versión recomendada|Gestor de paquetes|
|--------|--------------|-------------------|------------------|
|Java|Por defecto|Por defecto|Sistema|
|wget/curl|Por defecto|Por defecto|Sistema|

<a name="deploy"></a>
### Despliegue

```bash
git clone https://github.com/openrefine/openrefine openrefine; cd openrefine
./refine
``` 
<a name="docs"></a>
## Documentación oficial
[Wiki oficial](https://github.com/openrefine/openrefine/wiki)
<a name="comms"></a>
## Comentarios adicionales
Proporcionamos una imagen docker con OpenRefine instalado y listo para correr con los datos de ejemplo utilizados en este documento.

```
docker pull cttl/cttl:openrefine
docker run --name openrefine -it cttl/cttl:openrefine bash
cd /root/openrefine; ./refine -i 0.0.0.0
```

<a name="sec"></a>
## Seguridad
    OpenRefine provee su interfaz mediante un servidor web básico sin ningún tipo de solución de seguridad, luego, en entornos donde varias máquinas trabajen sobre un solo servidor OpenRefine, será interesante aplicar las medidas de seguridad, por lo menos básicas, para este tipo de servicios - implementar un proxy inverso para encryptación HTTPS, entre otros.

<a name="val"></a>
## Valoración

Encontramos OpenRefine fácil de instalar y fácil de usar siempre y cuando el objeto de uso esté claro. 
