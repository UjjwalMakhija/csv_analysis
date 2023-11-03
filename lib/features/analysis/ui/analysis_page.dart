// import 'package:csv_analysis/features/random/ui/test_page.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:csv_analysis/features/analysis/ui/selcectparams.dart';
import 'package:csv_analysis/features/home/ui/home_page.dart';
import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:csv/csv.dart';

class an1 extends StatefulWidget {
  const an1({super.key});

  @override
  State<an1> createState() => _an1State();
}

class _an1State extends State<an1> {
  List<String> filenames = [];
  List<bool> color = [];
  bool done = false;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> listex() async {
    firebase_storage.ListResult listResult = await firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('files')
        .listAll();
    listResult.items.forEach((firebase_storage.Reference ref) {
      print("File found:  $ref");
      filenames.add(ref.name);
      color.add(false);
      
    });
    done = true;
    listResult.prefixes.forEach((firebase_storage.Reference ref) {
      print("File  directory : $ref");
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => an2(
                  filenames: filenames,
                  color: color,
                )));
  }

  @override
  void initState() {
    listex();

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

class an2 extends StatefulWidget {
  final List<String> filenames;
  final List<bool> color;
  an2({required this.filenames, required this.color, super.key});

  @override
  State<an2> createState() => _an2State();
}

class _an2State extends State<an2> {
  String filename = "";
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const homepg()));
              },
              icon: const Icon(Icons.navigate_before_sharp)),
          title: const Text(
            "Files",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(103, 57, 183, 1),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => s1(filename: filename)));
              },
              child: count > 0
                  ? const Text(
                      "See Analysis",
                      style: TextStyle(
                        color: Color.fromRGBO(6, 6, 6, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      "Tap on the filename to select",
                      style: TextStyle(
                        color: Color.fromRGBO(7, 7, 7, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              itemCount: widget.filenames.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          for (int i = 0; i < widget.color.length; i++) {
                            if (i == index) {
                              if (widget.color[index] == true) {
                                widget.color[index] = false;
                                count = 0;
                              } else {
                                widget.color[index] = true;
                                count++;
                                filename = widget.filenames[index];
                                // print(filename);
                              }
                            } else {
                              widget.color[i] = false;
                            }
                          }
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: !widget.color[index]
                                ? Colors.white
                                : const Color.fromRGBO(103, 57, 183, 1),
                            border: Border.all(
                                color: Color.fromARGB(255, 73, 16, 101),
                                style: BorderStyle.solid,
                                width: 1.4)),
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Center(
                          child: Text(
                            widget.filenames[index],
                            style: TextStyle(
                                color: widget.color[index]
                                    ? Colors.white
                                    : const Color.fromRGBO(103, 57, 183, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ));
  }
}
