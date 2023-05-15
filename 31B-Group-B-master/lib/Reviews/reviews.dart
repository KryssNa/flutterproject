
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({Key? key}) : super(key: key);

  @override
  State<Feedbacks> createState() => _Feedbacks();
}

class _Feedbacks extends State<Feedbacks> {
  // use this controller to get what the user typed
  final _textController = TextEditingController();
  Future submit() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("Users-FeedBack");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("feedback")
        .doc()
        .set({
      'feedback': _textController.text
    }).then((value) => print("Your FeedBack is recorded"));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Feedback Section",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
          elevation: 0,
        ),
        body:  Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(bottom: 30),
              child: Image.network("https://thumbs.dreamstime.com/b/feedback-concept-image-arrows-blue-chalkboard-background-40378284.jpg")),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Any FeedBack?',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87)
                  ),
                  suffixIcon: IconButton( onPressed: () {
                    // clear what's currently in the textfield
                    _textController.clear();
                  },
                    icon: Icon(Icons.clear),),
                ),
                maxLines: 15,
                minLines: 3,
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(onPressed: (){
                submit();
              }, label: Text("Submit",style: TextStyle(color: Colors.white),), icon: Icon(Icons.move_to_inbox),
              )
            ],
          ),
      ),
    );
  }
}

