#!/bin/bash
usuarioActual=`logname`
GIDgerentesGenerales=`cat /etc/group | grep "gerentesGenerales" | cut -d ":" -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $usuarioActual`
if [ -z "$confirmarGerenteGeneral" ]
then
	echo "No tiene permisos para remover usuarios de grupos"
else
	echo "Ingrese el nombre del usuario que desea remover del grupo"
	read nomUsuario
	buscar=`cat /etc/passwd | cut -d ":" -f 1 | grep -w $nomUsuario`
	if [ "$nomUsuario" = "$buscar" ]
	then
		echo "Ingrese el nombre del grupo del que quiere removerlo"
		read nomGrupo
		buscar=`cat /etc/group | grep $nomGrupo | cut -d ":" -f 4 | grep $nomUsuario -w`
		if [ -z "$buscar" ]
		then
			read -p "El usuario '$nomUsuario' no se encuentra en el grupo '$nomGrupo' (como grupo secundario). Presione enter para continuar"
		else
			gpasswd -d $nomUsuario $nomGrupo > /dev/null
			buscar=`cat /etc/group | grep $nomGrupo | cut -d ":" -f 4 | grep $nomUsuario -w`
			if [ -z "$buscar" ]
			then
				read -p "El usuario '$nomUsuario' se elimino correctamente del grupo '$nomGrupo'. Presione enter para continuar"
				d=`date +"%H:%M:%S %Y-%m-%d"`
				echo "Removido usuario '$nomUsuario' del grupo '$nomGrupo';$usuarioActual;$d" >> /SISALCA/logs
			else
				read -p "Ocurrio un error al eliminar el usuario del grupo. Presione enter para continuar"
			fi
		fi
	else
		read -p "No existe ningun usuario con el nombre que ingreso. Presione enter para volver al menu principal"
	fi
fi
bash mainmenu.sh
