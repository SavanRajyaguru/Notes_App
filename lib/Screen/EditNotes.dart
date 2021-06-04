import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Screen/Home_Screen.dart';

class EditNotes extends StatefulWidget {
  DocumentSnapshot docToEdit;
  EditNotes({Key? key, required this.docToEdit}) : super(key: key);

  CollectionReference ref = FirebaseFirestore.instance.collection('Notes');

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState(){
    title = TextEditingController(text: widget.docToEdit.data()!['title']);
    content = TextEditingController(text: widget.docToEdit.data()!['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1f27),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Edit'),
        actions: [
          ElevatedButton.icon(
            onPressed: () async{
              await widget.docToEdit.reference.update({
                'title': title.text,
                'content': content.text
              }).whenComplete(() => Navigator.pop(context));
            },
            icon: Icon(Icons.save),
            label: Text('Save'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
          ElevatedButton.icon(
            onPressed: () async{
              widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));
            },
            icon: Icon(Icons.delete),
            label: Text('Delete'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: TextField(
                controller: title,
                cursorColor: Colors.red,
                style: TextStyle(fontSize: 19.0, color: Colors.white),
                autofocus: true,
                decoration: InputDecoration(hintText: ' Title',border: InputBorder.none,hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  cursorColor: Colors.red,
                  expands: true,
                  style: TextStyle(fontSize: 19.0,color: Colors.white),
                  decoration: InputDecoration(hintText: ' Content',border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
