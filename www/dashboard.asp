
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
		<meta name="description" content="Riverdale Collegiate Institute - Announcement Dashboard"/>
		<title>Riverdale Collegiate Institute - Announcement Dashboard</title>
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
		<%
			dim strSQL, objConn, objRS
			
			baseURL=request.servervariables("URL")
			
			session("sessionStart")=now()
			
			strSQL="SELECT COUNT(Cur_Posted) AS NAnnPosted FROM announcements WHERE Cur_Posted=true AND Prev_Posted=false"
			
			set objConn=server.createobject("ADODB.Connection")
			set objRS=server.createobject("ADODB.Recordset")
			
			objConn.connectionstring="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&server.mappath("db/rciann.mdb")
			objConn.open
			objRS.open strSQL, objConn
		%>
		<!--Template-->
		<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<!--End Template-->
		<style>
			body{padding-top:50px;}
			.clock, .clock *{display:inline;}
			.clock ul{list-style:none;}
			.date, .clock ul{padding-left:5px;}
		</style>
		<!--Template-->
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries--><!--[if lt IE 9]>
		<script type="text/javascript" src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script type="text/javascript" src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
		<!--End Template-->
	</head>
	<!--Dashboard Template-->
	<%baseURL=request.servervariables("URL")%>
	<!--End Dashboard Template-->
	<body class="body-nav-offcanvas">
		<!--Dashboard Template-->
		<%
			if session("verified")=false then
				session("status")=0
				baseURL=request.servervariables("URL")
				strURL=mid(baseURL,1,instrrev(baseURL,"/"))
				response.redirect(strURL&"login.asp")
			end if
		%>
		<!--End Dashboard Template-->
		<!--Header-->
		<!--#include file="includes/nav.inc"-->
		<!--#include file="includes/nav_sw.inc"-->
		<!--#include file="includes/nav_top.inc"-->
		<!--Content-->
		<div class="site-wrap">
			<div class="container-fluid">
				<script language="javascript" runat="server">
					function getLocalDateTime(){
						return new Date().toLocaleString('en-CA', { timeZone: 'North America/Canada' });
					}
				</script><%=getLocalDateTime()%>
				<div class="row">
					<div class="col-sm-9 col-md-10 main">
						<div class="panel-group dash-info">
							<div class="panel panel-info">
								<a id="di-toggle" data-toggle="collapse" data-parent=".dash-info" href="#dash-info-disp" class="panel-info">
									<div class="panel-heading">
										<h3 class="panel-title">Dashboard Information</h3>
									</div>
								</a>
								<div id="dash-info-disp" class="panel-collapse collapse">
									<div class="panel-body">
										<div class="col-md-4">
											<span>Welcome to the RCI Announcement System. If there are any questions, comments, or concerns regarding this system, contact your system administrators. Any and all feedback on this system is welcome.</span>
										</div>
										<div class="col-md-8">
											<div class="col-md-6">
												<span><strong>Signature:</strong>&nbsp;<%=session("signature")%></span>
												<br>
												<span><strong>Current User:</strong>&nbsp;<%=session("firstname")&"&nbsp;"&session("lastname")%></span>
												<br>
												<span><strong>Email:</strong>&nbsp;<%=session("email")%></span>
												<br>
												<br>
											</div>
											<div class="col-md-6">
												<span style="text-transform:capitalize;"><strong>Clearance Level:</strong>&nbsp;<%=session("clearance")%></span>
												<br>
												<span><strong>IP Address:</strong>&nbsp;<%=request.servervariables("REMOTE_ADDR")%></span>
												<br>
												<span><strong>Announcements On Display:</strong>&nbsp;<%=objRS("NAnnPosted")%></span>
											</div>
											<div class="col-sm-12 col-md-12"><strong>Current Date/Time:</strong><!--#include file="includes/date_clock.inc"--></div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div>
							<iframe id="content_container" name="content_container" src="home.asp" scrolling="no" style="width:100%;"></iframe>
						</div>
						<div class="col-sm-3 col-sm-offset-9 col-md-2 col-md-offset-10 sidebar">
							<h2 class="sub-header">Tasks</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Footer-->
		<!--#include file="includes/nav_bottom.inc"-->
		<!--Dashboard Template-->
		<!--Bootstrap core JavaScript-->
		<!--Placed at the end of the document so the pages load faster-->
		<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/docs.min.js"></script>
		<!--IE10 viewport hack for Surface/desktop Windows 8 bug-->
		<script type="text/javascript" src="js/ie10-viewport-bug-workaround.js"></script>
		<!--End Dashboard Template-->
		<!--iFrame Resize-->
				<script type="text/javascript" src="js/iframeResizer.min.js"></script>
		<!--Bootstrap Session Timeout-->
		<!--+javascript('js/bootstrap-session-timeout.min.js')-->
		<!--Date Clock-->
				<script type="text/javascript" src="js/date_clock.js"></script>
		<!--Initiatation of scripts-->
				<script type="text/javascript">
					$('#content_container',parent.document).iFrameResize({
						log: false,
						autoResize: true,
						bodyBackground: '',
						bodyMargin: '',
						checkOrigin: true,
						enablePublicMethods: false,
						interval: 32 /*ms*/,
						heightCalculationMethod: 'lowestElement' /*'bodyOffset' | 'bodyScroll' | 'documentElementOffset' | 'documentElementScroll' | 'max' | 'min' | 'grow' | 'lowestElement'*/,
						//maxHeight: 0,
						//maxWidth: 0,
						minHeight: 500,
						//minWidth: 0,
						scrolling: false,
						sizeHeight: true,
						sizeWidth: false,
						tolerance: 0
					});
				</script>
				<script type="text/javascript" src="js/fullsize.min.js"></script>
				<script type="text/javascript">$('#di-toggle').click();
				</script>
		<%
			baseURL=request.servervariables("URL")
			
			if instr(baseURL,"announcements.asp")<=0 then
				if instr(baseURL,"dashboard.asp")>0 then
		%>
				<script type="text/javascript">
					/*$(function(){
						$.sessionTimeout({
							message			: "You have been inactive for 15 minutes. Would you like to stay logged in?",
							logoutUrl		: "login.asp?a=l", 
							redirUrl		: "login.asp?a=l",
							keepAliveUrl	: "keepAlive.asp",*/
							//warnAfter		: 120000,
							//redirAfter	: 140000,
							//min * 60 * 1000
						//});
					//});
				</script>
		<%
			end if
			end if
			
			objRS.close
			objConn.close
			set objRS=nothing
			set objConn=nothing
		%>
		<!--Template-->
				<script type="text/javascript" src="js/HTML_Inspector.js"></script>
		<!--End Template-->
	</body>
</html>