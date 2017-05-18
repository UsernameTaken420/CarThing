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
	read choice
	if [ $choice = 1]
	then
		userdel $username
	fi
else
	echo "No existe tal usuario"
fi
