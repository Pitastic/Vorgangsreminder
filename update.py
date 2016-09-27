#!/usr/bin/env python
# -*- coding: utf-8 -*-

#from sys import platform

if __name__ == '__main__':
	platform = False
	if platform == "linux" or platform == "linux2" or platform == "darwin":
		# get latest Downloadlink
		pass
	else:
		print
		print u"Der Updater funktioniert momentan nur auf Unix Systemen !"
		print
		print u"Für ein manuelles Update mache folgende Schritte:"
		print
		print u"\t1. Kopiere deine Vorgänge an einen sicheren Ort von:"
		print u"\t   .\\Vorgangsreminder\\vorgaenge.db"
		print u"\t2. Lade die neue Version als ZIP hier herunter:"
		print u"\t   https://github.com/Pitastic/Vorgangsreminder/releases/latest"
		print u"\t3. Lösche den Ordner des Vorgangsreminders und entpacke den neuen"
		print u"\t4. Kopiere jetzt deine alte vorgaenge.db wieder in das Verzeichnis"
		print u"\t   .\\Vorgangsreminder\\vorgaenge.db"
		print
		raw_input("- beliebige Taste drücken -")