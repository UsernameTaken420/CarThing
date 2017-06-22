#!/bin/bash
groupadd gerentesGenerales
groupadd gerentesSucursal
groupadd administrativos
groupadd ejecutivosVentas
groupadd tecnicos
groupadd laPaloma
groupadd puntaDelEste
groupadd tacuarembo
groupadd gerentes
clave=`openssl passwd -crypt Clave123`
useradd -m -p $clave -g gerentesGenerales -G gerentes Gerente
