<!doctype html>

<head>
	<meta charset="utf-8">
    <meta name="viewport" content="max-width=device-width", initial-scale="1.0">
	<link type="text/css" href="style.css" rel="stylesheet">
	<link type="text/css" href="../style.css" rel="stylesheet">
	
	<title>Vorgangs-Reminder</title>
</head>

<body>
<header>
<h1>Reminder</h1>
<h2>{{heading}}</h2>
</header>

<div class="content">
<ul id="alleV">
	<li class="{{msg_class}}">
	{{msg}}<a href={{span_link}}>{{span_msg}}</a>
	</li>
</ul>
</div>

<footer><a href="../" class="button OK alone">Zurück</a></footer>
</body>
<script type="text/javascript" src="../script.js"></script>
<script>
document.body.addEventListener('keypress', function (e) {
	var key = e.which || e.keyCode;
	if (key == 13) {
		window.location = "{{span_link}}"
	}
});
</script>
</html>
