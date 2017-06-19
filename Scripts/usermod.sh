#!/bin/bash
GIDgerentesGenerales=`cat /etc/group | grep 'gerentesGenerales' | cut -d ':' -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $USER`
if [ -z $confirmarGerenteGeneral ]
then
	permisos='false'
else
	permisos='true'
fi
echo "Ingrese el nombre de usuario anterior"
read username
sucursal1=`cat /etc/group |  grep 'laPaloma' | grep $username | grep $USER`
sucursal2=`cat /etc/group |  grep 'tacuarembo' | grep $username | grep $USER`
sucursal3=`cat /etc/group |  grep 'colonia' | grep $username | grep $USER`
sucursal4=`cat /etc/group |  grep 'puntaDelEste' | grep $username | grep $USER`
if [ -z $sucursal1 ] || [ -z $sucursal2 ] || [ -z $sucursal3 ] || [ -z $sucursal4 ] || [ '$permisos' -ne 'true' ]
then
	echo "No tiene permisos para modificar el usuario $username"
else
	buscar=`cut -d ":" -f 1 /etc/passwd | grep "$username"`
	if [ "$buscar" = "$username" ]
	then
		echo "Ingrese el nuevo nombre del usuario"
		read newUsername
		buscar=`cut -d ":" -f 1 /etc/passwd | grep $newUsername`
		if [ "$buscar" != "$newUsername"]
		then
			usermod -l $newUsername $username
			buscar=`cut -d ":" -f 1 /etc/passwd | grep $newUsername`
			if [ "$buscar" = "$newUsername" ]
			then
				echo "El nombre de usuario ha sido cambiado exitosamente"
				d=`date + '%H:%M:%S %Y-%m-%d'`
				echo "Modificado nombre del usuario '$username' a '$newUsername';$USER;$d" >> /SISALCA/logs
			else
				echo "Se produjo un error"
			fi
		else
			echo "El nombre de usuario ya esta en uso"
		fi
	else
		echo "El usuario no existe"
	fi
fi
./mainmenu.sh
