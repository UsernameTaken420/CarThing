#!/bin/bash
echo "Bienvenido al menu principal de administracion de usuarios"
echo "Seleccione que desea hacer:"
echo "1- Crear un usuario"
echo "2- Borrar un usuario"
echo "3- Cambiar el nombre de un usuario"
echo "4- Cambiar la contraseña de un usuario"
echo "5- Crear un grupo"
echo "6- Borrar grupo"
echo "7- Agregar usuario a un grupo"
echo "8- Borrar usuario de un grupo"
echo "9- Ver todos los usuarios de un grupo"
echo "10- Ver los grupos a los que pertenece un usuario"
echo "0- Salir"
condicion=1
while [ $condicion -eq 1 ]
do
	read choice
	case $choice in
		1) condicion=0
		bash useradd.sh;;
		2) condicion=0
		bash userdel.sh;;
		3) condicion=0
		bash usermod.sh;;
		4) condicion=0
		bash passmod.sh;;
		5) condicion=0
		bash groupadd.sh;;
		6) condicion=0
		bash groupdel.sh;;
		7) condicion=0
		bash addusertogroup.sh;;
		8) condicion=0
		bash removeuserfromgroup.sh;;
  	9) condicion=0
		bash groupmembers.sh;;
		10) condicion=0
		bash usergroups.sh;;
		0) condicion=0;;
		*) echo "Ingrese una de las opciones";;
	esac
done
