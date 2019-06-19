# [Decidim](https://decidim.org)

Aquesta guia està disponible en valencià (aquest document), [espanyol](../README.md) i [anglès](en.md). Més traducciones son benvolgudes a través d'un PR.


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
> una plataforma digital de participació ciutadana

[Decidim](decidim.org) es un framework que ajuda a organizacions i equipos a construir una esfera democràtica virtual als seus usuaris. Permet la creació d'un flux participatiu que inclou assemblees, consultes i conferencies.  

Un proces es una definició del tipus cicle de vida el qual recull activitats fetes per un usuari en un determinat context. Per exemple, la implementació de `decidim` a la ciutat de Barcelona defineix un process per a diagnosticar la necessitat de revisió i reequipament d'infraestructura pública a Nou Barris.
Un usuari `decidim`pot seleccionar qualsevol procés existent i crear una proposta al mateix, per example, la necesitat de crear un espai infantil o un parc. Les propostes poden ser comentades i aprovades  per altres membres de l'organització. El cicle de vida d'un procés está fet a mida per a cada un d'ells, es a dir, els seus passos son creats quan un procés es definit, encara que un pas denominat 'Introducció' serà automàticament afegit per defecte.
<a name="authorship"></a>
## Autoria
Projecte realitzar per la Comunitat Decidim a [decidim.org](decidim.org)
<a name="license"></a>
## Llicència
AGPL v3.
<a name="reqs"></a>
## Requerimients hardware
Una configuración mínima para testeo no necesitará más de 2GB de RAM y 1 core pero en un despliegue de producción las necesidades crecerán a medida que el número de usuario aumente
Una configuració mínima per a testejar no necessitarà més de 2GB de RAM i 1 core però en un desplegament de producció les necessitats creixeran a mesura que el nombre d'usuaris augmenta.
<a name="install"></a>
## Instal·lació
<a name="env"></a>
### Entorn
Per a desplegar aquest servici hem utilitzat l'imatge docker `airdock/rvm`, basada en Debian Jessie.
<a name="deps"></a>
### Dependències

| Software | Versió mínima | Versió recomanada | Gestor de paquets |
| :-------- | --------------- | ------------------- | -------------|
| ruby | 2.5.1 | 2.5.1 | sistema |
| gems | 2.5.1 | 2.7.9 | sistema |
| postgresql | 9.6 | 11 | sistema | 
| imagemagick | per defecte | per defecte | sistema |
| libicu | per defecte | per defecte | sistema |
| nodejs | per defecte | per defecte | sistema |
| libpq | per defecte | per defecte | sistema |
| mini_portile2 | 2.2.0 | 2.2.0| gem |
| bundler | 2.0.1 | 2.0.1 | gem | 
| icu | per defecte | per defecte | gem | 

<a name="deploy"></a>
### Desplegament

Després d'instalar totes les dependències:
```bash
# instal·lar la gema principal
gem install decidim

# crear el superusuari i la base de dades
sudo -u postgres psql -c "CREATE USER decidim_cttl WITH SUPERUSER CREATEDB NOCREATEROLE PASSWORD 'decidim_cttl'"

# crear el projecte 
decidim decidim_cttl
cd decidim_cttl
```

Ara que estem dins de la carpeta arrel del projecte, necessitem editar el fitxer Gemfile d'acord a les nostres necessitats. Creem una secció per al nostre desplegament i afegim la gema `figaro` per a que siga instal·lada més endavant.
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
Ara es possible llançar la comanda  `bundle` per a desplegar el projecte

```bash
bundle install
echo -e "DATABASE_URL: postgres://decidim_cttl:decidim_cttl@localhost/decidim_prod \nSECRET_KEY_BASE:" \
> config/application.yml
rake secret >> config/application.yml
bin/rails db:create RAILS_ENV=production
bin/rails assets:precompile db:migrate RAILS_ENV=production
```
Nuestra app está finalmente desplegada, sin embargo será necesario crear un usuario administrador mediante la consola de rails.
La nostra app està finalment desplegada però serà necessari crear un usuari administr mitjançant la consola rails.

```bash
bin/rails console -e production
# now we're inside the rails console
2.5.1 :001 > password = "fifteencharpassword"
2.5.1 :002 > email = "admin@cttl.local"
2.5.1 :003 > user = Decidim::System::Admin.new(email: email, password: password, password_confirmation: password(
2.5.1 :004 > user.save!
2.5.1 :005 > quit
# llançar el servei a localhost:3000
bin/rails s
```

<a name="docs"></a>
## Documentació oficial
- [Guia d'instal·lació de Platoniq en Ubuntu 18.04](https://github.com/Platoniq/decidim-install/blob/master/decidim-bionic.md)
- [Guies d'instal·lació oficials](https://github.com/decidim/decidim/blob/master/docs/getting_started.md)

<a name="comms"></a>
## Comentaris adicionals
N'hi ha disponible un fitxer anomenat `.history` el qual conté totes les comandes utiltzades - inclouent les necessàries per a les dependències - per a instal·lar aquest servici.
<a name="sec"></a>
## Seguretat

Com `decidim` està fet amb Ruby on Rails, la aplicació principal es un servei web HTTP que per ell mateix no proveeix la capa de seguritat HTTPS. Per a acoplar aquesta al nostre projecte recomanem llançar la aplicació principal darrera d'un proxy inverse Nginx o Apache.
D'altra banda, existeix el software [passenger](https://www.phusionpassenger.com) - aka mod_ruby - el qual pot ser integrat amb Nginx o Apache per a gestionar el servei ruby directament. Per a desplegar passenger recomanem la quia de [platoniq](https://github.com/Platoniq/decidim-install/blob/master/decidim-bionic.md#4-installing-nginx).
<a name="val"></a>
## Valoració
Encara que no hi haja, a priori, restricció d'ús per a organització més menudes, aquest servici es _gegant_, fet que implica que la seua instal·lació i preparació per a producció pot ser tedioas, especialmente quan solament el versionament de ruby es àrdua tasca per ella mateixa. Si es desitja una instal·lació ràpida, recomanem la oficial mitjançant docker.
