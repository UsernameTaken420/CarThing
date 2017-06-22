#!/bin/bash
echo 'Ingrese el nombre del usuario que desea saber a que grupo pertenece'
read nomUsuario
buscar=`cut -d ':' -f 1 /etc/passwd | grep -w $nomUsuario`
echo $nomUsuario
echo $buscar
if [ -n "$buscar" ]
then
	usuarioGID=`cat /etc/passwd | grep $nomUsuario | cut -d ':' -f 4`
	grupoPrimario=`cat /etc/group | grep $usuarioGID | cut -d ':' -f 1`
	echo "El grupo primario de $nomUsuario es $grupoPrimario"
 	gruposSecundarios=`cat /etc/group | grep $nomUsuario | cut -d ':' -f 1`
	if [ -z "$gruposSecundarios" ]
	then
		echo "El usuario $nomUsuario no pertenece a ningun grupo secundario"
    		./mainmenu.sh
	else
		echo "Los grupos secundarios a los que pertenece son:"
		echo "$gruposSecundarios"
		echo 'Presione enter para volver al menu principal'
		read volver
		bash mainmenu.sh
	fi
else
	echo "No existe ningun usuario con el nombre que ingreso"
	read -p "Presione enter para volver al menu principal"
	bash mainmenu.sh
fi
