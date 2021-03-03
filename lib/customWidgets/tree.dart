import 'package:flutter/material.dart';
import 'package:slash/customWidgets/leaf.dart';

class Node {
  var parent ;
  var widget;
  var children;

  Node(this.widget, this.children);

  isRoot() {
    if (parent == null) {
      return true;
    }

    return false;
  }

  isLeaf() {
    if (children == null) {
      return true;
    }

    return false;
  }
}

const data = {
  "text": "First",
  "children": [
    {
      "text": "2.1",
      "children": [
        {"text": "3.1", "children": []},
        {"text": "3.2", "children": []}
      ]
    },
    {
      "text": "2.2",
      "children": [
        {"text": "3.3", "children": []},
        {"text": "3.4", "children": []}
      ]
    }
  ]
};

class Tree extends StatefulWidget {
  final data;
  Tree(this.data);
  @override
  _TreeState createState() => _TreeState(data);
}

class _TreeState extends State<Tree> {
  var data;
  var tree;

  _TreeState(data){
    this.data=data;
    parseTree(data);
  }

  

  parseTree(data) {
    if (data.isEmpty) {
      return null;
    }

    var tmp = [];
    for (var i in data) {
      var children = parseTree(i.children);
      var widget = Leaf(i.text);
      if (children != null) {
        for (var j in children) {
          j.parent = widget;
        }
      }

      tmp.add(Node(widget, children));
    }
    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
