#!/bin/bash
usuarioActual=`logname`
GIDgerentesGenerales=`cat /etc/group | grep "gerentesGenerales" | cut -d ":" -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $usuarioActual`
if [ -z "$confirmarGerenteGeneral" ]
then
	read -p "No tiene permisos para eliminar grupos. Presione enter para continuar"
else
	echo "Ingrese el nombre del grupo que desea eliminar"
	read nomGrupo
	buscar=`cut -d ":" -f 1 /etc/group | grep -w $nomGrupo`
	if [ "$buscar" != "$nomGrupo" ]
	then
		read -p "No existe ningun grupo con el nombre que ingreso. Presione enter para continuar"
	else
		IDgrupo=`cat /etc/group | grep $nomGrupo | cut -d ":" -f 3`
		buscar=`cut -d ":" -f 4 /etc/passwd | grep $IDgrupo`
		if [ -z "$buscar" ]
		then
			buscar=`cat /etc/group | grep $IDgrupo | cut -d ":" -f 4`
			if [ -z "$buscar" ]
			then
				groupdel $nomGrupo
				buscar=`cut -d ":" -f 1 /etc/group | grep $nomGrupo`
				if [ "$buscar" != "$nomGrupo" ]
				then
					read -p "El grupo se elimino correctamente. Presione enter para continuar"
					d=`date +"%H:%M:%S %Y-%m-%d"`
					echo "Eliminado grupo '$nomGrupo';$usuarioActual;$d" >> /SISALCA/logs
				else
					read -p "Ocurrio un error al eliminar el grupo. Presione enter para continuar"
				fi
			else
				read -p "No se puede eliminar el grupo '$nomGrupo' porque existen usuarios que lo tienen como grupo secundario. Presione enter para continuar"
			fi
		else
			read -p "No se puede eliminar el grupo '$nomGrupo' porque existen usuarios que lo tienen como grupo primario. Presione enter pra continuar"
		fi
	fi
fi
bash mainmenu.sh
