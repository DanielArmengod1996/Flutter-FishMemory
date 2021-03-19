import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hello_world/RecordButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fish Memory'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon btnIcon;
  bool isRecording = false;

  FlutterSoundPlayer playerModule = FlutterSoundPlayer();
  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
  void _incrementCounter() {}
  void changeIcon() {
    setState(() {
      if (isRecording) {
        // stop
        this.btnIcon = Icon(
          Icons.circle,
          color: Colors.red[600],
          size: 200,
        );
        isRecording = false;
      } else {
        //record
        this.btnIcon = Icon(
          Icons.circle,
          color: Colors.black,
          size: 200,
        );
        isRecording = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            /*
              TextButton(
                onPressed: changeIcon,
                child: this.btnIcon,
              ),*/
            LoadingButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
