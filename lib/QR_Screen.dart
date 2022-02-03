import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'NavBar.dart';
import 'QR_Scanner.dart';
import 'global.dart' as global;
import 'package:electronic_id/TopAppBar.dart';
import 'global.dart';

class QR_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    global.sizeP = 24;
    global.sizeD = 24;
    global.sizeN = 40;
    global.colorN = Colors.grey;
    global.colorD = Colors.grey;
    global.colorP = Colors.grey;
    global.colorQ = Colors.white;
    SystemChrome.setEnabledSystemUIOverlays ([]);
    return  WillPopScope(
        onWillPop: () async {
      Navigator.of(context).popUntil((route) {
        return route.settings.name == 'ProfileScreen';
      });
      return false;
      },
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: topAppBar,
        bottomNavigationBar:NavBar(),

        body: Column(
          children:  <Widget>[
            SizedBox(height: 40.0),
            FadeInDownBig(
                child: CircleAvatar(
            backgroundImage: AssetImage('assets/img_avatar.png',),
                radius: 40,
            ),
              ),
            SizedBox(height: 15.0),
            FadeInDownBig(
              child: Text(global.dfname,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 20.0),
            ZoomIn(
              child: Center(
                child: Container(
                  height: 350,
                  width: 300,
                  child: Material(
                    elevation: 15.0,
                    borderRadius: BorderRadius.circular(30.0),
                    shadowColor: Colors.black,

                    child: Center(
                      child: QrImage(
                        data: email,
                        version: QrVersions.auto,
                        size: 260,
                        gapless: true,
                        embeddedImage: AssetImage('assets/logo BW.png'),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(50, 50),
                        ),
                      ),
                    ),

                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            FadeInUpBig(
              child:
            RaisedButton.icon(
              onPressed: (){
                Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>QR_Scanner(),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text('QR Scanner',
                style: TextStyle(fontSize: 20,color: Colors.black),),
              icon: Icon(Icons.qr_code_scanner_outlined,  color:Colors.black,size: 40,),
              textColor: Colors.black,
              splashColor: Colors.green,
              color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }

}









