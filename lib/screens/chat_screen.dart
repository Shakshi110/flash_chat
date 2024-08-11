
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ChatScreen extends StatefulWidget {
  static const  String id= 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  final _firestore= FirebaseFirestore.instance; //instance to store the msg into cloud firestore
  final _auth= FirebaseAuth.instance; //instance for firebase authenticatiion
  final messageTextController= TextEditingController(); //to remove the text from clipboard text field after being send.

  var loggedInUser;
  //String? msgText; //for firestore

  //to let know the chat screen about the login user.
   void getCurrentUser()async{
     try{
     final currentUser= await _auth.currentUser;
     if(currentUser!= null){
         loggedInUser= currentUser;
     }
   }catch(e){
       print(e);
     }
   }

   @override
  void initState() {
     super.initState();
     getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
               _auth.signOut();
               Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').orderBy('timestamp',descending: false).snapshots(),
                builder:(context, snapshot) {
                  if(snapshot.hasData) {
                    final messages = snapshot.data!.docs.reversed;
                    List<MessageBubble> messageBubbles = [];
                    for (var message in messages) {
                      final messageText = message['text'];
                      final messageSender = message['sender'];
                      final messageTimestamp= message['timestamp'] as Timestamp;

                      final currentUser= loggedInUser.email;
                      if(currentUser== messageSender){
                        //the msg is goining from logged in user
                      }

                      final messageBubble = MessageBubble(
                          sender: messageSender,
                          text:messageText,
                        isMe: currentUser==messageSender,
                        timestamp: messageTimestamp.toDate(),
                      );
                      messageBubbles.add(messageBubble);
                    }
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical:20 ),
                        child: ListView(
                          reverse: true,
                            children: messageBubbles
                        ),
                      ),
                    );
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightBlueAccent,
                      ),
                    );
                  }
                },
                ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                 TextButton(
                    onPressed: (){
                      if(messageTextController.text.isNotEmpty){
                          _firestore.collection('messages').add({
                            "text": messageTextController.text,
                            "sender": loggedInUser.email,
                            "timestamp": FieldValue.serverTimestamp(),
                          });
                          messageTextController.clear();
                      }
                     },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageBubble extends StatelessWidget {
 MessageBubble({required this.sender, required this.text, required this.isMe,  required this.timestamp});

  String? sender;
  String? text;
  final isMe;
 final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text('$sender',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45
              ),
          ),
          Material(
            elevation: 5,
            borderRadius:isMe? BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft:  Radius.circular(30)):
            BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topRight:  Radius.circular(30),
            ),
            color: isMe?Colors.lightBlueAccent:Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15,
                    color: isMe? Colors.white: Colors.black54
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
