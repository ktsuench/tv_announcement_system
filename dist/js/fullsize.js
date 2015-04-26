function fixpage(){
	if($('.body-nav-offcanvas').height()<window.innerHeight){
		$('.body-nav-offcanvas').css('height',window.innerHeight);
	}else{
		$('.body-nav-offcanvas').css('height','100%');
	}
}

$(window).resize(fixpage());
$(document).ready(fixpage());