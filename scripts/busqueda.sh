#!/bin/bash
servidor[1]=srv1-difusas.esy.es
servidor[2]=srv2-difusas.16mb.com
servidor[3]=srv3-difusas.pe.hu
servidor[4]=srv4-difusas.890m.com
usuario[1]=u427372086
usuario[2]=u739500485
usuario[3]=u818241799
usuario[4]=u389049874
pc=1
ruta="$HOME"/php-shell/resultados
if [ "$1" == "" ];then
        echo "Debe ingresar como parametro el nombre de la canción o artista"
        exit 0
fi
echo -e "\e[1;33mSe realizo la busqueda de $1\e[0m"
echo -e "\e[31m ******** Servidor $pc  ********\e[0m"
"$HOME"/local.sh "$1"
for (( i=1; i<=4; i++ ))
do
  if [ $i != $pc ];then
    echo -e "\e[31m ******** Servidor $i  ********\e[0m"
    rm -Rf "$ruta"/pc$i.txt
    ssh -p 65002 ${usuario[$i]}@${servidor[$i]} "./local.sh $1" > "$ruta"/pc$i.txt
    cat "$ruta"/pc$i.txt
  fi
done
echo -e "\e[31m ******** Resultados  ********\e[0m"
rm -rf "$ruta"/resumen.txt
cat "$ruta"/pc?.txt|awk -F ';' '{a[$1] += $2 } END {for (i in a) print i, ";", a[i]}' > "$ruta"/resumen.txt
cat "$ruta"/resumen.txt
exit 0