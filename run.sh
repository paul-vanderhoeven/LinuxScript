#!/bin/bash

# --------------------------------------------------------------------------------
# Lisez attentivement les consignes ci-dessous.
# --------------------------------------------------------------------------------
# Ce script est fait pour les distributions basée sur Debian.
# Si vous avez une version d'Ubuntu différente ou une autre distribution que Ubuntu, certaines partie du script ne fonctionneront pas.
# --------------------------------------------------------------------------------

STDERR="$(pwd)/log/stderr-$(date +%Y-%m-%d-%H:%M:%S).log"
STDOUT="$(pwd)/log/stdout-$(date +%Y-%m-%d-%H:%M:%S).log"
TTY="$(tty)"

echo "Vous devez avoir les droits d'administrateur pour exécuter ce script !"

echo "Script de configuration et d'installation des logiciels principaux pour Paul VDH."
echo "Ce script va installer les logiciels : Flatpak, VLC, LibreOffice, Git, Eclipse, Discord, Qbittorrent, Klavaro, Intellij, Dconf, Sublime Text, Gnome Tweaks, Steam, Lutris, Minecraft ..."
echo "Des paramètres seront également changés: notifications, recherche, swap, suppression de snap"
echo "Etês-vous certain de vouloir exécuter ce script(y/n): "

read reponse

creationLog() {
	if [ ! -e log ] ; then
		mkdir log
	fi
	touch $STDOUT
	touch $STDERR
}

if [ ! -z "$(cat /etc/*-release | grep Ubuntu)" ] ; then
	source ./apt
fi
if [ ! -z "$(cat /etc/*-release | grep Arch)" ] ; then
	source ./pacman
fi
source ./gnome
source ./functions

if [ $reponse = "y" ] || [ $reponse = "Y" ] ; then 

	creationLog

	installFlatpakUbuntu 2>> $STDERR >> $STDOUT
	flatpakSetup 2>> $STDERR >> $STDOUT

	installStandardApps 2>> $STDERR >> $STDOUT
	#installAppsDev 2>> $STDERR >> $STDOUT
	#installSteam 2>> $STDERR >> $STDOUT
	#installLutris 2>> $STDERR >> $STDOUT
	#installMinecraft 2>> $STDERR >> $STDOUT
	#installWineForLutris 2>> $STDERR >> $STDOUT
	#installOpenJre 2>> $STDERR >> $STDOUT
	#installEclipse 2>> $STDERR >> $STDOUT
	#installEclipse 2>> $STDERR >> $STDOUT
	#removeSnap 2>>$STDERR >> $STDOUT
	#installLAMP 2>> $STDERR >> $STDOUT

	changeGnomeSettings 2>> $STDERR >> $STDOUT
	changeSwapSettings 2>> $STDERR >> $STDOUT

	updateAndClean 2>> $STDERR >> $STDOUT
fi