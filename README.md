# Vorgangsreminder
*Vorgangsverwaltungssystemmit verschiedenen Funktionen zur Erinnerung, Notizen und Archivierung.*


## Inhalt

- [Ziele des Tools](#Ziele)
- [Installation](#Installation)
- [Datenschutz](#Datenschutz)
- [Funktionen](#Funktionen)


<a name="Ziele"></a>
## Ziel des Tools

###Remind Me
Der Vorgangsreminder soll in erster Linie dazu dienen, an Vorgänge zu erinnern (*reminden*), die sonst evtl. unter einem Stapel verschwinden würden (z.B. durch lange Wartezeiten). Man behält nur das im Auge, was aktuell relevant und wichtig ist.

Neben der Terminierung hilft ein Protokoll schnell wieder den Einstieg in den Vorgang zu finden, bei dem man z.B. länger auf ein Ergebnis gewartet hat.


###Wer suchet, der findet
Außerdem gibt es Funktionen, auch nicht-dringliche Vorgänge später leicht wieder zu finden (z.B. bei Nachfragen oder bei ähnlichen Sachverhalten), ohne dass man in einem Stapel Vorblätter greifen muss.


###Workflows
Möchte man sehr eng mit dem Tool arbeiten bietet es außerdem auch vorgefertigte Workflows / Checklisten (wie ein vorgedrucktes Vorblatt) die eine effektive Abarbeitung bestimmter Phänomene einfach macht.


###Alles kann, nichts muss
Bei allen Funktionen besteht kein Anspruch darauf, etwas ausfüllen oder eingeben zu *müssen*. Das Tool ermöglicht es jedem Nutzer es in einer individuellen Tiefe zu nutzen.


<a name="Installation"></a>
##Installation

1. ZIP-Datei in der Download-Section des neuesten Realeses herunterladen:<br>
https://github.com/Pitastic/Vorgangsreminder/releases/latest
2. Datei entpacken zum Beispiel nach `/home/BENUTZER/Dokumente`. Dadurch wird ein Unterverzeichnis `Vorgangsreminder-1-X` angelegt.
3. In diesem Verzeichnis Rechtsklick auf die Datei `vn_reminder.py` und `Öffnen / Im Terminal ausführen` wählen.
  - *oder Alternativ*:
    - Terminal aus dem Startmenü öffnen
    - in das neue Verzeichnis wechseln und Datei ausführen<br>
    `cd /home/BENUTZER/Dokumente/Vorgangsreminder-1`<br>
    (drücken der `Tab-Taste` hilft bei der Pfadeingabe)
    - Datei starten<br>
    `./vn_reminder.py`

4. Gib folgende Adresse in den Internetbrowser (**nicht Intranetbrowser**) ein: <a href="http://localhost:8080">localhost:8080</a>
5. Im Vorgangsreminder-Ordner wurde mit dem ersten Aufruf eine neue Datei mit dem Namen `vorgaenge.db` erstellt. Hier werden alle Daten gespeichert. **Sichere diese Datei von Zeit zu Zeit und vor jedem Update !**
6. Das Programm läuft im Terminal. Mit dem Schließen wird auch der Vorgangsreminder beendet.


<a name="Datenschutz"></a>
##Datenschutz

Der Vorgangsreminder speichert alle deine Eingaben in einer Datenbankdatei (`vorgaenge.db`) direkt im Programmverzeichnis.

**Es verlassen keine Daten deinen PC / dein AFS Konto !**


<a name="Funktionen"></a>
##Funktionen

###Priorisierte Vorgangsliste
-

###Maßnahmen-Protokoll
-

###Workflows
-

###Suchfunktion und Hashtags &#35;
-
