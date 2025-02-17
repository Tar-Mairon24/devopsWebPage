#!/bin/bash

url=$2
ruta=/home/webdirectory/html/$1

if [ "$EUID" -ne 0 ]; then 
  echo "Permiso denegado"
  exit 1
fi

if [ -d ruta ]; then
  echo "El directorio ya existe"
else
  mkdir -p $ruta
fi 

chown $1:sftpusers $ruta
if [ $? -ne 0 ]; then 
  echo "Error, debes usar un usuario ya existente"
  rm -rf $ruta
  exit 1
fi

cd $ruta

git clone $url

if [ $? -ne 0 ]; then
  echo "Hubo un error, se realiza un rollback"
  rm -rf $ruta
  exit 1
else
  echo "Se realizo correctamente"
  chown -R $1:sftpusers $ruta 
  exit 0
fi
