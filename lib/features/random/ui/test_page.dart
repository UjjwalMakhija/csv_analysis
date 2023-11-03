import 'package:flutter/material.dart';

class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Hi there!"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          // ElevatedButton(
          //     // onPressed: () {
          //     //   _pickfile();
          //     //   print(_data.length);
          //     // },
          //     child: const Text("Upload file")),
          // const SizedBox(
          //   height: 10,
          // ),
          // HorizontalDataTable(

          //   leftHandSideColumnWidth: 0,
          //    rightHandSideColumnWidth:MediaQuery.of(context).size.width ,
          // )
          //child of listview builder is listview builder
          
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: 20,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height*0.05,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int i) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                               color: index == 0 ? Color.fromARGB(255, 121, 204, 218) : Colors.white,
                            ),
                            height: MediaQuery.of(context).size.height * 0.1,
                           
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Center(
                              child: Text(
                                "NO  ${i} ",
                                style: TextStyle(
                                    color: index == 0 ? const Color.fromARGB(255, 5, 4, 4) : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                    // child: Card(
                    //   margin: const EdgeInsets.all(3.0),
                    //   color: index == 0 ? Colors.indigoAccent : Colors.white,
                    //   child: ListTile(
                    //     leading: Text(
                    //       _data[index][0].toString(),
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           fontSize: index == 0 ? 18 : 15,
                    //           fontWeight:
                    //               index == 0 ? FontWeight.bold : FontWeight.normal,
                    //           color: index == 0 ? Colors.red : Colors.black),
                    //     ),
                    //     title: Text(
                    //       _data[index][3].toString(),
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           fontSize: index == 0 ? 18 : 15,
                    //           fontWeight:
                    //               index == 0 ? FontWeight.bold : FontWeight.normal,
                    //           color: index == 0 ? Colors.red : Colors.black),
                    //     ),
                    //     trailing: Text(
                    //       _data[index][4].toString(),
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           fontSize: index == 0 ? 18 : 15,
                    //           fontWeight:
                    //               index == 0 ? FontWeight.bold : FontWeight.normal,
                    //           color: index == 0 ? Colors.red : Colors.black),
                    //     ),
                    //   ),
                    // ),
                  },
                ),
              ),
            ),
          
        ],
      ),
    );
  }
}
