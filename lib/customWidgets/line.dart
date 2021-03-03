import 'dart:math';

import 'package:flutter/material.dart';


const LINE_WIDTH=1.0;
enum Direction { topLeft, downLeft, topRight, downRight }

class DirectionIncrement {
  final Offset head;
  final Offset tail;
  final double gap;
  final double length;
  bool isFirst = true;
  bool isOver = false;
  Offset start;
  Offset end;

  DirectionIncrement(this.head, this.tail, this.gap, this.length);

  increment() {
    var width = tail.dx - head.dx;
    var height = tail.dy - head.dy;

    var scaleWidth = pow(width, 2) / (pow(height, 2) + pow(width, 2));
    var scaleHeight = pow(height, 2) / (pow(height, 2) + pow(width, 2));

    var increWidth = sqrt(1 * scaleWidth);
    var increHeight = sqrt(1 * scaleHeight);

    var widthFlag = width >= 0 ? 1 : -1;
    var heightFlag = height >= 0 ? 1 : -1;
    return [increWidth * widthFlag, increHeight * heightFlag];
  }

  checkTail(Offset middle) {
    if (((middle - head).distanceSquared - (tail - head).distanceSquared) >=
        0) {
      isOver = true;
      return tail;
    } else {
      return middle;
    }
  }

  step() {
    var incre = increment();
    var increWidth = incre[0];
    var increHeight = incre[1];

    if (isFirst) {
      start = head;
      isFirst = false;
    } else {
      start = end + Offset(increWidth * gap, increHeight * gap);
    }

    end = start + Offset(increWidth * length, increHeight * length);

    start = checkTail(start);
    end = checkTail(end);

    return [start, end];
  }
}

class Line extends StatelessWidget {
  final Offset head;
  final Offset tail;
  final bool isDashed;
  Line(this.head, this.tail, this.isDashed);

  @override
  Widget build(BuildContext context) {
    var width = (head.dx - tail.dx).abs() == 0 ? 5 : (head.dx - tail.dx).abs();
    var height = (head.dy - tail.dy).abs() == 0 ? 5 : (head.dy - tail.dy).abs();
    return CustomPaint(
      size: Size(width, height),
      painter: LinePainter(head, tail, isDashed),
    );
  }
}

class LinePainter extends CustomPainter {
  final Offset head;
  final Offset tail;
  final double gap = 5;
  final double length = 5;
  final bool isDashed;
  LinePainter(this.head, this.tail, this.isDashed);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..color = Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = LINE_WIDTH;

    if (isDashed) {
      var directionIncre = DirectionIncrement(head, tail, gap, length);

      while (!directionIncre.isOver) {
        var tmpPoints = directionIncre.step();
        canvas.drawLine(tmpPoints[0], tmpPoints[1], paint);
      }
    } else {
      canvas.drawLine(head, tail, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
