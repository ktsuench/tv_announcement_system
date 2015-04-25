
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
		<%if action=editExisting then%>
		<meta name="description" content="Riverdale Collegiate Institute - Edit Member"/>
		<%else%>
		<meta name="description" content="Riverdale Collegiate Institute - Add Member"/>
		<%end if%>
		<%if action=editExisting then%>
		<title>Riverdale Collegiate Institute - Edit Member</title>
		<%else%>
		<title>Riverdale Collegiate Institute - Add Member</title>
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
		<!--Bootstrap Select Input css-->
		<link rel="stylesheet" type="text/css" href="css/bootstrap-combobox.css"/>
		<!--Bootstrap File Input css-->
		<link rel="stylesheet" type="text/css" href="css/fileinput.min.css"/>
		<style>#mem_add_frm .form-group{margin-left:0px;margin-right:0px;}</style>
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
			dim objConn, objRs, strQuery, memail, mpass, mfn, mln, mlvl, mstat, action
			
			action=request("action")
			
			if action="editExisting" then
				set objConn=server.createobject("ADODB.Connection")
				set objRs=server.createobject("ADODB.Recordset")
			
				strQuery="SELECT * FROM authentication WHERE ID="&int(request("ID"))
			
				objConn.connectionstring="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&server.mappath("db/rciann.mdb")
				objConn.open
				objRs.open strQuery, objConn, ,adLockOptimistic
			
				memail=objRs("Email")
				mpass=objRs("Password")
				mfn=objRs("Firstname")
				mln=objRs("Lastname")
				mlvl=objRs("Clearance")
				mstat=objRs("Status")
			end if
			
			baseURL=request.servervariables("URL")
			strURL=mid(baseURL,1,instrrev(baseURL,"/"))
		%>
		<!--Header-->
		<!--Content-->
		<div class="site-wrap">
			<div class="container-fluid">
				<h2 class="page-header">
					<%if action="editExisting" then%>Edit Member
					<%else%>Add Member
					<%end if%>
				</h2>
				<div class="row">
					<!--Announcement Submission Form-->
					<form id="mem_add_frm" method="post" action="mem_sub.asp?action=<%=action%>" role="form">
						<%if action="editExisting" then response.write("<input type='hidden' name='ID' value='"&request("ID")&"'/>")%>
						<!--Left form column-->
						<div class="col-sm-6 col-md-6">
							<!--Firstname-->
							<div class="form-group">
								<label for="firstname" class="control-label">First Name</label>
								<input id="firstname" type="text" maxlength="50" name="firstname" placeholder="Enter your first name" value="<%if not isempty(mfn) and not isnull(mfn) then response.write(htmlEntityEncode(mfn))%>" autocomplete="off" required class="form-control">
								<span class="help-block">
									<span id="fn_feedback"></span>
								</span>
							</div>
							<!--Last Name-->
							<div class="form-group">
								<label for="lastname" class="control-label">Last Name</label>
								<input id="lastname" type="text" maxlength="50" name="lastname" placeholder="Enter your last name" value="<%if not isempty(mln) and not isnull(mln) then response.write(htmlEntityEncode(mln))%>" autocomplete="off" required class="form-control">
								<span class="help-block">
									<span id="ln_feedback"></span>
								</span>
							</div>
							<!--Status-->
							<div class="form-group">
								<label for="status" class="control-label">Status</label>
								<textarea id="status" style="resize:none;" rows="8" cols="30" maxlength="150" name="status" placeholder="Input your positions/responsibilities and/or activities that you participate in around the school" value="<%if not isempty(mstat) and not isnull(mstat) then response.write(htmlEntityEncode(mstat))%>" autocomplete="off" data-toggle="tooltip" data-placement="auto bottom" title="Examples: PHAASE VP, S.W.A.T. Member, DECA Staff Advisor, Archery Team Coach" class="form-control"><%if not isempty(mstat) and not isnull(mstat) then response.write(htmlEntityEncode(mstat))%></textarea>
								<span class="help-block">
									<span id="status_feedback"></span>
								</span>
							</div>
						</div>
						<!--Right form column-->
						<div class="col-sm-6 col-md-6">
							<!--Email-->
							<div class="form-group">
								<label for="email" class="control-label">Email</label>
								<input id="lastname" type="email" maxlength="50" name="email" placeholder="Enter your email (example@domain.com)" value="<%if not isempty(memail) and not isnull(memail) then response.write(htmlEntityEncode(memail))%>" autocomplete="off" required class="form-control">
							</div>
							<!--Current Password-->
							<div class="form-group">
								<label for="pass" class="control-label"><%if action="editExisting" then response.write("Current ")%>Password</label>
								<input id="pass" type="password" maxlength="25" name="pass" placeholder="Enter your current password" autocomplete="off" <%if action<>"editExisting" then response.write("required")%> class="form-control">
							</div>
							<!--New Password-->
							<div class="form-group">
								<label for="new_pass" class="control-label">New Password</label>
								<input id="new-pass" type="password" maxlength="25" name="new_pass" placeholder="Enter your new password" autocomplete="off" <%if action<>"editExisting" then response.write("disabled")%> class="form-control">
							</div>
							<!--Confirm New Password-->
							<div class="form-group">
								<label for="confirm_new_pass" class="control-label">Confirm New Password</label>
								<input id="confirm-new-pass" type="password" maxlength="25" name="confirm_new_pass" placeholder="Confirm your new password" autocomplete="off" <%if action<>"editExisting" then response.write("disabled")%> class="form-control">
							</div>
							<!--Clearance Level-->
							<div class="form-group">
								<label for="memtype" class="control-label">Clearance Level</label>
								<select id="memtype" name="memtype" autocomplete="off" required class="form-control">
									<option></option>
									<option value="admin" <%if mlvl="admin" then response.write("selected")%>>Admin</option>
									<option value="moderator" <%if mlvl="moderator" then response.write("selected")%>>Moderator</option>
									<option value="content creator" <%if mlvl="content creator" then response.write("selected")%>>Content Creator</option>
									<option value="guest" <%if mlvl="guest" then response.write("selected")%>>Guest</option>
								</select>
							</div>
							<!--Form Submission & Cancellation-->
							<div class="form-group">
								<!--Form Submission-->
								<div style="padding-left:0px" class="col-sm-6 col-md-6">
									<input id="submit" type="submit" value="Submit" class="btn btn-success col-sm-12 col-md-12">
								</div>
								<!--Form Cancellation-->
								<div style="padding-right:0px" class="col-sm-6 col-md-6">
									<button id="cancel" type="submit" value="Cancel" onclick="cancel_sub()" class="btn btn-danger col-sm-12 col-md-12">Cancel</button>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="pass-err-lim" role="alert" class="alert alert-float alert-danger alert-dismissible invisible">
					<button onclick="$(this).parent().addClass('invisible');" class="close">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
					<span>
						<strong id="pass-err-msg"></strong>
					</span>
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
		<!--Text Character Counter-->
				<script type="text/javascript" src="js/text_counter.min.js"></script>
		<!--BootStrap Select Input-->
				<script type="text/javascript" src="js/bootstrap-combobox.js"></script>
		<!--BootStrap File Input-->
				<script type="text/javascript" src="js/fileinput.min.js"></script>
		<!--Initiatation of scripts-->
				<script type="text/javascript">
					$(function () {
						//Initialize text counters
						text_counter($('#firstname'),$('#fn_feedback'),$('#firstname').attr('maxlength'));
						text_counter($('#lastname'),$('#ln_feedback'),$('#lastname').attr('maxlength'));
						text_counter($('#status'),$('#status_feedback'),$('#status').attr('maxlength'));
						$('#firstname').keyup();
						$('#lastname').keyup();
						$('#status').keyup();

						//Initialize all tooltips
						$('[data-toggle="tooltip"]').tooltip();

						//Initialize select input fields
						$('#memtype').combobox();
						$('.combobox-container input[type*=text]').attr('placeholder','Select Type');

						var hasErr;
						//New Password Validation
						$('#submit').click(function(){
							var cp=$('#pass'),cplen=cp.val().length;
							<%if action="editExisting" then%>
							var np1=$('#new-pass'),np2=$('#confirm-new-pass'),np1len=np1.val().length,np2len=np2.val().length;
							if(cplen>0||np1len>0||np2len>0){	
								if(hasErr||typeof(hasErr)==='undefined'){
									ajaxAsp('<%=objRs("ID")%>',cp.val(),function (response){	
										var err=$('#pass-err-lim'),errMsg=$('#pass-err-msg'),str='Change Password Error! <br />',
											tempStr,tempEl='';

										hasErr=false;

										if(cplen<8||np1len<8||np2len<8){
											hasErr=true;
											if(cplen<8){cp.parent().addClass('has-error');}else if(cp.parent().hasClass('has-error')){cp.parent().removeClass('has-error');}
											if(np1len<8){np1.parent().addClass('has-error');}else if(np1.parent().hasClass('has-error')){np1.parent().removeClass('has-error');}
											if(np2len<8){np2.parent().addClass('has-error');}else if(np2.parent().hasClass('has-error')){np2.parent().removeClass('has-error');}
											tempStr='Highlighted Password Fields are either empty or do not meet length requirement!';
											str=str+tempStr;
										}else{
											if(cp.parent().hasClass('has-error')){cp.parent().removeClass('has-error');}
											if(np1.parent().hasClass('has-error')){np1.parent().removeClass('has-error');}
											if(np2.parent().hasClass('has-error')){np2.parent().removeClass('has-error');}

											if(response!==-1){
												if(!parseInt(response)){
													hasErr=true;
													cp.parent().addClass('has-error');
													tempStr='Incorrect Current Password!';
													str=str+tempEl+tempStr;
													tempEl='<br />';
												}
												if(np1.val()!==np2.val()){
													hasErr=true;
													np1.parent().addClass('has-error');
													np2.parent().addClass('has-error');
													tempStr='New Passwords do not match!';
													str=str+tempEl+tempStr;
												}
											}else{hasErr=true;str='Sorry, unable to change password at the moment. Please try again later.';}
										}
										if(hasErr){
											err.removeClass('invisible');
											errMsg.html(str);
											$('#submit').attr('value','Try Again').removeClass('btn-warning').addClass('btn-success');
										}else{
											err.addClass('invisible');
											$('#submit').attr('value','Success').removeClass('btn-warning').addClass('btn-success');
											$('#mem_add_frm').submit();
											$('#submit').click();
										}
									});
								}else{
									$('#mem_add_frm').submit();
								}
							}else{
								hasErr=false;
								$('#mem_add_frm').submit();
							}
							<%else%>
							var err=$('#pass-err-lim'),errMsg=$('#pass-err-msg'),str='Password Error! <br />';
							hasErr=false;
							if(cplen<8){
								hasErr=true;
								cp.parent().addClass('has-error');
								if(cplen===0){
									str=str+'You left the password field empty!';
								}else{
									str=str+'Your password is too short!';
								}
							}
							if(hasErr){
								if(hasErr){
									err.removeClass('invisible');
									errMsg.html(str);
									$('#submit').attr('value','Try Again').removeClass('btn-warning').addClass('btn-success');
								}else{
									err.addClass('invisible');
									$('#submit').attr('value','Success').removeClass('btn-warning').addClass('btn-success');
									$('#mem_add_frm').submit();
									$('#submit').click();
								}
							}else{
								$('#mem_add_frm').submit();
							}
							<%end if%>
						});

						//Cancel Form validation
						$('#mem_add_frm').submit(function(e){
							if(cancel||hasErr<%if action="editExisting" then response.write("||typeof(hasErr)==='undefined'")%>){
								e.preventDefault();
								<%if action="editExisting" then response.write("if(!cancel){$('#submit').attr('value','Processing...').removeClass('btn-success').addClass('btn-warning');}")%>
							}
						});
					});

					//Form Cancel Submission
					var cancel=false;
					function cancel_sub(){
						cancel=true;
						$('.form-control').each(function(){
							if($(this).attr('required')){
								$(this).removeAttr('required');
							}
						});
						parent.frames[0].location.href='mem_list.asp?action=list';
					}

					//AJAX ASP
					function ajaxAsp(id,val,e){
						$.ajax({
							async: true,
							url: 'mem_sub.asp',
							type: 'get',
							data: {'action':'_cp','ID':id,'p':val},
							mimeType: 'application/x-www-form-urlencoded',
							contentType: false,
							cache: false,
							processData: true,
							success:function (data,textStatus,jqXHR){e(data);},
							error:function (jqXHR,textStatus,errorThrown){e(-1);}
						});
					}
				</script>
		<!--Template-->
				<script type="text/javascript" src="js/HTML_Inspector.js"></script>
		<!--End Template-->
		<%
			if action="editExisting" then
				objRs.close
				objConn.close
				set objRs=nothing
				set objConn=nothing
			end if
		%>
	</body>
</html>