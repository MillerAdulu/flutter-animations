import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'dart:math';
import 'dart:ui' show lerpDouble;

void main() {
  runApp(MaterialApp(
    home: ChartPage(),
  ));
}

class ChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChartPageState();
  }
}

class ChartPageState extends State<ChartPage> with TickerProviderStateMixin {
  final random = Random();
  int dataSet = 50;

  AnimationController animation;
  double startHeight;
  double currentHeight;
  double endHeight;

  @override
  void initState() {
    super.initState();

    animation = AnimationController(
      duration: const Duration(microseconds: 300),
      vsync: this,
    )..addListener(() {
        setState(() {
          currentHeight = lerpDouble(startHeight, endHeight, animation.value);
        });
      });

    startHeight = 0.0;
    currentHeight = 0.0;
    endHeight = dataSet.toDouble();
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {
      dataSet = random.nextInt(100);
      startHeight = currentHeight;
      endHeight = dataSet.toDouble();
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
            size: Size(200.0, 100.0), painter: BarChartPainter(currentHeight)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: changeData,
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  static const barWidth = 10.0;
  BarChartPainter(this.barHeight);
  final double barHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH((size.width - barWidth) / 2.0, size.height - barHeight,
            barWidth, barHeight),
        paint);
  }

  @override
  bool shouldRepaint(BarChartPainter old) {
    return barHeight != old.barHeight;
  }
}
