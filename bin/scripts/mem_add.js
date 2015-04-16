
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