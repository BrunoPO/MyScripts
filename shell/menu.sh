#!/bin/bash

clear
echo "Menu de scripts"

myFolder="/mnt/Compart/Scripts"
scriptsFolder="scriptsMenu"
scriptsFolder="$myFolder/$scriptsFolder"
wordName="nome"
wordDescription="Descricao"
scripts=($(ls $scriptsFolder | sed 's/ /\n/g'))
posi=0
nomes=""
descricoes=""
for fl in ${scripts[@]}; do
	nome=$(cat $scriptsFolder/$fl | grep $wordName | sed 's/#[a-z,A-Z,0-9].*=//g')
	descricao=$(cat $scriptsFolder/$fl | grep $wordDescription | sed 's/#[a-z,A-Z,0-9].*=//g')
	echo "$fl"
	echo "$posi - script: $nome"
	echo "descrição: $descricao" 
	echo
	nomes=("${nomes[@]}" "$nome")
	descricoes=("${descricoes[@]}" "$descricao")
	posi+=1
done
	echo "Sair - sair do menu" 
echo
input_variable=""

while true; do
	echo "Escolha um script pela posição: "
	read input_variable
	clear
	echo "Você escolheu: $input_variable"
	if [ $input_variable == "Sair" ]; then
		echo "Você saiu"
		exit
	elif test "${scripts[$input_variable]+isset}"; then
		echo "O script que vai ser executado: ${scripts[$input_variable]}"
		echo
		$scriptsFolder/${scripts[$input_variable]}
		echo
		echo "Final da execução do script"
		exit
	else
		echo "Posição não é valida"
	fi
done

