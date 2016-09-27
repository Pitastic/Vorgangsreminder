#!/bin/bash
# -*- coding: utf-8 -*-

if [[ true ]]
	then
		# Get latest Link
		echo
		echo "1. Download"
		TAG=`curl -s https://api.github.com/repos/Pitastic/Vorgangsreminder/releases/latest | grep 'tag_name' | cut -d\" -f4`
		DLINK="https://codeload.github.com/Pitastic/Vorgangsreminder/zip/${TAG}"
		# Download to Temp
		curl $DLINK --output "/tmp/VN_${TAG}.zip"
		# Copy old DB to Temp
		echo "2. alte Vorgaenge sichern"
		#--
		# Remove VN
		# Extract VN
		echo "3. neue Version entpacken"
		#---
		# Copy old DB to VN
		echo "4. alte Vorgaenge zurueckholen"
		#---
		echo
		echo "Dein Vorgangsreminder ist jetzt auf der neuesten Version (${TAG}) !"
		echo
	else
		echo
		echo "Der Updater funktioniert momentan nur auf Unix Systemen !"
		echo
		echo "Für ein manuelles Update mache folgende Schritte:"
		echo
		echo "\t1. Kopiere deine Vorgaenge an einen sicheren Ort von:"
		echo "\t   .\\Vorgangsreminder\\vorgaenge.db"
		echo "\t2. Lade die neue Version als ZIP hier herunter:"
		echo "\t   https://github.com/Pitastic/Vorgangsreminder/releases/latest"
		echo "\t3. Loesche den Ordner des Vorgangsreminders und entpacke den neuen"
		echo "\t4. Kopiere jetzt deine alte vorgaenge.db wieder in das Verzeichnis"
		echo "\t   .\\Vorgangsreminder\\vorgaenge.db"
fi