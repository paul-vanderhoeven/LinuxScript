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
echo "Ce script va installer les logiciels : Flatpak, VLC, LibreOffice, Git, Eclipse, Discord, Qbittorrent, Klavaro, Intellij, Dconf, Sublime Text, Gnome Tweaks, Steam, Lutris, Minecraft ..."
echo "Des paramètres seront également changés: notifications, recherche, swap, suppression de snap"
echo "Etês-vous certain de vouloir exécuter ce script(y/n): "

read reponse

source ./functions

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