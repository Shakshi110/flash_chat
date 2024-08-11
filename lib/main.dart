import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCpqN_YrFz0Fjupidcdhbkkt-oynJ2wBZE",
        appId: "1:707137647528:android:8a3cfa420ad2f4e2cb639d",
        messagingSenderId: "707137647528",
        projectId: "flash-chat-bb02e",
        storageBucket:  "flash-chat-bb02e.appspot.com",
      )
  );
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue.shade400,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(fontSize: 20,color: Colors.white,)
        )
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
       WelcomeScreen.id: (context)=> WelcomeScreen(),
        LoginScreen.id: (context)=> LoginScreen(),
        RegistrationScreen.id: (context)=> RegistrationScreen(),
        ChatScreen.id: (context)=> ChatScreen(),
    } ,
    );
  }
}
