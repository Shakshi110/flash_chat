import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
static const  String id= 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth= FirebaseAuth.instance;
  var email;
  var password;
  bool showSpinner= false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LOGIN'),
      backgroundColor: Colors.lightBlueAccent,),
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
                    hintText: 'Enter your email',
                    suffixIcon: Icon(Icons.email))
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
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
            RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Log In',
                onPressed: ()async{
                  setState(() {
                    showSpinner= true;
                  });
                  try {
                    final oldUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (oldUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        showSpinner= false;
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