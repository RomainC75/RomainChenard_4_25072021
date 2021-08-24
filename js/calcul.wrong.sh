#!/usr/bin/bash

liste=`ls`
sum=0
nb=0

if [[ $# != 1  ]]
then 
	echo "error : enter an extension name - ex : pdf-js..."
	exit 1
fi

for file in $liste
do
	if [[ $file != *.min.$1  ]] && [[ $file = *.$1 ]]
	then
		echo "réduction pour $file : "
		file2=`echo $file | sed "s/.$1/.min.$1/"
		echo "file 2 : $file2"

		taille1=`ls -l $file | nawk '{print $5}'`
		taille1="${taille1}.0"
		taille2=`ls -l $file2 | nawk '{print $5}'`
		
		echo "$taille1 ... $taille2"
		dif=`python3 -c "print($taille2/$taille1)"`
		dif=`python3 -c "print( 100 - $dif * 100)"`
		echo $dif
		echo " "

		sum=`python3 -c "print($dif + $sum)"`
		((nb= $nb + 1))	
	fi	
done

echo "sum : $sum   et  nb=$nb"
moyenne=`python3 -c "print( $sum / $nb )"`

echo "-------------------------------"
echo "-------------------------------"
echo "la réduction moyenne est de : $moyenne %"
