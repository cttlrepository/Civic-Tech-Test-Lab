# [Decidim](https://decidim.org)

This guide is available english in (this doc), [spanish](../README.md), and [catalan](vlc.md). We'll welcome more translations via PR.

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

> a digital platform for citizen participation

[Decidim](decidim.org) is a framework which aims to help teams and organizations build a virtual democratic field for its users.
It allows creating a participatory flow involving processes, assemblies, user-made assemblies, consultations and conferences.

Decidim uses specific terminology when describing its use cases. The foremost concept we have is a *process*, which is a cycle-of-life definition which gathers user-made activities in a given context. For example, the city of Barcelona's `decidim` has a process to diagnose the need of revision and reequipment of public infrastructure at Nou Barris.
A `decidim` user may select a given process in a that area and create a proposal on that process, eg, the need to create a children space or a park.
That proposal can be commented and endorsed by other members of the organization.
The cycle-of-life of a process is custom-made for each process, this is, its steps are made when defining a process, although a 'Introduction' step will be automatically defined by default.

[WIP]

<a name="authorship"></a>
## Autorship
Project made by the Decidim Community at [decidim.org](decidim.org)
<a name="license"></a>
## License
Licensed under AGPL v3.
<a name="reqs"></a>
## Hardware requirements

A minimal configuration for testing purposes won't need much more than 2GB of RAM and 1 core to deploy the app but 
the requirements will grow as the number of users grows.

<a name="install"></a>
## Installing
<a name="env"></a>
### Environment
In order to deploy this app, we've used the `airdock/rvm` docker image, which is based on Debian Jessie.
<a name="deps"></a>
### Dependencies
| Software | Minimal version | Recommended version | Package manager |
| :-------- | --------------- | ------------------- | --------------- |
| ruby | 2.5.1 | 2.5.1 | system |
| gems | 2.5.1 | 2.7.9 | system |
| postgresql | 9.6 | 11 | system | 
| imagemagick | system default | system default | system |
| libicu | system default | system default | system |
| nodejs | system default | system default | system |
| libpq | system default | system default | system |
| mini_portile2 | 2.2.0 | 2.2.0| gem |
| bundler | 2.0.1 | 2.0.1 | gem | 
| icu | system default | system default | gem | 

<a name="deploy"></a>
### Deployment
After installing all dependencies:
```bash
# installing the main gem
gem install decidim

# creating the system super user and the db
sudo -u postgres psql -c "CREATE USER decidim_cttl WITH SUPERUSER CREATEDB NOCREATEROLE PASSWORD 'decidim_cttl'"

# creating the project
decidim decidim_cttl
cd decidim_cttl
```

Now we're inside the project's main folder, we need to edit the Gemfile according to our needs. 
We create a production section for our deployment and add the `figaro` gem for it to be installed later.

```vim
# add this anywhere outside a group
gem "figaro"

# add this at the end of the file
group :production do
  gem "passenger"
  gem 'delayed_job_active_record'
  gem "daemons"
end
```

Now we're ready to `bundle` the Gemfile and deploy our project.
```bash
bundle install
echo -e "DATABASE_URL: postgres://decidim_cttl:decidim_cttl@localhost/decidim_prod \nSECRET_KEY_BASE:" \
> config/application.yml
rake secret >> config/application.yml
bin/rails db:create RAILS_ENV=production
bin/rails assets:precompile db:migrate RAILS_ENV=production
```

Our app is finally deployed! But one last step is needed as we don't really have an admin user to manage the app. So:

```bash
bin/rails console -e production
# now we're inside the rails console
2.5.1 :001 > password = "fifteencharpassword"
2.5.1 :002 > email = "admin@cttl.local"
2.5.1 :003 > user = Decidim::System::Admin.new(email: email, password: password, password_confirmation: password(
2.5.1 :004 > user.save!
2.5.1 :005 > quit
# this starts the server and it will be accessible @ localhost:3000
bin/rails s
```

<a name="docs"></a>
## Official documentation
- [Platoniq's installation guide on Ubuntu 18.04](https://github.com/Platoniq/decidim-install/blob/master/decidim-bionic.md)
- [Official installation guides](https://github.com/decidim/decidim/blob/master/docs/getting_started.md)
<a name="comms"></a>
## Additional comments
A file named `.history` is available with all commands used - even those for installing dependencies - to install this application.
<a name="sec"></a>
## Security
As `decidim` is made with Ruby on Rails, the main app is a HTTP webserver which by itself doesn't provide the basic HTTPS security layer. 
In order to have that layer we recommend exposing the webserver to the public behind a reverse proxy via Nginx or Apache.

On the other hand, instead of a reverse proxy there's also [passenger](https://www.phusionpassenger.com/) - aka mod_ruby - which can
be integrated into Nginx or Apache in order to handle the ruby server directly. 
We recommend following [platoniq's guide](https://github.com/Platoniq/decidim-install/blob/master/decidim-bionic.md#4-installing-nginx)
to deploy `decidim` via Nginx + passenger.



<a name="val"></a>
## Final assessment
Although there is, at first, no restriction of use for smaller orgs, this app is huge and as such, its installation can be a bit tedious,
especially since ruby versioning is a hassle in itself. If a fast installation is desired, we recommend the official guide's
docker way.


