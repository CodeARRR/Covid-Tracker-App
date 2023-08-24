import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mycovidtracker/View/world_state.dart';
import 'package:pie_chart/pie_chart.dart';

class practice extends StatefulWidget {
  const practice({Key? key}) : super(key: key);

  @override
  State<practice> createState() => _practiceState();
}

class _practiceState extends State<practice> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => WorldState())));
  }

  final colorlist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedBuilder(
              child: Container(
                height: 200,
                width: 200,
                child:
                    Center(child: Image(image: AssetImage('images/virus.png'))),
              ),
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                    child: child, angle: _controller.value * 2.0 * pi);
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Align(
              alignment: Alignment.center, child: Text('COVID 19 \N SPINNER')),
        ],
      ),
    );
  }
}

class ReuseAble extends StatelessWidget {
  final String title, value;
  const ReuseAble({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
