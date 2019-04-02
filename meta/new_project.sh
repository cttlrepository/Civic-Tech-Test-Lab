#!/usr/bin/env sh

filename=$(basename "$0")
usage="$filaneme [-h] [PROJECT_NAME] 
ll=$(ls -l)
\n\tDESCRICIÓN\n
\t\teste script crea un nuevo proyecto con las plantillas para los idiomas disponibles, así como actualizar el README.md general\n"


if [ "$1" == "-h" ]; then
	echo -e $usage
	exit 1
fi

if [ -z "$1" ]; then
	echo $0
	echo -e $usage
	exit 1
fi


mkdir ../$1
cp -r templates/* ../$1/
ls -l ../$1/

string="| [$1](/$1) | $1 |  |"

echo $string >> ../README.md
echo $string >> ../README_en.md
echo $string >> ../README_cat.md

