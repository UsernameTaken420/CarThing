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
echo "Ingrese el nombre del usuario a ser borrado"
read username
sucursal1=`cat /etc/group |  grep "laPaloma" | grep $username | grep $usuarioActual`
sucursal2=`cat /etc/group |  grep "tacuarembo" | grep $username | grep $usuarioActual`
sucursal3=`cat /etc/group |  grep "colonia" | grep $username | grep $usuarioActual`
sucursal4=`cat /etc/group |  grep "puntaDelEste" | grep $username | grep $usuarioActual`
if [ -z "$sucursal1" ] && [ -z "$sucursal2" ] && [ -z "$sucursal3" ] && [ -z "$sucursal4" ] && [ "$permisos" != "true" ]
then
	read -p "No tiene permisos para eliminar el usuario '$username', presione enter para continuar"
else
	buscar=`cut -d ':' -f 1 /etc/passwd | grep $username`
	if [ "$buscar" = "$username" ]
	then
		echo "Esta seguro de que desea borrar el usuario '$username' ?"
		echo "0 - Cancelar"
		echo "1 - Confirmar"
		echo ""
		condicion=1
		while [ $condicion -eq 1 ]
		do
			read choice
			if [ "$choice" = "1" ] || [ "$choice" = "0" ]
			then
				condicion=0
			else
				echo "Elija 0 para cancelar o 1 para confirmar"
			fi
		done
		if [ "$choice" = "1" ]
		then
			userdel $username
			buscar=`cut -d ":" -f 1 /etc/passwd | grep $username`
			if [ "$buscar" != "$username" ]
			then
				read -p "Usuario eliminado correctamente, presione enter para continuar"
				d=`date + "%H:%M:%S %Y-%m-%d"`
				echo "Eliminado usuario '$username';$usuarioActual;$d" >> /SISALCA/logs

			else
				read -p "Se produjo un error al borrar el usuario, presione enter para continuar"
			fi
		fi
	else
		read -p "No existe tal usuario, presione enter para contnuar"
	fi
fi
bash mainmenu.sh
