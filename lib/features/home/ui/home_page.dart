import 'dart:convert';
import 'dart:io';
import 'package:csv_analysis/features/analysis/ui/analysis_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:horizontal_data_table/horizontal_data_table.dart';

class homepg extends StatefulWidget {
  const homepg({super.key});

  @override
  State<homepg> createState() => _homepgState();
}

class _homepgState extends State<homepg> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var fl;
  double progress = 0;
  UploadTask? uploadTask;
  PlatformFile? pickedFile;

  List<List<dynamic>> _data = [];
  String? filename;
  int a = 0;
  String? filepath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: const Color.fromRGBO(103, 57, 183, 1),
        title: const Text(
          "Welcome ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(103, 57, 183, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
              ),
              onPressed: () {
                _pickfile();
                print(_data.length);
              },
              child: const Text(
                "Select file",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(103, 57, 183, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Colors.purple[900],
                  elevation: 4),
              onPressed: () {
                setState(() {
                  const snakbar = SnackBar(
                  content: Text(
                    "Please selecet a file!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Color.fromRGBO(103, 57, 183, 1),
                );

                fl == null
                    ? ScaffoldMessenger.of(context).showSnackBar(snakbar)
                    :
                  uploadfile();
                });

                print(_data.length);
              },
              child: const Text(
                "Upload file",
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                 Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const an1()));
              },
              child: const Text(
                "See uploaded files",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w900),
              )),
          const SizedBox(
            height: 10,
          ),
          buildprogress(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: _data.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _data[0].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            color: index == 0
                                ? const Color.fromARGB(255, 121, 204, 218)
                                : Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Center(
                            child: Text(
                              _data[index][i].toString(),
                              // "NO  ${i} ",
                              style: TextStyle(
                                color: index == 0
                                    ? const Color.fromARGB(255, 5, 4, 4)
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _pickfile() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: false);
    fl = res;
    if (res == null) return;
    print(res.files.first.name);
    filepath = res.files.first.path;
    final input = File(filepath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();

    print(fields.length);
    print(fields[0].length);
    setState(() {
      _data = fields;
      a = _data[0].length;
      pickedFile = res.files.first;

      // uploadfile();
    });
  }

  Future uploadfile() async {
    final path = 'files/${pickedFile!.name}';
    filename = pickedFile!.name;
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final downloadurl = await ref.getDownloadURL();
    print(downloadurl);
    await firebaseFirestore
        .collection("CSV's")
        .add({"name": pickedFile!.name, "url": downloadurl});
    setState(() {
      uploadTask = null;
    });
  }

  Widget buildprogress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData && (100 * progress).roundToDouble() != 100) {
            final data = snapshot.data!;
            progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 20,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(10),
                    value: progress,
                    backgroundColor: const Color.fromARGB(255, 230, 231, 232),
                    color: const Color.fromRGBO(69, 17, 159, 1),
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 30,
            );
          }
          // progress = 0;
        },
      );
}
