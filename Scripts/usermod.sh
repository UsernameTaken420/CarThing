#!/bin/bash
usuarioActual=`logname`
GIDgerentesGenerales=`cat /etc/group | grep "gerentesGenerales" | cut -d ":" -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $usuarioActual`
if [ -z "$confirmarGerenteGeneral" ]
then
	permisos="false"
else
	permisos="true"
fi
echo "Ingrese el nombre de usuario anterior"
read username
sucursal1=`cat /etc/group |  grep "laPaloma" | grep $username | grep $usuarioActual`
sucursal2=`cat /etc/group |  grep "tacuarembo" | grep $username | grep $usuarioActual`
sucursal3=`cat /etc/group |  grep "colonia" | grep $username | grep $usuarioActual`
sucursal4=`cat /etc/group |  grep "puntaDelEste" | grep $username | grep $usuarioActual`
if [ -z "$sucursal1" ] && [ -z "$sucursal2" ] && [ -z "$sucursal3" ] && [ -z "$sucursal4" ] && [ "$permisos" != "true" ]
then
	read -p "No tiene permisos para modificar el usuario '$username', presione enter para continuar"
else
	buscar=`cut -d ":" -f 1 /etc/passwd | grep "$username"`
	if [ "$buscar" = "$username" ]
	then
		echo "Ingrese el nuevo nombre del usuario"
		read newUsername
		buscar=`cut -d ":" -f 1 /etc/passwd | grep $newUsername`
		if [ -z "$buscar" ]
		then
			usermod -l $newUsername $username
			buscar=`cut -d ":" -f 1 /etc/passwd | grep $newUsername`
			if [ "$buscar" = "$newUsername" ]
			then
				read -p "El nombre de usuario ha sido cambiado exitosamente, presione enter para continuar"
				d=`date +"%H:%M:%S %Y-%m-%d"`
				echo "Modificado nombre del usuario '$username' a '$newUsername';$usuarioActual;$d" >> /SISALCA/logs
			else
				read -p "Se produjo un error, presione enter para continuar"
			fi
		else
			read -p "El nombre de usuario ya esta en uso, presione enter para continuar"
		fi
	else
		read -p "El usuario no existe, presione enter para continuar"
	fi
fi
bash mainmenu.sh
