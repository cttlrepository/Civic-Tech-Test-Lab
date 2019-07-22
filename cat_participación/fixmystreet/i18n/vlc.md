# [FixMyStreet](https://fixmystreet.org)

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

> Informa, mira o discuteix problemes locals.


[FixMyStreet](https://fixmystreet.org) es una ferramenta de recolecció i informació de problemes
que poden sorgir en un carrer - un fanal espatllat, un semàfor que no funciona, etc.
_FMS_ definex `òrgans` - ajuntaments, regidories - als quals els passaràn els informes
creats a partir dels problemes que els usuaris han informat mitjançant el servici _FMS_. 
Els usuaris poden informar d'un problema creant-se un compte per a configurar els informes
més tard, o fer-lo anonimament. Així mateix, cada informe permet recollir un títol,
una descripció del problema i fotos.

Pel que respecta a la comunicació amb els òrgans oficials, aquesta es transparent a l'usuari,
però, a l'hora de configurar un òrgan, es necessari establir quin tipus
de protocol d'enviament es utilitzarà, tenint _Open311_ o _email_.

A l'hora d'administrar el servicio, l'interficie `/admin` ofereix una gran varietat d'ajustos.
En primer lloc i com s'ha explicat anteriorment, la configuració d'òrgans oficials als que enviar els informes d'usuarios.
Donat un òrgan, es poden establir per aquest 'Plantilles`, `Prioritats` i `Estats`, així com administrar usuaris - creació i eliminació.



<a name="authorship"></a>
## Autoria

Servici desenvolupat i mantengut per [MySociety](https://www.mysociety.org/about/).
<a name="license"></a>
## Llicència
Llicenciat sota GNU GPLv3.
<a name="reqs"></a>
## Requerimients hardware

Una instal·lació en un entorn de test o desenvolupament no necessitarà una gran capacitat
per a córrer el servici. Desglossant els requeriments segons estàndards _cloud_/VPS,
els servidors amb característiques mínimes dels principals proveïdors seran suficients.
D'un altra banda, en entorns de producció, les mesures de capacitat hardware augmenten en funció
de l'abast d'usuaris i de què altres ferramentes s'empot

<a name="install"></a>
## Instal·lació
<a name="env"></a>
### Entorn
Hem desplegat el servicio amb el qual es va realitzar aquest document en un entorn
docker basat en una imatge `Ubuntu:18.04`

<a name="deps"></a>
### Dependències

|Software|Versió mínima| Versió recomendada|Gestor de paquets|
|-----|----|------|------|
|postgresql|10|10|Sistema|
|wget|Sistema|Sistema|Sistema|

<a name="deploy"></a>
### Desplegament
```bash

wget https://raw.githubusercontent.com/mysociety/commonlib/master/bin/install-site.sh
# editem la configuració general 
vim conf/general.yml
# l'instalació crearà una carpeta fixmystreet dins del $HOME del nou usuari fms
#  asignad al domini fixmystreet.local
sh install-site.sh fixmystreet fms fixmystreet.local
su - fms
cd fixmsytreet
script/server
```
Llegados a este punto, el servicio debe estar disponible en el puerto 3000 de la máquina donde se instaló.
<a name="docs"></a>
## Documentació oficial
<a name="comms"></a>
## Comentaris adicionals
<a name="sec"></a>
- Si a l'hora de configurar el servici observem problemes amb `postgres` per l'eixida
estandar de la terminal, será necesari configurar el servici a la base de dades.

    
    Editem el fitxer de configuració general ajustant les dades segons les credencials de `postgres`:
    
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
    Reconstruïm l'esquema en la base de dades i instal·lem.
    ```bash
    cd /home/fms/fixmystreet
    ./script/setup
    ```

-  Proveïm una imatge docker basada en `Ubuntu:18.04` amb una instal·lació bàsica
de _FixMyStreet_ amb els següents credencials:

    - Usuario: `admin@cttl.local`
    - Contraseña: `cttl`
   
    Per a descarregar l'imatge solament fa falta realitzar un pull: 
    ```bash
    docker pull cttl/fms
    docker run --name fms -it cttl/fms bash --login
    su - fms
    cd fixmystreet; script/server
    ```

## Seguretat
<a name="val"></a>

El script d'instal·lació configura automaticament un proxy invers amb Ngin per a 
gestionar el servici _FMS_ per el port `80`, sense encriptació, en un fitxer
de configuració amb el nombre del domini afegit en l'instalació -
`/etc/nginx/sites-available/fixmystreet.local`. Recomanem, com a mesura de seguretat fonamental,
crear un certificat gratuit de [Let's Encrypt](https://letsencrypt.org) i modificar la configuració
anterior d'Nginx utilitzant el port HTTPS `443` encriptant la comunicació.

## Valoració

L'instal·lació de `fixmystreet` pot ser mes o menys tediosa en funció del que es necessite,
es a dir, el temps necesari per una instal·lació ràpida en entorns de test es pot
mesurar en minuts, però una instal·lació en entorns de producció i customitzada a una organització concreta
pot ser tediosa per la gran quantitat de servicis als que es pot unir aquest projecte, destacant
el motor geogràfic `mapit`. D'altra banda i mencionant l'obvi gràcies a la fama
i la gran quantitat d'implementacions satisfactòries en grans entorns, es tracta
d'un servici molt robust.


