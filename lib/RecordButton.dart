import 'dart:ui';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibration/vibration.dart';

class LoadingButton extends StatefulWidget {
  @override
  LoadingButtonState createState() => LoadingButtonState();
}

class LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  AudioPlayer audioPlayer = AudioPlayer();

  var progressRecording;
  var kUrl;

  Icon micIcon = Icon(
    Icons.record_voice_over_rounded,
    size: 25,
    color: Colors.red,
  );
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );

    controller.addListener(() {
      setState(() {});
    });
  }

  void startRecording() async {
    micIcon = Icon(
      Icons.record_voice_over_rounded,
      size: 25,
      color: Colors.red,
    );
    Vibration.vibrate(duration: 18, amplitude: 255);
    if (await Record.hasPermission()) {
      final dir = await getApplicationDocumentsDirectory();
      kUrl = dir.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.m4a';
      // Start recording

      await Record.start(
        path: kUrl,
      );
      print(kUrl);
    }
  }

  void stoptRecording() async {
    if (await Record.hasPermission() && Record.isRecording() == true) {
      await Record.stop();
      await audioPlayer.play(kUrl);
    }

    micIcon = null;
  }

  void stopFunction() {
    Vibration.vibrate(duration: 18, amplitude: 255);
    if (controller.status == AnimationStatus.forward) {
      controller.reverseDuration = Duration(
        seconds: 2,
      );
      controller.reverse();
    }
    stoptRecording();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        controller.forward();
        startRecording();
      },
      onVerticalDragEnd: (_) {
        stopFunction();
      },
      onHorizontalDragEnd: (_) {
        stopFunction();
      },
      onTapUp: (_) {
        stopFunction();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: micIcon,
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
                    strokeWidth: 20,
                  ),
                  height: 200.0,
                  width: 200.0,
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    value: controller.value,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red[600]),
                    strokeWidth: 20,
                  ),
                  height: 200.0,
                  width: 200.0,
                ),
                Icon(
                  Icons.mic_rounded,
                  size: 40,
                ),
              ])),
        ],
      ),
    );
  }
}
