import 'dart:math';

import 'package:flutter/material.dart';

import 'w_arrow_view.dart';
import 'w_model.dart';

class BoardView extends StatefulWidget {
  final double angle;
  final double current;
  final List<Luck> items;

  const BoardView({key, required this.angle, required this.current, required this.items});

  @override
  State<StatefulWidget> createState() {
    return _BoardViewState();
  }
}

class _BoardViewState extends State<BoardView> {
  Size get size => Size(MediaQuery.of(context).size.width * 0.8,
      MediaQuery.of(context).size.width * 0.8,);

  double _rotote(int index) =>  (index / widget.items.length) * 2 * pi  ;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        //shadow
        Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 30, color: Colors.black38)],),
        ),
        Transform.rotate(
          angle: -(widget.current + widget.angle) * 2 * pi,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              for (final Luck luck in widget.items ?? []) ...[_buildCard(luck)],
              for (final Luck luck in widget.items ?? []) ...[_buildImage(luck)],
            ],
          ),
        ),
        Container(
          height: size.height,
          width: size.width,
          child: ArrowView(),
        ),
      ],
    );
  }

  _buildCard(Luck luck) {
    final double _rotate =  _rotote(widget.items.indexOf(luck)) ;
    final double _angle =  (2 * pi / widget.items.length) ;
    return Transform.rotate(
      angle: _rotate,
      child: ClipPath(
        clipper: _LuckPath(_angle.toInt()),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [luck.color, luck.color.withOpacity(0)],),),
        ),
      ),
    );
  }

  Transform _buildImage(Luck luck) {
    final _rotate = _rotote(widget.items.indexOf(luck));
    return Transform.rotate(
      angle: _rotate.toDouble(),
      child: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints:
          BoxConstraints.expand(height: size.height / 3, width: 44),
          child: Image.asset(luck.asset),
        ),
      ),
    );
  }
}

class _LuckPath extends CustomClipper<Path> {
  final int angle;

  _LuckPath(this.angle);

  @override
  Path getClip(Size size) {
    final Path _path = Path();
    final Offset _center = size.center(Offset.zero);
    final Rect _rect = Rect.fromCircle(center: _center, radius: size.width / 2);
    _path.moveTo(_center.dx, _center.dy);
    _path.arcTo(_rect, -pi / 2 - angle / 2, angle.toDouble(), false);
    _path.close();
    return _path;
  }

  @override
  bool shouldReclip(_LuckPath oldClipper) {
    return angle != oldClipper.angle;
  }
}
