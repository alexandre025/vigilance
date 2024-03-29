// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require select2
//= require_tree .

Turbolinks.enableProgressBar();

$(document).on('page:change', function () {
    $('select.select2').select2();

    $('select.select2-no-search').select2({
        minimumResultsForSearch: Infinity
    });

    $('.grid').masonry({
        itemSelector: ".grid-item"
    });

    $('.to_read, .like-content, .article-footer .later').on('click', function (e) {
        e.preventDefault();
        $(this).toggleClass('active');
    });

    $('.like').on('click', function (e) {
        e.preventDefault();
        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
            $(this).children().first().text("favorite_border");
        } else {
            $(this).addClass('active');
            $(this).children().first().text('favorite');
        }
    });

    $('.alert i').on('click', function (e) {
        e.preventDefault();
        $(this).parent().hide();
    });

});





