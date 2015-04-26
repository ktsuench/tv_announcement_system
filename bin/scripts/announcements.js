			
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