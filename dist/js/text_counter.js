function text_counter(e1,e2,n){
    var text_max=n;
    e2.html(text_max+' characters remaining');
    //Bootstrap Styling
    e2.addClass('text-primary');

    e1.keyup(function(){
        var text_length=e1.val().length,
            text_remaining=text_max-text_length;

        e2.html(text_remaining+' characters remaining');
        //Bootstrap Styling
        if(text_remaining==0){
            e2.removeClass('text-primary').addClass('text-danger')
        }else if(e2.hasClass('text-danger')){
            e2.removeClass('text-danger').addClass('text-primary');
        }
    });
}