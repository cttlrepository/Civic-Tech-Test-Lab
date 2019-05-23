#!/usr/bin/env sh

filename=$(basename "$0")
usage="$filaneme [-h] [NOMBRE DE PROYECTO] [CATEGORÍA]
\n\tDESCRICIÓN\n
\t\teste script crea un nuevo proyecto con las plantillas para los idiomas disponibles\n
\n\tCATEGORÍA\n
\t\t td: Transparencia y datos
\n\t\t c: Colaboración <- por defecto 
\n\t\t rc: Rendición de cuentas" 

cat="cat_participación"

if [ "$1" == "-h" ]; then
	echo -e $usage
	exit 1
fi

if [ -z "$1" ]; then
	echo $0
	echo -e $usage
	exit 1
fi

if [ "$2" == "td" ]; then
	cat="cat_tyd"
fi

if [ "$2" == "rc" ]; then
	cat="cat_rdc"
fi
mkdir -p ../$cat/$1
cp -r templates/* ../$cat/$1/


