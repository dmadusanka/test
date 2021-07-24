import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/mainDrawer.dart';

class makeOder extends StatefulWidget {
  @override
  _makeOderState createState() => _makeOderState();
}

class _makeOderState extends State<makeOder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        backgroundColor: Colors.orange,
      ),
      drawer: MainDrawer(),
    );
  }
}
