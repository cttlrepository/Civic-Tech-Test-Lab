# [Bokeh](https://bokeh.pydata.org)

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

> Bokeh es una librería de visualización interactiva de datos dirigida a 
navegadores modernos como presentación. Su meta es proveer una construcción concisa y 
elegante de gráficos versátiles, extendiendo estas capacidades junto a una 
interactividad de gran rendimiento sobre datasets muy grandes o que están
transmitiendo continuamente. Bokeh puede ayudar a cualquiera que desee crear
planos, dashboards y aplicaciones que muestren datos de manera rápida y sencilla


Bokeh es una plataforma de desarrollo en python (aunque tiene integraciones con otros idiomas como JS o R) para la creación rápida de servicios web
que muestran datos de forma interactiva, ie: gráficos. A pesar de que hace
la creación de estas aplicaciones algo simple, el alcance de la librería es muy vasto.

Por otro lado, en primera instancia bokeh permite crear gráficos de manera _estática_,
esto es, sin lo que el servicio denomina *servir* una aplicación web, simplemente
descargando una fichero HTML con el gráfica realizado. 

```python
from bokeh.plotting import figure, output_file, show
output_file("test.html")
p = figure()
p.line([1, 2, 3, 4], [10, 25, 2, 3], linw_width=2)
show(p)
``` 
La penúltima línea se ha encargado de definir las coordenadas de la línea a dibujar
en el fichero `test.html`, siendo la primera lista los valores del plano X
y la segunda las del plano Y.

Existe un estándar para servir aplicaciones más complejas con datos dinámicos. En
el modo más básico, una aplicación necesita una carpeta propia y un fichero
`main.py` dentro de esta, encargado de, utilizando la API de Bokeh, construir
un `Documento` que Bokeh pueda servir. Más información [aquí](#docs).


<a name="authorship"></a>
## Autoría

Bokeh ha sido desarrollado por su comunidad de [contribuidores](https://github.com/bokeh/bokeh/graphs/contributors) gracias a la financión
de Anaconda Inc mediante el programa [XDATA](https://www.darpa.mil/program/xdata).

<a name="license"></a>
## Licencia

Bokeh está licenciado bajo BSD-3-Clause

<a name="reqs"></a>
## Requerimientos hardware

Para instalar bokeh los requerimientos son nulos mientras se disponga de una máquina funcional.
A la hora de realizar la computación, es necesario realizar una estimación personalizada de
los requerimientos teniendo en cuenta el cálculo y el rendering de los gráficos,
así como los usuarios que podrán visualizar la eventual aplicación web.

<a name="install"></a>
## Instalación


<a name="env"></a>
### Entorno

Hemos instalado y testeado Bokeh bajo la imagen docker `cttl/py`, utilizando
`virtualenv` para trabajar con las dependencias de python3.

<a name="deps"></a>
### Dependencias

|Software|Versión mínima|Versión recomendada|Gestor de paquetes|
|-------|-----------|-------------------|---------------|
|python|3.5|3.7|virtualenv|
|git|Por defecto|Por defecto|Sistema|
|pip|Por defecto|Por defecto|virtualenv|
|jinja2|2.7|>2.7|pip|
|numpy|1.1.7|>1.7.1|pip|
|pillow|4.0|>4.0|pip|
|dateutil|2.1|>2.1|pip|
|pyyaml|3.10|>3.1|pip|
|six|1.5.2|>1.5.2|pip|
|tornado|4.3|>4.3|pip|
|pandas|Por defecto|Por defecto|pip|
|psutil|Por defecto|Por defecto|pip|
|selenium|Por defecto|Por defecto|pip|
|phantomjs|Por defecto|Por defecto|Sistema|
|nodejs|Por defecto|Por defecto|Sistema|



<a name="deploy"></a>
### Despliegue

`pip install bokeh`

<a name="docs"></a>
## Documentación oficial

- [Formato del sistema de ficheros de Bokeh](https://bokeh.pydata.org/en/latest/docs/user_guide/server.html#directory-format)
- [Documentación oficial sobre la instalación](https://bokeh.pydata.org/en/latest/docs/installation.html)
- [Documentación oficial para el usuario](https://bokeh.pydata.org/en/latest/docs/user_guide.html)
- [Documentación oficial para el desarrollador](https://bokeh.pydata.org/en/latest/docs/dev_guide/setup.html)


<a name="comms"></a>
## Comentarios adicionales

Proporcionamos una imagen docker `cttl/bokeh` con _Bokeh_ instalado
junto a los programas de ejemplo para testear rápidamente.
Para conseguir la imagen:
```bash
git pull cttl/bokeh
docker run --name bokeh -it cttl/bokeh bash --login
cd; source $HOME/env3/bin/activate
```

Los datos de ejemplo están en `$HOME/bokeh/app/`. Para probar cualquiera de los
ejemplos disponibles, en este caso _movies_:
```bash
# conseguimos la IP del contenedor, en este caso suponemos 172.17.0.2
cd $HOME/bokeh/app
bokeh serve --show movies --address 0.0.0.0 --port 3000 --allow-websocket-origin=172.17.0.2:3000
```

Y finalmente accedemos con el navegador a 172.17.0.2:3000, en caso de que esa sea
la IP del contenedor.
 
<a name="sec"></a>
## Seguridad

<a name="val"></a>
## Valoración
Bokeh resulta ser una herramienta perfecta a la hora de desplegar rápidamente aplicaciones web
que sirvan gráficos interactivos ya que combina una fácil instalación, falta de complejidad
a la hora de desarrollar pero gran alcance para realizar proyectos de envergadura. Además, cuenta con una
gran comunidad.