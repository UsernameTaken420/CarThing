#!/bin/bash
clear
usuarioActual=`logname`
GIDgerentesGenerales=`cat /etc/group | grep "gerentesGenerales" | cut -d ":" -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $usuarioActual`
echo $usuarioActual
echo "$confirmarGerenteGeneral"
if [ -z "$confirmarGerenteGeneral" ]
then
	permisos="false"
else
	permisos="true"
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
		if [ -z "$buscar" ]
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
				case $sucursal in
				0)
				condicion=0;;
				1)
				condicion=0
				sucursal="laPaloma";;
				2)
				condicion=0
				sucursal="puntaDelEste";;
				3)
				condicion=0
				sucursal="tacuarembo";;
				4)
				condicion=0
				sucursal="colonia";;
				*)
				echo "Ingrese una de las opciones";;
				esac
			done
			mismaSucursal=`cat /etc/group |  grep $sucursal | grep $USER`
			if [ -z $mismaSucursal ]
			then
				mismaSucursal="false"
			else
				mismaSucursal="true"
			fi
			if [ "$sucursal" != "0" ]
			then
				if [ "$mismaSucursal" = "true" ] || [ "$permisos" = "true" ]
				then
					echo "Ingrese una clave para el usuario"
					read -s contra
					claveEncriptada=`openssl passwd -crypt $contra`
					echo "Esta seguro de que desea crear el usuario '$username'?"
					echo "0- No"
					echo "1- Si"
					condicion=1
					while [ $condicion -eq 1 ]
					do
						read conf
						if [ "$conf" = 1 ] || [ "$conf" = 0 ]
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
						tipoUser="administrativos";;
						4)
						tipoUser="gerentesSucursal";;
						5)
						tipoUser="tecnicos";;
						esac
						if [ "$tipoUser" = gerentesSucursal ]
						then
							useradd -m -p $claveEncriptada -g $tipoUser -G gerentes,$sucursal $username
						else
							useradd -m -p $claveEncriptada -g $tipoUser -G $sucursal $username
						fi
						buscar=`cat /etc/passwd | cut -d ":" -f1 | grep $username`
						if [ "$buscar" = "$username" ]
						then
							read -p "El usuario se creo correctamente, presione enter para volver al menu principal"
							d=`date + "%H:%M:%S %Y-%m-%d"`
							case $tipoUser in
							"ejecutivosVentas")
							echo "Creado el usuario ejecutivo de ventas '$username' de '$sucursal';$usuarioActual;$d" >> /SISALCA/logs;;
							"administrativos")
							echo "Creado el usuario administrativo '$username' de '$sucursal';$usuarioActual;$d" >> /SISALCA/logs;;
							"gerentesSucursal")
							echo "Creado el usuario gerente de sucursal '$username' de '$sucursal';$usuarioActual;$d" >> /SISALCA/logs;;
							"tecnicos")
							echo "Creado el usuario tecnico '$username' de '$sucursal';$usuarioActual;$d" >> /SISALCA/logs;;
							esac
						else
							read -p "Se produjo un error, presione enter para volver al menu principal"
						fi
					fi
				else
					read -p "No tiene permisos para crear este usuario"
				fi
		fi
	else
		read -p "Ya existe un usuario con el nombre que ingreso, presione enter para volver al menu principal"
	fi
	;;
	1)
	if [ "$permisos" == "true" ]
	then
		condicion=0
		echo "Ingrese el nombre para el usuario"
		read username
		buscar=`cut -d ":" -f 1 /etc/passwd | grep $username`
		if [ -z "$buscar" ]
		then
			echo "Ingrese una clave para el usuario"
			read -s contra
			echo "Esta seguro de que desea crear el usuario '$username'?"
			echo "0- No"
			echo "1- Si"
			condicion=1
			while [ $condicion == 1 ]
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
				tipoUser="gerentesGenerales"
				claveEncriptada=`openssl passwd -crypt $contra`
				useradd -m -p $claveEncriptada -g $tipoUser -G gerentes $username
				buscar=`cut -d ":" -f 1 /etc/passwd | grep $username`
				if [ "$buscar" = "$username" ]
				then
					read -p "El usuario se creo correctamente, presione enter para volver al menu principal"
					d=`date + "%H:%M:%S %Y-%m-%d"`
					echo "Se creo el usuario gerente general '$username';$usuarioActual;$d" >> /SISALCA/logs
				else
					echo "Se produjo un error al crear el usuario"
				fi
			fi
		else
			read -p "Ya existe un usuario con ese nombre, presione enter para volver al menu principal"
		fi
	else
		read -p "No tiene permisos para crear gerentes generales, presione enter para volver al menu principal"
	fi;;
	0) condicion=0;;
	*) echo "Ingrese una de las opciones";;
	esac
done
bash mainmenu.sh
