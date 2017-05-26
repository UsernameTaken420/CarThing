#!/bin/bash
echo “Ingrese el nombre de usuario anterior”
read username
d=`date +%S%M%H%d%m%y`
if [ "$buscar" = "$username" ]
then
	echo "Ingrese el nuevo nombre del usuario"
	read newUsername
	buscar=`cut -d ":" -f 1 /etc/passwd | grep "$newUsername"`
	if [ "$buscar" != "$newUsername"]
	then
			usermod -l $newUsername $username
			buscar=`cut -d ":" -f 1 /etc/passwd | grep $newUsername`
			if [ "$buscar" = "$newUsername" ]
			then
				echo "El nombre de usuario ha sido cambiado exitosamente"
				echo "Se cambio el nombre del usuario $username a $newUsername el $d" >> /root/Userlogs
			else
				echo "Se produjo un error"
			fi
	else
			echo "El nombre de usuario ya esta en uso"
	fi
else
	echo "El usuario no existe"
fi
