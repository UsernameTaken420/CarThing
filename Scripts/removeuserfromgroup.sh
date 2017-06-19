#!/bin/bash
GIDgerentesGenerales=`cat /etc/group | grep 'gerentesGenerales' | cut -d ':' -f 3`
confirmarGerenteGeneral=`cat /etc/passwd |  grep $GIDgerentesGenerales | grep $USER`
if [ -z $confirmarGerenteGeneral ]
then
	echo "No tiene permisos para remover usuarios de grupos"
else
  echo 'Ingrese el nombre del usuario que desea remover del grupo'
  read nomUsuario
  buscar=`cat /etc/passwd | cut -d ':' -f 1 | grep -w $nomUsuario`
  if [ '$nomUsuario' -eq '$buscar' ]
  then
    echo "Ingrese el nombre del grupo del que quiere removerlo"
    read nomGrupo
    buscar=`cat /etc/group | grep $nomGrupo | cut -d ':' -f 4 | grep $nomUsuario -w`
    if [ -z $buscar ]
    then
      echo 'El usuario $nomUsuario no se encuentra en el grupo $nomGrupo (como grupo secundario)'
    else
      gpasswd -d $nomUsuario $nomGrupo
      buscar=`cat /etc/group | grep $nomGrupo | cut -d ':' -f 4 | grep $nomUsuario -w`
      if [ -z $buscar ]
      then
        echo 'El usuario $nomUsuario se elimino correctamente del grupo $nomGrupo'
        d=`date + '%H:%M:%S %Y-%m-%d'`
        echo "Removido usuario '$nomUsuario' del grupo '$nomGrupo';$USER;$d" >> /SISALCA/logs
      else
        echo 'Ocurrio un error al eliminar el usuario del grupo'
      fi
    fi
  else
    echo 'No existe ningun usuario con el nombre que ingreso'
  fi
fi
./mainmenu.sh
