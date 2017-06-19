#!/bin/bash
GIDgerentesGenerales=`cat /etc/group | grep 'gerentesGenerales' | cut -d ':' -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $USER`
if [ -z $confirmarGerenteGeneral ]
then
	permisos='false'
else
	permisos='true'
fi
echo "Ingrese el nombre del usuario al que desea cambiarle la clave"
read username
buscar=`cut -d ":" -f 1 /etc/passwd | grep "$username"`
if [ "$buscar" = "$username"]
then
	sucursal1=`cat /etc/group |  grep 'laPaloma' | grep $username | grep $USER`
	sucursal2=`cat /etc/group |  grep 'tacuarembo' | grep $username | grep $USER`
	sucursal3=`cat /etc/group |  grep 'colonia' | grep $username | grep $USER`
	sucursal4=`cat /etc/group |  grep 'puntaDelEste' | grep $username | grep $USER`
	if [ -z $sucursal1 ] || [ -z $sucursal2 ] || [ -z $sucursal3 ] || [ -z $sucursal4 ] || [ '$permisos' -ne 'true' ]
	then
		echo "No tiene permisos para cambiar la clave de $username"
	else
		echo "Ingrese la nueva clave"
		read -s clave1
		echo "Ingrese la clave denuevo"
		read -s clave2
		if [ "$clave1" = "$clave2" ]
		then
			usermod -p $clave1 $username
			echo "La clave ha sido cambiada"
			d=`date + '%H:%M:%S %Y-%m-%d'`
			echo "Clave de usuario '$username' modificada;$USER;$d" >> /SISALCA/logs
		else
			echo "Las claves no son iguales"
		fi
	fi
else
	echo "El usuario no existe"
fi
./mainmenu.sh
