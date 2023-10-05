import 'dart:math';

import 'package:flutter/material.dart';

import 'w_board_view.dart';
import 'w_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
   double _angle = 0.0;
   double _current = 0.0;
  late AnimationController _ctrl;
  late Animation _ani;
//  Animation k;
  bool _visible = false;

  final List<Luck> _items = [
    Luck("bomb", Colors.accents[0]),
    Luck("gold", Colors.accents[2]),
    Luck("12", Colors.accents[4]),
    Luck("gift", Colors.accents[6]),
    Luck("bomb2", Colors.accents[8]),
    Luck("beer", Colors.accents[10]),
    Luck("winner", Colors.accents[12]),
    Luck("50000", Colors.accents[14]),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.pink.withOpacity(0.9)],),),
        child: AnimatedBuilder(
            animation: _ani,
            builder: (context, child) {
              final _value = _ani.value;
//              final k = _value;
              final double _angle = _ani.value * this._angle;
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  BoardView(  items: _items, current: _current, angle: _angle, key: _value,),
                  _buildGo(),
                  _buildResult(_value),
//                  _buildResult(k),
                ],
              );
            },),

      ),
    );

  }

  Material _buildGo() {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: _animation,
        child: Container(
          alignment: Alignment.center,
          height: 72,
          width: 72,
          child: const Text(
            "GO",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  _animation() {
    _visible = false;
    if (!_ctrl.isAnimating) {
      final _random = Random().nextDouble();

      // Ensure this results in a double
      _angle = 20.0 + Random().nextInt(5).toDouble() + _random;

      _ctrl.forward(from: 0.0).then((_) {
        _current = _current + _random;

        // Convert integer division result to double before subtracting
        _current = _current - (_current ~/ 1).toDouble();

        _ctrl.reset();
        setState(() {
          _visible = true;
        });
      });
    }
  }


  int _calIndex(value) {
    final _base = (2 * pi / _items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * _items.length).floor();
  }

  Opacity _buildResult(_value) {
    final int _index = _calIndex(_value * _angle + _current);
    final String _asset = _items[_index].asset;

    return Opacity(opacity: _visible ? 1.0 : 0.0, child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset(_asset, height: 80, width: 80),
      ),
    ),);
  }

}
