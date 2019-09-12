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

installFlatpakUbuntu() {

	printf "Installation de Flatpak pour Ubuntu >= 18.10 (requis pour ce script)..."

	apt -y install flatpak >> stdout.log
	apt -y install gnome-software-plugin-flatpak >> stdout.log

	printf "OK\n"
}

flatpakSetup() {

	printf "Ajout du repository FlatHub..."

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	printf "OK\n"
}


installSteam() {

	printf "Installation de Steam..."

	apt install -y steam-installer >> stdout.log
	
	printf "OK\n"
}

installLutris() {

	printf "Installation de Lutris..."

	add-apt-repository -y ppa:lutris-team/lutris >> stdout.log
	apt-get update >> stdout.log
	apt-get -y install lutris >> stdout.log

	printf "OK\n"
}

installWineForLutris() {
	
	# Installer Wine (faire tourner des programmes Windows).

	dpkg --add-architecture i386 >> stdout.log
	wget -nc https://dl.winehq.org/wine-builds/winehq.key >> stdout.log
	apt-key add winehq.key >> stdout.log
	rm winehq.key >> stdout.log

	#--------------------- ONLY FOR UBUNTU 19.04 ---------------
	# If your have others version or distribution, go to https://github.com/lutris/lutris/wiki/Wine-Dependencies
	apt-add-repository -y 'deb https://dl.winehq.org/wine-builds/ubuntu/ disco main' >> stdout.log
	apt update >> stdout.log
	apt-get install -y --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 >> stdout.log
	apt-get install -y libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 >> stdout.log
}

changeSwap() {

	#change le déclenchement du fichier swap à 5% de la ram libre
	printf "Réglage du déclenchement du fichier d'échange (swap)..."

	echo vm.swappiness=5 | tee /etc/sysctl.d/99-swappiness.conf >> stdout.log
	echo vm.vfs_cache_pressure=50 | tee -a /etc/sysctl.d/99-swappiness.conf >> stdout.log

	sysctl -p /etc/sysctl.d/99-swappiness.conf >> stdout.log

	swapoff -av >> stdout.log
	swapon -av	>> stdout.log

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

installVirtualBox() {

	printf "Installation de VirtualBox..."

	apt install -y virtualbox virtualbox-dkms virtualbox-ext-pack virtualbox-guest-additions-iso virtualbox-qt

	printf "OK\n"
}

removeSnap() {

	printf "Désinstallation de snap..."

	apt -y purge snapd
}

installAppsDev() {

	printf "Installation du pack développeur (Eclipse, IntelliJIDEA, Git)..."

	apt install -y eclipse-titan git >> stdout.log
	flatpak install -y flathub com.jetbrains.IntelliJ-IDEA-Community com.visualstudio.code >> stdout.log

	printf "OK\n"
}

installStandardApps() {

	printf "Installation des applications standard..."

	apt -y install gnome-tweaks gparted baobab synaptic vlc libreoffice qbittorrent vim dconf-editor Klavaro >> stdout.log
	flatpak install -y flathub com.sublimetext.three com.discordapp.Discord >> stdout.log

	printf "OK\n"

}

installMinecraft() {

	printf "Installation de Minecraft..."

	flatpak install -y flathub com.mojang.Minecraft

	printf "OK\n"
}

updateAndClean() {

	printf "Mises à jour des programmes et suppressions des packages inutiles..."

	apt upgrade -y >> stdout.log
	apt autoremove -y --purge >> stdout.log
	apt clean >> stdout.log

	printf "OK\n"
}

read reponse

if [ $reponse = "y" ] || [ $reponse = "Y" ] ; then 

	installFlatpakUbuntu 2>> stderr.log
	flatpakSetup 2>> stderr.log

	installStandardApps 2>> stderr.log
	installAppsDev 2>> stderr.log
	installSteam 2>> stderr.log
	installLutris 2>> stderr.log
	installMinecraft 2>> stderr.log
	#installWineForLutris 2>> stderr.log
	changeSwap 2>> stderr.log
	changeGnomeSettings 2>> stderr.log
	removeSnap 2>>stderr.log
	updateAndClean 2>> stderr.log
fi