#!/bin/bash

# Leest locatie van de file (Moet geen "/" aan het einde hebben).
echo "Geef de locatie van de foto's door:"
read location
echo "Geef door of het gesorteerd moet worden op week of maand:"
read weekmonth

# For loop om door de foto's in de folder te gaan.
for pic in $location/*
do

# Check of het een file is en geen folder.
if [ ! -d $pic ]
   then
	if [ $weekmonth == 'maand' ]
  	 then
	  # Haalt de modified maand uit de foto.
 	  picdatemonth=$(date -r $pic "+%B")
		# Checkt of een folder al gemaakt is.
   		if [ ! -d $location/$picdatemonth ] 
		then 
		# Maakt een folder aan gebaseerd op de maand.
		  mkdir $location/$picdatemonth 
   		fi
	   # Kopieert de foto naar de nieuwe locatie.
     	   cp $pic $location/$picdatemonth
	   # Verwerft de meest recente file (de kopie) uit de nieuwe folder.
	   newpic=$(ls -Art "$location/$picdatemonth" | tail -n 1)
	   # Calculeert een md5 sum uit de originele foto.
           # Omdat md5sum 3 velden geeft gebruik je awk om alleen het eerste veld te 
           # gebruiken.
           md5sum1=$(md5sum $pic |awk '{print $1}')
	   # Calculeert een md5 sum uit de gekopieerde foto.
 	   md5sum2=$(md5sum < $location/$picdatemonth/$newpic |awk '{print $1}')
	   # Vergelijkt de twee md5 waardes, als ze gelijk zijn wordt de originele
	   # foto verwijderd.	
	   if [ $md5sum1 == $md5sum2 ]
	     then
		rm -f $pic 
	fi fi

	if [ $weekmonth == 'week' ]
  	 then
	  # Haalt de modified week uit de foto.
   	  picdateweek=$(date -r $pic "+%V")
		# Checkt of een folder al gemaakt is.
   		if [ ! -d $location/$picdateweek ]
		 then
		# Maakt een folder aan gebaseerd op de week.		
	  	   mkdir $location/$picdateweek
   		 fi
	   # Kopieert de foto naar de nieuwe locatie.
     	   cp $pic $location/$picdateweek
           # Verwerft de meest recente file (de kopie) uit de nieuwe folder.
	   newpic=$(ls -Art "$location/$picdateweek" | tail -n 1)
	   # Calculeert een md5 sum uit de originele foto.
           # Omdat md5sum 3 velden geeft gebruik je awk om alleen het eerste veld te 
           # gebruiken.
           md5sum1=$(md5sum $pic |awk '{print $1}')
	   # Calculeert een md5 sum uit de gekopieerde foto.
 	   md5sum2=$(md5sum < $location/$picdateweek/$newpic |awk '{print $1}')
	   # Vergelijkt de twee md5 waardes, als ze gelijk zijn wordt de originele
	   # foto verwijderd.	
	   if [ $md5sum1 == $md5sum2 ]
	     then
		rm -f $pic
	   fi 
	fi fi
	
done
