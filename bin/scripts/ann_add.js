
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