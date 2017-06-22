#!/bin/bash
echo "Ingrese el nombre del grupo que desea ver sus integrantes"
read nomGrupo
buscar=`cut -d ":" -f 1 /etc/group | grep -w $nomGrupo`
if [ -n "$buscar" ]
then
	IDgrupo=`cat /etc/group | grep $nomGrupo | cut -d ":" -f 3`
	buscarEnPasswd=`cat /etc/passwd | grep "$IDgrupo" | cut -d ":" -f 1`
	buscarEnGroup=`cat /etc/group | grep $nomGrupo | cut -d ":" -f 4`
	if [ -z "$buscarEnGroup" ] && [ -z "$buscarEnPasswd" ]
	then
		echo "El grupo que ingreso no tiene ningun integrante"
		read -p "Presione enter para volver al menu principal"
		bash mainmenu.sh
	else
		echo "Los integrantes de $nomGrupo son:"
		echo "$buscarEnGroup"
		echo "$buscarEnPasswd"
		echo "Presione enter para volver al menu principal"
		read volver
		bash mainmenu.sh
	fi
else
	echo "No existe ningun grupo con el nombre ingresado"
	read -p "Presione enter para volver al menu principal"
	bash mainmenu.sh
fi
