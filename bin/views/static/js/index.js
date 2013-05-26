$(document).ready(new function() {
    console.log($('ul.tiles li.misawa'));
    var option = {
        offset: 5,
        container: $('div#main'),
        autoResize: true
    };
    var handler = $('ul#tiles li.misawa');
    handler.wookmark(option);

    var selected = null

    handler.click(function(){
        if (selected != null) {
            selected.css('height', selected.height() - 80 + 'px');
        }
        // Randomize the height of the clicked item.
        var height = $(this).height();
        $(this).css('height', $(this).height() + 80 + 'px');
        selected = $(this);
        handler.wookmark();
    });
});
