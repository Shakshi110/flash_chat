import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const  String id= 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth= FirebaseAuth.instance;
   var email;
   var password;
   bool showSpinner= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('REGISTRATION'),
        backgroundColor: Colors.blueAccent,),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email=value;
                },
                decoration: kTextFielddecoration.copyWith(
                    suffixIcon: Icon(Icons.email),
                    hintText: 'Enter your email')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password=value;
                },
                decoration: kTextFielddecoration.copyWith(
                    hintText: 'Enter your password')
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  colour: Colors.blueAccent,
                  title: 'Register',
                  onPressed:()async{
                    setState(() {
                      showSpinner= true;
                    });
                 try {
                   final newUser = await _auth.createUserWithEmailAndPassword(
                       email: email, password: password);
                   if(newUser!= null){
                     Navigator.pushNamed(context, ChatScreen.id);
                     setState(() {
                       showSpinner=false;
                     });
                   }
                 }catch(e){
                   print(e);
                 }
                  })
            ],
          ),
        ),
      ),
    );
  }
}