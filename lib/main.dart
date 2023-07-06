import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
//import 'dart:js' as js;
//import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:js/js.dart';

@JS('triggerBarcodeScanner')
external dynamic triggerBarcodeScanner();

@JS('scanAndGetData')
external dynamic scanAndGetData();



//https://fireship.io/snippets/using-js-with-flutter-web/
//https://pub.dev/packages/js
//https://stackoverflow.com/questions/65423861/call-dart-method-from-js-in-flutter-web

//https://stackoverflow.com/questions/74531539/how-to-get-callback-or-return-value-from-async-js-function-to-dart-in-flutter-we <== THIS ONE IS IMPLEMENTED HERE
// DATA PULLED-UP FROM JS
//https://fedingo.com/how-to-listen-to-variable-changes-in-javascript/

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter for Zebra!',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Enterprise Browser|Datawedge|Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  String _resFromJS = "...";

  void _updateResFromJS(String s){
    setState(() {
      _resFromJS = s;
    });
  }

  void main() {

  }

  @override
  void didChangeDependencies() { //called when the page is created
    callJS();
  }

  Future<void> callJS() async {
    Timer.periodic(const Duration(milliseconds: 300), (timer) async {

      dynamic result = await promiseToFuture(scanAndGetData());
      //print(result);
      _updateResFromJS(result);

    });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Barcode data from Zebra Enterprise Browser API:',
            ),
            Text(
              _resFromJS,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: triggerBarcodeScanner,
        tooltip: 'Scan!',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
