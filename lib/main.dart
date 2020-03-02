import 'package:flutter/material.dart';
import "package:barcode_scan/barcode_scan.dart";
import "package:flutter/services.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result;
  @override
  Future qscan() async {
    try {
      String qresult = await BarcodeScanner.scan();
      setState(() {
        result = qresult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "camera permisson denied";
        });
      } else {
        setState(() {
          result = "unknown exception $ex";
        });
      }
    }catch(ex)
    {
      setState(() {
          result = "unknown exception $ex";
        });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.

              ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: Text("Hey there....\nclick on payment recieved button\n only after scanning the QR CODE")),
              RaisedButton(onPressed: (){},child: Text("Payment Recieved"),color: Colors.red,)
            ],
          ),
          

          floatingActionButton: FloatingActionButton.extended(
            onPressed: qscan,
            label: Text("scan"),
            icon: Icon(Icons.camera_alt),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
