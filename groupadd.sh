#!/bin/bash
echo "Ingrese el nombre del grupo que desea agregar"
read grupoNom
buscar=`cut -d ":" -f 1 /etc/group | grep $grupoNom`
d=`date +%S%M%H%d%m%y`
if [ "$buscar" != "$grupoNom" ]
	then
		groupadd $grupoNom
		buscar=`cut -d ":" -f 1 /etc/group | grep $grupoNom`
		if [ "$buscar" != "$grupoNom" ]
		then
			echo "Ocurrio un error al crear el grupo"
		else
			echo "El grupo se creo correctamente"
			echo "Se creo el grupo $grupoNom el $d" >> /root/Gestionlogs
		fi
	else
		echo "Error, ya hay un grupo con ese nombre"
fi
