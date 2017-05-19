#!/bin/bash
echo “Ingrese que dato desea modificar del usuario”
echo “1- Nombre de usuario”
echo “2- Clave”
echo “0- Cancelar”
read modif
case $modif in
1)
	echo “Ingrese el nombre de usuario anterior”
	read username
	buscar = `cat /etc/passwd | cut -d ‘:’ -f1 | grep $username`
	if [ $buscar -z ]
	then
		echo “No existe ningún usuario con el nombre que ingreso”
	else
		echo “Ingrese el nuevo nombre de usuario”
		read newUsername
		buscar = `cat /etc/passwd | cut -d ‘:’ -f1 | grep $newUsername`
		if [ $buscar -z ]
		then
			usermod -l $newUsername $username
			#mysql
			buscar = `cat /etc/passwd | cut -d ‘:’ -f1 | grep $newUsername`
			if [ $buscar -z ] 
			then
				echo “Ocurrió un error al cambiar el nombre de usuario”
			else
				echo	“El nombre de usuario se cambio correctamente”
				#Log
			fi
		else
			echo “No se puede cambiar el nombre de usuario porque ya existe un usuario con el nombre que ingreso”
		fi
	fi;;
2)
	echo “Ingrese el nombre del usuario al que desea cambiar la clave”
	read username
	buscar = `cat /etc/passwd | cut -d ‘:’ -f1 | grep $username`
	if [ $buscar -z ]
	then
		echo “No existe ningún usuario con el nombre que ingreso”
	else
		echo “Ingrese la nueva clave”
		read -s clave
		echo “Esta seguro que desea cambiar la clave?”
		echo ”0- Cancelar”
		echo “1- Confirmar”
		read sure
		if [ “$sure” == “1” ]
			usermod -p “$clave” $username
			#Log
			echo “La clave se cambio correctamente”
		fi
	fi;;
esac
./menuPrincipal
		
