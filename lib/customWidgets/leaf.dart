import 'package:flutter/material.dart';

const CIRCLE_SIZE = 9.0;
const LEAF_HEIGHT = 50.0;
const FONT_SIZE = LEAF_HEIGHT/2;
const LEAF_PADDING = LEAF_HEIGHT/3;
const COLOR = Color(0xff707070);
const COLOR_UNSELECTED = Color(0xffb3b3b3);
const SHADOW = BoxShadow(
    color: Color(0x29000000), offset: Offset(0.0, 3.0), blurRadius: 6.0);

class Leaf extends StatelessWidget {
  final innerText;

  Leaf(this.innerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: LEAF_HEIGHT,
      padding: EdgeInsets.fromLTRB(LEAF_PADDING, 0, LEAF_PADDING, 0),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        boxShadow: [SHADOW],
        borderRadius: BorderRadius.circular(LEAF_HEIGHT),
        border: Border.all(
          width: CIRCLE_SIZE / 3,
          color: COLOR,
        ),
      ),
      child: Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Text(
          innerText,
          style: TextStyle(
            fontSize: FONT_SIZE,
          ),
        ),
      ),
    );
  }
}


class Circle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: CIRCLE_SIZE,
      height: CIRCLE_SIZE,
      decoration: BoxDecoration(
          boxShadow: [SHADOW],
          border: Border.all(
            width: CIRCLE_SIZE / 3,
            color: COLOR,
          ),
          borderRadius: BorderRadius.circular(CIRCLE_SIZE)),
    );
  }
}


class CircleLeaf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      
    );
  }
}