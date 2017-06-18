#!/bin/bash
echo "Ingrese el nombre del usuario al que desea cambiarle la clave"
read username
buscar=`cut -d ":" -f 1 /etc/passwd | grep "$username"`
if [ "$buscar" = "$username"]
then
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
else
	echo "El usuario no existe"
fi
./mainmenu.sh
