$(document).ready(function() {
    document.search.text.focus();
    function copy(text) {
        var clip = $('#clipbox');
        clip.val(text);
        clip.select();
        document.execCommand('copy');
    };
    console.log($("misawa"))

    $("div#main img.misawa").click(function(event) {
        $("input#clip").val(this.src)
        clip.select();
    });
});
