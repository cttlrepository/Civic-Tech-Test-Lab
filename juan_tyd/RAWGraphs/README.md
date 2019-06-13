# [RAWGraphs](https://github.com/densitydesign/raw)

Esta aplicación fue instalada en una instancia t2.micro del servicio de Amazon de cloud computing (AWS) con Ubuntu 18.04.

## Tabla de contenidos

1. [Descripción](#Descripción)
2. [Autoría](#Autoría)
3. [Licencia](#Licencia)
4. [Requerimientos hardware](#Requerimientos-hardware)
5. [Instalación](#Instalación)  
  5.1. [Dependencias](#Dependencias)  
  5.2. [Instalar RAWGraphs](#Instalar-RAWGraphs)  
6. [Documentación oficial](#Documentación-oficial)
7. [Seguridad](#Seguridad)  
9. [Valoración](#Valoración)

## Descripción

RAWGraphs es una herramienta web abierta que te permite visualizar mediante gráficos datos introducidos en forma de tabla o texto. La ejecución es mediante el navegador web por lo que no se ejecuta o se guarda ninguna información por parte del servidor.

## Autoría

Desarrollado por Giorgio Caviglia, Michele Mauri, Giorgio Uboldi y Matteo Azzi. Mantenido por DensityDesign Research Lab y Calibro.

## Licencia
Está distribuido bajo la licencia [Apache 2.0](https://github.com/densitydesign/raw/blob/master/LICENSE).

## Requerimientos hardware
Para una presentación o un testeo de la aplicación no necesitará mas de 1 núcleo virtual, 1 o 2 GB de RAM y menos de 1 GB de almacenamiento pero conforme aumenten el número de usuarios es recomendable aumentar la ram y prestaciones del procesador.

## Instalación
Para probar y mostrar su funcionamiento le recomendamos visitar la [aplicación ofical](http://app.rawgraphs.io/) propuesta en su cuenta.

###  Dependencias
* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [Bower](https://bower.io/#installing-bower)
* npm

### Instalar RAWGraphs

Clonamos RAWGraphs.

```
sudo git clone https://github.com/densitydesign/raw.git
```

Nos movemos al fichero raíz de RAWGraphs.

`cd raw`  

Instalamos npm y bower utilizando npm.
``` 
sudo apt install npm build-essential
npm install -g bower
```
Añadimos el script analitics.js.
```
cp js/analytics.sample.js js/analytics.js
```
Ahora podemos ejecutar RAWGraphs en este caso utilizaremos python 3+ y lo pondremos a escuchar en el puerto 4000.
```
python -m http.server 4000
```
Ahora podremos acceder a la aplicación en http://localhost:4000/.

## Documentación oficial

[RAWGraphs](https://github.com/densitydesign/raw/blob/master/README.md)

## Seguridad

Recomendamos configurar el servicio como https y cambiar la URL de acceso por defecto.

## Valoración

RAWGraphs es una aplicación que sirve como enlace entre plantillas y tablas de calculo y diferentes modelos gráficos. Admite diferentes tipos de formatos de entrada y tiene una gran variedad de tipos de visualizaciones. ES una aplicación útil para mostrar información y flexible para introducirse en una aplicación web más compleja.
