
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
		<%if action=profile then%>
		<meta name="description" content="Riverdale Collegiate Institute - Profile"/>
		<%else%>
		<meta name="description" content="Riverdale Collegiate Institute - Member List"/>
		<%end if%>
		<%if action=profile then%>
		<title>Riverdale Collegiate Institute - Profile</title>
		<%else%>
		<title>Riverdale Collegiate Institute - Member List</title>
		<%end if%>
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
			.panel-table{padding: 0px 10px 0px 10;}
			.panel-table table{margin-bottom:0px;}
			.info-item{margin-bottom:5px;}
			.table-condensed>tbody>tr>th,.table-condensed>tbody>tr>td{padding-right:0;border-top:0;}
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
		<!--#include file="scripts/htmlEncode.asp"-->
		<%
			dim objConn, objRs, strQuery, sortOrder, duration, action, actionLink, strFuncURL, strFuncQuery, memName, isSysAdmin, elcls, elid, eldatapar, elhref
			
			strQuery="SELECT * FROM authentication ORDER BY Lastname"
			sortOrder=request("sortOrder")
			action=request("action")
			baseURL=mid(baseURL,1,instrrev(request.servervariables("URL"),"/"))
			strURL=baseURL&"mem_list.asp"
			
			strFuncURL=array():		redim strFuncURL(1)
			strFuncQuery=array():	redim strFuncQuery(1)
			actionLink=array():		redim actionLink(1)
			strFuncURL(0)=baseURL&"mem_add.asp":	strFuncQuery(0)="action=editExisting":		actionLink(0)="Edit"
			strFuncURL(1)=baseURL&"mem_sub.asp":	strFuncQuery(1)="action=delete":			actionLink(1)="Remove"
			
			select case sortOrder
			    case 1:strQuery=strQuery&" ORDER BY Lastname"
			    case 2:strQuery=strQuery&" ORDER BY Email"
			    case 3:strQuery=strQuery&" ORDER BY Clearance"
			    case 4:strQuery=strQuery&" ORDER BY Signature"
			end select
			
			set objConn=server.createobject("ADODB.Connection")
			set objRs=server.createobject("ADODB.Recordset")
			
			objConn.connectionstring="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&server.mappath("db/rciann.mdb")
			objConn.open
			objRs.open strQuery, objConn, , adLockOptimistic
		%>
		<!--Header-->
		<!--Content-->
		<div class="site-wrap">
			<div class="container-fluid">
				<h2 class="page-header">Members Listing</h2>
				<div class="row">
					<div class="panel-group">
						<div class="panel panel-default">
							<div class="panel-heading panel-table">
								<table id="tbl-head" class="table table-hover table-condensed table-responsive">
									<tr>
										<th class="col-sm-4 col-md-3">
											<a href="<%=strURL%>?sortOrder=1&action=<%=action%>">Name</a>
										</th>
										<th class="col-sm-4 col-md-4">
											<a href="<%=strURL%>?sortOrder=2&action=<%=action%>">Email</a>
										</th>
										<th class="col-sm-1 col-md-2">
											<a href="<%=strURL%>?sortOrder=3&action=<%=action%>">Clearance</a>
										</th>
										<th class="col-sm-1 col-md-2">
											<a href="<%=strURL%>?sortOrder=4&action=<%=action%>">Signature</a>
										</th>
										<th class="col-sm-1 col-md-1"></th>
									</tr>
								</table>
							</div>
						</div>
						<%
							do while not objRs.eof
							    isSysAdmin=false
							    elid="di"&objRs("ID")&"-toggle"
							    'elcls="panel-"&trCls
							    eldatapar="info-"&objRs("ID")
							    elhref="info-"&objRs("ID")&"-disp"
						%>
						<div class="panel panel-info">
							<a id="<%=elid%>" data-toggle="collapse" data-parent=".<%=eldatapar%>" href="#<%=elhref%>" onclick="/*adjustHeight($(this));*/" class="panel-info">
								<div class="panel-heading panel-table">
									<table class="table table-condensed table-responsive">
										<tr>
											<%
												if objRs("Firstname")="Admin" then
												    memName="Admin"
												elseif objRs("Firstname")="Guest" then
												    memName="Guest"
												else
												    memName=objRs("Lastname")&", "&left(objRs("Firstname"),1)&"."
												end if
											%>
											<td class="panel-info col-sm-4 col-md-3"><%=htmlEntityEncode(memName)%></td>
											<td class="panel-info col-sm-4 col-md-4"><%=htmlEntityEncode(objRs("Email"))%></td>
											<td style="text-transform:capitalize;" class="panel-info col-sm-1 col-md-2"><%=objRs("Clearance")%></td>
											<td class="panel-info col-sm-1 col-md-2"><%=objRs("Signature")%></td>
											<%
												strQuery=array():	redim strQuery(1)
												strQuery(0)="?ID="&objRs("ID")&"&"&strFuncQuery(0)
												strQuery(1)="?ID="&objRs("ID")&"&"&strFuncQuery(1)
												
												if objRs("Signature")="ADMIN" then isSysAdmin=true
											%>
											<td class="panel-info col-sm-1 col-md-1">
												<button <%if not isSysAdmin then response.write("onclick=""$("&chr(39)&"#content_container"&chr(39)&",window.parent.document).attr("&chr(39)&"src"&chr(39)&","&chr(39)&strFuncURL(0)&strQuery(0)&chr(39)&");"" ")%> <%if isSysAdmin then response.write("disabled")%> class="btn btn-success btn-edit col-sm-12 col-md-12"><%=actionLink(0)%></button>
												<button <%if not isSysAdmin then response.write("onclick=""$("&chr(39)&"#content_container"&chr(39)&",window.parent.document).attr("&chr(39)&"src"&chr(39)&","&chr(39)&strFuncURL(1)&strQuery(1)&chr(39)&");"" ")%> <%if isSysAdmin then response.write("disabled")%> class="btn btn-danger btn-remove col-sm-12 col-md-12"><%=actionLink(1)%></button>
											</td>
										</tr>
									</table>
								</div>
							</a>
							<div style="padding:0px;" class="panel-body panel-info">
								<div id="<%=elhref%>" style="padding:0px 20px 0px 20px;" class="panel-info panel-collapse collapse col-sm-12 col-md-12">
									<div style="margin-top:20px" class="panel-info info-item col-sm-12 col-md-12">
										<span>Email:&nbsp;</span><%=htmlEntityEncode(objRs("Email"))%>
									</div>
									<div style="margin-bottom:20px" class="panel-info info-item col-sm-6 col-md-6">
										<%
											dim lname
											if trim(objRs("Lastname"))<>"." then
											    lname=objRs("Lastname")
											else
											    lname="n/a"
											end if
										%>
										<div class="info-item">Lastname: <%=htmlEntityEncode(lname)%></div>
										<div class="info-item">Firstname: <%=htmlEntityEncode(objRs("Firstname"))%></div>
									</div>
									<div style="margin-bottom:20px" class="panel-info info-item col-sm-6 col-md-6">
										<div class="info-item">Signature: <%=objRs("Signature")%></div>
										<div style="text-transform:capitalize;" class="info-item">Clearance: <%=objRs("Clearance")%></div>
									</div>
									<div style="margin-bottom:20px" class="panel-info info-item col-sm-6 col-md-6 <%=trCls%>">
										<div class="info-item">Password: <%=htmlEntityEncode(objRs("Password"))%></div>
										<div class="info-item">Status: <%=htmlEntityEncode(objRs("Status"))%></div>
									</div>
								</div>
							</div>
						</div>
						<%
							    objRs.movenext
							loop
						%>
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
		<!--Template-->
				<script type="text/javascript" src="js/HTML_Inspector.js"></script>
		<!--End Template-->
		<%
			objRs.close
			objConn.close
			set objRs=nothing
			set objConn=nothing 
		%>
	</body>
</html>