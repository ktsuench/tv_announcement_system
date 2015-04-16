function alignHeaderBg(){
	$('*[id*="ann-header"]').each(function(){
		var id,container,pad_l,pad_r,pad_t,pad_b,mar_l,mar_r,mar_t,mar_b,obj_width,obj_height;
		id='#'+$(this).attr('id')+'-bg';
		container=$(this).parent();

		pad_l=parseInt(container.css('padding-left'));
		pad_r=parseInt(container.css('padding-right'));
		pad_t=parseInt($(this).css('padding-top'));
		pad_b=parseInt($(this).css('padding-bottom'));

		mar_l=parseInt(container.css('margin-left'));
		mar_r=parseInt(container.css('margin-right'));
		mar_t=parseInt($(this).css('margin-top'));
		mar_b=parseInt($(this).css('margin-bottom'));

		obj_width=container.width()+pad_l+pad_r+mar_l+mar_r;
		obj_height=$(this).height()+pad_t+pad_b+mar_t+mar_b;

		$(this).css('padding-left','20px');
		$(id).css({'margin-top':-obj_height,'margin-left':-(mar_l+pad_l)});
		$(id).width(obj_width).height(obj_height).addClass('bg-rci');
	});

	$('*[id*="post-header"]').each(function(){
		var id,container,pad_l,pad_r,pad_t,pad_b,mar_l,mar_r,mar_t,mar_b,obj_width,obj_height;
		id='#'+$(this).attr('id')+'-bg';
		container=$('#'+$(this).attr('data-parent'));

		pad_l=parseInt(container.css('padding-left'));
		pad_r=parseInt(container.css('padding-right'));
		pad_t=parseInt($(this).css('padding-top'));
		pad_b=parseInt($(this).css('padding-bottom'));

		mar_l=parseInt(container.css('margin-left'));
		mar_r=parseInt(container.css('margin-right'));
		mar_t=parseInt($(this).css('margin-top'));
		mar_b=parseInt($(this).css('margin-bottom'));

		obj_width=container.width()+pad_l+pad_r+mar_l+mar_r;
		obj_height=$(this).height()+pad_t+pad_b+mar_t+mar_b;

		$(id).css({'margin-top':-obj_height,'margin-left':-(mar_l+pad_l)});
		$(id).width(obj_width).height(obj_height).addClass('bg-rci');
	});	
}