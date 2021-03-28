import 'package:flutter/material.dart';
import 'package:hello_world/RecordButton.dart';
import 'package:hello_world/CustomSplash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initSplash();
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

  Future<DateTime> loadDatePicker() async {
    // carga de datos para logear etc...

    return Future.value(showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2222)));
  }

  //void _incrementCounter() {}

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
            ElevatedButton(
              child: Text('Select a date'),
              onPressed: () {
                loadDatePicker().then((value) => print(value));
              },
            ),
            LoadingButton(),
            Padding(
              padding: EdgeInsets.all(16.0),
            ),
            Text(
              'Hold pressing the button to record the audio reminder:',
            ),
          ],
        ),
      ), /*
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/
    );
  }
}
