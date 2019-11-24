#!/bin/bash

pwd="$(pwd)"
list=""
date="$(date +%Y-%m-%d-%H:%M:%S)"
destinationData="$pwd/home-$USER-$date.tar"
destinationConfig="$pwd/config-$USER-$date.tar"
destinationFirefox="$pwd/firefox-$USER-$date.tar"

saveData() {
	cd /home/$USER/
	tar cfpv $destinationData --exclude="\.*" --exclude="$destinationConfig $destinationData" *
	cd $pwd
}

saveFirefoxProfil() {
	folder=""
	
	folder="$(grep "Default=.*\." < ~/.mozilla/firefox/profiles.ini | sed 's/Default=//')"

	cd "/home/$USER/.mozilla/firefox/$folder"

	tar cfpv $destinationFirefox *

}

saveFirefoxProfil
#saveData