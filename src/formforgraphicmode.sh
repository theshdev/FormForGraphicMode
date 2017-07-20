#!/bin/bash

path=$(zenity --entry --title="FFGM" --text="Enter the file path: ")
nper=$(zenity --entry --title="FFGM" --text="How many questions do you want to generate? ")

nperp=$nper
npern=1
while [ $nperp -ne 0 ]; do
	pergunta=$(zenity --entry --title="FFGM" --text="Enter the question: ")
	declare "pergunta$npern=$pergunta"
	npern=$(($npern+1))
	nperp=$(($nperp-1))
done
npern=1
var=1
while true; do
	varp="pergunta$var"
	resposta=$(zenity --entry --title="FFGM" --text="${!varp}")
	if [[ $resposta == $(echo) ]];then
		break
	fi
	echo ${!varp} $resposta >> $path
	var=$(($var+1))
	if [ $var -gt $nper ];then
		var=1
		echo -e "\n" >> $path
	fi
done
