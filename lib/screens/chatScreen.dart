import 'package:firebase_auth/firebase_auth.dart';
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
      appBar: AppBar(
        title: Text('Chats'),
        actions: <Widget>[
          DropdownButton(
              icon: Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                  value: 'Logout',
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 6),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (val) {
                if(val=='Logout'){
                  FirebaseAuth.instance.signOut();
                }
              },),
        ],
      ),
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
        onPressed: () {
          Firestore.instance.collection('chats/G92pJV03CWjXy0SpRbcE/messages').add({
            'text':'This is added',
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
