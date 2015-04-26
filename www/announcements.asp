
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
		<meta name="description" content="Riverdale Collegiate Institute - Announcements"/>
		<title>Riverdale Collegiate Institute - Announcements</title>
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
		<%baseURL=request.servervariables("URL")%>
		<!--Template-->
		<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<!--End Template-->
		<!--Date Clock-->
		<link rel="stylesheet" type="text/css" href="css/date_clock.css"/>
		<!--Gridster.js Plugin-->
		<link rel="stylesheet" type="text/css" href="css/jquery.gridster.min.css"/>
		<!--bxSlider-->
		<link rel="stylesheet" type="text/css" href="css/jquery.bxslider.css"/>
		<!--Simple Weather Plugin With Yahoo Weather API-->
		<link rel="stylesheet" type="text/css" href="css/jquery.simpleWeather.css"/>
		<style>
			/*Move down content because we have a fixed navbar that is 50px tall*/
			body{padding-top:0px;}
			.site-wrap{padding-top:0px;}
			.site-wrap>.container-fluid{padding-bottom:0px;}
			.site-wrap,.site-wrap>.container-fluid{background:#222;}
			
			#header{margin-bottom:0px;}
			
			.gridster li{list-style:none; background:#fff}
			
			.bxsliderv{padding:0px;}
			
			.htitle,.hbody{padding:0px 20px 0px 20px;}
			.htitle{font-size:200%;padding-top:10px;padding-bottom:10px;margin-bottom:10px;}
			.hbody{font-size:200%;}
			
			.vtitle,.vbody{padding:0px 20px 0px 20px;}
			.vtitle{font-size:200%; padding-top:10px; padding-bottom:10px !important; margin-bottom:10px;}
			.vbody{font-size:150%;}
			
			.navbar-brand{padding-left:30px;}
			#crest{width:50px;float:left;}
			
			.clock ul, #Date{padding-left:20px; padding-right:20px;}
			.clock *{line-height:1.2;}
			
			*[id*='ann-header'],*[id*='post-header']{color:#fff;margin-top:10px;}
			.ann-post{padding:0px;}
			.ann-img{padding:0px;padding-top:20px;}
			/*.bxsliderv li{padding-bottom:30px;}*/	
		</style>
		<!--Template-->
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries-->
		<!--[if lt IE 9]>
		<script type="text/javascript" src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script type="text/javascript" src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
		<!--End Template-->
	</head>
	<body class="body-nav-offcanvas">
		<%
			dim objConn, objRs, strQuery, k, curDate, curTime, notToday, yy, mm, dd, annCount, annList
			
			strQuery="SELECT * FROM announcements"	
			
			yy=year(date())
			mm=month(date())
			dd=day(date())
			
			if len(mm)<2 then mm="0"&mm
			if len(dd)<2 then dd="0"&dd
			
			curDate=cstr(yy&"/"&mm&"/"&dd)
			curTime=FormatDateTime(now(),vbshorttime)
			
			annCount=array()
			redim annCount(2)
			
			annList=array()
			redim annList(2,2,2)
			
			set objConn=server.createobject("ADODB.Connection")
			set objRs=server.createobject("ADODB.Recordset")
			
			objConn.connectionstring="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&server.mappath("db/rciann.mdb")
			objConn.open
			objRs.open strQuery, objConn, , adLockOptimistic
			
			dim a, b, x
			
			annCount(0)=-1
			annCount(1)=-1
			annCount(2)=-1
			
			do while not objRs.eof
				notToday=true
				if objRs("Verified") then
					if objRs("Start_Date")<=curDate and objRs("End_Date")>=curDate then
						if objRs("Start_Date")=curDate or objRs("End_Date")=curDate then notToday=false
						if (objRs("Start_Time")<=curTime or objRs("End_Time")>=curTime) or notToday then
							objRs("Cur_Posted")=true
							select case objRs("Type")
								case "important"
									annCount(0)=annCount(0)+1
									a=0
									b=annCount(0)
								case "meeting"
									annCount(1)=annCount(1)+1
									a=1
									b=annCount(1)
								case else
									annCount(2)=annCount(2)+1
									a=2
									b=annCount(2)
							end select
							if annCount(0)>2 and annCount(0)>annCount(1) and annCount(0)>annCount(2) then 
								redim preserve annList(2,2,annCount(0)+1)
							elseif annCount(1)>2 and annCount(1)>annCount(0) and annCount(1)>annCount(2) then
								redim preserve annList(2,2,annCount(1)+1)
							elseif annCount(2)>2 and annCount(2)>annCount(0) and annCount(2)>annCount(1) then
								redim preserve annList(2,2,annCount(2)+1)
							end if
							annList(a,0,b)=objRs("Title")
							annList(a,1,b)=objRs("Description")
							annList(a,2,b)=objRs("Image")
						elseif objRs("End_Date")<=curDate and not objRs("Prev_Posted") then
							if objRs("End_Date")=curDate then notToday=false
							if (notToday=false and objRs("End_Time")<=curTime) or notToday then objRs("Prev_Posted")=true
						end if
					end if
				end if
				objRs.movenext
			loop
		%>
		<!--Header-->
		<!--Content-->
		<div class="site-wrap">
			<div class="container-fluid">
				<div class="row">
					<!--#include file="includes/nav_top.inc"-->
					<div class="gridster">
						<ul>
							<!--Horizontal Content Displays-->
							<li data-row="1" data-col="1" data-sizex="5" data-sizey="3" class="grid-obj gridh">
								<ul class="bxsliderh">
									<%for x=0 to annCount(0)%>
									<li>
										<div class="htitle bg-rci"><%=annList(0,0,x)%></div>
										<%if isnull(annList(0,2,x)) or isempty(annList(0,2,x)) or trim(annList(0,2,x))="" then%>
										<div class="hbody"><%=annList(0,1,x)%></div>
										<%else%>
										<div class="pull-left col-md-8 ann-post">
											<div style="font-size:22px" class="hbody"><%=annList(0,1,x)%></div>
										</div>
										<div class="pull-right col-md-4 ann-img">
											<img src="uploads/<%=annList(0,2,x)%>">
										</div>
										<%end if%>
									</li>
									<%next%>
								</ul>
							</li>
							<li data-row="4" data-col="1" data-sizex="5" data-sizey="3" class="grid-obj gridh">
								<ul class="bxsliderh">
									<%for x=0 to annCount(1)%>
									<li>
										<div class="htitle bg-rci"><%=annList(1,0,x)%></div>
										<%if isnull(annList(1,2,x)) or isempty(annList(1,2,x)) or trim(annList(0,2,x))="" then%>
										<div class="hbody"><%=annList(1,1,x)%></div>
										<%else%>
										<div class="pull-left col-md-8 ann-post">
											<div style="font-size:22px" class="hbody"><%=annList(1,1,x)%></div>
										</div>
										<div class="pull-right col-md-4 ann-img">
											<img src="uploads/<%=annList(1,2,x)%>">
										</div>
										<%end if%>
									</li>
									<%next%>
								</ul>
							</li>
							<!--Vertical Content Displays-->
							<%for k=1 to 5 step 2%>
							<li data-row="<%=k%>" data-col="6" data-sizex="4" data-sizey="2" class="grid-obj gridv">
								<ul class="bxsliderv">
									<%for x=0 to annCount(2)%>
									<li>
										<div class="vtitle bg-rci"><%=annList(2,0,x)%></div>
										<div class="vbody"><%=annList(2,1,x)%></div>
									</li>
									<%next%>
								</ul>
								<%
									for x=0 to annCount(2)
										if x=0 then
											annList(2,0,annCount(2)+1)=annList(2,0,x)
											annList(2,1,annCount(2)+1)=annList(2,1,x)
										end if
										annList(2,0,x)=annList(2,0,x+1)
										annList(2,1,x)=annList(2,1,x+1)
									next
								%>
							</li>
							<%next%>
							<!--Other Content Displays-->
							<li data-row="1" data-col="10" data-sizex="3" data-sizey="4" class="grid-obj gridh" id="dt">
								<div id="weather" class="center-block"></div>
								<div class="clearfix"></div>
								<!--#include file="includes/date_clock.inc"--->
							</li>
							<li data-row="4" data-col="10" data-sizex="3" data-sizey="2" class="grid-obj gridh">
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!--Footer-->
		<!--Bootstrap core JavaScript-->
		<!--Placed at the end of the document so the pages load faster-->
		<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/docs.min.js"></script>
		<!--IE10 viewport hack for Surface/desktop Windows 8 bug-->
		<script type="text/javascript" src="js/ie10-viewport-bug-workaround.js"></script>
		<!--Date Clock-->
		<script type="text/javascript" src="js/date_clock.js"></script>
		<!--Gridster.js Plugin-->
		<script type="text/javascript" src="js/jquery.gridster.min.js"></script>
		<!--bxSlider-->
		<script type="text/javascript" src="js/jquery.bxslider.js"></script>
		<!--Simple Weather Plugin With Yahoo Weather API-->
		<script type="text/javascript" src="js/jquery.simpleWeather.min.js"></script>
		<!--Initiatation of scripts-->
		<script type="text/javascript">			
			$(function() { 
				//Gridster.js Plugin
				$('.gridster ul').gridster({
					widget_selector: 'li.grid-obj',
					widget_margins: [5, 5],
					widget_base_dimensions: [(window.innerWidth-120)/12, (window.innerHeight-$('#header').height()-62)/6],
					/*extra_rows: 0,
					extra_cols: 0,
					max_cols: null,*/
					min_cols: 12,
					min_rows: 6,
					/*max_size_x: false,
					autogenerate_stylesheet: true,
					avoid_overlapped_widgets: true,
					serialize_params: function($w, wgd) { return { col: wgd.col, row: wgd.row, size_x: wgd.size_x, size_y: wgd.size_y } },
					draggable: {
						start: function(event, ui){},
						drag: function(event, ui){},
						stop: function(event, ui){},
						items: '.gs-w',
						distance: 4,
						ignore_dragging: Draggable.defaults.ignore_dragging.slice(0)
					},
					resize: {
						enabled: true,
						axes: ['both'],
						handle_class: 'gs-resize-handle',
						handle_append_to: '',
						min_size: [1, 1],
						max_size: [Infinity, Infinity],
						start: function(e, ui, $widget) {},
						resize: function(e, ui, $widget) {},
						stop: function(e, ui, $widget) {},
					},
					collision: {
						on_overlap_start: function(collider_data) {},
						on_overlap: function(collider_data) {},
						on_overlap_stop: function(collider_data) {},
					},*/
				});
				/*$('.gridster ul').data('gridster').add_widget( html, [size_x], [size_y], [col], [row] );*/
				/*$('.gridster ul').data('gridster').resize_widget( $widget, [size_x], [size_y], [reposition], [callback] );*/
				/*$('.gridster ul').data('gridster').remove_widget( el, [callback] );*/
				$('.gridster ul').data('gridster').disable();

				//bxSlider
				var props={
						//mode: 'horizontal' or 'vertical', 'fade',
						//speed: 1000 /*ms*/,
						slideMargin: 0,
						//startSlide: 0,
						randomStart: false,
						//slideSelector: div.slide,
						ticker: false,
						//tickerHover: false,
						adaptiveHeight: false,
						//adaptiveHeightSpeed: 500 /*ms*/,
						video: false,
						responsive: false,
						//wrapperClass: 'bx-wrap',
						pager: false,
						//pagerType: 'short' /*or 'full'*/,
						//pagerShortSeparator: '/',
						controls: false,
						autoControls: false,
						//autoControlsCombine: false,
						auto: true,
						pause: 10000 /*ms*/, 
						autoStart: true,
						autoDirection: 'next' /*'previous'*/,
						autoHover: false,
						autoDelay: 0 /*ms*/,
					},
				propsh={
						mode: 'horizontal' /*or 'vertical', 'fade'*/,
						startSlide: 0,
					},
				propsv={
						mode: 'vertical' /*or 'vertical', 'fade'*/, 
						startSlide: 0,
					};
				$.extend(propsh,props);
				$.extend(propsv,props);
				$('.bxsliderh').bxSlider(propsh),
				$('.bxsliderv').bxSlider(propsv);
				$('.gridv .bx-viewport').each(function(){
					$(this).height($('.gridv').height())
				});
				var animProp,div=document.createElement('div'),
					props=['WebkitPerspective','MozPerspective','OPerspective','msPerspective'];
				for(var i in props){
					if(div.style[props[i]]!==undefined){
						animProp='-'+props[i].replace('Perspective','').toLowerCase()+'-transform';
					}
				}
				$('.bxsliderv').each(function(){
					var x=$(this).parent().height();
					$(this).css(animProp,'translate3d(0px,-'+x+'px,0px)');
				}); 
				$('.bxsliderv li').each(function(){
					$(this).css('padding-bottom', $('.gridv').height()-$(this).height());
				});
				$('.bxsliderv img').each(function(){
					$(this).parent().height($('.gridv').height());
				});

				//Date Clock
				$('.clock,#Date').addClass('center-block'); 
				$('.clock ul').width($('#Date').width());

				//Simple Weather Plugin With Yahoo Weather API
				getWeather(); //Get the initial weather.
				setInterval(getWeather, 600000); //Update the weather every 10 minutes.

				//Custom Script
				jQuery('<img>', {
					id: 'crest',
					src: 'images/crest.png',
					title: 'Riverdale Collegiate Institute',
				}).prependTo('.navbar-header');

				$('.navbar').removeClass('navbar-inverse navbar-fixed-top');
				$('.navbar-brand').removeAttr('style').css({'font-size':'40px','white-space':'nowrap'});
				$('.navbar-brand').html('Riverdale Collegiate Institute Announcements');
				$('#Date').addClass('h2');
				$('#Date~').css({'position':'initial !important','padding':'0px'}).addClass('h2');
			});

			//Simple Weather Plugin With Yahoo Weather API
			function getWeather() {
				$.simpleWeather({
				location: 'quebec city',
				woeid: '',//'4118',
				unit: 'c',
				success: function(weather) {
					html = '<h2 style="margin-top:10px;"><i class="icon-'+weather.code+'"></i> '+weather.temp+'&deg;'+weather.units.temp+'</h2>';
					html += '<div class="center"><div class="currently h2 text-lowercase text-capitalize" style="margin-bottom:10px;margin-top:-10px;">'+weather.currently+'</div>';
					/*html += '<div class="h2 text-lowercase text-capitalize">Temp High: '+weather.high+'&deg;<br />Temp Low: '+weather.low+'&deg;</div></div>';*/

					$('#weather').html(html);
				},
				error: function(error) {
						$('#weather').html('<p>'+error+'</p>');
					}
				});
			}
		</script>
		<script type="text/javascript" src="js/fullsize.min.js"></script>
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