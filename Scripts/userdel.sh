#!/bin/bash
GIDgerentesGenerales=`cat /etc/group | grep 'gerentesGenerales' | cut -d ':' -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $USER`
if [ -z $confirmarGerenteGeneral ]
then
	permisos='false'
else
	permisos='true'
fi
echo "Ingrese el nombre del usuario a ser borrado"
read username
sucursal1=`cat /etc/group |  grep 'laPaloma' | grep $username | grep $USER`
sucursal2=`cat /etc/group |  grep 'tacuarembo' | grep $username | grep $USER`
sucursal3=`cat /etc/group |  grep 'colonia' | grep $username | grep $USER`
sucursal4=`cat /etc/group |  grep 'puntaDelEste' | grep $username | grep $USER`
if [ -z $sucursal1 ] || [ -z $sucursal2 ] || [ -z $sucursal3 ] || [ -z $sucursal4 ] || [ '$permisos' -ne 'true' ]
then
	echo "No tiene permisos para eliminar el usuario $username"
else
	buscar=`cut -d ‘:’ -f 1 /etc/passwd| grep $username`
	if [ "$buscar" = "$username" ]
	then
		echo "Esta seguro de que desea borrar el usuario $username ?"
		echo "0 - Cancelar"
		echo "1 - Confirmar"
		echo ""
		condicion=1
		while [ $condicion -eq 1 ]
		do
			read choice
			if [ $choice -eq 1 ] || [ $choice -eq 0 ]
			then
				condicion=0
			else
				echo "Elija 0 para cancelar o 1 para confirmar"
			fi
		done
		if [ "$choice" = 1 ]
		then
			userdel $username
			if [ "$buscar" != "$username"]
				echo "Usuario eliminado correctamente"
				d=`date + '%H:%M:%S %Y-%m-%d'`
				echo "Eliminado usuario '$username';$USER;$d" >> /SISALCA/logs
			fi
		else
			echo "Se produjo un error al borrar el usuario"
		fi
	else
		echo "No existe tal usuario"
	fi
fi
./mainmenu.sh
