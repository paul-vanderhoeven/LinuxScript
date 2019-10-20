#!/bin/bash

# --------------------------------------------------------------------------------
# Lisez attentivement les consignes ci-dessous.
# --------------------------------------------------------------------------------
# Ce script est fait pour les distributions basée sur Debian.
# Si vous avez une version d'Ubuntu différente ou une autre distribution que Ubuntu, certaines partie du script ne fonctionneront pas.
# --------------------------------------------------------------------------------

STDERR="$(pwd)/stderr-$(date +%Y-%m-%d-%H:%M:%S).log"
STDOUT="$(pwd)/stdout-$(date +%Y-%m-%d-%H:%M:%S).log"
USER="paul"

export TTY="$(tty)"

if [ "$(id -u)" != 0 ] ; then
	echo "Vous devez avoir les droits d'administrateurs !"
	exit
fi

echo "Script de configuration et d'installation des logiciels principaux pour Paul VDH."
echo "Ce script va installer les logiciels : Flatpak, VLC, LibreOffice, Git, Eclipse, Discord, Qbittorrent, Klavaro, Intellij, Dconf, Sublime Text, Gnome Tweaks, Steam, Lutris, Minecraft ..."
echo "Des paramètres seront également changés: notifications, recherche, swap, suppression de snap"
echo "Etês-vous certain de vouloir exécuter ce script(y/n): "

read reponse

source ./functions

if [ $reponse = "y" ] || [ $reponse = "Y" ] ; then 

	touch $STDOUT
	touch $STDERR
	chown $USER $STDERR
	chown $USER $STDOUT

	installFlatpakUbuntu 2>> $STDERR >> $STDOUT
	flatpakSetup 2>> $STDERR >> $STDOUT

	#installStandardApps 2>> $STDERR >> $STDOUT 
	#installAppsDev 2>> $STDERR >> $STDOUT
	#installSteam 2>> $STDERR >> $STDOUT
	#installLutris 2>> $STDERR >> $STDOUT
	#installMinecraft 2>> $STDERR >> $STDOUT
	#installWineForLutris 2>> $STDERR >> $STDOUT
	#installOpenJre 2>> $STDERR >> $STDOUT
	#installEclipse 2>> $STDERR >> $STDOUT
	#changeGnomeSettings 2>> $STDERR >> $STDOUT
	#installEclipse 2>> $STDERR >> $STDOUT
	#removeSnap 2>>$STDERR >> $STDOUT
	#installLAMP 2>> $STDERR >> $STDOUT

	#changeSwapSettings 2>> $STDERR >> $STDOUT
	
	updateAndClean 2>> $STDERR >> $STDOUT
fi