#!/bin/bash

# --------------------------------------------------------------------------------
# Lisez attentivement les consignes ci-dessous.
# --------------------------------------------------------------------------------
# Ce script est fait pour les distributions basée sur Debian.
# Si vous avez une version d'Ubuntu différente ou une autre distribution que Ubuntu, certaines partie du script ne fonctionneront pas.
# --------------------------------------------------------------------------------

STDERR="stderr-$(date +%Y-%m-%d-%H:%M:%S).log"
STDOUT="stdout-$(date +%Y-%m-%d-%H:%M:%S).log"
export TTY="$(tty)"

if [ "$(id -u)" != 0 ] ; then
	echo "Vous devez avoir les droits d'administrateurs !"
	exit
fi

touch $STDOUT

echo "Script de configuration et d'installation des logiciels principaux pour Paul VDH."
echo "Ce script va installer les logiciels : Flatpak, VLC, LibreOffice, Git, Eclipse, Discord, Qbittorrent, Klavaro, Intellij, Dconf, Sublime Text, Gnome Tweaks, Steam, Lutris, Minecraft ..."
echo "Des paramètres seront également changés: notifications, recherche, swap, suppression de snap"
echo "Etês-vous certain de vouloir exécuter ce script(y/n): "

read reponse

source ./functions

if [ $reponse = "y" ] || [ $reponse = "Y" ] ; then 

	installFlatpakUbuntu 2>> $STDERR >> $STDOUT
	flatpakSetup 2>> $STDERR >> $STDOUT

	#installStandardApps 2>> $STDERR 
	#installAppsDev 2>> $STDERR
	#installSteam 2>> $STDERR
	#installLutris 2>> $STDERR
	#installMinecraft 2>> $STDERR
	#installWineForLutris 2>> $STDERR
	#installOpenJre 2>> $STDERR
	#installEclipse 2>> $STDERR
	#changeSwapSettings 2>> $STDERR
	#changeGnomeSettings 2>> $STDERR
	#removeSnap 2>>$STDERR
	#installLAMP 2>> $STDERR
	updateAndClean 2>> $STDERR >> $STDOUT
fi