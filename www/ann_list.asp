
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
		<meta name="description" content="Riverdale Collegiate Institute - Announcement List"/>
		<title>Riverdale Collegiate Institute - Announcement List</title>
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
		<style>
			.annDT{/*width:150px;*/}
			.btn-edit{margin-bottom:5px;}
			.panel-table{padding: 0px 10px 0px 10px;}
			.panel-table table{margin-bottom:0px;}
			.info-item{margin-bottom:5px;}
			.table-condensed>tbody>tr>th,.table-condensed>tbody>tr>td{padding-right:0;}
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
	<body>
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
		<!--Content-->
		<div class="site-wrap">
			<div class="container-fluid">
				<h2 class="page-header">
					<%if action="list" then%>Announcement Listing
					<%else%>Verify Announcements
					<%end if%>
				</h2>
				<div class="row">
					<div class="panel-group">
						<div class="panel panel-default">
							<div class="panel-heading panel-table">
								<table id="tbl-head" class="table table-hover table-condensed table-responsive">
									<tr>
										<th class="col-sm-4 col-md-2">Title</th>
										<th class="col-sm-4 col-md-4">Description</th>
										<th class="col-sm-1 col-md-1">Type</th>
										<th class="col-sm-1 col-md-2">Start Date <wbr />&amp; Time</th>
										<th class="col-sm-1 col-md-2">Finish Date <wbr />&amp; Time</th>
										<th class="col-sm-1 col-md-1"></th>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--Footer-->
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
				<script type="text/javascript" src="js/iframeResizer.contentWindow.min.js"></script>
		<!--Bootstrap Session Timeout Event Listener-->
				<script type="text/javascript">//$(document).on("click keypress submit",function(){var cmd={report:true};/*$.ajax({type:'POST',url:'keepAlive.asp'});*/window.parent.sessionActive.call(cmd);});
				</script>
				<script type="text/javascript">
					/*function adjustHeight(e){
						var n=$("#content_container",parent.document),m=e.next().children();
						if(m.hasClass('in')){
							n.height(n.height()-m.height()+10);
						}else{
							n.height(n.height()+m.height()-10);
						}
					}*/
				</script>
		<!--Template-->
				<script type="text/javascript" src="js/HTML_Inspector.js"></script>
		<!--End Template-->
	</body>
</html>