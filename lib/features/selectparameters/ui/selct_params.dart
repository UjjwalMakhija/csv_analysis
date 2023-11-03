import 'package:flutter/material.dart';

class Sparams extends StatefulWidget {
  const Sparams({super.key});

  @override
  State<Sparams> createState() => _SparamsState();
}

class _SparamsState extends State<Sparams> {
  String dropdownValue = 'Dog';
  String DropdownValue = 'Apples';
  List<String> items = ["Apples", "Bananas", "Grapes", "Orange", "Kiwi"];
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hello!",
          style: TextStyle(color: Colors.black),
          // textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        bottomOpacity: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton(
                value: dropdownValue,
                items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) => {
                      setState(
                        () {
                          dropdownValue = newValue!;
                        },
                      )
                    }),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  
                  focusColor: Colors.amberAccent,
                  filled: true,
                  fillColor: Colors.amberAccent,
                  contentPadding: const EdgeInsets.all(8.0),
                  
                  labelText: 'Select an item',
                  border: const OutlineInputBorder(
                  
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    
                  ),
                  suffixIcon: DropdownButtonFormField(
                    iconEnabledColor: const Color.fromARGB(255, 11, 11, 11),
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: Colors.amber[300],
                    
                    style: const TextStyle(
                      leadingDistribution: TextLeadingDistribution.even,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    value: DropdownValue,
                    onChanged: (newValue) {
                      setState(() {
                        DropdownValue = newValue!;
                      });
                    },
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}