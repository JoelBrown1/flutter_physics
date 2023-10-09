import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v;

class Spring extends StatefulWidget {
  const Spring({Key? key}) : super(key: key);

  @override
  State<Spring> createState() => _SpringState();
}

class _SpringState extends State<Spring> {
  late v.Vector2 anchor;
  late v.Vector2 satellite;
  late v.Vector2 velocity;
  late v.Vector2 gravity;
  late Timer timer;

  @override
  void initState() {
    anchor = v.Vector2(300, 100);
    satellite = v.Vector2(100, 350);
    velocity = v.Vector2(0, 0);
    gravity = v.Vector2(0, 0.1);

    update();

    super.initState();
  }

  void update() {
    double k = .01;

    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      double restLength = 300;
      var force = satellite - anchor;
      var x = force.length - restLength;
      force.normalize();
      force.scale(-1 * k * x);

      velocity.add(force);
      velocity.add(gravity);
      satellite.add(velocity);

      velocity.scale(.99);

      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Flutter Demo Home Page'),
        ),
        body: InteractiveViewer(
          child: CustomPaint(
            painter: SpringPainter(anchor, satellite),
            child: Container(),
          ),
        ));
  }
}

class SpringPainter extends CustomPainter {
  final v.Vector2 anchor;
  final v.Vector2 satellite;

  SpringPainter(this.anchor, this.satellite);

  @override
  void paint(Canvas canvas, Size size) {
    Paint anchorPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    Paint satellitePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Paint linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;

    canvas.drawLine(Offset(anchor.x, anchor.y),
        Offset(satellite.x, satellite.y), linePaint);

    canvas.drawCircle(Offset(anchor.x, anchor.y), 20, anchorPaint);
    canvas.drawCircle(Offset(satellite.x, satellite.y), 40, satellitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
