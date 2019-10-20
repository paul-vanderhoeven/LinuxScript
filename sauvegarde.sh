#!/bin/bash

pwd="$(pwd)"
list=""
destinationData="$pwd/data.tar"
destinationConfig="$pwd/config.tar"
destinationFirefox="$pwd/firefox.tar"

while read line ; do
	if [ -e $line ]
	then
		list+="$line ";
	fi
done < folderToSave

saveData() {
	cd /home/$USER/
	tar cfpv $destinationData --exclude="\.*" --exclude="$destinationConfig $destinationData" *
	cd $pwd
}

saveFirefoxProfil() {
	cd /home/$USER/.mozilla/firefox/*.default
	tar cfpv $destinationFirefox *
	cd $pwd
}

saveFirefoxProfil