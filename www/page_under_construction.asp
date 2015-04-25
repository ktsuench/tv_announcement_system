
<!--Bare Template-->
<%'@language=vbscript%>
<%'option explicit%>
<!--End Bare Template-->
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--Template-->
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="author" content="">
		<link rel="icon" href="images/favicon.ico">
		<!--End Template-->
		<meta name="description" content="Riverdale collegiate Institute Dashboard - Page Under Construction"/>
		<title>Riverdale collegiate Institute Dashboard - Page Under Construction</title>
		<!--Template-->
		<%
			if instr(baseURL,"upload.asp")=-1 then
				const adLockOptimistic=3
				const adOpenDynamic=2
				const adAddNew=16778240
				const adDelete=16779264
				const adUpdate=16809984
				const adUpdateBatch=65536
			end if
			
			dim baseURL, strURL
		%>
		<!--End Template-->
		<!--Template-->
		<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<!--End Template-->
		<style>body{padding-top:40px; padding-bottom:40px; background-color:#eee;}</style>
		<!--Template-->
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries--><!--[if lt IE 9]>
		<script type="text/javascript" src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script type="text/javascript" src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
		<!--End Template-->
	</head>
	<body class="body-nav-offcanvas">
		<!--Header-->
		<!--#include file="includes/nav.inc"-->
		<!--#include file="includes/nav_sw.inc"-->
		<!--#include file="includes/nav_top.inc"-->
		<!--Content-->
		<div class="site-wrap">
			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-8 col-md-6 col-sm-push-4 col-md-push-3">
						<div class="jumbotron">
							<h1>Page is<br/>currently under<br/>construction. </h1>
							<p>Please visit back again some time, the page will be finished by then! Hopefully...</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Footer-->
		<!--#include file="includes/nav_bottom.inc"-->
		<!--Bootstrap core JavaScript-->
		<!--Placed at the end of the document so the pages load faster-->
		<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<!--IE10 viewport hack for Surface/desktop Windows 8 bug-->
		<script type="text/javascript" src="js/ie10-viewport-bug-workaround.js"></script>
		<!--Document Resize-->
		<script type="text/javascript" src="js/fullsize.min.js"></script>
		<script type="text/javascript">
			function adjustPlacement(){if($('.jumbotron').height()<(window.innerHeight-$('#header').height()-$('#footer').height())){$('.jumbotron').css('margin-top',window.innerHeight-$('#header').height()-$('#footer').height()-$('.site-wrap').height()/2-parseInt($('.site-wrap').css('padding-top'))/2-$('.jumbotron').height()/2-parseInt($('.jumbotron').css('padding-top'))*2);}}
			$(document).ready(adjustPlacement());
			$(window).resize(function(){adjustPlacement();$('body').css('height',window.innerHeight-$('#header').height()-$('#footer').height());});
		</script>
		<!--Template-->
		<script type="text/javascript" src="js/HTML_Inspector.js"></script>
		<!--End Template-->
	</body>
</html>