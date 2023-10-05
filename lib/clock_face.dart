import 'package:flutter/material.dart';
import 'clock_dial_painter.dart';
import 'clock_hands.dart';
import 'clock_text.dart';

class ClockFace extends StatelessWidget{

  final DateTime dateTime;
  final ClockText clockText;
  final bool showHourHandleHeartShape;

  const ClockFace({this.clockText = ClockText.arabic, this.showHourHandleHeartShape = false, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),

          child: Stack(
            children: <Widget>[
              //dial and numbers
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(0.0),
                child:CustomPaint(
                  painter: ClockDialPainter(clockText: clockText),
                ),
              ),


              //centerpoint
              Center(
                child: Container(
                  width: 15.0,
                  height: 15.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),


              ClockHands(dateTime:dateTime, showHourHandleHeartShape: showHourHandleHeartShape),

            ],
          ),
        ),

      ),
    );
  }
}


