import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
   static const String id= 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
//by the class singletickerprovider... we make our class to act as a ticker provider to controller.
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller= AnimationController(
      duration: Duration(seconds: 1),
        vsync: this,);
    controller?.forward();
    controller?.addListener(() {
      setState(() {});
      // print(controller?.value);
    });
  }

  //to dispose the controller or animation when close that screen
  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FLASH CHAT'),),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/images/logo.png'),
                  height:60 ,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                        color: Colors.black87 ,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                    ),
                ),
              ],
            ),
           ]
          ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Log In',
                onPressed:(){
                  Navigator.pushNamed(context, LoginScreen.id);
            }),
            RoundedButton(
                colour: Colors.blueAccent,
                title: 'Register',
                onPressed:(){
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}