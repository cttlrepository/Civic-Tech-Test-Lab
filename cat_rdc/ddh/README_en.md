# [Del dicho al hecho](https://github.com/ciudadanointeligente/del-dicho-al-hecho-ember) 

This guide is available english (this doc), [spanish](README.md), and [catalan](README_cat.md). We'll welcome more translations via PR.

### Table of contents
1. [ Description ](#desc)
2. [ Authorship ](#authorship)
3. [ License ](#license)
4. [ Hardware requirements ](#reqs)
5. [ Installing ](#install)

	5.1. [ Environment ](#env) 
	
	5.2. [ Dependencies ](#deps)
	
	5.3. [ Deployment ](#deploy)


	
6. [ Official documentation ](#docs)
7. [ Additional comments ](#comms)
8. [ Security ](#sec)
9. [ Final assessment ](#val)

<a name="desc"></a>
## Description

Electoral campaigns-measuring portal. Feeded with csv data files, the service builds
upon the data a web application which shows statitics of accountability for the given
campaigns.


<a name="authorship"></a>
## Autorship

Desarrollado por el la [Fundación Ciudadano Inteligente](https://ciudadaniai.org/) junto a sus constribuidores en [Github](https://github.com/ciudadanointeligente/del-dicho-al-hecho-ember)
<a name="license"></a>
## License

Without license.

<a name="reqs"></a>
## Hardware requirements

Assuming the service will be ran on a VPS, the basic plans the most famous providers offer will suffice for testing purposes.


<a name="install"></a>
## Installing

<a name="env"></a>
### Environment

The project was deployed using our `cttl/rails` docker image. More info [here](https://github.com/cttlrepository/cttl/meta).

<a name="deps"></a>
### Dependencies

|Service|Minimal version|Recommended version|Package manager|
|--------|--------------|-------------------|------------------|
|git|Default|Default|Sistema|
|node|Default|Default|Sistema|
|fontconfig|Default|Por defeccto|Sistema|
|phantomjs|Default|Default|sistema
|bower|Default|Default|npm|
|ember-cli|Default|Default|npm


<a name="deploy"></a>
### Deployment
```bash
apt install git node npm fontconfig phantomjs
npm install bower ember-cli
git clone https://github.com/ciudadanointeligente/del-dicho-al-hecho-ember ddh
cd ddh; ember serve
```

<a name="docs"></a>
## Official [documentation](https://github.com/ciudadanointeligente/del-dicho-al-hecho-ember)
<a name="comms"></a>


## Additional comments

We provide a docker image with the installed services used to make this document.


```bash
docker pull cttl/ddh
docker run --name ddh -it cttl/ddh bash
cd /root/ddh; ember serve
```

Studies are saved on `ddh/public/studies' as _.csv_ files. To add a new government/president,
editing the `governments` variable into the `config/environment.js` file wil be needed, by adding
a new JSON dictionary with government and studies metadata.


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
## Security

We recommend following, at least, the typical security measures used to securize
HTTP servers such as running it behind a production-level reverse proxy, SSL certs, etc. On the other hand,
we also recommend, if a _Del dicho al hecho_ will be deployed on production, to develop
a secure pipeline for trusted data-feeding so a non-authorized user won't have access
to the service's configuration files and the server itself.

<a name="val"></a>
## Final assessment

We find the installation processess very straightforward, although the feeding process
of new data can be a bit tedious from a user standpoint. Furhtermore, it can become a severe
security issue if the data can be provided by multiple non-authorized users.
