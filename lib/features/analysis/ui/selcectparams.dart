import 'package:csv_analysis/features/analysis/ui/analysis.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';

class s1 extends StatefulWidget {
  final String filename;
  const s1({required this.filename, super.key});

  @override
  State<s1> createState() => _s1State();
}

class _s1State extends State<s1> {
  List<List<dynamic>> fields = [];
  var f;

  List<dynamic> l = [];
  List<List<dynamic>> k = [];
  // fina;l zz

  Future load() async {
    // final path = 'files/${widget.filename}';
    final storageRef = FirebaseStorage.instance.ref();

    Reference? fileref = storageRef.child("files");
    final spaceref = fileref.child(widget.filename);
    final path = spaceref.fullPath;

    const oneMega = 1024 * 1024;
    var list;
    try {
      list = await spaceref.getData();
    } on FirebaseException catch (e) {
      print(e);
    }

    print(list);
    print(list.runtimeType);
    print(path);
    // var m = list.split(',');
    // print(m);
    // print(m.length);

    f = utf8.decode(list).split('\n');
    print(f);
    print(f.runtimeType);
    print(f.length);

    print(f[1]);
    for (int i = 0; i < f.length; i++) {
      // l.add(f[i].split(','));
      // if (i == 0) {
      //   print(l);
      // }

      k.add(f[i].split(','));
      l = [];
    }
    print(l.length);
    print(k[1].length);

    // fields= await input.openRead().transform(utf8.decoder).transform(const CsvToListConverter()).toList();
    // fields = utf8.decode(list).split('\n');
    // for (final i in list) {
    //   print(i);
    // }
    print(fields);
    // fields = list;
    // fields = await input
    //     .transform(utf8.decoder)
    //     .transform(const CsvToListConverter())
    //     .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (contexr) => s2(
                  f: k,
                )));
  }

  @override
  void initState() {
    setState(() {
      load();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(
          color: Color.fromRGBO(69, 17, 159, 1),
        ),
      ),
    );
  }
}

class s2 extends StatefulWidget {
  final List<List<dynamic>> f;
  s2({required this.f, super.key});
  // late List<List<dynamic>> f1=f;
  @override
  State<s2> createState() => _s2State();
}

class _s2State extends State<s2> {
  // late List<List<dynamic>> f1=widget.f;
  late String dropdownValue = widget.f[0][0];
  late String dropdownValue2 = widget.f[0][2];
  late List<dynamic> items = widget.f[0];
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select the parameters"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 112, 11, 174),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: h * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  focusColor: const Color.fromARGB(255, 112, 11, 174),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 112, 11, 174),
                  contentPadding: const EdgeInsets.all(8.0),
                  labelText: 'Select an item',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  suffixIcon: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )
                        ),
                        
                    ),
                    iconEnabledColor: const Color.fromARGB(255, 232, 226, 226),
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: const Color.fromARGB(255, 112, 11, 174),
                    style: const TextStyle(
                      
                      leadingDistribution: TextLeadingDistribution.even,
                      color: Color.fromARGB(255, 236, 234, 234),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    value: dropdownValue,
                    alignment: AlignmentDirectional.center,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items:
                        items.map<DropdownMenuItem<dynamic>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller1,
                decoration: InputDecoration(
                  focusColor: const Color.fromARGB(255, 112, 11, 174),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 112, 11, 174),
                  contentPadding: const EdgeInsets.all(8.0),
                  labelText: 'Select an item',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  
                  suffixIcon: DropdownButtonFormField(
                    iconEnabledColor: const Color.fromARGB(255, 232, 226, 226),
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: const Color.fromARGB(255, 112, 11, 174),
                    style: const TextStyle(
                      leadingDistribution: TextLeadingDistribution.even,
                      color: Color.fromARGB(255, 236, 234, 234),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    value: dropdownValue2,
                    alignment: AlignmentDirectional.center,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;
                      });
                    },
                    items:
                        items.map<DropdownMenuItem<dynamic>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 112, 11, 174),
                  borderRadius: BorderRadius.circular(15),
                  shape: BoxShape.rectangle),
              child: DropdownButton(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => a1(
                        dropdownValue: dropdownValue,
                        dropdownValue2: dropdownValue2,
                      )));
                },
                focusColor: const Color.fromARGB(255, 76, 5, 126),
                dropdownColor: const Color.fromARGB(255, 112, 11, 174),
                style: const TextStyle(
                    color:  Color.fromARGB(255, 112, 11, 174)),
                value: dropdownValue2,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                items: items.map((dynamic items) {
                  return DropdownMenuItem(
                    value: items,
                    alignment: Alignment.center,
                    child: Text(
                      items,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 239, 234, 234),
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    dropdownValue2 = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      // body: Column(children: <Widget>[
      //   SizedBox(
      //     height: h * 0.05,
      //   ),
      //   Container(
      //     height: 300,
      //     color: Color.fromARGB(255, 207, 59, 202),
      //     child: Center(
      //         child: Text(
      //       widget.f[2][0].toString(),
      //       style: const TextStyle(color: Colors.white),
      //     )),
      //   ),
      //   SizedBox(
      //     height: h * 0.05,
      //   ),
      //   Container(
      //     height: 300,
      //     color: Color.fromARGB(255, 207, 59, 202),
      //     child: Center(
      //         child: Text(
      //       widget.f[2].toString(),
      //       style: const TextStyle(color: Colors.white),
      //     )),
      //   )
      // ]),
    );
  }
}
