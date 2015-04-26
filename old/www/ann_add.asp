
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
		<meta name="description" content="Riverdale Collegiate Institute Edit Announcement"/>
		<%else%>
		<meta name="description" content="Riverdale Collegiate Institute Post Announcement"/>
		<%end if%>
		<%if action=editExisting then%>
		<title>Riverdale Collegiate Institute Edit Announcement</title>
		<%else%>
		<title>Riverdale Collegiate Institute Post Announcement</title>
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
		<!--Bootstrap DateTime Picker css-->
		<link rel="stylesheet" type="text/css" href="css/bootstrap-datetimepicker.min.css"/>
		<!--Bootstrap File Input css-->
		<link rel="stylesheet" type="text/css" href="css/fileinput.min.css"/>
		<style>
			.input-group[id*=dsel]{padding-left:0; padding-right:15px;}
			.input-group[id*=tsel]{padding-left:15px; padding-right:0;}
			#ann_add_frm .form-group{margin-left:0px;margin-right:0px;}
		</style>
		<!--Template-->
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries-->
		<!--[if lt IE 9]>
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
			dim objConn, objRs, strQuery, msub, mdesc, mtype, msdate, mfdate, mstime, mftime, mimg, Q, action
			
			action=request("action")
			
			if action="editExisting" then
				set objConn=server.createobject("ADODB.Connection")
				set objRs=server.createobject("ADODB.Recordset")
			
				strQuery="SELECT * FROM announcements WHERE ID="&int(request("ID"))
			
				objConn.connectionstring="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&server.mappath("db/rciann.mdb")
				objConn.open
				objRs.open strQuery, objConn, ,adLockOptimistic
			
				msub=objRs("Title")
				mdesc=objRs("Description")
				mtype=objRs("Type")
				msdate=objRs("Start_Date")
				mfdate=objRs("End_Date")
				mstime=objRs("Start_Time")
				mftime=objRs("End_Time")
				mimg=objRs("Image")
			end if
			
			baseURL=request.servervariables("URL")
			strURL=mid(baseURL,1,instrrev(baseURL,"/"))
		%>
		<!--Header-->
		<!--Content-->
		<div class="site-wrap">
			<div class="container-fluid">
				<h2 class="page-header">
					<%if action="editExisting" then%>Edit Announcement
					<%else%>Add Announcement
					<%end if%>
				</h2>
				<div class="row">
					<!--Announcement Submission Form-->
					<form id="ann_add_frm" method="post" action="ann_sub.asp?<%="action="&action%>" role="form">
						<%if action="editExisting" then response.write("<input type='hidden' name='ID' value='"&request("ID")&"'/>")%>
						<!--Left form column-->
						<div class="col-sm-6 col-md-6">
							<!--Announcement Title-->
							<div class="form-group">
								<label for="subject" class="control-label">Announcement Title</label>
								<input id="subject" type="text" maxlength="32" name="subject" placeholder="Enter name of sport, council, club, etc.." value="<%if not isempty(msub) and not isnull(msub) then response.write(htmlEntityEncode(msub))%>" autocomplete="off" required class="form-control">
								<span class="help-block">
									<span id="title_feedback"></span>
								</span>
							</div>
							<!--Announcement Content-->
							<div class="form-group">
								<label for="desc" class="control-label">Announcement Content</label>
								<textarea id="textarea" style="resize:none;" rows="8" cols="30" maxlength="150" name="desc" placeholder="Enter Your Announcement" value="<%if not isempty(mdesc) and not isnull(mdesc) then response.write(htmlEntityEncode(mdesc))%>" autocomplete="off" required class="form-control"><%if not isempty(mdesc) and not isnull(mdesc) then response.write(htmlEntityEncode(mdesc))%></textarea>
								<span class="help-block">
									<span id="textarea_feedback"></span>
								</span>
							</div>
						</div>
						<!--Right form column-->
						<div class="col-sm-6 col-md-6">
							<!--Announcement Type-->
							<div class="form-group">
								<label for="anntype" class="control-label">Announcement Type</label>
								<select id="anntype" name="anntype" autocomplete="off" required class="form-control">
									<option></option>
									<option value="important" <%if mtype="important" then response.write("selected")%>>Important</option>
									<option value="meeting" <%if mtype="meeting" then response.write("selected")%>>Meeting</option>
									<option value="university" <%if mtype="university" then response.write("selected")%>>University</option>
									<option value="volunteer" <%if mtype="volunteer" then response.write("selected")%>>Volunteer</option>
									<option value="sports" <%if mtype="sports" then response.write("selected")%>>Sports</option>
									<option value="other" <%if mtype="other" then response.write("selected")%>>Other</option>
								</select>
							</div>
							<!--Announcement Start Date & Time-->
							<div class="form-group">
								<!--Announcement Start Date-->
								<label class="control-label pull-left">Start Date &amp; Time</label>
								<div class="clearfix"></div>
								<div id="dsel1" class="input-group date col-sm-6 col-md-6">
									<input type="text" name="dateStart" value="" readonly="readonly" autocomplete="off" required="required" class="form-control" data-date-format="YYYY/MM/DD" placeholder="____/__/__"/>
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
								<!--Announcement Start Time-->
								<div id="tsel1" class="input-group date col-sm-6 col-md-6">
									<input type="text" name="timeStart" value="" readonly="readonly" autocomplete="off" required="required" class="form-control" placeholder="__:__"/>
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-time"></span>
									</span>
								</div>
							</div>
							<!--Announcement Finish Date & Time-->
							<div class="form-group">
								<!--Announcement Finish Date-->
								<label class="control-label pull-left">Finish Date &amp; Time</label>
								<div class="clearfix"></div>
								<div id="dsel2" class="input-group date col-sm-6 col-md-6">
									<input type="text" name="dateFinish" value="" readonly="readonly" autocomplete="off" required="required" class="form-control" data-date-format="YYYY/MM/DD" placeholder="____/__/__"/>
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
								<!--Announcement Finish Time-->
								<div id="tsel2" class="input-group date col-sm-6 col-md-6">
									<input type="text" name="timeFinish" value="" readonly="readonly" autocomplete="off" required="required" class="form-control" placeholder="__:__"/>
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-time"></span>
									</span>
								</div>
							</div>
							<!--Image Upload-->
							<div class="form-group">
								<label for="img" class="control-label">Upload Image</label>
								<input id="file-upload" type="file" name="img" accept="image/*" value="<%if not((isempty(mimg) and isnull(mimg)) or trim(mimg)="") then response.write(mimg)%>" class="form-control">
								<%if not((isempty(mimg) and isnull(mimg)) or trim(mimg)="") then response.write("<input id='file-upload-db' type='hidden' name='img-db' value='"&mimg&"'/>")%>
								<span id="file-upload-err" class="help-block"></span>
							</div>
							<!--Form Submission & Cancellation-->
							<div class="form-group">
								<!--Form Submission-->
								<div style="padding-left:0px" class="col-sm-6 col-md-6">
									<input id="submit" type="submit" value="Submit" onclick="upload_img()" class="btn btn-success col-sm-12 col-md-12">
								</div>
								<!--Form Cancellation-->
								<div style="padding-right:0px" class="col-sm-6 col-md-6">
									<button id="cancel" type="submit" value="Cancel" onclick="cancel_sub()" class="btn btn-danger col-sm-12 col-md-12">Cancel</button>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="min-dt-lim" role="alert" class="alert alert-float alert-danger alert-dismissible invisible">
					<button onclick="$(this).parent().addClass('invisible');" class="close">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
					<span>
						<strong>Announcement Submission Error <br /> Must be displayed at least for 1 hour.</strong>
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
		<!--BootStrap DateTime Picker-->
				<script type="text/javascript" src="js/moment.min.js"></script>
				<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
		<!--BootStrap File Input-->
				<script type="text/javascript" src="js/fileinput.min.js"></script>
		<!--Initiatation of scripts-->
				<script type="text/javascript">
					$(function () {
						//Initialize text counters
						text_counter($('#subject'),$('#title_feedback'),$('#subject').attr('maxlength'));
						text_counter($('#textarea'),$('#textarea_feedback'),$('#textarea').attr('maxlength'));
						$('#subject').keyup();
						$('#textarea').keyup();

						//Initialize select input fields
						$('#anntype').combobox();
						$('.combobox-container input[type*=text]').attr('placeholder','Select Type');

						//Initialize date time picker fields with validation
						$('#dsel1').datetimepicker({pickTime:false, sideBySide:true,}).data('DateTimePicker').setMinDate(new Date());
						$('#dsel2').datetimepicker({pickTime:false, sideBySide:true,}).data('DateTimePicker').setMinDate(new Date());
						$('#tsel1,#tsel2').datetimepicker({pickDate:false, sideBySide:true, minuteStepping:10});
						var mdt, k=0;
						<%if not isempty(msdate) and not isnull(msdate) then%>
							mdt=['<%=msdate%>','<%=mstime%>','<%=mfdate%>','<%=mftime%>'];
						<%end if%>
						$('#ann_add_frm').find('.input-group[id*=sel]').each(function(){
							var d=new Date(),h=d.getHours(),m=d.getMinutes(),t=(h>12?h-12:h)+':'+(Math.floor(m/10)*10)+(h<12?'AM':'PM'),x;
							x=(this.id.indexOf('tsel'))?d:t;

							if(typeof mdt!=='undefined'){
								$(this).data('DateTimePicker').setDate(mdt[k]);
							}else{
								$(this).data('DateTimePicker').setDate(x);
							}
							$(this).click(function(){$(this).data('DateTimePicker').show();});
							k+=1;
						});

						function retrieveTime(e){
							return e.data('DateTimePicker').getDate()._d.getHours()+':'+e.data('DateTimePicker').getDate()._d.getMinutes();
						}
						$('#dsel1').on('dp.change',function (e){
							var d1=$('#dsel1').data('DateTimePicker'),d2=$('#dsel2').data('DateTimePicker'),
								dd1=$('#dsel1 input'),dd2=$('#dsel2 input'),t1=$('#tsel1'),t2=$('#tsel2'),err=$('#min-dt-lim'),
								tt1=retrieveTime(t1),tt2=retrieveTime(t2);
							d2.setMinDate(e.date);
							if(d2.getDate()<e.date){d2.setDate(e.date);}
							if((tt1>tt2)&&(dd1.val()==dd2.val())){t1.data('DateTimePicker').setDate(t2.data('DateTimePicker').getDate()._d);}
							if(t2.hasClass('has-error')){t2.removeClass('has-error');err.addClass('invisible');}
						});
						$('#dsel2').on('dp.change',function (e){
								var d1=$('#dsel1').data('DateTimePicker'),d2=$('#dsel2').data('DateTimePicker'),
								dd1=$('#dsel1 input'),dd2=$('#dsel2 input'),t1=$('#tsel1'),t2=$('#tsel2'),err=$('#min-dt-lim'),
								tt1=retrieveTime(t1),tt2=retrieveTime(t2);
							d1.setMaxDate(e.date);
							if(d1.getDate()>e.date){d1.setDate(e.date);}
							if((tt1>tt2)&&(dd1.val()==dd2.val())){t1.data('DateTimePicker').setDate(t2.data('DateTimePicker').getDate()._d);}
							if(t2.hasClass('has-error')){t2.removeClass('has-error');err.addClass('invisible');}
						});
						$('#tsel1').on('dp.change',function (e){
							var d1=$('#dsel1 input'),d2=$('#dsel2 input'),t1=$('#tsel1'),t2=$('#tsel2'),err=$('#min-dt-lim'),
								tt1=retrieveTime(t1),tt2=retrieveTime(t2);
							if((tt2<tt1)&&(d1.val()==d2.val())){t2.data('DateTimePicker').setDate(t1.data('DateTimePicker').getDate()._d);}
							if(t2.hasClass('has-error')){t2.removeClass('has-error');err.addClass('invisible');}
						});
						$('#tsel2').on('dp.change',function (e){
							var d1=$('#dsel1 input'),d2=$('#dsel2 input'),t1=$('#tsel1'),t2=$('#tsel2'),err=$('#min-dt-lim'),
								tt1=retrieveTime(t1),tt2=retrieveTime(t2);
							if((tt1>tt2)&&(d1.val()==d2.val())){t1.data('DateTimePicker').setDate(t2.data('DateTimePicker').getDate()._d);}
							if(t2.hasClass('has-error')){t2.removeClass('has-error');err.addClass('invisible');}
						});
						$('.input-group[id*=dsel],.input-group[id*=tsel]').css('float','left');
						$('.input-group[id*=dsel] .form-control,.input-group[id*=tsel] .form-control').css('background-color','#fff');
						$('.input-group[id*=dsel]').parent().css('height',$('.input-group[id*=dsel]').parent().height()+$('.input-group[id*=dsel]').height());

						//Initiallize file input field
						$('#file-upload').fileinput({
							allowedFileTypes: ['image'],
							autoFitCaption: false,
							browseClass: 'btn btn-primary',
							browseLabel: ' Pick Image',
							browseIcon: '<i class="glyphicon glyphicon-picture"></i>',
							elErrorContainer: '#file-upload-err',
							initialCaption: 
							<%
								if not((isempty(mimg) and isnull(mimg)) or trim(mimg)="") then 
									response.write("'"&mimg&"'")
								else
									response.write("'Upload Image'")
								end if
							%>,
							initialPreview:
							<%
								if not((isempty(mimg) and isnull(mimg)) or trim(mimg)="") then 
							%>
								'<img src="uploads/<%=mimg%>" class="file-preview-image" title="<%=mimg%>" alt="<%=mimg%>" style="width:auto;height:160px;">'
							<%
								else
									response.write("''")
								end if
							%>,
							initialPreviewCount: <%if not((isempty(mimg) and isnull(mimg)) or trim(mimg)="") then response.write(1) else: response.write("0")%>,
							maxFilesNum: 1,
							previewFileType: 'image',
							showRemove: true,
							removeClass: 'btn btn-danger',
							removeLabel: ' Remove Image',
							removeIcon: '<i class="glyphicon glyphicon-trash"></i>',
							showPreview: true,
							showUpload: false,
							wrapTextLength: '40',
						}).on('filepredelete', function(e) {
							$('#file-upload').fileinput('refresh',{initialCaption:'',initialPreview:'',initialPreviewCount:0});
						}).on('filecleared', function(e) {
							$('#file-upload-db').attr('value','');
						}).on('fileclear', function(e) {
							$('#file-upload-db').attr('value','');
						}).on('fileimageloaded', function(e) {
							var cond=<%if not((isempty(mimg) and isnull(mimg)) or trim(mimg)="") then response.write("$('#file-upload').val().indexOf('"&mimg&"')") else: response.write(0)%>;
							if(cond<0){
								$('#file-upload-db').attr('value','<%=mimg%>');
							}
						});

						//Date Time Validation/Cancel Form/Upload validation
						$('#ann_add_frm').submit(function(e){
							$('#submit').attr('value','Processing...').addClass('btn-warning').removeClass('btn-success');
							if(cancel){
								e.preventDefault();
							}else{
								var d1=$('#dsel1 input'),d2=$('#dsel2 input'),t1=$('#tsel1 input'),t2=$('#tsel2 input'),
									err=$('#min-dt-lim');
								if(d1.val()==d2.val()&&t1.val()==t2.val()){
									e.preventDefault();
									t2.parent().addClass('has-error');
									err.removeClass('invisible');
								}else{
									var stop_sub;
									upload_img(function(uploaded){
										if(!uploaded){
											stop_sub=true;
											$('#file-upload').val('');
											$('#file-upload-db').val('');
										}
									});
									if(stop_sub){
										e.preventDefault;
										$('#submit').attr('value','Try Again').removeClass('btn-warning').addClass('btn-info');
									}
								}
							}
						});
					});

					//Form Filled Validation
					function form_filled(){
						var isValid=true;
						$('.form-control').each(function(){
							if($(this).val()===''){
								var cond_cls=$(this).attr('class'), cond_id=$(this).attr('id');
								cond_cls=(typeof cond_cls!=='undefined'&&cond_cls!==null)?cond_cls.indexOf('file'):-1;
								cond_id=(typeof cond_id!=='undefined'&&cond_id!==null)?cond_id.indexOf('file'):-1;
								if(cond_cls===-1&&cond_id===-1){isValid=false;}
							}
						});
						return isValid;
					}

					//Form Cancel Submission
					var cancel=false;
					function cancel_sub(){
						cancel=true;
						$('.form-control').each(function(){
							if($(this).attr('required')){
								$(this).removeAttr('required');
							}
						});
						parent.frames[0].location.href='ann_list.asp?action=list';
					}

					//AJAX ASP Upload Image
					function upload_img(result){
						var cond=$('#file-upload').val();
						cond=(typeof cond!=='undefined'&&cond!==null)?<%if not((isempty(mimg) and isnull(mimg)) or trim(mimg)="") then response.write("cond.indexOf('"&mimg&"')") else: response.write(-2)%>:-2;
						if(form_filled()&&cond<0&&$('#file-upload').val().trim()!==''){
							var img;
							img=new FormData();

							img.append("img", $('#file-upload').get(0).files[0]);

							$.ajax({
								url: 'upload.asp',
								type: 'post',
								data: img,
								mimeType: "multipart/form-data",
								contentType: false,
								cache: false,
								processData: false,
								async: false,
								success: function(data, textStatus, jqXHR){result(1);/*alert(data);*/},
								error: function(jqXHR, textStatus, errorThrown){alert('Failed to upload');result(0);/*alert('errorThrown');*/}
							});
						}
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