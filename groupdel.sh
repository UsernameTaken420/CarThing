#!/bin/bash
echo "Ingrese el nombre del grupo que desea modificar"
read nomGrupo
buscar=`cut -d ":" -f 1 /etc/group | grep $nomGrupo`
if [ "$buscar" != "$nomGrupo" ]
then
	echo "No existe ningun grupo con el nombre que ingreso"
else
	groupdel $nomGrupo
	buscar=`cut -d ":" -f 1 /etc/group | grep $nomGrupo`
	if [ "$buscar" != "$nomGrupo" ]
	then
		echo "El grupo se elimino correctamente"
		echo "Se elimino el grupo $nomGrupo el $d" >> /root/Gestionlogs
	fi
fi
