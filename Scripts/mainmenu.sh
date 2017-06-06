#!/bin/bash
echo "Bienvenido al menu principal de administracion de usuarios"
echo "Seleccione que desea hacer:"
echo "1- Crear un usuario"
echo "2- Borrar un usuario"
echo "3- Cambiar el nombre de un usuario"
echo "4- Cambiar la contraseña de un usuario"
echo "5- Crear un grupo"
echo "6- Agregar usuario a un grupo"
echo "7- Borrar usuario de un grupo"
echo "8- Borrar grupo"
echo ""
read choice
case $choice in
	1) sh useradd.sh;;
	2) sh userdel.sh;;
	3) sh usermod.sh;;
	4) sh passmod.sh;;
	5) sh groupadd.sh;;
	6) sh addusertogroup.sh;;
	7) #sh hilis
	;;
	8) sh groupdel..sh;;
  *) echo "ERROR";;
esac
