#!/bin/bash
usuarioActual=`logname`
GIDgerentesGenerales=`cat /etc/group | grep "gerentesGenerales" | cut -d ":" -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $usuarioActual`
if [ -z "$confirmarGerenteGeneral" ]
then
	permisos="false"
else
	permisos="true"
fi
echo "Ingrese el nombre del usuario al que desea cambiarle la clave"
read username
buscar=`cut -d ":" -f 1 /etc/passwd | grep "$username"`
if [ "$buscar" = "$username" ]
then
	sucursal1=`cat /etc/group |  grep "laPaloma" | grep $username | grep $usuarioActual`
	sucursal2=`cat /etc/group |  grep "tacuarembo" | grep $username | grep $usuarioActual`
	sucursal3=`cat /etc/group |  grep "colonia" | grep $username | grep $usuarioActual`
	sucursal4=`cat /etc/group |  grep "puntaDelEste" | grep $username | grep $usuarioActual`
	if [ -z "$sucursal1" ] && [ -z "$sucursal2" ] && [ -z "$sucursal3" ] && [ -z "$sucursal4" ] && [ "$permisos" != "true" ]
	then
		read -p "No tiene permisos para cambiar la clave de '$username', presione enter para continuar"
	else
		echo "Ingrese la nueva clave"
		read -s clave1
		echo "Ingrese la clave nuevamente"
		read -s clave2
		if [ "$clave1" = "$clave2" ]
		then
			claveEncriptada=`openssl passwd -crypt $clave1`
			usermod -p $claveEncriptada $username
			read -p "La clave ha sido cambiada, presione enter para continuar"
			d=`date + "%H:%M:%S %Y-%m-%d"`
			echo "Clave de usuario '$username' modificada;$usuarioActual;$d" >> /SISALCA/logs
		else
			read -p "Las claves ingresadas no coinciden, presione enter para continuar"
		fi
	fi
else
	read -p "El usuario no existe ingresado no existe, presione enter para continuar"
fi
bash mainmenu.sh
