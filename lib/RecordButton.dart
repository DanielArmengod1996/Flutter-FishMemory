import 'package:flutter/material.dart';

int _counter = 1;

class LoadingButton extends StatefulWidget {
  @override
  LoadingButtonState createState() => LoadingButtonState();
}

class LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

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

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (controller.value != null) {
        _counter = (controller.value * 100).toInt();
      }
    });
    return GestureDetector(
      onTapDown: (_) {
        controller.forward();
      },
      onTapUp: (_) {
        if (controller.status == AnimationStatus.forward) {
          controller.reverseDuration = Duration(
            seconds: 5,
          );
          controller.reverse();
        }
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
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
