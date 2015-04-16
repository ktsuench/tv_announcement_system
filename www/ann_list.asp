
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
		<!--End Dashboard Template--><!--#include file="scripts/htmlEncode.asp"-->	
		<%
			dim objConn, objRs, strQuery, sortOrder, duration, action, actionLink(1), strFuncURL(1), strFuncQuery(1), displayRec, trCls, yy, mm, dd, curDate, curTime, notToday, x, elcls, elid, eldatapar, elhref, cls
			
			strQuery="SELECT * FROM announcements"
			sortOrder=request("sortOrder")
			action=request("action")
			baseURL=mid(baseURL,1,instrrev(request.servervariables("URL"),"/"))
			strURL=baseURL&"ann_list.asp"
			
			yy=year(date())
			mm=month(date())
			dd=day(date())
			
			if len(mm)<2 then mm="0"&mm
			if len(dd)<2 then dd="0"&dd
			
			curDate=cstr(yy&"/"&mm&"/"&dd)
			curTime=FormatDateTime(now(),vbshorttime)
			
			strFuncURL(0)=baseURL&"ann_add.asp":	strFuncQuery(0)="action=editExisting":	actionLink(0)="Edit"
			
			select case action
				case "verify":	strFuncURL(1)=baseURL&"ann_sub.asp":	strFuncQuery(1)="action=verify":	actionLink(1)="Verify"
				case "list":	strFuncURL(1)=baseURL&"ann_sub.asp":	strFuncQuery(1)="action=delete":	actionLink(1)="Remove"
			end select 
			
			select case sortOrder 
				case 1:strQuery=strQuery&" ORDER BY Title"
				case 2:strQuery=strQuery&" ORDER BY Description"
				case 3:strQuery=strQuery&" ORDER BY Type"
				case 4:strQuery=strQuery&" ORDER BY Start_Date"
				case 5:strQuery=strQuery&" ORDER BY End_Date"
				case else:strQuery=strQuery&" ORDER BY Title"
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
										<th class="col-sm-4 col-md-2"><a href="<%=strURL%>?sortOrder=1&action=<%=action%>">Title</a></th>
										<th class="col-sm-4 col-md-4"><a href="<%=strURL%>?sortOrder=2&action=<%=action%>">Description</a></th>
										<th class="col-sm-1 col-md-1"><a href="<%=strURL%>?sortOrder=3&action=<%=action%>">Type</a></th>
										<th class="col-sm-1 col-md-2"><a href="<%=strURL%>?sortOrder=4&action=<%=action%>">Start Date <wbr />&amp; Time</a></th>
										<th class="col-sm-1 col-md-2"><a href="<%=strURL%>?sortOrder=5&action=<%=action%>">Finish Date <wbr />&amp; Time</a></th>
										<th class="col-sm-1 col-md-1"></th>
									</tr>
								</table>
							</div>
						</div>
						<%
							do while not objRs.eof
								displayRec=true
								if action="verify" and objRs("Verified") then
									displayRec=false
								else
									notToday=true
									if objRs("Verified") then
										if objRs("Start_Date")<=curDate and objRs("End_Date")>=curDate then
											if objRs("Start_Date")=curDate or objRs("End_Date")=curDate then notToday=false
											if (objRs("Start_Time")<=curTime or objRs("End_Time")>=curTime) or notToday then
												objRs("Prev_Posted")=false
												objRs("Cur_Posted")=true
											elseif objRs("End_Date")<=curDate and objRs("End_Time")<=curTime and not objRs("Prev_Posted") then
												objRs("Prev_Posted")=true
												objRs("Cur_Posted")=false
											end if
										end if
									end if
								end if
							
								if displayRec then
									if objRs("Verified") and objRs("Cur_Posted") then
										trCls="success"
									elseif objRs("Prev_Posted") then
										trCls="warning"
									elseif objRs("Verified") then
										trCls="info"
									else
										trCls="danger"
									end if
							
									if len(objRs("Description"))>=60 then
										x="..."
									else
										x=""
									end if
							
									elcls="panel-"&trCls&" info-"&objRs("ID")
						%>
						<div class="panel <%=elcls%>">
							<%
								elid="di"&objRs("ID")&"-toggle"
								elcls="panel-"&trCls
								eldatapar="info-"&objRs("ID")
								elhref="info-"&objRs("ID")&"-disp"
							%><a id="<%=elid%>" data-toggle="collapse" data-parent=".<%=eldatapar%>" href="#<%=elhref%>" onclick="/*adjustHeight($(this));*/" class="<%=elcls%>">
								<div class="panel-heading panel-table">
									<table class="table table-condensed table-responsive">
										<tr>
											<td class="col-sm-4 col-md-2 <%=trCls%>"><%=htmlEntityEncode(objRs("Title"))%></td>
											<td style="padding-right:25px;" class="col-sm-4 col-md-4 <%=trCls%>"><%=htmlEntityEncode(mid(objRs("Description"),1,60)&x)%></td>
											<td style="text-transform:capitalize;" class="col-sm-1 col-md-1 <%=trCls%>"><%=objRs("Type")%></td>
											<td class="col-sm-1 col-md-2 <%=trCls%>"><%=htmlEntityEncode(objRs("Start_Date"))%><wbr />&nbsp;<%=htmlEntityEncode(objRs("Start_Time"))%></td>
											<td class="col-sm-1 col-md-2 <%=trCls%>"><%=htmlEntityEncode(objRs("End_Date"))%><wbr />&nbsp;<%=htmlEntityEncode(objRs("End_Time"))%></td>
											<%
												strQuery=array():   redim strQuery(1)
												strQuery(0)="?ID="&objRs("ID")&"&"&strFuncQuery(0): strQuery(1)="?ID="&objRs("ID")&"&"&strFuncQuery(1)
												
												if action="verify" then
													cls="btn-verify btn-info"
												else
													cls="btn-remove btn-danger"
												end if
											%>
											<td class="col-sm-1 col-md-1 <%=trCls%>">
												<button onclick="$('#content_container',window.parent.document).attr('src','<%=strFuncURL(0)&strQuery(0)%>');" class="btn btn-success btn-edit col-sm-12 col-md-12"><%=actionLink(0)%></button>
												<button onclick="$('#content_container',window.parent.document).attr('src','<%=strFuncURL(1)&strQuery(1)%>');" class="btn col-sm-12 col-md-12 <%=cls%>"><%=actionLink(1)%></button>
											</td>
										</tr>
									</table>
								</div></a>
							<div style="padding:0px;" class="panel-body panel-<%=trCls%>">
								<div id="<%=elhref%>" style="padding:0px 20px 0px 20px;" class="panel-collapse collapse col-sm-12 col-md-12 bg-<%=trCls%>">
									<div style="margin-top:20px" class="info-item col-sm-12 col-md-12 <%=trCls%>"><span>Description:&nbsp;</span><%=htmlEntityEncode(objRs("Description"))%></div>
									<div class="info-item col-sm-12 col-md-12 <%=trCls%>">
										<%x=objRs("Image")%>
										<%if isempty(x) or isnull(x) or trim(x)="" then x="None"%><span style="padding-left:0px;" class="col-sm-6 col-md-6">Image: <%=htmlEntityEncode(x)%></span>
										<div class="col-sm-6 col-md-6">
											<label class="checkbox-inline">
												<input type="checkbox" disabled <%if objRs("Cur_Posted") then response.write("checked")%>>- Currently Posted
											</label>
											<label class="checkbox-inline">
												<input type="checkbox" disabled <%if objRs("Prev_Posted") then response.write("checked")%>>- Previously Posted
											</label>
											<label class="checkbox-inline">
												<input type="checkbox" disabled <%if objRs("Verified") then response.write("checked")%>>- Verified
											</label>
										</div>
									</div>
									<div style="margin-bottom:20px" class="info-item col-sm-6 col-md-6 <%=trCls%>">
										<div class="info-item">Created By: <%=objRs("Created_By")%></div>
										<div class="info-item">Modified By: <%=objRs("Modified_By")%></div>
									</div>
									<div style="margin-bottom:20px" class="info-item col-sm-6 col-md-6 <%=trCls%>">
										<div class="info-item">Date Created: <%=htmlEntityEncode(objRs("Date_Created"))%></div>
										<div class="info-item">Date Modified: <%=htmlEntityEncode(objRs("Date_Modified"))%></div>
									</div>
								</div>
							</div>
						</div>
						<%
							    end if
							
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
		<%
			objRs.close
			objConn.close
			set objRs=nothing
			set objConn=nothing
		%>
	</body>
</html>