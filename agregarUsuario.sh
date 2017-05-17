#!/bin/bash
echo “Bienvenido al script para la creación de usuarios”
echo “Seleccione que tipo de usuario desea crear”
echo ”1- Cliente”
echo “2- Ejecutivo de ventas”
echo “3- Administrativo”
echo “4- Gerente de sucursal”
echo “5- Gerente general”
echo “0- Cancelar”
read tipoUser
if [ “$tipoUser” == “2” ] || [ “$tipoUser” == “3” ] || [ “$tipoUser” == “4” ] || [ “$tipoUser” == “5” ]
	echo “Ingrese el nombre de usuario”
	read username
	buscar = `cat /etc/passwd | cut -d ‘:’ -f1 | grep $username`
	if [ -z $buscar ]
	then
		echo “Ingrese en que sucursal trabajara”
		echo “1- La Paloma”
		echo “2- Punta del Este”
		echo “3- Tacuarembo”
		echo “4- Colonia”
		echo “0- Cancelar”
		read sucursal
		if [ “$sucursal” -ne “0” ]
		then
			case $sucursal in
			1)
				sucursal = “La Paloma”;;
			2)
				sucursal = “Punta del Este”;;
			3)
				sucursal = “Tacuarembo”;;
			4)
				sucursal = “Colonia”;;
			esac
			echo “Ingrese una clave para el usuario”
			read -s contra
			
			echo “Esta seguro de que desea crear el usuario ’$username’?”
			echo “0- No”
			echo “1- Si”
			read conf
			if [ “$conf” == “1” ]
				case $tipoUser in
				2)
					#echo ‘mysql blabla”;;
				3)
					#echo ‘mysql blabla”;;
				4)
					#echo ‘mysql blabla”;;
				5)
					#echo ‘mysql blabla”;;
				esac
				useradd -p $contra $username
				buscar = `cat /etc/passwd | cut -d ‘:’ -f1 | grep $username`
				if [ -z $buscar ]
				then
					echo “Hubo un error al crear el usuario”
				else
					echo “El usuario se creo correctamente”
					#Log
				fi
			fi
			
	else
		echo “Ya existe un usuario con el nombre que ingreso”
	fi
elif [ “$tipoUser” == “1” ]
	echo “Ingrese el nombre para el usuario”
	read username
	buscar = `cat /etc/passwd | cut -d ‘:’ -f1 | grep $username`
	if [ -z $buscar ]
		echo “Ingrese una clave para el usuario”
		read -s contra
		echo “Esta seguro de que desea crear el usuario ’$username’?”
		echo “0- No”
		echo “1- Si”
		read conf
		if [ “$conf” == “1” ]
			#echo “mysql wea”
			useradd -p $contra $username
			buscar = `cat /etc/passwd | cut -d ‘:’ -f1 | grep $username`
			if [ -z $buscar ]
			then
				echo “Hubo un error al crear el usuario”
			else
				echo “El usuario se creo correctamente”
				#Log
			fi
		fi
	fi
fi
./menuprincipal
