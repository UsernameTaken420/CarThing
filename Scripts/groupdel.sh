#!/bin/bash
echo "Ingrese el nombre del grupo que desea modificar"
read nomGrupo
buscar=`cut -d ":" -f 1 /etc/group | grep $nomGrupo`
if [ "$buscar" != "$nomGrupo" ]
then
	echo "No existe ningun grupo con el nombre que ingreso"
else
	IDgrupo=`cat /etc/group | grep $nomGrupo | cut -d ':' -f 3`
	buscar=`cut -d ':' -f 4 /etc/passwd | grep $IDgrupo`
	if [ -z $buscar ]
	then
		buscar=`cat /etc/group | grep $IDgrupo | cut -d ':'-f 4` 
		if [ -z $buscar ]
		then	
			groupdel $nomGrupo
			buscar=`cut -d ":" -f 1 /etc/group | grep $nomGrupo`
			if [ "$buscar" != "$nomGrupo" ]
			then
				echo "El grupo se elimino correctamente"
				echo "Se elimino el grupo $nomGrupo el $d" >> /root/Gestionlogs
			else
				echo "Ocurrio un error al eliminar el grupo"
			fi
		else
			echo "No se puede eliminar el grupo $nomGrupo porque existen usuarios que lo tienen como grupo secundario"
		fi
	else
		echo "No se puede eliminar el grupo $nomGrupo porque existen usuarios que lo tienen como grupo primario"
	fi
fi
