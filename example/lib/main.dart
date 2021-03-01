import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_ffi_jscore/flutter_ffi_jscore.dart';

import 'json_viewer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlutterJsHomeScreen(),
    );
  }
}

class FlutterJsHomeScreen extends StatefulWidget {
  @override
  _FlutterJsHomeScreenState createState() => _FlutterJsHomeScreenState();
}

class _FlutterJsHomeScreenState extends State<FlutterJsHomeScreen> {
  String _jsResult = '';
  String _vDom = "";
  JavascriptRuntime javascriptRuntime;

  @override
  void initState() {
    super.initState();
    javascriptRuntime = getJavascriptRuntime();
    javascriptRuntime.onMessage('ConsoleLog2', (args) {
      print('ConsoleLog2 (Dart Side): $args');
      return json.encode(args);
    });
    initJsruntime();
  }

  Future<void> initJsruntime() async {
    String bundleJS = await rootBundle.loadString("assets/bundle.js");
    javascriptRuntime.evaluate("var window = global = globalThis;");
    await javascriptRuntime.evaluateAsync(bundleJS + "");
    javascriptRuntime.evaluate("buildvdom()");
  }

  @override
  dispose() {
    super.dispose();
    javascriptRuntime.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterJS Example'),
      ),
      body: Center(
        child: _vDom == ""
            ? Text("点击下方按钮")
            : JsonViewerRoot(
                jsonObj: json.decode(_vDom),
                expandDeep: 4,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Image.asset('assets/js.ico'),
        onPressed: () async {
          try {
            javascriptRuntime.evaluateAsync("getvdom()").then((value) => {
                  this.setState(() {
                    _vDom = value.stringResult;
                  })
                });
          } on PlatformException catch (e) {
            print('ERRO: ${e.details}');
          }
        },
      ),
    );
  }
}
