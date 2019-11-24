#!/bin/bash

pwd="$(pwd)"

date="$(date +%Y-%m-%d-%H:%M:%S)"

destinationData="$pwd/home-$USER-$date.tar"
destinationConfig="$pwd/config-$USER-$date.tar"
destinationFirefox="$pwd/firefox-$USER.tar"

saveData() {
	cd /home/$USER/
	tar cfpv $destinationData --exclude="\.*" --exclude="$destinationConfig $destinationData" *
	cd $pwd
}

saveFirefoxProfil() {	
	folder="$(grep "Default=.*\." < /home/$USER/.mozilla/firefox/profiles.ini | sed 's/Default=//')" # récupérer le dossier du profil par défault

	cd "/home/$USER/.mozilla/firefox/$folder"

	tar cfpv $destinationFirefox *

}

restoreFirefoxProfil() {
	folder="$(grep "Default=.*\." < /home/$USER/.mozilla/firefox/profiles.ini | sed 's/Default=//')"

	cd "/home/$USER/.mozilla/firefox/$folder"

	tar xfv $destinationFirefox

}

saveFirefoxProfil
saveData
#restoreFirefoxProfil