# Título del proyecto

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
Portal que muestra mediciones del cumplimiento de programas electorales. Alimentando la aplicación con un fichero de datos csv, esta construye sobre los datos del fichero una aplicación web que muestra a los usuarios estadísticas de rendición de cuentas de campañas presidenciales concretas.

<a name="authorship"></a>
## Autoría
Desarrollado por el la [Fundación Ciudadano Inteligente](https://ciudadaniai.org/) junto a sus constribuidores en [Github](https://github.com/ciudadanointeligente/del-dicho-al-hecho-ember)
<a name="license"></a>
## Licencia
Sin licencia.

<a name="reqs"></a>
## Requerimientos hardware
Suponiendo que la aplicación se ejecuta en un VPS, con la mayoría de planes básicos (1 core/1GB de memoria) sería suficiente para implementarlo en entorno de test.
<a name="install"></a>
## Instalación
<a name="env"></a>
### Entorno
Proyecto desplegado sobre nuestra imagen docker `cttl/cttl:rails`. Más información [aquí]()
<a name="deps"></a>
### Dependencias

|Servicio|Versión mínima|Versión recomendada|Gestor de paquetes|
|--------|--------------|-------------------|------------------|
|git|Por defecto|Por defecto|Sistema|
|node|Por defecto|Por defecto|Sistema|
|fontconfig|Por defecto|Por defeccto|Sistema|
|phantomjs|Por defecto|Por defecto|sistema
|bower|Por defecto|Por defecto|npm|
|ember-cli|Por defecto|Por defecto|npm

<a name="deploy"></a>
### Despliegue
```bash
apt install git node npm fontconfig phantomjs
npm install bower ember-cli
git clone https://github.com/ciudadanointeligente/del-dicho-al-hecho-ember ddh
cd ddh; ember serve
```
<a name="docs"></a>
## [Documentación oficial](https://github.com/ciudadanointeligente/del-dicho-al-hecho-ember)

<a name="comms"></a>
## Comentarios adicionales
Ponemos a disposición una imagen docker con el servicio instalado.
```bash
docker pull cttl/cttl:ddh
docker run --name ddh -it cttl/cttl:ddh bash
cd /root/ddh; ember serve
```

Los estudios se guardan en `ddh/public/studies`, siendo estos ficheros .csv.
Para añadir un nuevo gobierno/presidente, será necesario editar la variable `governments` del fichero `config/environment.js` añadiendo un diccionario JSON con metadatos sobre el gobierno y sus estudios.

```json
  "name": "Sebastián Piñera II",
        "years": {"start": 2018, "end": 2022},
        "color1": "#12D0D8",
        "color2": "#66DEE3",
        "color3": "#9AFAFF",
        "color4": "#DBF4FF",
        "studies": [{
    "type": "Programa",
    "color": "#12D0D8",
    "year": 2018,
    "version": "Programa de Gobierno",
                "in_landing": true,
    "name": "Sebastián Piñera: Programa de Gobierno 2018",
    "filename": "Piñera-2018-2022_Programa-2018.csv",
    "description": ".",
    "fixed_result": 23,
    "visible": true,
  }]},

```
<a name="sec"></a>
## Seguridad
Recomendamos seguir las recomendaciones de seguridad, por lo menos, típicas, para la securización de servidores HTTP mediante proxies inversos, certificados SSL, etcétera.
<a name="val"></a>
## Valoración