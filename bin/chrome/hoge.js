var copyTextToClipboard = function(txt){
    var copyFrom = $("<textarea/>");
    copyFrom.text(txt);
    $("body").append(copyFrom);
    copyFrom.select();
    document.execCommand('copy');
    console.log(copyFrom);
    alert(txt);
    copyFrom.remove();
}

alert("hellox")

chrome.extension.onMessage.addListener(function(req, sender, callback) {
    console.log("hellox");
    copyTextToClipboard(req.text);
    console.log(req.text);
});
