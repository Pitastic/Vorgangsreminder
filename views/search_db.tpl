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
<h2>Suchergebnis für *{{query[1:-1]}}*</h2>
</header>


<div class="content">
    <ul id="alleV">
   %for row in rows:
		<a href="../vorgang/{{row['vn']}}"><li>
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
		</li></a>
	%end
    </ul>
</div>
<footer>
		<a href="/" class="button OK alone">zurück</a>
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
