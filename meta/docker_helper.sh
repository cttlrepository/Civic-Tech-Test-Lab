#!/usr/bin/env sh

filename=$(basename "$0")
usage="$filaneme [-h] [OPCIONES] contenedor [contenedor base]
\n\tDESCRICIÓN\n
\t\tayuda para tareas repetitivas con docker\n
\n\tOPCIONES\n
\t\t-s: levanta un contenedor\n
\t\t-se: inicia de manera interactiva un contenedor\n
\t\t-c: mata un contenedor\n
\t\t-r: crea un nuevo contenedr (docker run) a partir de un contenedor base\n"

if [ "$1" == "-h" ]; then
	echo -e $usage
	exit 1
fi

if [ -z "$1" ]; then
	echo -e $usage
	exit 1
fi

if [ "$1" == "-c" ]; then
	if [ -z "$2" ]; then
		echo $usage
		exit 1
	fi
	docker stop $2
fi


if [ "$1" == "-r" ]; then
	if [ -z "$2" ]; then
		echo $usage
		exit 1
	fi

	if [ -z "$3" ]; then
		echo $usage
		exit 1
	fi
	docker run --expose 8000 --expose 8001 --expose 3000 --name $2 -it $3 bash --login 
fi




if [ "$1" == "-s" ]; then
	if [ -z "$2" ]; then
		echo $usage
		exit 1
	fi
	docker start $2
fi

if [ "$1" == "-se" ]; then
	if [ -z "$2" ]; then
		echo $usage
		exit 1
	fi
	docker start $2
	docker exec -it $2 bash --login
fi
