//import 'dart:async';
import 'package:flutter/material.dart';
import 'hand_hour.dart';
import 'hand_minute.dart';
import 'hand_second.dart';




class ClockHands extends StatelessWidget {
  final DateTime dateTime;
  final bool showHourHandleHeartShape;

  const ClockHands({required this.dateTime, this.showHourHandleHeartShape = false});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.0,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CustomPaint( painter: HourHandPainter(
                      hours: dateTime.hour, minutes: dateTime.minute, showHeartShape: showHourHandleHeartShape,),
                  ),
                  CustomPaint(painter: MinuteHandPainter(
                      minutes: dateTime.minute, seconds: dateTime.second,),
                  ),
                  CustomPaint(painter: SecondHandPainter(seconds: dateTime.second),
                  ),
                ],
            ),
        ),

    );
  }
}

//class _ClockHandState extends State<ClockHands> {
//  Timer _timer;
//
//  _ClockHandState();
//
//  @override
//  void initState() {
//    super.initState();
//    dateTime = new DateTime.now();
//    _timer = new Timer.periodic(const Duration(seconds: 1), setTime);
//  }
//
//  void setTime(Timer timer) {
//    setState(() {
//      dateTime = new DateTime.now();
//    });
//  }
//
//  @override
//  void dispose() {
//    _timer.cancel();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//  }
//}
