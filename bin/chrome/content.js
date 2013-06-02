var copyTextToClipboard = function(txt){
    var copyFrom = $("<textarea/>");
    copyFrom.text(txt);
    $("body").append(copyFrom);
    copyFrom.select();
    document.execCommand('copy');
    console.log(copyFrom);
    copyFrom.remove();
}


chrome.extension.onMessage.addListener(function(req, sender, callback) {
    copyTextToClipboard(req.text);
});

console.log("content.js loaded");
