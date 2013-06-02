
window.addEventListener('keydown', function(e) {
    if (e.altKey && e.keyCode == 77) {
        var text = window.getSelection().toString();
        if (text.length > 0) {
            var result = $.get
            var result = $.ajax({type: "GET",
                                 url: "http://127.0.0.1:4567/recommend/" + text,
                                 async: false}).responseText;
            chrome.extension.sendMessage({"text": "![misawa](" + result + ")"},
                                         function(response) {});
        }
    } else if (e.altKey && e.keyCode == 78) {
        var text = window.getSelection().toString();
        if (text.length > 0) {
            var result = $.get
            var result = $.ajax({type: "GET",
                                 url: "http://127.0.0.1:4567/recommend/" + text,
                                 async: false}).responseText;
            chrome.extension.sendMessage({"text": result}, function(response) {});
        }
    }
}, false);
