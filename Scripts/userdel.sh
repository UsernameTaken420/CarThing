#!/bin/bash
echo "Ingrese el nombre del usuario a ser borrado"
read username
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
./mainmenu.sh
