var keys = []; // Array für multiple KeyEvents


function newTree(counter){
// neuen Tree anlegen (inkl Header)
	// Erstelle unique ID
	var t = new Date().getTime().toString();
	if (counter) {
		t += counter;
	}
	
	// Erstelle Tree
	var ul = document.createElement('ul');
	var li = document.createElement('li');
	ul.setAttribute("contenteditable", "true");
	ul.setAttribute("data-gruppe", t);
	ul.className = "tree";
	ul.appendChild(li);
	
	var sec = document.getElementById('mySection');
	sec.insertBefore(ul, sec.childNodes[0]);
	
	// EventListener für das neue UL
	ul.addEventListener("input", listenKey);
	
	// Erstelle Header-Funktionen
	var div = document.createElement('div');
		div.setAttribute("contenteditable", "false");
		div.setAttribute("data-gruppe", t);
	var outer = document.createElement('div');
	var span = document.createElement('span');
		span.className = "termin nichts";
		span.setAttribute('data-name', 'termin');
		span.setAttribute('title', 'Status');
		span.setAttribute('onclick', "tglTermin(this)");
	outer.appendChild(span);
	span = document.createElement('input');
		span.setAttribute('type', 'button');
		span.setAttribute('value', '\u2195');
		span.setAttribute('title', 'Nach oben');
		span.setAttribute('onclick', "moveUp(this)");
	outer.appendChild(span);
	span = document.createElement('input');
		span.setAttribute('type', 'button');
		span.setAttribute('value', '\u27F2');
		span.setAttribute('title', 'Box neu laden');
		span.setAttribute('onclick', "refTree(this)");
	outer.appendChild(span);
	span = document.createElement('input');
		span.setAttribute('type', 'button');
		span.setAttribute('value', '\u2613');
		span.setAttribute('title', 'Löschen');
		span.setAttribute('onclick', "delTree(this)");
	outer.appendChild(span);	
	div.appendChild(outer);
	
	sec.insertBefore(div, sec.childNodes[0]);
	return t;
}

function listenKey(e){
	// EventListener
	var lis = e.target.getElementsByTagName('li');
	for (i=0;i<lis.length;i++){
		lis[i].addEventListener('click', pressKeys, true);
	}
	return true;
}

function pressKeys(e){
	// Check ob CTRL
	if (e.ctrlKey){
		timeStamp(e.target);
		e.preventDefault();
	}
	// Check ob ALT
	if (e.altKey){
		e.target.classList.toggle('indented');
		e.preventDefault();
	}
	// Check ob ESC
	if (e.keyCode == 27) {
		closePop();
	}
}

function timeStamp(element){
	var s = new Date();
	var tag = (s.getDate()>9) ? s.getDate() : "0"+s.getDate();
	var monat = s.getMonth()+1;
	var jahr = s.getFullYear().toString().substring(2,4);
	monat = (monat>9) ? monat : "0"+monat;
	var text = element.innerHTML;
	// lösche End-Breaks
	if (text.substr(-4) == "<br>"){text = text.substr(0,text.length-4)}
	element.innerHTML = text+" ("+tag+"."+monat+"."+jahr+")";
}

function moveUp(element) {
	var i, new_index;
	var mySection = document.getElementById('mySection');
	var uni_id = element.parentNode.parentNode.getAttribute('data-gruppe');
	var toMove = document.querySelectorAll("[data-gruppe='"+uni_id+"']");
	// finde den Index des vorherigen Eintrags im DOM (-2)
	var prev_element = [].indexOf.call(mySection.children, toMove[0]) - 2;
	if (prev_element >= 0) {
		for (let el = 0; el < toMove.length; el++) {
			mySection.insertBefore(toMove[el], mySection.childNodes[prev_element + el]);
		}
	}
}

function tglTermin(element){
	var termine = ["nichts", "warten", "erledigt"];
	var stat = element.classList[1];
	var new_stat = termine.indexOf(stat)
	if (new_stat==2){
		new_stat = termine[0];
	}else{
		new_stat = termine[new_stat+1];
	}
	element.classList.remove(stat);
	element.classList.add(new_stat);
	element.preventDefault;
	return true;
}

function delTree(element){
// eigenen Tree löschen
	var i;
	var mySection = document.getElementById('mySection');
	var uni_id = element.parentNode.parentNode.getAttribute('data-gruppe');
	toDelete = document.querySelectorAll("[data-gruppe='"+uni_id+"']");
	for (i=0;i<toDelete.length;i++){
		mySection.removeChild(toDelete[i]);
	}
	return true;
}

function refTree(element) {
// ul leeren und neues li einfügen
	var mySection = document.getElementById('mySection');
	var uni_id = element.parentNode.parentNode.getAttribute('data-gruppe');
	var old_ul = document.querySelector("ul[data-gruppe='"+uni_id+"']");
	// Erstelle Tree
	var ul = document.createElement('ul');
	var li = document.createElement('li');
	ul.setAttribute("contenteditable", "true");
	ul.setAttribute("data-gruppe", uni_id);
	ul.className = "tree";
	ul.appendChild(li);
	// Replace
	mySection.replaceChild(ul, old_ul);
}

function sucheVN(){
	vn = document.forms.Vorgang_neu.VN.value;
	if (!vn || vn=="") {
		alert("FEHLER: Gib eine Vorgansnummer oder Suchbegriff an!");
		return;
	}else if (vn && /\d{13}/i.test(vn)) {
		// Query ist VN
		window.location = "vorgang/"+vn;
	}else{
		// Query ist etwas anderes (Tags)
		window.location = "suche/"+vn;
	}

	return;
}

function writeTags() {
	document.getElementById('hidden_tags').value = document.getElementById('tags').value;
	return;
}

function popUp() {
	var f = document.getElementById('fadeBlack');
	f.classList.remove('hide');
	document.getElementsByClassName('popUp')[0].classList.remove('hide');
	window.addEventListener('keydown', closePop);
	return;
}

function closePop() {
	var f = document.getElementById('fadeBlack');
	if (f) {
		f.classList.add('hide')
		document.getElementsByClassName('popUp')[0].classList.add('hide');
		window.removeEventListener('keydown', closePop);
	}
	return;
}

function post(path) {
	// Formulardaten und innerHTML als POST absenden
	var form = document.getElementById('myForm');
	form.setAttribute("method", "POST");
	form.setAttribute("action", path);

	var param = document.getElementById('mySection').innerHTML;

	var hiddenField = document.createElement("input");
	hiddenField.setAttribute("type", "hidden");
	hiddenField.setAttribute("name", 'todo_text');
	hiddenField.setAttribute("value", param);

	form.appendChild(hiddenField);

	document.body.appendChild(form);
	form.submit();
	return true;
}	
