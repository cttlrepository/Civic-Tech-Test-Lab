# Image hub
All images provided are stored at [DockerHub](https://hub.docker/u/cttl). To access them, you'll have to pull from there via `docker pull cttl/cttl:[TAG]`
where the tag specifies the desired image. Currently we provide:
 - Generics:
     - Rails generic 
     
        `docker pull cttl/rails`
 
        Rails-ready [rbenv-based](https://github.com/rbenv/rbenv) with ruby 2.6.1 and postgresql 10 installed.
        
        To use ruby 2.6.1 via rbenv:
        
        ```bash        
        rbenv global 2.6.1
        ruby --version            
        ```
        
        To install a specific ruby version, eg: 2.7.0-dev
         
        ```bash      
        # check rbenv existing candidates
        rbenv install --list | grep 2.7.0
        rbenv install 2.7.0-dev --verbose
        ruby --version            
        ```
        
        Postgres service is available via its default daemon `service postgresql start`. To access the database,
        either via the binaries - eg: `psql` or a rails app, you'll need to use `postgres` as user and as password. The authentication
        default behaviour was changed to md5 via the config file `/etc/postgresql/10/main/pg_hba.conf`
     - Python generic 
     
        `docker pull cttl/py`
 
        django-ready virtualenv-based with postgresql 10 installed
        
        py2 (2.7.15rc1) environment available via:
        ```bash
        cd; source env2/bin/activate
        python --version
        ```
        
        py3 (3.6.7) environment available via:
        ```bash
        cd; source env3/bin/activate
        python --version
         ```
         
        postgres environment is provided as is in the `rails` image 
        
 - Services:
     - Shareabouts 
     
        `docker pull cttl/shareabouts`
        
        More [here](https://github.com/cttlrepository/cttl/shareabouts)
     - Citizenos 
     
        `docker pull cttl/citizenos`
        
        More [here](https://github.com/cttlrepository/cttl/citizenos)
     - Del dicho al hecho 
     
        `docker pull cttl/ddh`
         
         More [here](https://github.com/cttlrepository/cttl/ddh)
     - FixMyStreet 
     
        `docker pull cttl/fms`
        
        More [here](https://github.com/cttlrepository/cttl/fixmystreet)
     - Froide 
     
        `docker pull cttl/froide`
        
        More [here](https://github.com/cttlrepository/cttl/froide)

     - OpenRefine
     
     	`docker pull cttl/openrefine`
        
     	More [here](https://github.com/)
       
     - Bokeh

		`docker pull cttl/bokeh`
       
       More [here](https://github.com)
     
# Utils
- `new_project.sh`
- `docker_helper.sh`