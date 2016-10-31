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
	- in das neue Verzeichnis wechseln<br>
	`cd /home/BENUTZER/Dokumente/Vorgangsreminder-1`<br>
	(drücken der `Tab-Taste` hilft bei der Pfadeingabe)
	- und Datei ausführen<br>
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

Die Bedienung ist eigentlich selbst erklärend, wenn man es einmal mit ein paar Dummy-Einträgen getestet hat. Nach dem Testen lösche einfach die `vorgaenge.db` und starte das Programm (den Server) neu.

Ein paar Kern-Features werden hier nur kurz dargestellt:

###Priorisierte Vorgangsliste
Jeder Vorgang wird anhand seines RemindMe-Datums absteigend in der Gesamtübersicht aufgelistet. Auf einen Blick finden sich hier Grundinformationen, wie Vorgangsnummer, Schlagwort (Hashtag), Erstelldatum und das RemindMe-Datum. Letzteres wird durch die Ampelfarben noch etwas verdeutlicht.
<img src="https://cloud.githubusercontent.com/assets/6623286/19868939/824bc850-9faa-11e6-8f40-ebfc4d427cee.png">

Angezeigt werden in der Sortierung nur *aktive* Vorgänge (s.u.) und danach alle *weitergeleiteten*. Vorgänge die *endabgegeben* sind, werden ausgeblendet, sind aber noch recherchierbar (s.u.).

Ganz unten auf der Seite findest du das multifunktionale Vorgangsnummern-Feld, mit dem man neue Vorgänge anlegen oder eine Suche durchführen kann.

####neuer Vorgang
Zum Anlegen eines neuen Vorgangs musst du nur eine valide Vorgangsnummer in das Feld unten eingeben und auf `Enter` oder auf den Button `Neuer Vorgang` klicken. Wenn du bei der nächsten Meldung wieder `Enter` drückst oder auf die Nummer klickst, landest du direkt im neuen Vorgang.

####Suchfunktion und Hashtags &#35;
Im selben Vorgangsnummer-Feld kannst du auch mit dem Klick auf den Suchen-Button unten links die Vorgangsnummer direkt aufrufen. Es reicht auch, wenn du entweder Teile einer Nummer oder Teile eines Schlagworts eingibts, um auf eine Liste mit Suchergebnissen zu gelangen.

In den letzten beiden Fällen kannst du sogar auch wieder einfach auf `Enter` drücken.

###Maßnahmen-Protokoll
In dieser Übersicht kannst du ein Schlagwort für diesen Vorgang vergeben, den Status des Vorgangs setzen (aktiv, weitergeleitet, abgeschlossen) und das RemindMe Datum ändern (zuerst standardmäßig 7 Tage).

Mit einem Klick auf `+` kannst du außerdem einen neuen Eintrag anlegen, den du entweder nur mit einer Zeile oder (indem du einfach mit Absätzen weiter schreibst) mit einer Überschrift und meheren Spiegelstrichen versehen kannst.
<img src="https://cloud.githubusercontent.com/assets/6623286/19868946/86e1a8c6-9faa-11e6-8026-2b0725cbfaf1.png">

Vergiss nach den Änderungen nicht auf `Speichern` zu drücken.

###Workflows

Für ein schnelles Grundgerüst gibt es für manche Vorgangsarten vorgefertigte Workflows, die einen Satz Standardeinträge mit einem Klick auf `+++` einfügen. Die Module sollen durch dein Feedback erweitert werden und thematisch besser zugeschnitten sein. Wenn dir also etwas fehlt, schreib mir eine Mail und oder erstelle dir ein eigenes Modul (siehe unten).
<img src="https://cloud.githubusercontent.com/assets/6623286/19868952/8aa04f08-9faa-11e6-8d98-d72258c940b7.png">

####eigene Workflows erstellen

Die auswählbaren Workflows befinden sich um Unterordner

	Vorgangsreminder/modules/modulName.mod

Kopiere eines der Module und passe die Einträge mit einem Texteditor an. Es darf kein Modulname doppelt vorkommen.

- im Abschnitt `[DEFAULT]`
	- `modul` : Name des Moduls, wie es in der Liste auftauchen soll
- `[Eintrag ?]` : Jeder Abschnitt wird später ein eigener Eintrag
	- `li1` : Überschrift des Eintrags
	- `li?` : optional weitere Spiegelstriche in diesem Eintrag

**Bedenke, dass mit jedem Update diese Module überschrieben werden. Du solltest sie also auch vorher sichern !**
