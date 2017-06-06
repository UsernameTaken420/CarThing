!#/bin/bash
echo "Ingrese el grupo al que desea agregar el nuevo usuario"
read grupoNom
buscar=`cut -d ":" -f 1 /etc/group | grep $grupoNom`
d=`date +%S%M%H%d%m%y`
if [ "$buscar" != "$grupoNom" ]
then
	echo "El grupo que ingreso no existe"
else
	echo "Ingrese el nombre del usuario que desea agregar al grupo"
	read userNom
	buscar=`cut -d ":" -f 1 /etc/passwd | grep $userNom`
	buscarg=`cut -d ":" -f 1 /etc/passwd | grep $userNom`
	if [ "$buscar" != "$userNom" ]
	then
		echo "No hay ningún usuario que se llame así"
	elif [ "$buscarg" != "$userNom" ]
	then
		usermod -G $grupoNom -a $userNom
		buscar=`cut -d ":" -f 4 /etc/group | grep -w $userNom`
		if [ -z $buscar ]
		then
			echo "Ha ocurrido un error al agregar el usuario al grupo"
		else
			echo "El usuario se agrego correctamente"
			echo "El usuario '$userNom' se agrego al grupo '$grupoNom' el '$d'" >> /root/Gestionlogs
		fi
	else
		echo "El usuario ya está en ese grupo"
	fi
fi
