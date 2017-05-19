#!/bin/bash
echo “Ingrese el nombre de usuario anterior”
read username
buscar = `cut -d ‘:’ -f 1 /etc/passwd | grep $username`
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
			else
				echo "Se produjo un error"
			fi
	else
			echo "El nombre de usuario ya esta en uso"
	fi
else
	echo "El usuario no existe"
fi
