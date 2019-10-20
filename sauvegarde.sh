#!/bin/bash

list=""
destinationData="data.tar"
destinationConfig="config.tar"


while read line ; do
	if [ -e $line ]
	then
		list+="$line ";
	fi
done < folderToSave

saveData() {
	tar cfpv $destinationData --exclude="\.*" --exclude="$destinationConfig $destinationData" /home/paul/
}

saveData