import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:electronic_id/ProfileScreen.dart';
import 'global.dart' as global;
import 'package:flutter_login/flutter_login.dart';


String email= '';
String password= '';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

   Duration get loginTime => Duration(milliseconds: 2250);

   Future<String> _authUser(LoginData data) {
   print('1Name: ${data.name}, 1Password: ${data.password}');
   // Getting value from Controller
   email = data.name;
   password = data.password;

   return Future.delayed(loginTime).then((_) async {
     // SERVER LOGIN API URL
     var url = 'http://192.168.0.123/electronicid/login_user.php';

     // Store all data with Param Name.
     var data = {'email': email, 'password': password};

     // Starting Web API Call.
     var response = await
     http.post(url, body: json.encode(data));

     // Getting Server response into variable.
     var message = jsonDecode(response.body);

     // If the Response Message is Matched.
     if (message == 'Login Matched') {
       global.email = email;
       print(message);
       return null;

     } else {
       return 'Invalid Username or Password Please Try Again';


     }
   }
   );
   }

   @override
   Widget build(BuildContext context) {
     SystemChrome.setEnabledSystemUIOverlays ([]);

     return FlutterLogin(
       title: null,
       logo: 'assets/logo.png',

       //emailValidator: ,
       onLogin: _authUser,
       onSignup: null,
       onSubmitAnimationCompleted: () {
         Navigator.of(context).push(
             MaterialPageRoute(builder: (_) {
               return  ProfileScreen(email: email);  //NavBar();
             },
               settings: RouteSettings(name: 'ProfileScreen',),
             ));
       },
       onRecoverPassword: (String) { return ; },
     theme: LoginTheme(
     primaryColor: Colors.indigo,
        )

     );


   }
}


