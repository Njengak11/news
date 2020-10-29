import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Row(children: [
          Text('GO',
          style: Google),
          Text('NEWS')
        ],),
        elevation: 0.0,
        centerTitle: true,
      ),
    );
  }
}