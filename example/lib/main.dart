import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_ffi_jscore/flutter_ffi_jscore.dart';

import 'json_viewer.dart';
import 'package:http/http.dart' as http;

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
  JavascriptRuntime javascriptRuntime;

  @override
  void initState() {
    super.initState();
    javascriptRuntime = getJavascriptRuntime();
    initJsruntime();
  }

  Future<String> getBundleData() async {
    String kkintervalRuntime =
        await rootBundle.loadString("assets/godzilla_runtime.js");
    javascriptRuntime.evaluate(kkintervalRuntime + "");

    String bundleData = "";
    try {
      bundleData = await http.read('http://127.0.0.1:3333/home.js');
    } catch (e) {
      bundleData = await rootBundle.loadString("assets/bundle.js");
    }
    return bundleData;
  }

  Future<void> initJsruntime() async {
    String bundleJS = await getBundleData();
    javascriptRuntime.evaluate("var window = global = globalThis;");
    await javascriptRuntime.evaluateAsync(bundleJS + "");

    javascriptRuntime
        .evaluateAsync("Object.keys(window)")
        .then((value) => print(value.stringResult));

    javascriptRuntime.evaluateAsync("godzilla.render()");
    javascriptRuntime
        .evaluateAsync("__godzilla_ui_manager__")
        .then((value) => {print(value.stringResult)});
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
        child: Column(children: [Text("flutter ffi jscore")]),
      ),
    );
  }
}
