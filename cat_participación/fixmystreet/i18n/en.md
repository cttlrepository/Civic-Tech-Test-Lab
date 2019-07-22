# [FixMyStreet](https://fixmystreet.org)

This guide is available on english (this doc), [spanish](../README.md), and [catalan](vlc.md). We'll welcome more translations via PR.

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
 

[FixMyStreet](https://fixmystreet.org)  is compiling and reporting tool of problems which arouse
at a given street - a broken streetlight, a semaphor which doesn't work, etc. _FMS_
defines _bodies_ - city halls, councils, etc - to which the reports, created from
the users provided information about street issues, will be passed. The users can 
report an issue by creating an account or they can do it so anonymously. Each report
allows a descriptive title, some notes as a full description and several photos.


Concerning the communication protocol between _FMS_ and the official bodies, it's fully
transparent to the user but when configuring a body, it has to be established which
type of communication protocol will be used, having Open311 and email.

When _sysadmin-ing_ the service, the `/admin` interface offers a great variety
of settings. First of all and as it has been already explained, the official body
configuration. Given a body, `Templates`, `Priorities` and `States` can be established,
besides creating, editing and removing user accounts.

<a name="authorship"></a>
## Autorship

The service is being developed and mantained by [MySociety](https://www.mysociety.org/about/).

<a name="license"></a>
## License
Licensed under the GNU AGPLv3 license.
<a name="reqs"></a>
## Hardware requirements
A test or development installation won't need great hardware features to be able to run the service.
Unrolling the requirements using _cloud_/VPS standars, the basic servers offered
by the main providers are enough. On production environments, the hardware requirements
will go up as the userbase grows and different services are being embedded into 
_FixMyStreet_.

<a name="install"></a>
## Installing
<a name="env"></a>
### Environment

We've deployed the service which this document was made upon via a `Ubuntu:18.04` docker image.

<a name="deps"></a>
### Dependencies

|Software|Minimal version|Recommended version|Package manager|
|-----|----|------|------|
|postgresql|10|10|System|
|wget|System|System|System|

<a name="deploy"></a>
### Deployment

```bash
wget https://raw.githubusercontent.com/mysociety/commonlib/master/bin/install-site.sh
# edit the conf file with the postgres credentials 
vim conf/general.yml
# this will create a fixmystreet folder inside the new user $HOME - /home/fms/fixymstreet
# esto creará la carpeta fixmystreet dentro del $HOME del nuevo usuario fms
# assigned to the fixmystreet.local domain 
sh install-site.sh fixmystreet fms fixmystreet.local
su - fms
cd fixmsytreet
script/server
```
At this point the service must be available on `localhost:3000`.

<a name="docs"></a>
## Official documentation

[Official installation manual](https://fixmystreet.org/install/)

<a name="comms"></a>
## Additional comments

- If when installing or restarting the service we observer issues regarding postgres on
stdout, it will be necessary to configure the service access to the database.


    We edit the general configuration file with the postgres credentials.
    ```vim
    {
        # PostgreSQL database details for FixMyStreet
        FMS_DB_HOST: ''
        FMS_DB_PORT: '5432'
        FMS_DB_NAME: 'fixmystreet'
        FMS_DB_USER: 'postgres'
        FMS_DB_PASS: 'postgres'
    }
    ```
    Scheme reconstruction will be needed.
    ```bash
    cd /home/fms/fixmystreet
    ./script/setup
    ```

- We provide `Ubuntu:18.04`-based docker image with the basic _FMS_ installation with the
credentials below:

    - Usuario: `admin@cttl.local`
    - Contraseña: `cttl`
   
   To download the image we'll only need to make a pull: 
    ```bash
    docker pull cttl/fms
    docker run --name fms -it cttl/fms bash --login
    su - fms
    cd fixmystreet; script/server
    ```



<a name="sec"></a>
## Security
The installation script configures automatically a reverse Nginx proxy in order to
access the _FMS_ service on port 80, without encryption, configured by the automatically generated
`/etc/nginx/sites-available/fixmystreet.local` file. We recommend, as a fundamental security measeure,
the creation of a [Let's Encrypt](https://letsencrypt.org) HTTPS cert in order to activate
443-port encrypted conexions.

<a name="val"></a>
## Final assessment

The `fixmystreet` installation can be more or less tedious depenedning on what the use case
and its needs are, this is, the needed time to install _FMS_ on a testing environment
can be measured in minutes while a production installation customized to a given organization
can be a bit tedious due to the large quantity of services which can be embedded to this project,
displaying the geografic engine `mapit`. On the other hand, given the fame and the sheer quantity
of already successful _FMS_ implementations, we conclude it is a very robust service.

