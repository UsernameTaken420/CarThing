#!/bin/bash
usuarioActual=`logname`
GIDgerentesGenerales=`cat /etc/group | grep "gerentesGenerales" | cut -d ":" -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $usuarioActual`
if [ -z "$confirmarGerenteGeneral" ]
then
	read -p "No tiene permisos crear grupos, presione enter para continuar"
else
	echo "Ingrese el nombre del grupo que desea agregar"
	read grupoNom
	buscar=`cut -d ":" -f 1 /etc/group | grep -w $grupoNom`
	if [ "$buscar" != "$grupoNom" ]
	then
		groupadd $grupoNom
		buscar=`cut -d ":" -f 1 /etc/group | grep $grupoNom`
		if [ "$buscar" != "$grupoNom" ]
		then
			read -p "Ocurrio un error al crear el grupo, presione enter para continuar"
		else
			read -p "El grupo se creo correctamente, presione enter para continuar"
			d=`date + "%H:%M:%S %Y-%m-%d"`
			echo "Creado grupo '$grupoNom';$usuarioActual;$d" >> /SISALCA/logs
		fi
	else
		read -p "Error, ya hay un grupo con ese nombre. Presione enter para continuar"
	fi
fi
bash mainmenu.sh
