#!/bin/bash
GIDgerentesGenerales=`cat /etc/group | grep 'gerentesGenerales' | cut -d ':' -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $USER`
if [ -z $confirmarGerenteGeneral ]
then
	permisos='false'
else
	permisos='true'
fi
echo "Seleccione que tipo de usuario desea crear"
echo "1- Gerente general"
echo "2- Ejecutivo de ventas"
echo "3- Administrativo"
echo "4- Gerente de sucursal"
echo "5- Tecnico"
echo "0- Cancelar"
condicion=1
while [ $condicion -eq 1 ]
do
	read tipoUser
	case $tipoUser in
		2|3|4|5)
		condicion=0
		echo "Ingrese el nombre de usuario"
		read username
		buscar=`cut -d ":" -f 1 /etc/passwd | grep $username`
		if [ "$buscar" != "$username" ]
		then
			echo "Ingrese en que sucursal trabajara"
			echo "1- La Paloma"
			echo "2- Punta del Este"
			echo "3- Tacuarembo"
			echo "4- Colonia"
			echo "0- Cancelar"
			condicion=1
			while [ $condicion -eq 1 ]
			do
				read sucursal
				#if [ "$sucursal" != 0 ]
				#then
				case $sucursal in
					0)
					condicion=0;;
					1)
					condicion=0
					sucursal = "laPaloma";;
					2)
					condicion=0
					sucursal = "puntaDelEste";;
					3)
					condicion=0
					sucursal = "tacuarembo";;
					4)
					condicion=0
					sucursal = "colonia";;
					*)
					echo "Ingrese una de las opciones";;
				esac
			done
			mismaSucursal=`cat /etc/group |  grep $sucursal | grep $USER`
			if [ -z $mismaSucursal ]
			then
				mismaSucursal='false'
			else
				mismaSucursal='true'
			fi
			if [ "$sucursal" != 0 ]
			then
				if [ '$mismaSucursal' -eq 'true' ] || [ '$permisos' -eq 'true' ]
				then
					echo "Ingrese una clave para el usuario"
					read -s contra
					echo "Esta seguro de que desea crear el usuario '$username'?"
					echo "0- No"
					echo "1- Si"
					condicion=1
					while [ $condicion -eq 1 ]
					do
						read conf
						if [ $conf -eq 1 ] || [ $conf -eq 0 ]
						then
							condicion=0
						else
							echo "Ingrese 1 o 0 para continuar"
						fi
					done
					if [ "$conf" = 1 ]
					then
						case $tipoUser in
							2)
							tipoUser="ejecutivosVentas";;
							3)
							tipoUser="administrativos"s;;
							4)
							tipoUser="gerentesSucursal";;
							5)
							tipoUser="tecnicos";;
						esac
						if [ "$tipoUser" -eq "gerentesSucursal" ]
						then
							useradd -p $contra -g $tipoUser -G gerentes,$sucursal $username
						else
							useradd -p $contra -g $tipoUser -G $sucursal $username
						fi
						buscar = `cat /etc/passwd | cut -d ':' -f1 | grep $username`
						if [ "$buscar" = "$username" ]
						then
							echo "El usuario se creo correctamente"
							d=`date + '%H:%M:%S %Y-%m-%d'`
							case $tipoUser in
								2)
								echo "Creado el usuario ejecutivo de ventas '$username' de '$sucursal';$USER;$d" >> /SISALCA/logs;;
								3)
								echo "Creado el usuario administrativo '$username' de '$sucursal';$USER;$d" >> /SISALCA/logs;;
								4)
								echo "Creado el usuario gerente de sucursal '$username' de '$sucursal';$USER;$d" >> /SISALCA/logs;;
								5)
								echo "Creado el usuario gerente general '$username' de '$sucursal';$USER;$d" >> /SISALCA/logs;;
							esac
						else
							echo "Se produjo un error"
						fi
					fi
				else
					echo "No tiene permisos para crear este usuario"
				fi
			fi
		else
			echo "Ya existe un usuario con el nombre que ingreso"
		fi;;
		1)
		if [ '$permisos' -eq 'true' ]
		then
			condicion=0
			echo "Ingrese el nombre para el usuario"
			read username
			buscar=`cut -d ":" -f 1 /etc/passwd | grep $username`
			if [ "$buscar" != "$username" ]
			then
				echo "Ingrese una clave para el usuario"
				read -s contra
				echo "Esta seguro de que desea crear el usuario ’$username’?"
				echo "0- No"
				echo "1- Si"
				condicion=1
				while [ $condicion -eq 1 ]
				do
					read conf
					case $conf in
						1)
						condicion=0;;
						0)
							condicion=0;;
							*)
							echo "Debe ingresar una de las opciones validas";;
						esac
					done
					if [ "$conf" = 1 ]
					then
				#echo “mysql wea”
					tipoUser="gerentesGenerales"
					useradd -p $contra -g $tipoUser -G gerentes $username
					buscar=`cut -d ":" -f 1 /etc/passwd | grep $username`
					if [ "$buscar" = "$username" ]
					then
						echo "El usuario se creo correctamente"
						d=`date + '%H:%M:%S %Y-%m-%d'`
						echo "Se creo el usuario gerente general '$username';$USER;$d" >> /SISALCA/logs
					else
						echo "Se produjo un error al crear el usuario"
					fi
				fi
  		else
				echo "Ya existe un usuario con ese nombre"
			fi;;
		else
			echo "No tiene permisos para crear gerentes generales"
		fi
		*) echo "Ingrese una de las opciones";;
	esac
done
./mainmenu.sh
