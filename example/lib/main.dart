import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ffi_jscore/flutter_jscore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_jscore',
      home: _JSCorePage(),
    );
  }
}

class _JSCorePage extends StatefulWidget {
  @override
  _JSCorePageState createState() => _JSCorePageState();
}

class _JSCorePageState extends State<_JSCorePage> {
  TextEditingController _jsInputController;
  JSContext _jsContext;

  @override
  void initState() {
    super.initState();
    _jsContext = JSContext.createInGroup();
    _jsInputController = TextEditingController(text: '1 + 1');
    loadAsset();
  }

  Future<void> loadAsset() async {
    String bundleStr = await rootBundle.loadString('assets/bundle.js');
    print(bundleStr);
  }

  @override
  void dispose() {
    _jsContext.release();
    _jsInputController.dispose();
    super.dispose();
  }

  String _runJs(String script) {
    print(script);
    String _script = '1-1';
    var jsValue = _jsContext.evaluate(_script);
    return jsValue.string;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JavaScriptCore for Flutter'),
      ),
      body: TextField(
        maxLines: 50,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        controller: _jsInputController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Result'),
                content: Text(_runJs(_jsInputController.text ?? '')),
              );
            },
          );
        },
        child: Icon(Icons.autorenew),
      ),
    );
  }
}
