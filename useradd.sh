#!/bin/bash
echo “Seleccione que tipo de usuario desea crear”
echo ”1- Cliente”
echo “2- Ejecutivo de ventas”
echo “3- Administrativo”
echo “4- Gerente de sucursal”
echo “5- Gerente general”
echo “0- Cancelar”
read tipoUser
case $tipoUser in
	2|3|4|5)
		echo “Ingrese el nombre de usuario”
		read username
		buscar=`cut -d ":" -f 1 /etc/passwd | grep $username`
		if [ "$buscar" != "$username" ]
		then
			echo “Ingrese en que sucursal trabajara”
			echo “1- La Paloma”
			echo “2- Punta del Este”
			echo “3- Tacuarembo”
			echo “4- Colonia”
			echo “0- Cancelar”
			read sucursal
			if [ “$sucursal” != 0 ]
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
				if [ “$conf” = 1 ]
					then
					useradd -p $contra $username
					buscar = `cat /etc/passwd | cut -d ‘:’ -f1 | grep $username`
					d=`date +%S%M%H%d%m%y`
					if [ "$buscar" = "$username" ]
					then
						echo “El usuario se creo correctamente”
						case $tipoUser in
							2)
							echo "Se creo el usuario ejecutivo de ventas $username de $sucursal el $d" >> /root/Gestionlogs;;
							3)
							echo "Se creo el usuario administrativo $username de $sucursal el $d" >> /root/Gestionlogs;;
							4)
							echo "Se creo el usuario gerente de sucursal $username de $sucursal el $d" >> /root/Gestionlogs;;
							5)
							echo "Se creo el usuario gerente general $username de $sucursal el $d" >> /root/Gestionlogs;;
						esac
					else
						echo “Se produjo un error”
					fi
				fi
			fi
	else
		echo “Ya existe un usuario con el nombre que ingreso”
	fi;;
	1)
	echo “Ingrese el nombre para el usuario”
	read username
	buscar=`cut -d ":" -f 1 /etc/passwd | grep $username`
	if [ "$buscar" != "$username" ]
		echo “Ingrese una clave para el usuario”
		read -s contra
		echo “Esta seguro de que desea crear el usuario ’$username’?”
		echo “0- No”
		echo “1- Si”
		read conf
		if [ “$conf” = 1 ]
			#echo “mysql wea”
			useradd -p $contra $username
			buscar=`cut -d ":" -f 1 /etc/passwd | grep $username`
			if [ "$buscar" = "$username" ]
			then
				echo “El usuario se creo correctamente”
				d=`date +%S%M%H%d%m%y`
				echo "Se creo el usuario cliente $username el $d" >> /root/Userlogs
			else
				echo “Se produjo un error al crear el usuario”
			fi
		fi
  else
		echo "Ya existe un usuario con ese nombre"
	fi;;
esac
