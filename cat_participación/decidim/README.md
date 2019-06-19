# [Decidim](https://decidim.org)

Esta guia está disponible en castellano (este documento), [inglés](i18n/en.md) y [valenciano](i18n/vlc.md). Más traducciones son bienvenidas mediante un PR.

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

> una plataforma digital de participación ciudadana

[Decidim](decidim.org) es un framework que ayuda a origanizaciones y equipos a construir una esfera democrática virtual a sus usuarios. Permite la creación de un flujo participativo que incluye procesos, asambleas, consultas y conferencias.

Un proceso es una definición del tipo ciclo de vida la cual recoge actividades hechas por un usuario en un determinado contexto. Por ejemplo, la implementación de `decidim` a la ciudad de Barcelona define un proceso para diagnosticar la necesidad de revisión y reequipamiento de infraestructura pública a Nou barris.
Un usuario `decidim` puede seleccionar un proceso dado y crear una propuesta al mismo, por ejemplo, la necesidad de crear un espacio infantil o un parque. Las propuestas pueden ser comentadas y aprobadas por otros miembros de la organización. El ciclo de vida de un proceso está hecho a medida para cada uno de ellos, esto es, sus pasos son creados cuando un proceso es definido, aunque un paso denominado 'Introduccón' será automáticamente añadido por defecto.

<a name="authorship"></a>
## Autoría

Proyeccto realizado por la Comunidad Decidim en [decidim.org](decidim.org) 
<a name="license"></a>
## Licencia
AGPL v3.

<a name="reqs"></a>
## Requerimientos hardware
Una configuración mínima para testeo no necesitará más de 2GB de RAM y 1 core pero en un despliegue de producción las necesidades crecerán a medida que el número de usuario aumente.

<a name="install"></a>
## Instalación

<a name="env"></a>
### Entorno

Para desplegar este servicio hemos usado la imagen docker `airdoc/rvm`, basada en Debian Jessie.
<a name="deps"></a>
### Dependencias
| Software | Versión mínima | Versión recomendada | Gestor de paquetes |
| :-------- | --------------- | ------------------- | --------------- |
| ruby | 2.5.1 | 2.5.1 | sistema |
| gems | 2.5.1 | 2.7.9 | sistema |
| postgresql | 9.6 | 11 | sistema | 
| imagemagick | por defecto | por defecto | sistema |
| libicu | por defecto | por defecto | sistema |
| nodejs | por defecto | por defecto | sistema |
| libpq | por defecto | por defecto | sistema |
| mini_portile2 | 2.2.0 | 2.2.0| gem |
| bundler | 2.0.1 | 2.0.1 | gem | 
| icu | por defecto | por defecto | gem | 


<a name="deploy"></a>
### Despliegue
Después de instalar todas las dependencias:
```bash
# instalar la gema principal
gem install decidim

# crear el superusuario y la base de datos 
sudo -u postgres psql -c "CREATE USER decidim_cttl WITH SUPERUSER CREATEDB NOCREATEROLE PASSWORD 'decidim_cttl'"

# crear el proyecto 
decidim decidim_cttl
cd decidim_cttl
```
Ahora que estamos dentro de la carpeta raíz del proyecto, necesitamos editar el Gemfile de acuerdo a nuestras necesidades.
Creamos una sección para nuestro despliegue y añadimos la gema `figaro` para que sea instalada más tarde.

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
Ahora es posbile lanzar el comando `bundle` para desplegar el proyecto

```bash
bundle install
echo -e "DATABASE_URL: postgres://decidim_cttl:decidim_cttl@localhost/decidim_prod \nSECRET_KEY_BASE:" \
> config/application.yml
rake secret >> config/application.yml
bin/rails db:create RAILS_ENV=production
bin/rails assets:precompile db:migrate RAILS_ENV=production
```
Nuestra app está finalmente desplegada, sin embargo será necesario crear un usuario administrador mediante la consola de rails.

```bash
bin/rails console -e production
# now we're inside the rails console
2.5.1 :001 > password = "fifteencharpassword"
2.5.1 :002 > email = "admin@cttl.local"
2.5.1 :003 > user = Decidim::System::Admin.new(email: email, password: password, password_confirmation: password(
2.5.1 :004 > user.save!
2.5.1 :005 > quit
# lanzar el servidor en localhost:3000
bin/rails s
```
<a name="docs"></a>
## Documentación oficial
- [Guía de instalación de Platoniq en Ubuntu 18.04](https://github.com/Platoniq/decidim-install/blob/master/decidim-bionic.md)
- [Guías de instalación oficiales](https://github.com/decidim/decidim/blob/master/docs/getting_started.md)


<a name="comms"></a>
## Comentarios adicionales

Hay disponible un fichero denominado `.history` el cual contiene todos los comandos utilizados - incluso los necesario para las dependencias - para instalar este servicio.

<a name="sec"></a>
## Seguridad
En tanto en cuanto `decidim` está hecho con Ruby on Rails, la aplicación principal es un servidor web HTTP que por sí mismo no provee la capa de seguridad HTTPS. Para acoplar la misma a nuestro proyecto recomendamos correr la aplicación principal detrás de un proxy inverso Nginx o Apache.
Por otro lado, en vez de un proxy inverso, también existe el software [passenger](https://www.phusionpassenger.com) - aka mod_ruby - el cual pude ser integrado en Nginx o Apache para manejar el servidor ruby directamente. Para ello recomendamos la guía de [platoniq](https://github.com/Platoniq/decidim-install/blob/master/decidim-bionic.md#4-installing-nginx)

<a name="val"></a>
## Valoración

Aunque no exista, a priori, restricción de uso para organizaciones pequeñas, este servicio es _gigante_, lo que implica que su instalación y preparación para producción puede ser tediosa, especialmente cuando solo el versionado de ruby es una tarea ardua en sí misma. Si se desea una instalación rápida, recomendamos la oficial mediante docker
