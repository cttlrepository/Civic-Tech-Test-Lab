# [OpenRefine](https://openrefine.org) 

This guide is available english (this doc), [spanish](../README.md), and [catalan](vlc.md). We'll welcome more translations via PR.

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

> OpenRefine (formerly Google Refine) is a powerful tool for working with messy data: cleaning it; transforming it from one format into another; and extending it with web services and external data.
 
OpenRefine opens a local webservice to process a great size of data. The processing
baseline is the cleaning of anomalous or straight-up erroneus data. OpenRefine 
works with common text or binary data - csv, tsv, json, xls, xml among other.

The data processings is made with filters. The filters syntaxis is defined either via [GREL](https://github.com/OpenRefine/OpenRefine/wiki/General-Refine-Expression-Language), [P](https://python.org)/[Jython](https://jython.org) or [Clojure](https://clojure.org).

Besides filters, cells, columnos or rows transformations can be made, using the latter filters.

As an example, we'll define the next dataset,

|Nombre|Apellido 1|Apellido 2| Fecha de nacimiento| Género|
|------|----------|----------|-----|-------|
|Torcuato|Martínez|García|04/04/1995|H|
|Lucy|Ford| |05/06/1996|M|
|Benito|Martínez|Ocasio|10-03-1994|Hombre|
|Mister|Fantastic|Doom|09-01-1994|hh

... we can see how the last two columns of the last row contains anomalous data: the `fecha` and `género`
rows have a different format in comparison with their upper rows. This is
estimable with a naked eye because there only are three entries on our example, but, 
with a dataset which has thousands or millions of entries it would impossible to glance the
anomalous data, hence, applying a GREL filter with the next syntaxis:

```grel
length(value) < 2 
```
... it'd return two rows which meet the requirements and two which do not.



<a name="authorship"></a>
## Autorship
OpenRefine was originally created by Metaweb Technologies and aquaired in 
2012 by Google to be converted into a community project led by [Qi Jacky Cui](https://github.com/jackyq2015). 
<a name="license"></a>
## License

OpenRefine is licensed under BSD-3

<a name="reqs"></a>
## Hardware requirements
<a name="install"></a>
## Installing
<a name="env"></a>
### Environment
Project deployed under a `Ubuntu:18.04` docker image.
<a name="deps"></a>
### Dependencies

|Service|Minimal version|Recommended version|Package manager|
|--------|--------------|-------------------|------------------|
|Java|Default|Default|System|
|wget/curl|Default|Default|System|
<a name="deploy"></a>
### Deployment

```bash
git clone https://github.com/openrefine/openrefine openrefine; cd openrefine
./refine
``` 
<a name="docs"></a>
## Official documentation

[Official wiki](https://github.com/openrefine/openrefine/wiki)

<a name="comms"></a>
## Additional comments
We provide a docker image with OpenRefine installed and ready to test with the 
examples exposed on this document.

```
docker pull cttl/openrefine
docker run --name openrefine -it cttl/openrefine bash
cd /root/openrefine; ./refine -i 0.0.0.0
```
<a name="sec"></a>
## Security
OpenRefine provides its UI via a basic webserver without any security solution.
As so, while working on environments where several machines query a single OpenRefine
server it'd be interesting to implement basic webserver security measures, such as
running the server behind a HTTPS reverse proxy.

    
<a name="val"></a>
## Final assessment

We find OpenRefine easy to install and use as long as the use case is clear from the beggining.
