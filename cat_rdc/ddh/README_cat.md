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


Portal que mostra medicions del compilment de programes elecotrals. Alimentant l'aplicació amb un fitxer
de dades _csv_, aquesta construeix sobre les dades una aplicació web la qual mostra
als usuaris estadístiques de rendicions de comptes de campanyes electoras concretes.

<a name="authorship"></a>
## Autoria

Desenvolupat per la [Fundación Ciudadano Inteligente](https://ciudadaniai.org/) junto a sus constribuidores en [Github](https://github.com/ciudadanointeligente/del-dicho-al-hecho-ember)

<a name="license"></a>
## Llicència

Sense llicència.

<a name="reqs"></a>
## Requerimients hardware

Suposant que l'aplicació s'executa en un VPS, amb la majoria de plans bàsics és suficient per entorns de test o desenvolupament.

<a name="install"></a>
## Instalació


<a name="env"></a>
### Entorn

Projecte desplegat sobre la nostra imatge docker `cttl/rails`. Més [informació](https://github.com/cttlrepository/cttl/meta).

<a name="deps"></a>
### Dependències
|Servici|Versió mínima|Versió recomendada|Gestor de paquets|
|--------|--------------|-------------------|------------------|
|git|Per defecte|Per defecte|Sistema|
|node|Per defecte|Per defecte|Sistema|
|fontconfig|Per defecte|Por defeccto|Sistema|
|phantomjs|Per defecte|Per defecte|sistema
|bower|Per defecte|Per defecte|npm|
|ember-cli|Per defecte|Per defecte|npm


<a name="deploy"></a>
### Desplegament

```bash
apt install git node npm fontconfig phantomjs
npm install bower ember-cli
git clone https://github.com/ciudadanointeligente/del-dicho-al-hecho-ember ddh
cd ddh; ember serve
```
<a name="docs"></a>
## [Documentació official](https://github.com/ciudadanointeligente/del-dicho-al-hecho-ember)

<a name="comms"></a>
## Comentaris adicionals



Ponem a disposició una imatge docker del servici instal·lat.º
```bash
docker pull cttl/ddh
docker run --name ddh -it cttl/ddh bash
cd /root/ddh; ember serve
```
Els estudis es guarden en `ddh/public/studies` com a fitxers _.csv_. Per a afegir
un nou govern/president, hem d'editar la variable `governments` del fitxer
`config/environment.js` afegint un diccionari JSON ambe metadades del govern i els
seus estudis.

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
## Seguretat

Recomanem seguri les recomendacions de seguretat, almenys, tipiques, pero la 
securització de serveis HTTP mitjaçant proxis inversos, certificats SSL, etc.
D'altra banda, si es va a utilitzar el servici en entorns de producció, desenvolupar
un pipeline segur per a introduïr dades en el servidor sense que un usuari que
no estiga autoritzat puga tindre accés a toda la configuració del servei o el mateix servidor.

<a name="val"></a>
## Valoració

Trobem l'instal·lació del servici molt senzilla, però l'_alimentació_ de noves dades
pot resultar tediosa des del punt de vista de l'usuari, ademés de que pot arribar a ser
un problema de seguretat si les dades les proporcionen molts usuaris.
