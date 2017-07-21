#!/bin/bash
zenity --version || exit
if [ "$1" == "-h" ]; then
	echo "-u uninstall the program"; exit
elif [ "$1" == "-u" ]; then
	rm -rf /usr/bin/formforgraphicmode; exit
else
	echo "Running FFGM"
fi


path=$(zenity --entry --title="FFGM" --text="Enter the file path: ")
if [[ "$path" == "$(echo)" ]];then
	exit
fi
nper=$(zenity --entry --title="FFGM" --text="How many questions do you want to generate? ")
if [ "$nper" == "$(echo)" ];then
	exit
fi

nperp=$nper
npern=1
while [[ $nperp -ne 0 ]]; do
	pergunta=$(zenity --entry --title="FFGM" --text="Enter the question: ")
	if [[ $pergunta == $(echo) ]];then
		npern=$(($npern-1))
	fi
	declare "pergunta$npern=$pergunta"
	npern=$(($npern+1))
	nperp=$(($nperp-1))
done
npern=1
var=1
while true; do
	varp="pergunta$var"
	resposta=$(zenity --entry --title="FFGM" --text="${!varp}")
	if [[ ${!varp} != $(echo) ]];then
		if [[ $resposta == $(echo) ]];then
			break
		fi
	fi
	if [[ ${!varp} == $(echo) ]];then
		if [[ $resposta == $(echo) ]];then
			echo "Sorry for the bug, please report in https://github.com/theshdev/FormForGraphicMode/issues"
		fi
	fi
	echo ${!varp} $resposta >> $path
	var=$(($var+1))
	if [ $var -gt $nper ];then
		var=1
		echo -e "\n" >> $path
	fi
done
