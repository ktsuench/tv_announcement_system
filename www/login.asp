
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
		<meta name="description" content="Riverdale Collegiate Institute Dashboard - Login"/>
		<title>Riverdale Collegiate Institute Dashboard - Login</title>
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
		<link rel="stylesheet" type="text/css" href="css/signin.css"/>
		<style>.alert-float{bottom:0px; right:10px;}</style>
		<!--Template-->
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries--><!--[if lt IE 9]>
		<script type="text/javascript" src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script type="text/javascript" src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
		<!--End Template-->
	</head>
	<body class="body-nav-offcanvas">
		<%
			if request("a")="l" then session.contents.removeall()
			
			dim verified, clearance
			dim stat, referrer, errMsg
			
			verified=session("verified")
			
			if verified then
				baseURL=request.servervariables("URL")
				strURL=mid(baseURL,1,instrrev(baseURL,"/"))
			
				response.redirect(strURL&"dashboard.asp") 
			else
				session("verified")=false
				stat=session("status")
				referrer=request.servervariables("HTTP_REFERER")
				errMsg=session("error_message")
			
				if isempty(stat) or isnull(stat) then stat=0
		%>
		<!--Header--><!--#include file="includes/nav.inc"-->
		<!--#include file="includes/nav_sw.inc"-->
		<!--#include file="includes/nav_top.inc"-->
		<!--Content-->
		<div class="site-wrap">
			<div class="container-fluid">
				<%
					if session("pass_attempts") < 3 then
						if stat<>0 and instr(referrer,"login.asp")>-1 then
				%>
				<div role="alert" class="alert alert-float alert-danger alert-dismissible">
					<button data-dismiss="alert" class="close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span>
						<%
							if errMsg<>"User does not exist." then
								dim n, strtemp
								n=3-session("pass_attempts")
								strtemp=" tries"
								if n < 2 then strtemp=" try"
							end if
						%><strong>Login Failure - <%=errMsg%></strong><br>
						<%if errMsg<>"User does not exist." then%>You have <%=n&strtemp%> left.
						<%end if%></span>
				</div>
				<%    end if%>
				<div class="row">
					<form id="loginfrm" method="post" action="login_val.asp" role="form" class="form-signin center-block">
						<div class="panel panel-rci">
							<div class="panel-heading"><img id="crest" src="images/crest.png" width="200" class="center-block">
								<h2 class="form-signin-heading">RCI Dashboard Login</h2>
							</div>
							<div class="panel-body">
								<div class="lblOverlay"></div>
								<div class="lblOverlay">
									<input id="email" type="email" name="email" required autofocus autocomplete="off" class="form-control input-lg">
									<label for="email">Email Address</label>
								</div>
								<div class="lblOverlay">
									<input id="pass" type="password" name="password" required autocomplete="off" class="form-control input-lg">
									<label for="pass">Password</label>
								</div>
								<!--
								.checkbox
								label
									input(type='checkbox' value='remember-me') Remember me
								-->
							</div>
							<div class="panel-footer">
								<button type="submit" class="btn btn-lg btn-success btn-block">Sign in</button>
							</div>
						</div>
					</form>
				</div>
				<%else%>
				<div class="row">
					<form id="loginfrm" method="post" action="login.asp" encType="multipart/form-data" role="form" class="form-signin center-block">
						<div class="panel panel-rci">
							<div class="panel-heading"><img id="crest" src="images/crest.png" width="200" class="center-block">
								<h2 class="form-signin-heading">RCI Dashboard Login</h2>
							</div>
							<div class="panel-body">
								<h4 class="text-center">Login Failure - <%=errMsg%></h4>
								<h4 class="text-center">You have no more tries left.</h4>
								<%session.timeout=1%>
								<h4 id="countdown" class="text-center"></h4>
								<!--Jquery-->
								<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
								<!--Countdown-->
								<script type="text/javascript" src="js/jquery.plugin.min.js"></script>
								<script type="text/javascript" src="js/jquery.countdown.min.js"></script>
								<script type="text/javascript">
									var timeout_reset;
									$('#countdown').countdown({
										until:timeout_reset,
										format:'MS',
										expiryUrl:window.location.href,
										padZeroes:true,
										significant:00,
										layout:'Try again in {mnn} {ml} {snn} {sl}.'
									}); 
									timeout_reset=new Date();                                     
									timeout_reset.setSeconds(timeout_reset.getSeconds()+((<%=session.timeout%>+1)*60)); 
									$('#countdown').countdown('option', {until:timeout_reset});
								</script>
							</div>
							<div class="panel-footer">
								<button type="submit" disabled class="btn btn-lg btn-success btn-block">Sign in</button>
							</div>
						</div>
					</form>
				</div>
				<%end if%>
			</div>
		</div>
		<!--Footer--><!--#include file="includes/nav_bottom.inc"--> 
		<!--Bootstrap core JavaScript-->
		<!--Placed at the end of the document so the pages load faster-->
		<%if session("pass_attempts") < 3 then%>
		<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
		<%end if%>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<!--IE10 viewport hack for Surface/desktop Windows 8 bug-->
		<script type="text/javascript" src="js/ie10-viewport-bug-workaround.js"></script>
		<!--Jquery Easing for Form-->
		<script type="text/javascript" src="js/jquery.easing.min.js"></script>
		<!--Form Animation-->
		<script type="text/javascript" src="js/labelAnimate.min.js"></script>
		<!--Document Resize-->
		<script type="text/javascript" src="js/fullsize.min.js"></script>
		<script type="text/javascript">
			function adjustPlacement(){if($('.form-signin').height()<(window.innerHeight-$('#header').height()-$('#footer').height())){$('.form-signin').css('margin-top',window.innerHeight-$('#header').height()-$('#footer').height()-$('.site-wrap').height()/2-parseInt($('.site-wrap').css('padding-top'))/2-$('.form-signin').height()/2);}}
			$(document).ready(adjustPlacement());
			$(window).resize(function(){adjustPlacement();$('body').css('height',window.innerHeight-$('#header').height()-$('#footer').height());});
		</script>
		<%end if%>
		<!--Template-->
		<script type="text/javascript" src="js/HTML_Inspector.js"></script>
		<!--End Template-->
	</body>
</html>