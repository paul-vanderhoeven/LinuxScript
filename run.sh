#!/bin/bash

# --------------------------------------------------------------------------------
# Lisez attentivement les consignes ci-dessous.
# --------------------------------------------------------------------------------
# Ce script est fait pour les distributions basée sur Debian.
# Si vous avez une version d'Ubuntu différente ou une autre distribution que Ubuntu, certaines partie du script ne fonctionneront pas.
# --------------------------------------------------------------------------------

USER="paul" # Utilisé pour supprimer le dossier snap qui est dans le dossier personnel

if [ $(id -u) -ne 0 ] ; then
	echo "Vous devez avoir les droits d'administrateur pour exécuter ce script !"
	exit
fi

echo "Script d'installation des logiciels principaux pour Paul VDH."
echo "Ce script va installer les logiciels : Flatpak, VLC, LibreOffice, Git, Eclipse, Discord, Qbittorrent, Klavaro, Intellij, Dconf, Sublime Text, Gnome Tweaks, Steam, Lutris, Minecraft ..."
echo "Etês-vous certain de vouloir exécuter ce script(y/n): "

read reponse

source ./apt
source ./flatpak

if [ $reponse = "y" ] || [ $reponse = "Y" ] ; then 

	installVirtualBox
	installGit
	installGnomeTweaks
	installGparted
	installAnalyseurUtilisationDisque
	installSynaptic
	installOpenJre
	installLutris
	installLAMP
	setupPublic_html
	configGit

	installDiscord
	installSublimeText
	installIntelliJ
	installEclipse
	installAtom
	installVisualStudioCode
	installMinecraft
	installTor
	installSteam
	installDConfEditor
	installVim
	installLibreOffice
	installQbitTorrent
	installVLC
	installKlavaro

	changeSwapSettings
	removeSnap

	updateAndClean
fi
