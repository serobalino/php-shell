#!/bin/bash
usuario=whoami
pc=3
ruta="`pwd`"
echo $ruta

d0=`cat "$ruta"/consulta|head -n 1`
d2i=0

while [[ $d2 != 0 ]]; do

d1=`cat "$ruta"/consulta|head -n 1`
d2=`cat "$ruta"/consulta|tail -n 1`
#echo $d1
#echo $d2
#echo $d0
#echo $d2i

sleep 2
if [ "$d2" -gt "$d2i" ]
then
d2i=$(($d2i+1))
dcontrol=`cat "$ruta"/consulta|head -n 1`
if [[ "$dcontrol" != "" ]]; then
    grep -i $d1 "$ruta"/pc$pc/*|grep -v -i "Coincidencia en el archivo binario"|sed s/";"/"_"/g|awk -F "/" {' print $NF '}|awk -F "," {' print $1 '}|sort|uniq -c|sort -n -r|sed 's/^[[:space:]]*//'|sed s/" "/";"/|awk -F ";"  {' print awk $2";"$1 '}|sort > "$ruta"/pc$pc.txt
    #sleep 10
    echo "archivo pc$pc generado"
    echo "pc$pc;"$d2i >> "$ruta"/res
    fi
    if [ $d1 != $d0 ]
    then 
    echo "pc1;"$d2 >> "$ruta"/res
    d0=`cat "$ruta"/consulta|head -n 1`
    fi
fi
done
