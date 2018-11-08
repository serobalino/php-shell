#!/bin/bash
usuario=`whoami`
ruta="`pwd`"

if [ -s "$ruta"/contador ];
	then
	contador=`cat "$ruta"/contador`
else 
	echo 0 > "$ruta"/contador
fi

echo "" > "$ruta"/res

contador=$(($contador+1))
echo $contador > "$ruta"/contador

echo $1 > "$ruta"/consulta
echo $contador >> "$ruta"/consulta

pc1=0
pc2=0
pc3=0
pc4=0


while [[ $pc1 != $contador || $pc2 != $contador || $pc3 != $contador || $pc4 != $contador ]];
do
	sleep 2
	pc1=`cat "$ruta"/res|grep pc1|head -n 1|awk -F ";" {' print $2 '}`
	pc2=`cat "$ruta"/res|grep pc2|head -n 1|awk -F ";" {' print $2 '}`
	pc3=`cat "$ruta"/res|grep pc3|head -n 1|awk -F ";" {' print $2 '}`
	pc4=`cat "$ruta"/res|grep pc4|head -n 1|awk -F ";" {' print $2 '}`
	
done

if [[ $pc1 == $contador || $pc2 == $contador || $pc3 == $contador || $pc4 == $contador ]];
then
	for i in `seq 1 4`; do
	echo "Clave valor recibido de PC$i -----------------------------------------"
	cat "$ruta"/pc$i.txt
	done

	cat "$ruta"/pc?.txt|awk -F ';' '{a[$1] += $2 } END {for (i in a) print i, ";", a[i]}' > "$ruta"/clave-valor-total.txt
	echo "Clave valor total ooooooooooooooooooooooooooooooooooooooooooooooooo"
	cat "$ruta"/clave-valor-total.txt
else 
	"Mensaje de Master: PCs con datos erroneos" > "$ruta"/clave-valor-total.txt
fi
	

