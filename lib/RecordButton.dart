import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';

class LoadingButton extends StatefulWidget {
  @override
  LoadingButtonState createState() => LoadingButtonState();
}

class LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  var recorder;
  var recording;
  var progressRecNum;

  @override
  void initState() {
    FlutterAudioRecorder.hasPermissions;
    var recorder = FlutterAudioRecorder("file_path.wav");
    Future<dynamic> initialized = recorder.initialized;
    initialized.then((value) => null);
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );

    controller.addListener(() {
      setState(() {});
    });
  }

  void startRecording() {
    recorder.start().then(() => {recording = recorder.current(channel: 0)});
  }

  void stoptRecording() {
    var result = recorder.stop();
    log(result.path);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (recorder != null) {
        var progressRecording;
        progressRecording = recording.current(channel: 0);
        progressRecNum = progressRecording.status();
      }
    });
    return GestureDetector(
      onTapDown: (_) {
        controller.forward();
        startRecording();
      },
      onTapUp: (_) {
        if (controller.status == AnimationStatus.forward) {
          controller.reverseDuration = Duration(
            seconds: 1,
          );
          controller.reverse();
        }
        stoptRecording();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              '$progressRecNum',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Stack(alignment: Alignment.center, children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(
                    value: 1.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                  height: 100.0,
                  width: 100.0,
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    value: controller.value,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red[600]),
                  ),
                  height: 100.0,
                  width: 100.0,
                ),
                Icon(Icons.add),
              ])),
        ],
      ),
    );
  }
}
