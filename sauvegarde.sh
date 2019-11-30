#!/bin/bash

pwd="$(pwd)"

destinationData="$pwd/home-$USER.tar"
destinationFirefox="$pwd/firefox-$USER.tar"

saveData() {
	cd /home/$USER/
	tar cfpv $destinationData  --exclude="[^(.git/.*)(.gitignore)].*" --exclude="$destinationFirefox" *
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