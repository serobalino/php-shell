#!/bin/bash
pc=1
ruta="$HOME"/php-shell/data/pc"$pc"
ruta2="$HOME"/php-shell/resultados
mkdir -p "$ruta2"
rm -Rf "$ruta2"/pc$pc.txt
grep -i "$1" $ruta/*|grep -v -i "Coincidencia en el archivo binario"|sed s/";"/"_"/g|awk -F "/" {' print $NF '}|awk -F "," {' print $1 '}|sort|uniq -c|sort -n -r|sed 's/^[[:space:]]*//'|sed s/" "/";"/|awk -F ";"  {' print awk $2";"$1 '}|sort > "$ruta2"/pc$pc.txt
cat "$ruta2"/pc$pc.txt
exit 0