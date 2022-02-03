import 'package:flutter/material.dart';
import 'package:electronic_id/LoginScreen.dart';
import 'package:electronic_id/ProfileScreen.dart';
import 'package:electronic_id/Download.dart';
import 'package:electronic_id/Notifications.dart';
import 'QR_Screen.dart';
import 'global.dart' as global;

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      BottomAppBar(
      color: Colors.indigo[900],
     // elevation:10,
      child: SizedBox(
        height: 50,
        child: FittedBox(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[



              FlatButton(
                color: Colors.transparent,
                onPressed: () {
                    Navigator.of(context).push(
                        PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>Notifications(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              var begin = Offset(0.0, 1.0);
                              var end = Offset.zero;
                              var curve = Curves.easeIn;

                              var tween = Tween(begin: begin, end: end);
                              var curvedAnimation = CurvedAnimation(
                                parent: animation,
                                curve: curve,
                              );

                              return SlideTransition(
                                position: tween.animate(curvedAnimation),
                                child: child,
                              );
                            }

                        )
                    );
                  },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Icon(Icons.notification_important_outlined, color: global.colorN,),
                    Text("Notifications",style: TextStyle(fontSize: 12, color: global.colorN,)),
                  ],
                ),
              ),

              FlatButton(
                color: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).push(
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => QR_Screen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.easeIn;

                            var tween = Tween(begin: begin, end: end);
                            var curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: curve,
                            );

                            return SlideTransition(
                              position: tween.animate(curvedAnimation),
                              child: child,
                            );
                          }

                      )
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    Icon(Icons.qr_code_outlined, color: global.colorQ,),
                    Text("QR",style: TextStyle(fontSize: 12, color: global.colorN,)),
                  ],
                ),
              ),

              FlatButton(
                onPressed: (){
                  Navigator.of(context).push(
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>ProfileScreen(email: global.email),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end);
                            var curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: curve,
                            );

                            return SlideTransition(
                              position: tween.animate(curvedAnimation),
                              child: child,
                            );
                          }

                      )

                  );//Navigator.pop(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Icon(Icons.person_outline, color: global.colorP,//size:global.sizeP
                    ),
                    Text('Profile',
                        style: TextStyle(
                          color: global.colorP,
                          fontSize:12,
                          // fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),

              FlatButton(
                onPressed: (){
                    Navigator.of(context).push(
                        PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>Download(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              var begin = Offset(0.0, 1.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end);
                              var curvedAnimation = CurvedAnimation(
                                parent: animation,
                                curve: curve,
                              );

                              return SlideTransition(
                                position: tween.animate(curvedAnimation),
                                child: child,
                              );
                            }

                        )
                    );//Navigator.pop(context);
                  },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Icon(Icons.download_outlined, color: global.colorD,),
                    Text("Downlaods",style: TextStyle(fontSize: 12, color: global.colorD,)),
                  ],
                ),
              ),

              FlatButton(
                onPressed: (){
                    global.email = '';
                    global.dfname = '';
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>  LoginScreen(),
                      ),
                          (route) => false,//if you want to disable back feature set to false
                    );
                  },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Icon(Icons.logout,color: Colors.white),
                    Text("Logout",style: TextStyle(fontSize: 12,color: Colors.white)),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );


  }
  }