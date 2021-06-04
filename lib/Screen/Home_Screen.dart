import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Screen/AddNotes.dart';
import 'package:notes_app/Screen/EditNotes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  TextEditingController search = TextEditingController();

  final ref = FirebaseFirestore.instance.collection('Notes');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF1f1f27),
      appBar: AppBar(
        backgroundColor: Colors.red,
        // centerTitle: true,
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNotes()));
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey.shade700, width: 2.0),
            //     borderRadius: BorderRadius.circular(40.0),
            //   ),
            //   child: TextField(
            //     enableInteractiveSelection: false,
            //     controller: search,
            //     style: TextStyle(fontSize: 19.0, color: Colors.white),
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       prefixIcon: Icon(
            //         Icons.search,
            //         color: Colors.grey[600],
            //       ),
            //       hintText: 'Search notes',
            //       hintStyle: TextStyle(color: Colors.grey[600])
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10.0,
            ),
            StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return Expanded(
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount:
                            snapshot.hasData ? snapshot.data!.docs.length : 0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditNotes(
                                            docToEdit:
                                                snapshot.data!.docs[index],
                                          )));
                            },
                            child: Card(
                                color: Colors.blueGrey[800],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RichText(
                                        overflow: TextOverflow.ellipsis,
                                        strutStyle: StrutStyle(fontSize: 8.0),
                                        text: TextSpan(
                                      text: snapshot.data!.docs[index]
                                          .data()['title'],
                                      style: TextStyle(
                                          fontSize: 22.0, color: Colors.white),
                                    )),
                                    RichText(
                                        overflow: TextOverflow.fade,
                                        strutStyle: StrutStyle(fontSize: 8.0),
                                        text: TextSpan(
                                          text: snapshot.data!.docs[index]
                                              .data()['content'],
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.white),
                                        )),
                                  ],
                                )),
                          );
                        }),
                  );
                })
          ],
        ),
      ),
    );
  }
}
