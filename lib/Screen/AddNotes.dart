import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatelessWidget {
  AddNotes({Key? key}) : super(key: key);

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('Notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1f27),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Add Notes'),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              await ref.add({
                'title': title.text,
                'content': content.text
              }).whenComplete(() => Navigator.pop(context));
            },
            icon: Icon(Icons.save),
            label: Text('Save'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: TextField(
                        controller: title,
                        cursorColor: Colors.red,
                        style: TextStyle(fontSize: 19.0, color: Colors.white),
                        autofocus: true,
                        decoration: InputDecoration(
                            hintText: ' Title',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: TextField(
                          controller: content,
                          maxLines: null,
                          cursorColor: Colors.red,
                          expands: true,
                          style: TextStyle(fontSize: 19.0, color: Colors.white),
                          decoration: InputDecoration(
                              hintText: ' Content',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
