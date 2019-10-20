#!/bin/bash

# --------------------------------------------------------------------------------
# Script de configuration de Gnome
# --------------------------------------------------------------------------------
# Ce script fonctionne uniquement pour Gnome.
# A ne pas executer en root !
# --------------------------------------------------------------------------------

changeGnomeSettings() {

	printf "Changement des paramètres de gnome..."
	#Notifications
	gsettings set org.gnome.desktop.notifications show-in-lock-screen false
	gsettings set org.gnome.desktop.notifications show-banners false
	#Recherche
	gsettings set org.gnome.desktop.search-providers disable-external true
	#Layout windows
	gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
	gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
	#Barre supérieure
	gsettings set org.gnome.desktop.interface clock-show-seconds true
	gsettings set org.gnome.desktop.interface clock-show-weekday true
	gsettings set org.gnome.desktop.interface show-battery-percentage true
	#Calendrier
	gsettings set org.gnome.desktop.calendar show-weekdate true
	#Périphériques
	gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
	gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
	#Vérrouiller
	gsettings set org.gnome.desktop.lockdown disable-lock-screen false
	
	printf "OK\n"
}

if [ $(id -u) -eq 0 ] ; then
	echo "A ne pas executer en root !"
	exit
fi

changeGnomeSettings