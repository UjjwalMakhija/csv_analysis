import 'package:flutter/material.dart';

class a1 extends StatefulWidget {
  final String dropdownValue;
  final String dropdownValue2;
  const a1(
      {required this.dropdownValue, required this.dropdownValue2, super.key});
  
  @override
  State<a1> createState() => _a1State();
}

class _a1State extends State<a1> {
  
  @override
  
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          SizedBox(
            height: h*0.1,
          ),
          Container(
            child: Text(
              widget.dropdownValue
            ),
          ),
           SizedBox(
            height: h*0.1,
          ),
          Container(
            child: Text(
              widget.dropdownValue2
            ),
          )
        ],
      ),
    ));
  }
}
