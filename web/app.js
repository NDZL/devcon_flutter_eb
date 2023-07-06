
    var value="---";
    async function scanAndGetData(){
        var finalResult = barcode_data
        return Promise.resolve(finalResult)
    }

var barcode_data;
var _debug_intent_Received;
var callback = function(intentval){
    _debug_intent_Received = intentval;
	barcode_data = "Barcode value: " + Object.values(intentval.data)[3]  + "\n\nBarcode Symbology: "+ Object.values(intentval.data)[2] ;
	//window.alert("<"+barcode_data+">");
};
EB.Intent.startListening(callback);

function triggerBarcodeScanner(){
        //window.alert("triggerBarcodeScanner");

        var extra= {'com.symbol.datawedge.api.SOFT_SCAN_TRIGGER' : 'START_SCANNING'};
		var params = {
                    intentType: EB.Intent.BROADCAST,
                   action: 'com.symbol.datawedge.api.ACTION',
                   data: extra
                };
        EB.Intent.send(params);

}

//window.alert("flutter/web - app.js loaded!");

