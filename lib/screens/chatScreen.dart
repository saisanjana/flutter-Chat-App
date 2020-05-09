import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('chats/G92pJV03CWjXy0SpRbcE/messages')
              .snapshots(),
          builder: (ctx, snap) {
            if(snap.connectionState==ConnectionState.waiting){
              return Center(child:CircularProgressIndicator());
            }
            final documents=snap.data.documents;
            return ListView.builder(
              itemBuilder: (ctx, ind) => Container(
                padding: EdgeInsets.all(10),
                child: Text(documents[ind]['text']),
              ),
              itemCount: documents.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
