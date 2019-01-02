<!doctype html>

<head>
	<meta charset="utf-8">
    <meta name="viewport" content="max-width=device-width", initial-scale="1.0">
	<link type="text/css" href="style.css" rel="stylesheet">
	
	<title>Vorgangs-Reminder (v 1.1.4)</title>
</head>

<body>
<header>
<h1>Reminder</h1>
<h2>Auflistung aller Vorgänge</h2>
</header>


<div class="content">
    <ul id="alleV">
	%count = 1
	%for row in rows:
		<a href="./vorgang/{{row['vn']}}"><li>
			<span class="vn">{{row['vn']}}</span>
			<span class="tags">
				%for t in row['tags'].split(" "):
					#{{t}}&nbsp;
				%end
			</span>
			<div class="status"></div>
			<span class="remind">
				<p>{{checkRemind(row['remind_date'], True)}}</p>
				<p>(erstellt: {{dateFunc(row['created'], False)}})</p>
			</span>
			<div class="clearer"></div>
			%count += 1
		</li></a>
	%end
    </ul>
</div>
<footer>
    <form name="Vorgang_neu" action="/new">
        <a id="suche" class="button OK" onclick="sucheVN()">- -</a>
		<input type="submit" value="Neuer Vorgang">
		<input type="text" name="VN" placeholder="VN / Suche :" required=required>
	</form>
</footer>
</body>
<script type="text/javascript" src="../script.js"></script>
<script type="text/javascript">
	setTimeout(function(){
		var lampe, row, allStatus = document.getElementsByClassName('remind');
		for (var i=0;i<allStatus.length;i++){
			row = allStatus[i].querySelector('p');
			lampe = allStatus[i].parentNode.getElementsByClassName('status')[0];
			if (row.innerHTML == "Heute"){
				lampe.classList.add("dringend");
			}else if (row.innerHTML == "Morgen" || row.innerHTML == "in ca. 2 Tagen" || row.innerHTML == "in ca. 3 Tagen"){
				lampe.classList.add("bald");
			}else if (row.innerHTML == "- - -"){
				lampe.classList.add("weg");
			}else{
				lampe.classList.add("ok");
			}
		}
	},10);
</script>
</html>
