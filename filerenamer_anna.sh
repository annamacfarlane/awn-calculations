#!/bin/bash
j=0;

for file in /Users/AnnaMacFarlane/Documents/MATLAB/JoanMWM/TestFiles/*.csv;
do
    newfilename=$(echo $file | sed -e "s/\ /_/g")
    #echo $file $newfilename
    mv "$file" "$newfilename"
done
#mv ${subjpath}/$file ${subjpath}/$newFile
j=1

i=0;

filepath="/Users/AnnaMacFarlane/Documents/MATLAB/JoanMWM/TestFiles/"

while IFS=, read -r Test Animal Treatment Code Stage Trial test1;
do
    if [ $i -gt 0 ]
    then
	      # Use if data file is missing certain tests
	      #if [ $i -eq 109 ] || [ $i -eq 110 ] || [ $i -eq 111 ]
	      #then
	      #    i=112
	      #fi
	      oldFile="JoanMWM_010722_-_"$i.csv
        newFile=$Animal"_"$Stage"_T"$Trial"_positions".csv
        #echo $oldFile
        #echo $newFile
        #mv "${filepath}$oldFile" "${filepath}$newFile"
        mv ${filepath}$oldFile ${filepath}$newFile
        i=$((i+1))
    else
        i=$((i+1))
    fi

done < ~/Documents/MATLAB/JoanMWM/JOAN_MWM_combined.csv;



