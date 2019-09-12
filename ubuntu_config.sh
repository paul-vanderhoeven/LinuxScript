#!/bin/bash

# --------------------------------------------------------------------------------
# Lisez attentivement les consignes ci-dessous.
# --------------------------------------------------------------------------------
# Ce script est fait pour les distributions basée sur Debian.
# Si vous avez une version d'Ubuntu différente ou une autre distribution que Ubuntu, certaines partie du script ne fonctionneront pas.
# --------------------------------------------------------------------------------

if [ "$(id -u)" != 0 ] ; then
	echo "Vous devez avoir les droits d'administrateurs !"
	exit
fi

echo "Script de configuration et d'installation des logiciels principaux pour Paul VDH."
echo "Ce script va installer les logiciels : VLC, LibreOffice, Git, Eclipse, Discord, Qbittorrent, Klavaro, Intellij, Dconf, Sublime Text, Gnome Tweaks, Analyseur d'espace disque, Steam, Lutris, ..."
echo "Etês-vous certain de vouloir exécuter ce script(y/n): "

installFlatHubUbuntu() {

	printf "Installation de Flatpak pour Ubuntu >= 18.10 (requis pour ce script)..."

	sudo apt -y install flatpak >> stdout.log
	sudo apt -y install gnome-software-plugin-flatpak >> stdout.log

	printf "OK\n"
}

flatpakSetup() {

	printf "Ajout du repository FlatHub..."

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	printf "OK\n"
}


installSteamLutris() {

	printf "Installation de Steam et Lutris..."

	flatpak install flathub com.valvesoftware.Steam >> stdout.log
	sudo add-apt-repository -y ppa:lutris-team/lutris >> stdout.log
	sudo apt-get update >> stdout.log
	sudo apt-get -y install lutris >> stdout.log
	
	printf "OK\n"
}

installWineForLutris() {
	
	# Installer Wine (faire tourner des programmes Windows).

	sudo dpkg --add-architecture i386 >> stdout.log
	wget -nc https://dl.winehq.org/wine-builds/winehq.key >> stdout.log
	sudo apt-key add winehq.key >> stdout.log
	rm winehq.key >> stdout.log

	#--------------------- ONLY FOR UBUNTU 19.04 ---------------
	# If your have others version or distribution, go to https://github.com/lutris/lutris/wiki/Wine-Dependencies
	sudo apt-add-repository -y 'deb https://dl.winehq.org/wine-builds/ubuntu/ disco main' >> stdout.log
	sudo apt update >> stdout.log
	sudo apt-get install -y --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 >> stdout.log
	sudo apt-get install -y libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 >> stdout.log
}

changeSwap() {

	#change le déclenchement du fichier swap à 5% de la ram libre
	printf "Réglage du déclenchement du fichier d'échange (swap)..."

	echo vm.swappiness=5 | sudo tee /etc/sysctl.d/99-swappiness.conf >> stdout.log
	echo vm.vfs_cache_pressure=50 | sudo tee -a /etc/sysctl.d/99-swappiness.conf >> stdout.log

	sudo sysctl -p /etc/sysctl.d/99-swappiness.conf >> stdout.log

	sudo swapoff -av >> stdout.log
	sudo swapon -av	>> stdout.log

	printf "OK\n"	
}

changeGnomeSettings() {

	printf "Changement des paramètres de gnome shell..."
	#Notifications
	gsettings set org.gnome.desktop.notifications show-in-lock-screen false >> stdout.log
	gsettings set org.gnome.desktop.notifications show-banners false >> stdout.log
	#Recherche	
	gsettings set org.gnome.desktop.search-providers disable-external true >> stdout.log

	printf "OK\n"

}

installAppsDev() {

	printf "Installation du pack développeur (Eclipse, IntelliJIDEA, Git)..."

	sudo apt install -y eclipse-titan git >> stdout.log
	flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community com.visualstudio.code >> stdout.log

	printf "OK\n"
}

installStandardApps() {

	printf "Installation des applications standard..."

	sudo apt -y install gnome-tweaks gparted baobab synaptic >> stdout.log
	flatpak install flathub com.sublimetext.three com.discordapp.Discord org.videolan.VLC org.libreoffice.LibreOffice org.qbittorrent.qBittorrent >> stdout.log
	flatpak install flathub org.vim.Vim ca.desrt.dconf-editor net.sourceforge.Klavaro >> stdout.log
	printf "OK\n"

}

installMinecraft() {

	printf "Installation de Minecraft..."

	sudo flatpak install flathub org.libreoffice.LibreOffice >> stdout.log

	printf "OK\n"
}

updateAndClean() {

	printf "Mises à jour des programmes et suppressions des packages inutiles..."

	sudo apt upgrade -y >> stdout.log
	sudo apt autoremove -y --purge >> stdout.log
	sudo apt clean >> stdout.log

	printf "OK\n"
}

read reponse

if [ $reponse = "y" ] || [ $reponse = "Y" ] ; then 

	installFlatHubUbuntu 2>> stderr.log
	flatpakSetup 2>> stderr.log

	installStandardApps 2>> stderr.log
	installAppsDev 2>> stderr.log
	installSteamLutris 2>> stderr.log
	installMinecraft 2>> stderr.log
	#installWineForLutris 2>> stderr.log
	changeSwap 2>> stderr.log
	changeGnomeSettings 2>> stderr.log
	updateAndClean 2>> stderr.log
fi