#!/usr/bin/env python
# -*- coding: utf-8 -*-

#============== INFO ===========================#
#												#
# Erstellt:										#
# Dezember 2015 von Michael Prior, PK 			#
# michael.prior@polizei.niedersachsen.de 		#
#												#
# Beschreibung:									#
# WebApp zur Vorgangsübersicht & Erinnerung. 	#
# Als Merkzettel oder zur Dokumentation fuer	#
# eine gewissenhafte Vorgangsbearbeitung ;)		#
# Basierend auf einer lokalen sqlite3 Datenbank.#
#												#
#===============================================#

import sqlite3
import time
import codecs
import math
import sys
from os import listdir
import re
import ConfigParser
from bottle import Bottle, PasteServer, static_file, route, run, template, request, redirect

# Global Variables
app = Bottle()
db_file = 'vorgaenge.db'

# Allgemeine Funktionen
def createDB():
	conn = sqlite3.connect(db_file)
	cur = conn.cursor()
	cur.execute("CREATE TABLE IF NOT EXISTS vorgaenge (id INTEGER PRIMARY KEY AUTOINCREMENT, vn INTEGER UNIQUE, created DATETIME DEFAULT CURRENT_TIMESTAMP, changed DATETIME DEFAULT CURRENT_TIMESTAMP, notes TEXT DEFAULT 'aktiv', todo TEXT, remind_date TEXT)")
	conn.commit()
	cur.execute("PRAGMA table_info(vorgaenge)")
	columns = []
	for r in cur:
		columns.append(r[1])
	if not 'tags' in columns:
		cur.execute("ALTER TABLE vorgaenge ADD tags TEXT DEFAULT 'Vorgang'")
	conn.close()
	return

def formDate(string, bol_time):
	# Datum von SQLite nach sauberen String
	arr_Monate = ['none', 'Januar', 'Februar', u'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember']
	arr_datum = string.split(' ')
	datum = arr_datum[0].split('-')
	datum = datum[2]+". "+arr_Monate[int(datum[1])]+" "+datum[0]
	zeit  = unicode(int(arr_datum[1].split(':')[0])+2)+":"+arr_datum[1].split(':')[1]+" Uhr"
	if bol_time:
		return datum+" , um "+zeit
	else:
		return datum

def formDate2(secs):
	# Datum von Sekunden nach Datum
	secs = time.localtime(float(secs))
	secs = time.strftime("%Y-%m-%d", secs)
	return secs
	
		
def diffDate(vergangenheit):
	now = time.time() # Sekunden
	vergangenheit = vergangenheit.split(' ')
	vergangenheit_datum = map(int, vergangenheit[0].split('-')[:3])
	vergangenheit_zeit = map(int, vergangenheit[1].split(':')[:2])
	vergangenheit = time.mktime((int(vergangenheit_datum[0]), int(vergangenheit_datum[1]), int(vergangenheit_datum[2]),int(vergangenheit_zeit[0]),int(vergangenheit_zeit[1]),0,0,0,0))
	now_tage = now/(3600*24)
	vergangenheit_tage = vergangenheit/(3600*24)
	diff = now_tage-vergangenheit_tage
	if diff<0.75:
		diff = "Heute"
	elif diff>0.75 and diff<1.75:
		diff = "Gestern"
	elif diff>1.75:
		diff = "vor "+str(int(round(diff)))+" Tagen"
	return diff

def checkRemind(zukunft, bol_raw):
	# Check zwischen jetzt und Reminder
	now = time.time()
	if not bol_raw:
		now = int(round(now/(3600*24)))
		zukunft = map(int, zukunft.split('-'))
		zukunft = time.mktime((int(zukunft[0]), int(zukunft[1]), int(zukunft[2]),6,0,0,0,0,0))
		zukunft = zukunft/(3600*24)
	else:
		zukunft = int(round(float(zukunft)))
	diff = int(math.ceil(float(zukunft-now)/(3600*24)))
	if diff < 0:
		diff = "- - -"
	elif diff == 0:
		diff = "Heute"
	elif diff == 1:
		diff = "Morgen"
	elif diff>1:
		diff = "in ca. "+str(diff)+" Tagen"
	return diff

def myResult(cur, arr_fields):
	result = []
	for row in cur:
		r = {}
		for f in arr_fields:
			r[f] = row[f]
		result.append(r)
	return result

def getConfigs():
	configs = {}
	confs = listdir('./modules')
	for x in confs:
		c = ConfigParser.ConfigParser()
		c.read('modules/'+x)
		m_defaults = c.defaults()
		m_name = m_defaults['modul']
		#c.get('DEFAULT', 'modul')
		configs[m_name] = []
		for s in c.sections():
			c_list = []
			for item in c.options(s):
				if not item in m_defaults:
					c_list.append(c.get(s,item))
			if c_list:
				configs[m_name].append(c_list)
	return configs

# Static Files
@app.route('/<filename:re:.*\.css>')
def stylesheets(filename):
	return static_file(filename, root='css')
@app.route('/<filename:re:.*\.(jpg|png|gif|ico)>')
def images(filename):
	return static_file(filename, root='img')
@app.route('/<filename:re:.*\.js>')
def images(filename):
	return static_file(filename, root='js')


# Routings
@app.route('/')
def show_db():
	count = 1
	conn = sqlite3.connect(db_file)
	conn.row_factory = sqlite3.Row
	cur = conn.cursor()
	cur.execute("SELECT * FROM vorgaenge WHERE notes != 'abgeschlossen' ORDER BY notes, remind_date")
	conn.commit()
	r = myResult(cur, ['vn', 'created', 'remind_date', 'tags'])
	conn.close()
	return template('gesamte_db', rows=r, dateFunc=formDate, dateDiff=diffDate, checkRemind=checkRemind)


@app.route('/new', method='GET')
def createVN():
	vn = request.GET.get('VN', '').strip()
	if not re.search(r"\d{12}", vn):
		redirect("suche/"+vn,303)
	remind_date = time.time()+(7*3600*24)
	conn = sqlite3.connect(db_file)
	cur = conn.cursor()
	try:
		cur.execute("INSERT INTO vorgaenge (vn, remind_date) VALUES (?, ?)",[vn, remind_date])
	except conn.IntegrityError, e:
		conn.commit()
		heading = "Achtung !"
		msg_class = "error"
		msg = "Vorgang existiert schon : "
		span_msg = vn
		return template('msg.tpl', heading=heading, msg_class=msg_class, span_msg=span_msg, span_link="/vorgang/"+vn, msg=msg)
	except Exception, e:
		conn.commit()
		conn.close()
		heading = "Befehl wurde nicht ausgeführt !"
		msg_class = "error"
		msg = "Fehlermeldung : "
		span_msg = e.args[0]
		return template('msg.tpl', heading=heading, msg_class=msg_class, span_msg=span_msg, span_link="/", msg=msg)
	conn.commit()
	heading = "Neuer Vorgang wurde angelegt !"
	msg_class = "success"
	msg = "Nummer des neuen Vorgangs : "
	span_msg = vn
	span_link = "../vorgang/"+vn
	return template('msg.tpl', heading=heading, msg_class=msg_class, span_msg=span_msg, span_link=span_link, msg=msg)


@app.route('/vorgang/:vn')
def show_vn(vn):
	conn = sqlite3.connect(db_file)
	conn.row_factory = sqlite3.Row
	cur = conn.cursor()
	cur.execute("SELECT * FROM vorgaenge WHERE vn=?",[vn,])
	notes = None
	module = getConfigs()
	for row in cur:
		notes = row['notes']
		created = formDate(row['created'], False)
		changed = formDate(row['changed'], True)
		todo = row['todo'] if row['todo'] else ""
		remind_date = formDate2(row['remind_date'])
		tags = row['tags']
	conn.commit()
	conn.close()
	if notes:
		return template('detail_vn.tpl', created=created, vn=vn, tags=tags, notes=notes, changed=changed, todo=todo, remind_date=remind_date, module=module)
	else:
		heading = "Vorgangs wurde nicht gefunden !"
		msg_class = "error"
		msg = "Kein Vorgang in der Datenbank vorhanden. VN : "
		span_msg = vn
		return template('msg.tpl', heading=heading, msg_class=msg_class, span_msg=span_msg, span_link="/", msg=msg)


@app.route('/todo_aendern', method='POST')
def todo_aendern():
	conn = sqlite3.connect(db_file)
	cur = conn.cursor()
	stodo = request.forms.get('todo_text', '').strip()
	stodo = stodo.decode('utf-8')
	vn = request.forms.get('vn', '').strip()
	remind_date = request.forms.get('remind_date', '').strip()
	remind_date = map(float, remind_date.split('-'))
	remind_date = time.mktime((int(float(remind_date[0])), int(float(remind_date[1])), int(float(remind_date[2])),0,0,0,0,0,0))
	status = request.forms.get('status', '').strip()
	tags = request.forms.get('tags', '').strip()
	try:
		cur.execute("UPDATE vorgaenge SET todo=?, changed=CURRENT_TIMESTAMP, remind_date=?, notes=?, tags=? WHERE vn=?", [stodo, remind_date, status, tags, vn])
	except conn.Error, e:
		conn.commit()
		heading = "Befehl wurde nicht ausgeführt !"
		msg_class = "error"
		msg = "Fehlermeldung : "
		span_msg = e.args[0]
		return template('msg.tpl', heading=heading, msg_class=msg_class, span_msg=span_msg, span_link="/", msg=msg)
	conn.commit()
	conn.close()
	redirect('/')

@app.route('/suche/:query')
def sucheTag(query):
	query = "%"+query+"%"
	conn = sqlite3.connect(db_file)
	conn.row_factory = sqlite3.Row
	cur = conn.cursor()
	cur.execute("SELECT * FROM vorgaenge WHERE vn LIKE ? OR tags LIKE ? ORDER BY vn", [query, query])
	conn.commit()
	r = myResult(cur,['vn', 'remind_date', 'tags', 'created'])
	conn.close()
	return template('search_db', rows=r, query=query, dateFunc=formDate, dateDiff=diffDate, checkRemind=checkRemind)

@app.route('/drop_:vn')
def drop_VN(vn):
	conn = sqlite3.connect(db_file)
	cur = conn.cursor()
	cur.execute("DELETE FROM vorgaenge WHERE vn=?", [vn])
	conn.commit()
	conn.close()
	heading = "Vorgang gelöscht !"
	msg_class = "error"
	msg = "Nummer des gelöschten Vorgangs : "
	span_msg = vn
	return template('msg.tpl', heading=heading, msg_class=msg_class, span_msg=span_msg, span_link="/", msg=msg)


@app.route('/dropDB')
def drop():
	conn = sqlite3.connect(db_file)
	cur = conn.cursor()
	cur.execute("DROP TABLE vorgaenge")
	conn.commit()
	conn.close()
	heading = "Datenbank gelöscht !"
	msg = "Es wurde die gesamte Datenbank gelöscht. Der Server muss "
	span_msg = "neu gestartet werden !"
	msg_class = "error"
	return template('msg.tpl', heading=heading, msg_class=msg_class, span_msg=span_msg, span_link="/", msg=msg)

# Start Service
createDB()
run(app, host='127.0.0.1', port=8080, server=PasteServer, debug=True)
