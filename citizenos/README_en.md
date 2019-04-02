# Citizen OS

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

## Description

Citizen OS is a free software, collaborative platform made to help teams and organizations at the task of making decisions and all the idiosyncrasies a piece of software can solve for them. It allows real-time collaborative edition, voting, project making and managing, and other characteristics.

Characteristics list:
 * Social authentication via google/facebook and native.
 * Topics, user-made resolutions where other users can:
 
 	* Comment.
 	* Add pro or con arguments.
 	* Vote the topic.
 	* Online editing with other users.
 	* Add a social mentions log using hashtags.
 	* Categorize the topic.
 	
* Groups, which puts together several topics.
	


<a name="authorship"></a>
## Authorship

Citizen OS was made and is mantained by the estonian company with the same name and the developer community at [GitHub](https://github.com/citizenos)


<a name="license"></a>
## Licenses

Citizen OS is liecensed under Apache 2.0 and it mantains the licenses of its parts which are forked from other projects. More info about the Apache License [here](https://www.apache.org/licenses/LICENSE-2.0).

<a name="reqs"></a>
## Hardware requirements

Citizen OS is made by three services, whose requirementes will be shown below. As there are three independent services, bear in mind that if they'll be deployed on the same machine, quasi-sum of each requirement will be needed. 

| Servicio    | [API](https://github.com/citizenos/citizenos-api)    | [FE](https://github.com/citizenos/citizenos-fe)     |  [Etherpad](https://github.com/ether/etherpad-lite/) |
| :---------- |:-----: | :----: | :-------: |
| **CPU**     | 1 core | 1 core | 1 core    |
| **Memory** | 1GB    | 1GB    | 0.5 GB	   |

<a name="install"></a>
## Installing

<a name="env"></a>
### Environment
The services deployment was made via a docker ubuntu:18.04-based container.

```
# official ubuntu image download 
docker pull ubuntu 
# container build and interactive start 
#  un contendor que se llamará ubuntu
docker run --name ubuntu  -it ubuntu:latest bash 
``` 
Due to the way *npm* works, issues when installing this service with *root* user may appear, which makes us recommend to work with a different user, install **sudo** and add that user to the **sudo** group. 

```
apt install sudo
useradd foo -G sudo -m
```

<a name="env"></a>
### Dependencies

- [API](https://github.com/citizenos/citizenos-api)

| Software   | Versión mínima | Versión recomendada|
| :-----     | :------------: |:-----------------: |
| [postgresql](https://www.postgresql.org/) | 9.5            | > 9.5              | 
| [nodejs](https://nodejs.org/es/)     | 6.13.1         | >6.13.1            |

- [API](https://github.com/citizenos/citizenos-api)
	- nodejs
- [Etherpad](https://github.com/ether/etherpad-lite/)
	- nodejs v8.9	

<a name="deploy"></a>
### Deployment
- Etherpad

One-command Etherpad install, where its repository is cloned and its server launched.

```
git clone --branch master https://github.com/ether/etherpad-lite.git && cd etherpad-lite && bin/run.sh
```

- API

The one-command Etherpad install created a folder called etherpad-lite/. Inside this folder there is a file called APIKEY.txt which has the HTTP API token needed to glue the Citizen OS API with  Etherpad. This token and the http Etherpad service address - by default, http://localhost:9001 - are need when setting up the service.

```
git clone https://github.com/citizenos/citizenos-api.git 
cd citizenos-api/bin
bash install.sh 
```

This point onwards will be needed to set up the service. Inside the service root folder there's another one called **config/**, which stores the configuration files for the API. We'll modify the proper config file according to the environment the service will be working on; this is: default, development, production or test, each one with a .json associated file. Regardless of environment choice, each of one of the files will have to have the Etherpad configuration set up. To do that we'll have to look up for the etherpard dictionary inside the config files. Here's an example:

```
"etherpad": {
  "host": "localhost", 
  "port": "9001", 
  "ssl": true,
  "rejectUnauthorized": false,
  "apikey": "fb1f98df49f80182296ce2dbc72b3b848be2f1c7b2ede082eaff5261e1a408ab"
}
```
At last, in order to start de service:
```
cd config/
npm start
```
- FE

```
git clone https://github.com/citizenos/citizenos-fe.git 
cd citizenos-fe
npm run dev
```

<a name="docs"></a>
## Official documentation

<a name="comms"></a>
## Additional comments
- Expected bugs

When installing the node services (FE and API), issues may appear with npm dependencies. If the process of starting one of those service raises a failure due to a npm dependency issue, it's recommended to install them with root user:
```
npm install -g [paquete]
```

- Docker environment

We provide the docker environment which we have worked with in order to deploy the services explained in this document  [here](/container.tar.gz). 
After downloading the file, import the container with:
```
zcat container.tar.gz | docker - import citizenos
docker run --name citizenos -i -t /bin/bash
su - foo
```
The services folders are available at /home/foo


<a name="sec"></a>
## Security
On production environments we recommend blocking the outbound ports of the services deployed and redirect the petitions via a reverse proxy such as Apache or Nginx.

<a name="val"></a>
## Final assessment
Our assessment is made to give an opinion about the installation process - if it's tedious, if the software is over-dependant on other technologies, etc - and the service use.

The installation process can grow tedious if experience is needed when, on the one hand, working with node service due to its package manager - ```npm```- idiosyncrasies, or, in the other hand, while working with ```postgresql``` because its workflow is a tad different  to more classical approaches like ```mariadb``` or ```mysql```. If we ignore those two cases, the project actually has very few dependencies and the installation is speedy and easy.

As for its use, Citizen OS provides a modern and friendly user interface, reason by which we consider is easy to use regardless of  technical knowledge of the user.
