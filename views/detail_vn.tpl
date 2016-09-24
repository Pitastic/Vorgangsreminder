<!doctype html>

<head>
	<meta charset="utf-8">
    <meta name="viewport" content="max-width=device-width", initial-scale="1.0">
	<link type="text/css" href="../style.css" rel="stylesheet">
	
	<title>Vorgangs-Reminder</title>
</head>

<body>
<header>
<h1>Reminder</h1>
</header>

		<form id="myForm" name="todo_aendern" onsubmit="post('/todo_aendern')">
<div class="content">
	<h2>Vorgangsnummer : {{vn}}
		<span>
			<select id="vn_status" name="status" onchange="this.className = this.value;">
				<option>aktiv</option><option>weitergeleitet</option><option>abgeschlossen</option>
			</select>
		</span>
	</h2>

	<h3 class="head_buttons">
		<label>Notizen :<input type="button" id="nT" value="+" onclick="newTree()"></label>
		<label><input type="button" id="nS" value="+++" onclick="insertWorkflow()"></label>
	</h3>
	<h3 class="head_buttons"><label># Tags :<input type="text" id="tags" size=25 value="{{tags}}" onchange="writeTags()"></label></h3>

	<section id="mySection">
		{{!todo}}
	</section>
<div class="pre-foot">
	<p>erstellt : {{created}}</p><p>geändert : {{changed}}</p>
</div>

	<input type="hidden" name="vn" value={{vn}}>
	<input type="hidden" id="hidden_tags" name="tags" value="{{tags}}">

</div>

<footer>
	<div class="wrapper">
		<a href="../drop_{{vn}}" class="button Abort">Löschen</a>
		<input type="date" id="remind_date" name="remind_date">
		<a href="../" id="back" class="button OK">Zurück</a>
		<input type="submit" class="save" value="Speichern">
	</div>
</footer>
		</form>

</body>

<script type="text/javascript" src="../script.js"></script>
<script type="text/javascript">
	var i;
	// Werte eintragen:
	var sel = document.getElementById('vn_status');
	sel.value = "{{notes}}";
	sel.className = "{{notes}}";
	var remDate = document.getElementById('remind_date');
	remDate.value = "{{remind_date}}";
	var uls = document.getElementsByTagName('ul');
	for (i=0;i<uls.length;i++){
		uls[i].addEventListener("keydown", listen);
		}
	writeTags();
</script>
</html>
