function alertMessage(text) {
    alert(text)
}

window.logger = (flutter_value) => {
   console.log({ js_context: this, flutter_value });
}

var barcode_data;
var callback = function(intentval){
	barcode_data = Object.values(intentval.data)[3]  ;
	window.alert("<"+barcode_data+">");
};

EB.Intent.startListening(callback);

window.alert("flutter/web - app.js loaded!");