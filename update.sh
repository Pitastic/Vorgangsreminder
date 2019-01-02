#!/bin/bash
# -*- coding: utf-8 -*-

# TODO:
# - Pfad zum Programm variabel
# - Sichern/Updaten von Vordrucken
# - Updater == Installer ?

while true; do
	echo
	echo "=== Update und Installation des aktuellen Vorgangsreminders ==="
	read -p "Fortfahren ? (Y/N)" yn
	case $yn in
		[Yy]* ) INSTALL=true; break;;
		[Nn]* ) echo;exit;;
		* ) echo "(J oder N)!";;
	esac
done


if [[ $INSTALL ]]
	then
		# Vorbereitungen
		echo
		VN_PATH="`dirname \"$0\"`"
		VN_PATH="`( cd \"${VN_PATH}\" && pwd )`"
		PASS=false

		if [[ -f "${VN_PATH}/new_update.sh" ]]; then
			# Für den Fall den Updater upzudaten
			${VN_PATH}/new_update.sh
			exit;
		else

			# Get latest Link and download to TEMP
			echo "1. Download"
			TAG=`curl -s https://api.github.com/repos/Pitastic/Vorgangsreminder/releases/latest | grep 'tag_name' | cut -d\" -f4`
			DLINK="https://github.com/Pitastic/Vorgangsreminder/archive/${TAG}.tar.gz"
			SAVETO="/tmp/VN_${TAG}.tar.gz"
			curl -Ls $DLINK --output $SAVETO
			
			# Copy old DB to Temp
			echo "2. sichere alte Vorgänge"
			if [ -f "${VN_PATH}/vorgaenge.db" ]; then
				echo "  ...vorgaenge.db gefunden"
				cp ${VN_PATH}/vorgaenge.db /tmp/vorgaenge.db
				HAT_VORGAENGE=true
			else
				echo ">> SKIPPING (keine alten Vorgänge vorhanden)"
			fi
			
			# Extract VN
			if [[ $PASS ]]; then
				# Remove VN
				rm -rf ${VN_PATH}
				mkdir ${VN_PATH};

				echo "3. entpacke neue Version nach: ${VN_PATH}"
				tar -xzf $SAVETO -C ${VN_PATH} --strip-components 1

				# Alte VNs wiederherstellen (ggf.)
				if [[ $HAT_VORGAENGE ]]; then
					echo "4. stelle alte Vorgänge wieder her"
					mv /tmp/vorgaenge.db ${VN_PATH}/vorgaenge.db
				fi
				echo
				echo "Dein Vorgangsreminder ist jetzt auf der neuesten Version (${TAG}) !"
				echo
			else
				echo "Abgebrochen !"
			fi
		fi
	else
		echo
		echo "Der Updater funktioniert momentan nur auf Unix Systemen !"
		echo
		echo "Für ein manuelles Update mache folgende Schritte:"
		echo
		echo "\t1. Kopiere deine Vorgänge an einen sicheren Ort von:"
		echo "\t   .\\Vorgangsreminder\\vorgaenge.db"
		echo "\t2. Lade die neue Version als ZIP hier herunter:"
		echo "\t   https://github.com/Pitastic/Vorgangsreminder/releases/latest"
		echo "\t3. Lösche den Ordner des Vorgangsreminders und entpacke den neuen"
		echo "\t4. Kopiere jetzt deine alte vorgaenge.db wieder in das Verzeichnis"
		echo "\t   .\\Vorgangsreminder\\vorgaenge.db"
fi