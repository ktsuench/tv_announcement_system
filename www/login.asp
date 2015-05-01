
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta name="description" content="Dashboard Login - Riverdale Collegiate Institute Announcements"/>
		<title>Dashboard Login - Riverdale Collegiate Institute Announcements</title>
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
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries-->
		<!--[if lt IE 9]>
		<script type="text/javascript" src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script type="text/javascript" src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
		<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="css/nav.css"/>
		<link rel="stylesheet" type="text/css" href="css/signin.css"/>
		<style>
			.alert-float{bottom:0px; right:10px;}
			.align-vertical{position:absolute;top:50%;left:50%;transform:translateY(-50%) translateX(-50%);}
		</style>
	</head>
	<body class="body-nav-offcanvas">
		<%
			if request("a")="l" then session.contents.removeall()
			
			dim verified, clearance
			dim status, referrer, errMsg
			
			verified=session("verified")
			
			if verified then
				baseURL=request.servervariables("URL")
				strURL=mid(baseURL,1,instrrev(baseURL,"/"))
			
				response.redirect(strURL&"dashboard.asp") 
			else
				session("verified")=false
				status=session("status")
				referrer=request.servervariables("HTTP_REFERER")
				errMsg=session("error_message")
			
				if isempty(status) or isnull(status) then status=0
		%>
		<!--______________________Header_______________________-->
		<!--#include file="includes/nav.inc"-->
		<!--#include file="includes/nav_sw.inc"-->
		<!--#include file="includes/nav_top.inc"-->
		<!--______________________Content______________________-->
		<div class="site-wrap">
			<div class="container-fluid">
				<%
					if session("pass_attempts") < 3 then
						if status<>0 and instr(referrer,"login.asp")>-1 then
				%>
				<div role="alert" class="alert alert-float alert-danger alert-dismissible">
					<button data-dismiss="alert" class="close">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
					<span>
						<%
							if errMsg<>"User does not exist." then
								dim n, strtemp
								n=3-session("pass_attempts")
								strtemp=" tries"
								if n < 2 then strtemp=" try"
							end if
						%>
						<strong>Login Failure - <%=errMsg%></strong>
						<br>
						<%if errMsg<>"User does not exist." then%>You have <%=n&strtemp%> left.
						<%end if%>
					</span>
				</div>
				<%end if%>
				<div class="row">
					<form id="loginfrm" method="post" action="login_val.asp" role="form" class="form-signin center-block">
						<div class="panel panel-rci">
							<div class="panel-heading">
								<img id="crest" src="images/crest.png" width="200" class="center-block">
								<h2 class="text-center">Riverdale Collegiate<br/>Institute</h2>
							</div>
							<div id="body-heading">
								<h2 class="text-center">Dashboard Login</h2>
							</div>
							<div class="panel-body">
								<div class="form-group">
									<label for="email" style="margin:0;" class="h4">Email Address</label>
									<input id="email" type="email" name="email" placeholder="someone@example.com" required autofocus autocomplete="off" class="form-control input-md">
								</div>
								<div class="form-group">
									<label for="pass" style="margin:0;" class="h4">Password</label>
									<input id="pass" type="password" name="password" placeholder="password" required autocomplete="off" class="form-control input-md">
								</div>
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
						<div class="panel panel-rci align-vertical">
							<div class="panel-heading">
								<img id="crest" src="images/crest.png" width="200" class="center-block">
								<h2 class="form-signin-heading">RCI Dashboard Login</h2>
							</div>
							<div class="panel-body">
								<h4 class="text-center">Login Failure - <%=errMsg%></h4>
								<h4 class="text-center">You have no more tries left.</h4>
								<%session.timeout=1%>
								<h4 id="countdown" class="text-center"></h4>
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
		<!--______________________Footer_______________________-->
		<!--#include file="includes/nav_bottom.inc" -->
		<!--Bootstrap core JavaScript-->
		<!--Placed at the end of the document so the pages load faster-->
		<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<!--IE10 viewport hack for Surface/desktop Windows 8 bug-->
		<script type="text/javascript" src="js/ie10-viewport-bug-workaround.js"></script>
		<%end if%>
		<script type="text/javascript">$('.nav-offcanvas a#nav-link').on('click',function(){$('#nav-offcanvas-toggle').click()});
		</script>
	</body>
</html>