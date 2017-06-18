#!/bin/bash
echo "Ingrese el nombre del grupo que desea agregar"
read grupoNom
buscar=`cut -d ":" -f 1 /etc/group | grep $grupoNom`
if [ "$buscar" != "$grupoNom" ]
	then
		groupadd $grupoNom
		buscar=`cut -d ":" -f 1 /etc/group | grep $grupoNom`
		if [ "$buscar" != "$grupoNom" ]
		then
			echo "Ocurrio un error al crear el grupo"
		else
			echo "El grupo se creo correctamente"
			d=`date + '%H:%M:%S %Y-%m-%d'`
			echo "Creado grupo '$grupoNom';$USER;$d" >> /SISALCA/logs
		fi
	else
		echo "Error, ya hay un grupo con ese nombre"
fi
./mainmenu.sh
