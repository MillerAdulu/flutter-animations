import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'dart:math';

import 'package:animationapp/utils/routes.dart';
import 'package:animationapp/bar.dart';

void main() {
  runApp(MaterialApp(
    home: ChartPage(),
    routes: routes,
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
  BarTween tween;

  @override
  void initState() {
    super.initState();

    animation = AnimationController(
      duration: const Duration(microseconds: 300),
      vsync: this,
    );
    tween = BarTween(Bar(0.0), Bar(0.0));
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
      tween =
          BarTween(tween.evaluate(animation), Bar(random.nextDouble() * 100.0));
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        Center(
          child: CustomPaint(
              size: Size(200.0, 100.0),
              painter: BarChartPainter(tween.animate(animation))),
        ),
        RaisedButton(child: Text('Animate Screen'), onPressed: () {
          Navigator.pushNamed(context, '/animate');
        },)
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: changeData,
      ),
    );
  }
}
