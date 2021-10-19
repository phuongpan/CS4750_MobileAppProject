import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
class TimePage extends StatefulWidget {
  const TimePage({key}) : super(key: key);

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> with TickerProviderStateMixin{

  late AnimationController controller;
  int _hrs = 2;

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${(duration.inHours).toString().padLeft(2,'0')}:${(duration.inMinutes%60).toString().padLeft(2,'0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    print(_hrs.toString());
    controller = AnimationController(
      vsync: this,
      duration: Duration(hours: _hrs)
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Fasting Page", style: TextStyle(fontSize: 20),),
        centerTitle: true,
          actions: [
            new IconButton(
              onPressed: () => showMaterialNumberPicker(
                  context: context,
                  title: 'Choose hours',
                  headerColor: Colors.orange,
                  headerTextColor: Colors.black,
                  buttonTextColor: Colors.orange,
                  minNumber: 0,
                  maxNumber: 24,
                confirmText: 'Done',
                cancelText: 'Cancle',
                selectedNumber: _hrs,
                onChanged: (value) =>setState(() {
                  _hrs = value;
                print(_hrs.toString());
                }),
              ),
                icon: Icon(Icons.settings),
            )
          ],

      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget? child) {
                            return CustomPaint(
                                painter: TimerPainter(
                                  animation: controller,
                                  backgroundColor: Colors.white,
                                  color: themeData.indicatorColor,
                                ));
                          },
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: controller.isAnimating? Text("Remaining",style: TextStyle(fontSize: 40, color: Color(0xff7A6B6B)),
                        ) : Text("Let's fasting", style: TextStyle(fontSize: 40, color: Color(0xff7A6B6B)),),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: AnimatedBuilder(
                                  animation: controller,
                                  builder: (BuildContext context, Widget? child) {
                                    return Text(
                                      timerString,
                                      style: TextStyle(fontSize: 93, color: Color(0xff7A6B6B),)
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 250,
                    height: 50,
                    margin: EdgeInsets.only(bottom: 20),
                    child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            //side: BorderSide(color: Colors.red)
                        ),

                        color: controller.isAnimating ? Color(0xffFB9600) : Color(0xffFB9600),
                        textColor: Colors.white,
                        child: controller.isAnimating ? Text("Pause Fasting",
                          style: TextStyle(fontSize: 25),) : Text("Start Fasting",
                            style: TextStyle(fontSize: 25)),
                        //    style: TextStyle(fontSize: 14)
                        onPressed: () {
                          setState(() {
                            if(controller.isAnimating)
                              {
                                controller.stop(canceled: true);
                              }
                            else{
                              controller.reverse(from: controller.value == 0.0 ? 1.0: controller.value);
                            }
                          });
                        }
                    ),
                  ),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 70),
                    child: TextButton(
                        child: controller.isAnimating ? Text("Stop",
                          style: TextStyle(fontSize: 25),) : Text("",
                            style: TextStyle(fontSize: 25)),
                        //    style: TextStyle(fontSize: 14)
                        onPressed: () {
                          setState(() {
                            if(controller.isAnimating)
                            {
                              controller.stop(canceled: true);
                              _hrs = 0;
                            }
                            else{
                              //controller.reverse(from: controller.value == 0.0 ? 1.0: controller.value);
                            }
                          });
                        }
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class TimerPainter extends CustomPainter {
  TimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}