#!/bin/bash
GIDgerentesGenerales=`cat /etc/group | grep 'gerentesGenerales' | cut -d ':' -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $USER`
if [ -z $confirmarGerenteGeneral ]
then
	echo "No tiene permisos crear grupos"
else
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
fi
./mainmenu.sh
