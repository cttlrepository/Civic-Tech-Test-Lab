# Project title

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

> [Shareabouts](https://github.com/openplans/shareabouts#shareabouts-) is a mapping application for crowdsourced info gathering.


Having a specific picked point on a map, [Shareabouts](https://github.com/openplans/shareabouts#shareabouts-) 
allows its users - without the need to signup - entry an issue or a desired feature at that point.

<a name="authorship"></a>
## Autorship

Developed by the [OpenPlans](https://openplans.org) group.

<a name="license"></a>
## License

Developed under the [GPLv3](https://github.com/openplans/shareabouts/blob/master/LICENSE.txt) license. 
The project is also merged together with other Free Software projects.

<a name="reqs"></a>
## Hardware requirements

A basic testing installation will not need more than 0.5GB of RAM and 1 core for each
part of the service - given a virtualzed environment.A production environment will need
at least double of those values - although it will increase if embedding with other services
such as reverse proxies, backups. 

<a name="install"></a>
## Installing



<a name="env"></a>
### Environment

We've deployed the service on a standard 'postgres:latest', which is also based on 
`Ubuntu:18.04`.



<a name="deps"></a>
### Dependencies

|Software|Minimal version| Recommended version| Package manager|
|-----|-----|----|----|
|virtualenv|Default|Default| system|
|git | Default|Default| system|
|python2|2.6| 2.6+ | virtualenv|
|pip|Default| Default| virtualenv|
|postgresql| 9.1| 9.1+|system|
|postgis| 2.0| 2.0|system|
|geodjango| Default| Default| pip (env)|
|requirements.txt del proyecto| Default| Default | pip (env)|

<a name="deploy"></a>
### Deployment
- [shareabouts-api](https://github.com/openplans/shareabouts-api/blob/master/doc/README.md)
    
    With `virtualenv` we will manage the python dependencies.
    
    
    ```bash
    git clone https://github.com/openplans/shareabouts-api
    cd shareabouts-api
    # new environment called env 
    virtualenv env
    source env/bin/activate
    pip install -r requirements.txt
    ```
    Creation and edition of the configuration file. 
    
    ```bash
    cp src/project/local_settings.py.template src/project/local_settings.py
    vim src/project/local_settings.py
    ```
    ```python
    DATABASES = {
        'default': {
            'ENGINE': 'django.contrib.gis.db.backends.postgis',
            'NAME': 'shareabouts',
            'USER': 'shareabouts',
            'PASSWORD': 'shareabouts',
            'HOST': '', # empty means default 
            'PORT': '', # empty means default 
        }
    }
    
    ```
    Admin user creation
    ```bash
    src/manage.py createsuperuser
    ```
    Service start on all interfaces and the `8000` port.
    ```
    src/manage.py runserver 0.0.0.0:8001
    ```
    The final configuration will be graphical with the default _Django_ configuration
    menu, accessing the machine's `domain/admin`, we'll log in with the superuser credentiales
    created above in order to create a dataset of key pair in order to glue the frontend with the backend.

- [shareabouts](https://github.com/openplans/shareabouts/blob/master/doc/README.md)
   
    We follow the same instruction given on the backend installation until the configuration
    file creation, where:
     
    ```bash
    cp src/project/local_settings.py.template src/project/local_settings.py
    vim src/project/local_settings.py
    ```
    
    In order to glue the backend with the frontend, as per the backend dataset configuration,
    we edit the configuration file with it.
    ```python
    SHAREABOUTS = {
        'FLAVOR': 'defaultflavor',
        'DATASET_ROOT': 'http://localhost:8001/api/v2/foo/datasets/aaa',
        'DATASET_KEY': 'MTUzNmQ0MmVmZDJhYzE0NjAyNDA1YTlm',
    }
    ```
    `DATASET_ROOT` and `DATASET_KEY` were made when installing the backend. The `DATASET_ROOT`
    field is composed by a base URL `domain/api/v2/[USER]/datasets/[DATASET]` where
    `[USER]` is the admin username which created the dataset and `[DATASET¯`is the created dataset name.
    
    Lastly, to start the frontend service
    ```bash
    src/manage.py runserver 0.0.0.0:8000
    ```
<a name="docs"></a>
## Official documentation
- [shareabouts]([https://github.com/openplans/shareabouts/blob/master/doc/README.m)
- [shareabouts-api](https://github.com/openplans/shareabouts-api/blob/master/doc/README.md)
- [geodjango](https://docs.djangoproject.com/en/dev/ref/contrib/gis/install/#django)

<a name="comms"></a>
## Additional comments
We provied a docker image with the services already installed. To import the image and
start the servers:

```bash
docker pull cttl/shareabouts
docker run --name shareabouts -it shareabouts bash --login
```
Inside the container 
```bash
su - postgres
/usr/lib/postgresql/11/bin/pg_ctl -D /var/lib/postgresql/data -l logfile start
exit
# backend init 
cd shareabouts-api
source env/bin/activate
src/manage.py runserver 0.0.0.0:8001

# frontend init 
cd; cd shareabouts
source env/bin/activate
src/manage.py runserver 0.0.0.0:8000
```


<a name="sec"></a>
## Security

We strongly recommendad leaving the server's public frontend access behind a reverse proxy such as
Nginx or Apache and block the backend from receiveng external queries.

<a name="val"></a>
## Final assessment

If a basic community/neighbourhood issue-tracking services is needed, Shareabouts is perfect given the fact
its installation isn't very complex. On the other hand, if a more feature-rich and complex service is needed,
we recommend  [FixMyStreet](https://github.com/cttlrepository/cat_participación/fms)