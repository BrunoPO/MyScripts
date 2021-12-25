#nome=Change Grub
#Descricao=Altera a preferencia na iniciailização  


clear


echo "Iniciando script"
posi=0
canAlter=0
configFile="/boot/grub/grub.cfg"


grubList=($(cat $configFile  | grep "menuentry '" | sed -r "s/([a-z,A-Z,0-9].*) (--class) ([a-z,A-Z,0-9].*)/\1/g" | sed -r "s/(.*) '(.*)' (.*)/\2/g" | sed -r 's/(,)(.*)/\1/g' | uniq | sed 's/ //g'))

for grubItem in ${grubList[@]}; do
	echo "$posi - $grubItem"
	posi=$(echo "$posi + 1" | bc)
done
echo




while true; do
	echo "digite a posição do grub para ser inicializada"
	read choosenNumber
	if [ $choosenNumber == "S" ]; then
		echo "Saindo"
	elif [ "$choosenNumber" -lt "$posi" ] && [ "$choosenNumber" -ge "0" ]; then
		echo "Alterado para $choosenNumber"	
		break;
	else
		echo "Numero invalido"
	fi
done


if [ -e "$configFile.bk" ] ; then
	echo "existe o arquivo de backup"
	canAlter=1
else
	echo "Não existe o arquivo de backup"
	echo "Para guardar as novas config precisamos fazer um backup antes"
	sudo su -c "cat $configFile > \"$configFile.bk\""
	if [ -e "$configFile.bk" ] ; then
		canAlter=1
	fi
fi

if [ $canAlter==1 ] ; then
	alterRowString=$(cat $configFile | grep "set default=" | grep -v "set default=\"\${")
	alterRowNumber=$(cat $configFile | grep -n "$alterRowString" | sed -r 's/(.*):(.*)/\1/g')
	alteredRow=$(echo $alterRowString | sed -r "s/(.*)\"(.*)\"/\1\"$choosenNumber\"/g")
	
	echo "linha vai ser alterada de: $alterRowString /n para: $alteredRow"
	sed "${alterRowNumber}s/.*/$alteredRow/g" $configFile > temp.file
	if [ -e "temp.file" ] ; then
		sudo su -c "mv temp.file /boot/grub/grub.cfg"
	fi
	echo "linha atualmente $(cat $configFile | grep "set default=" | grep -v "set default=\"\${")"

fi


echo $canAlter
echo "Fim do script"
