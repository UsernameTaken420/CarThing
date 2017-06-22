#!/bin/bash
usuarioActual=`logname`
GIDgerentesGenerales=`cat /etc/group | grep "gerentesGenerales" | cut -d ":" -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $usuarioActual`
if [ -z "$confirmarGerenteGeneral" ]
then
	read -p "No tiene permisos para agregar usuarios a grupos. Presione enter para continuar"
else
	echo "Ingrese el grupo al que desea agregar el nuevo usuario"
	read grupoNom
	buscar=`cut -d ":" -f 1 /etc/group | grep $grupoNom`
	if [ "$buscar" != "$grupoNom" ]
	then
		read -p "El grupo que ingreso no existe. Presione enter para continuar"
	else
		echo "Ingrese el nombre del usuario que desea agregar al grupo"
		read userNom
		buscar=`cut -d ":" -f 1 /etc/passwd | grep -w $userNom`
		buscarg=`cat /etc/group | grep $grupoNom | cut -d ":" -f 4 | grep $userNom`
		if [ "$buscar" != "$userNom" ]
		then
			read -p "No hay ningún usuario que se llame así. Presione enter para continuar"
		elif [ -z "$buscarg" ]
		then
			usermod -G $grupoNom -a $userNom
			buscar=`cut -d ":" -f 4 /etc/group | grep -w $userNom`
			if [ -z "$buscar" ]
			then
				read -p "Ha ocurrido un error al agregar el usuario al grupo. Presione enter para continuar"
			else
				read -p "El usuario se agrego correctamente. Presione enter para continuar"
				d=`date + "%H:%M:%S %Y-%m-%d"`
				echo "Usuario '$userNom' agregado al grupo "$grupoNom";$usuarioActual;$d" >> /SISALCA/logs
			fi
		else
			read -p "El usuario ya está en ese grupo. Presione enter para continuar"
		fi
	fi
fi
bash mainmenu.sh
