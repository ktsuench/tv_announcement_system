/*var min_height_dash_open,
	min_height_dash_closed;

function min_height(){
	var temp;
	temp=window.innerHeight-parseInt($('.body-nav-offcanvas').css('padding-top'))-parseInt($('#header').css('min-height'))-parseInt($('.site-wrap').css('padding-top'))-$('.dash-info').height()-parseInt($('.dash-info').css('margin-bottom'))-parseInt($('#footer').css('min-height'))
	return temp;
}

$(document).ready(function(){if($('.dash-info-disp').hasClass('in')){
	min_height_dash_open=min_height();
	document.getElementById('di-toggle').click();
	min_height_dash_closed=min_height();
	document.getElementById('di-toggle').click();	
}else{
	min_height_dash_closed=min_height();
	document.getElementById('di-toggle').click();
	min_height_dash_open=min_height();
	document.getElementById('di-toggle').click();
}});

function frame_resize(){
	var mheight;
	if($('#content_container').height()<$('.body-nav-offcanvas').height()){
		$('.site-wrap .container-fluid').css('height',$('.site-wrap').height());
		if($('.dash-info-disp').hasClass('in')){mheight=min_height_dash_open}else{mheight=min_height_dash_closed}
		$('#content_container').height(mheight);
	}
	if($('.body-nav-offcanvas').height()<$('.site-wrap .container-fluid .row').height()){$('.body-nav-offcanvas').css('height','100%');}
}*/

//$('.dash-info,.dash-info *').click(frame_resize());
$(window).resize(function(){if($('.body-nav-offcanvas').height()<window.innerHeight){$('.body-nav-offcanvas').css('height',window.innerHeight);}else{$('.body-nav-offcanvas').css('height','100%');}/*frame_resize();*/});
$(document).ready(function(){if($('.body-nav-offcanvas').height()<window.innerHeight){$('.body-nav-offcanvas').css('height',window.innerHeight);}else{$('.body-nav-offcanvas').css('height','100%');}/*frame_resize();*/});